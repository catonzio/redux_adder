import 'package:redux_adder/models/parameter.dart';
import 'package:redux_adder/pages/base_page.dart';
import 'package:redux_adder/utils/parameters_helper.dart';

import '../utils/functions.dart';

class StatePageBuilder extends BasePage {
  final String baseName;
  final String stateName;
  final List<Parameter> parameters;

  StatePageBuilder({required this.baseName, required this.parameters})
      : stateName = "${capitalize(baseName)}State";

  @override
  String buildPage() {
    List<String> componentsNames = [
      for (var p in parameters)
        if (p.isComp) p.name.replaceAll("State", "")
    ];
    String res = "import 'dart:convert';\n";
    res += [
      for (String cn in componentsNames)
        indent("import '../$cn/${cn}_state.dart';")
    ].join();
    res += "\n\nclass $stateName {\n";
    res += buildParamsDeclaration();
    res += buildConstructor();
    res += buildCopyWith();
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

  String buildConstructor() {
    String res = indent("$stateName({", tabs: 1);
    res += [
      for (var p in parameters) indent(p.getParameterConstructor(), tabs: 2)
    ].join(",");
    res += indent("});\n", tabs: 1);
    return res;
  }

  String buildCopyWith() {
    String res = indent("$stateName copyWith({", tabs: 1);
    res += [for (var p in parameters) indent(p.getCopyWithArgument(), tabs: 2)]
        .join();
    res += indent("}) {", tabs: 1);
    res += indent("return $stateName(", tabs: 2);
    res +=
        [for (var p in parameters) indent(p.getCopyWithBody(), tabs: 3)].join();
    res += indent(");", tabs: 2);
    res += indent("}\n", tabs: 1);
    return res;
  }

  String buildInitial() {
    String res = indent("factory $stateName.initial() {", tabs: 1);
    res += indent("return $stateName(", tabs: 2);
    res += [
      for (var p in parameters) indent(p.getParameterInitialization(), tabs: 3)
    ].join();
    res += indent(");", tabs: 2);
    res += indent("}\n", tabs: 1);
    return res;
  }

  String buildFromJson() {
    String res = indent(
        "factory $stateName.fromJson(Map<String, dynamic> json) {",
        tabs: 1);
    res += indent("return $stateName(", tabs: 2);
    res += [for (var p in parameters) indent(p.getParameterFromJson(), tabs: 3)]
        .join();
    res += indent(");", tabs: 2);
    res += indent("}\n", tabs: 1);
    return res;
  }

  String buildToJson() {
    String res = indent("Map<String, dynamic> toJson() => {", tabs: 1);
    res += [for (var p in parameters) indent(p.getParameterToJson(), tabs: 2)]
        .join();
    res += indent("};\n", tabs: 1);
    return res;
  }

  String buildEquals() {
    String res = indent("@override", tabs: 1);
    res += indent("bool operator ==(Object other) =>", tabs: 1);
    res += indent("identical(this, other) ||", tabs: 2);
    res += indent("other is $stateName", tabs: 2);
    res += [
      for (var p in parameters) indent("&& ${p.getParameterEquals()}", tabs: 2)
    ].join();
    res += indent(";\n", tabs: 1);
    return res;
  }

  String buildHashCode() {
    String res = indent("@override", tabs: 1);
    res += indent("int get hashCode =>", tabs: 1);
    res += indent("super.hashCode", tabs: 2);
    res += [
      for (var p in parameters) indent("^ ${p.getParameterHashcode()}", tabs: 2)
    ].join();
    res += indent(";\n", tabs: 1);
    return res;
  }
}

void main(List<String> args) {
  List<String> strs = ["ciao", "a", "tutti"];
  print([
    for (String s in strs)
      if (s != "a") s
  ].join("\n"));
}

/*Future<void> main(List<String> arguments) async {
  StatePage sp = StatePage(baseName: "prova", parameters: [
    {'type': "prova"}
  ]);
  await sp.buildPage();
  String val = await readFile(path: "libr/redux/prova");
  print(val);
}
*/