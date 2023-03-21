import 'package:redux_adder/models/parameter.dart';
import 'package:redux_adder/pages/base_page.dart';
import 'package:redux_adder/utils/functions.dart';

import '../models/action.dart';

class ViewModelPageBuilder extends BasePage {
  final String baseName;
  final String vmName;
  final String stateName;
  final List<Action> actions;
  late List<Parameter> parameters;

  ViewModelPageBuilder({
    required this.baseName,
    required this.vmName,
    required this.stateName,
    required this.actions,
  }) {
    parameters = computeParameters();
  }

  List<String> get computeActionNames {
    return [
      for (var p in parameters)
        if (!p.isComp)
          getActionFromName(p.name, stateName).replaceAll("State", "")
    ];
  }

  List<Parameter> computeParameters() {
    return [Parameter(type: stateName, name: "state", isComp: true)] +
        [
          for (var a in actions)
            Parameter(
                type: "Function(${[
                  for (var p in a.parameters) p.type
                ].join(',')})?",
                name: a.snakeActionName.replaceAll("_", ""))
        ];
  }

  @override
  String buildPage() {
    String res =
        "import 'dart:convert';\nimport '../app/app_state.dart';\nimport 'package:redux/redux.dart';\n";
    res +=
        "import '${baseName}_state.dart';\nimport '${baseName}_action.dart';";
    res += "\n\nclass $vmName {\n";
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
      for (var p in parameters) indent(p.getParameterDeclaration(), tabs: 1)
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
        [for (var a in actions) indent(a.getVmActionDeclaration(), tabs: 3)]
            .join(),
        tabs: 3);
    res += indent(");", tabs: 2);
    res += indent("}\n", tabs: 1);
    return res;
  }

  String buildConstructor() {
    String res = indent("$vmName({", tabs: 1);
    res += [
      for (var p in parameters) indent(p.getParameterConstructor(), tabs: 2)
    ].join(",");
    res += indent("});\n", tabs: 1);
    return res;
  }

  String buildInitial() {
    String res = indent("factory $vmName.initial() {", tabs: 1);
    res += indent("return $vmName(", tabs: 2);
    res += [
      for (var p in parameters)
        if (!isFunction(p.type)) indent(p.getParameterInitialization(), tabs: 3)
    ].join();
    res += indent(");", tabs: 2);
    res += indent("}\n", tabs: 1);
    return res;
  }

  String buildFromJson() {
    String res = indent("factory $vmName.fromJson(Map<String, dynamic> json) {",
        tabs: 1);
    res += indent("return $vmName(", tabs: 2);
    res += [
      for (var p in parameters)
        if (!isFunction(p.type)) indent(p.getParameterFromJson(), tabs: 3)
    ].join();
    res += indent(");", tabs: 2);
    res += indent("}\n", tabs: 1);
    return res;
  }

  String buildToJson() {
    String res = indent("Map<String, dynamic> toJson() => {", tabs: 1);
    res += [
      for (var p in parameters)
        if (!isFunction(p.type)) indent(p.getParameterToJson(), tabs: 2)
    ].join();
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
        if (!p.type.toLowerCase().contains("function"))
          indent(p.getParameterEquals(), tabs: 2)
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
        if (!p.type.toLowerCase().contains("function"))
          indent(p.getParameterHashcode(), tabs: 2)
    ].join(" ^");
    res += indent(";\n", tabs: 1);
    return res;
  }
}
