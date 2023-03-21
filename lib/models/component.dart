import 'dart:convert';
import 'dart:io';

import 'package:redux_adder/models/action.dart';
import 'package:redux_adder/models/parameter.dart';
import 'package:redux_adder/utils/components_helper.dart';

import '../pages/action_page_builder.dart';
import '../pages/middleware_page_builder.dart';
import '../pages/reducer_page_builder.dart';
import '../pages/state_page_builder.dart';
import '../pages/viewmodel_page_builder.dart';
import '../pages/widget_page_builder.dart';
import '../utils/constants.dart';
import '../utils/file_handler.dart';
import '../utils/functions.dart';

class Component {
  final String name;
  final List<Parameter> parameters;
  final List<Action> actions;

  late String stateName;
  late String vmName;
  late String reducerName;
  late String middlewareName;
  late String pageName;

  Component(
      {required this.name, required this.parameters, required this.actions})
      : stateName = "${capitalize(name)}State",
        vmName = "${capitalize(name)}ViewModel",
        reducerName = "${uncapitalize(name)}Reducer",
        middlewareName = "create${capitalize(name)}Middleware",
        pageName = "${capitalize(name)}Page" {
    setActionsFromParameters();
  }

  factory Component.initial() {
    return Component(name: "", parameters: <Parameter>[], actions: <Action>[]);
  }

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
        name: json['name'],
        parameters: [for (var j in json['parameters']) Parameter.fromJson(j)],
        actions: json['actions'] == null
            ? []
            : [for (var j in json['actions']) Action.fromJson(j)]);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'parameters': [for (var p in parameters) p.toJson()],
        'actions': [for (var a in actions) a.toJson()]
      };

  void setActionsFromParameters() {
    List<Action> actions = [
      for (var p in parameters)
        if (!p.isComp)
          Action(
              name: "Update${capitalize(name)}${capitalize(p.name)}Action",
              parameters: [p],
              isAsync: false)
    ];
    this.actions.addAll([
      for (var a in actions)
        if (!this.actions.contains(a)) a
    ]);
  }

  void writeReduxComponent() {
    String camelCase = snakeToCamel(name);
    camelCase = capitalize(camelCase);

    String statePage =
        StatePageBuilder(stateName: stateName, parameters: parameters)
            .buildPage();
    String reducerPage = ReducerPageBuilder(
            baseName: name,
            reducerName: reducerName,
            stateName: stateName,
            actions: actions,
            componentsParameters: parameters.where((p) => p.isComp).toList())
        .buildPage();
    String actionPage =
        ActionPageBuilder(stateName: stateName, actions: actions).buildPage();
    String viewModelPage = ViewModelPageBuilder(
            baseName: name,
            vmName: vmName,
            stateName: stateName,
            actions: actions)
        .buildPage();
    String middlewarePage = MiddlewarePageBuilder(
            middlewareName: middlewareName,
            asyncActions: actions.where((a) => a.isAsync).toList())
        .buildPage();
    String widgetPage =
        WidgetPageBuilder(baseName: name, pageName: pageName, vmName: vmName)
            .buildPage();

    List<List<String>> pages = [
      [statePage, "state"],
      [reducerPage, "reducer"],
      [actionPage, "action"],
      [viewModelPage, "vm"],
      [middlewarePage, "middleware"],
      [widgetPage, "page"],
    ];

    writePages(name, pages);
    writeModelJson();
  }

  void printDifferences(Component currentComponent) {
    List paramsInCurrNotJson =
        findDifferences(currentComponent.parameters, parameters);
    List paramsInJsonNotCurr =
        findDifferences(parameters, currentComponent.parameters);

    List actionsInCurrNotJson =
        findDifferences(currentComponent.actions, actions);
    List actionsInJsonNotCurr =
        findDifferences(actions, currentComponent.actions);

    if (paramsInCurrNotJson.isNotEmpty) {
      printHeader(
          "Parameters in current component, but not in the JSON skeleton");
      print([for (var p in paramsInCurrNotJson) p.name].join("\n"));
    }
    if (paramsInJsonNotCurr.isNotEmpty) {
      printHeader(
          "Parameters in JSON skeleton, but not in the current component");
      print([for (var p in paramsInJsonNotCurr) p.name].join("\n"));
    }
    if (actionsInCurrNotJson.isNotEmpty) {
      printHeader("Actions in current component, but not in the JSON skeleton");
      print([for (var p in actionsInCurrNotJson) p.name].join("\n"));
    }
    if (actionsInJsonNotCurr.isNotEmpty) {
      printHeader("Actions in JSON skeleton, but not in the current component");
      print([for (var p in actionsInJsonNotCurr) p.name].join("\n"));
    }
  }

  void refreshReduxComponent({delete = false, printDiffs = false}) {
    Component currentComponent =
        getComponentFromFolder("${Constants.basePath}/$name");
    if (printDiffs) printDifferences(currentComponent);
    if (!delete) {
      print(
          "This will overwrite the component located at ${Constants.jsonModelsPath}/$name.json.");
      stdout.write("Do you whish to continue? [(y)/n] ");
      String? inp = stdin.readLineSync();
      delete = inp == null
          ? false
          : (inp.toLowerCase().contains("n") ? false : true);
    }

    if (delete) {}
  }

  void writeModelJson() {
    writeFileSync(
        path: "${Constants.jsonModelsPath}/$name.json",
        content: JsonEncoder.withIndent("\t").convert(toJson()));
  }
}

/// finds all elements in list1 not in list2
List<dynamic> findDifferences(List<dynamic> list1, List<dynamic> list2) {
  return [
    for (var p in list1)
      if (!list2.contains(p)) p
  ];
}

void main(List<String> args) {
  print(Component(name: "prova", parameters: [
    Parameter(type: "int", name: "param1", isComp: false),
    Parameter(type: "bool", name: "param2", isComp: false)
  ], actions: []).toJson());
}
