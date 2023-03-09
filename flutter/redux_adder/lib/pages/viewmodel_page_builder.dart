import 'package:redux_adder/pages/base_page.dart';
import 'package:redux_adder/utils/functions.dart';

import '../utils/parameters_helper.dart';

class ViewModelPageBuilder extends BasePage {
  final String baseName;
  final String vmName;
  final String stateName;
  late List<Map<String, dynamic>> parameters;
  late List<String> actionNames;
  late List<Map<String, dynamic>> functionNames;

  ViewModelPageBuilder({required this.baseName, required this.parameters})
      : vmName = "${capitalize(baseName)}ViewModel",
        stateName = "${capitalize(baseName)}State" {
    actionNames = computeActionNames;
    functionNames = computeFunctionNames;
    parameters = computeParameters(functionNames);
  }

  List<String> get computeActionNames {
    return [
      for (var p in parameters)
        if (!p['is_comp'])
          getActionFromName(p['name'], stateName).replaceAll("State", "")
    ];
  }

  List<Map<String, dynamic>> get computeFunctionNames {
    return [
      for (var p in parameters)
        if (!p['is_comp'])
          {
            'type': p['type'],
            'name': "update${capitalize(p['name'])}",
            "is_comp": false
          }
    ];
  }

  List<Map<String, dynamic>> computeParameters(
      List<Map<String, dynamic>> functionNames) {
    return [
          {
            "type": stateName,
            "name": "state",
            "is_comp": true,
          }
        ] +
        [
          for (var p in functionNames)
            {
              "type": "Function(${p['type']})?",
              "name": p['name'],
              "is_comp": p['is_comp']
            }
        ];
  }

  @override
  String buildPage() {
    String res =
        "import 'dart:convert';\nimport '../app/app_state.dart';\nimport 'package:redux/redux.dart';\n";
    res +=
        "import '${baseName}_state.dart';\nimport '${baseName}_action.dart';\n\n";
    res += "class $vmName {\n";
    res += buildParamsDeclaration();
    res += buildFromStore();
    res += buildConstructor();
    res += buildInitial();
    res += buildFromJson();
    res += buildToJson();
    res += buildEquals();
    res += buildHashCode();
    res += "}";
    return res;
  }

  String buildParamsDeclaration() {
    String res = [
      for (var p in parameters) indent(getParameterDeclaration(p), tabs: 1)
    ].join("");
    res += "\n";
    return res;
  }

  String buildFromStore() {
    String res = indent(
        "static $vmName fromStore({required Store<AppState> store}) {",
        tabs: 1);
    res += indent("return $vmName(", tabs: 2);
    res += indent("state: store.state.${uncapitalize(stateName)},", tabs: 3);
    res += indent(
        [
          for (int i = 0; i < functionNames.length; i++)
            indent(getParameterFunctionVm(functionNames[i], actionNames[i]),
                tabs: 3)
        ].join(),
        tabs: 3);
    res += indent(");", tabs: 2);
    res += indent("}\n", tabs: 1);
    return res;
  }

  String buildConstructor() {
    String res = indent("$vmName({", tabs: 1);
    res += [
      for (var p in parameters) indent(getParameterConstructor(p), tabs: 2)
    ].join(",");
    res += indent("});\n", tabs: 1);
    return res;
  }

  String buildInitial() {
    String res = indent("factory $vmName.initial() {", tabs: 1);
    res += indent("return $vmName(", tabs: 2);
    res += [
      for (var p in parameters) indent(getParameterInitialization(p), tabs: 3)
    ].join();
    res += indent(");", tabs: 2);
    res += indent("}\n", tabs: 1);
    return res;
  }

  String buildFromJson() {
    String res = indent("factory $vmName.fromJson(Map<String, dynamic> json) {",
        tabs: 1);
    res += indent("return $vmName(", tabs: 2);
    res += [for (var p in parameters) indent(getParameterFromJson(p), tabs: 3)]
        .join();
    res += indent(");", tabs: 2);
    res += indent("}\n", tabs: 1);
    return res;
  }

  String buildToJson() {
    String res = indent("Map<String, dynamic> toJson() => {", tabs: 1);
    res += [for (var p in parameters) indent(getParameterToJson(p), tabs: 2)]
        .join();
    res += indent("};\n", tabs: 1);
    return res;
  }

  String buildEquals() {
    String res = indent("@override", tabs: 1);
    res += indent("bool operator ==(Object other) =>", tabs: 1);
    res += indent("identical(this, other) ||", tabs: 2);
    res += indent("other is $vmName &&", tabs: 2);
    res += [
      for (var p in parameters)
        if (!p['type'].toLowerCase().contains("function"))
          indent(getParameterEquals(p), tabs: 2)
    ].join(" &&");
    res += indent(";\n", tabs: 1);
    return res;
  }

  String buildHashCode() {
    String res = indent("@override", tabs: 1);
    res += indent("int get hashCode =>", tabs: 1);
    res += indent("super.hashCode ^", tabs: 2);
    res += [
      for (var p in parameters)
        if (!p['type'].toLowerCase().contains("function"))
          indent(getParameterHashcode(p), tabs: 2)
    ].join(" ^");
    res += indent(";\n", tabs: 1);
    return res;
  }
}
