import 'package:redux_adder/models/parameter.dart';

import '../utils/functions.dart';

class Action {
  late String name;
  final List<Parameter> parameters;
  final String implementation;
  final bool isAsync;
  late String snakeActionName;

  Action(
      {required String name,
      required this.parameters,
      this.implementation = "",
      required this.isAsync})
      : name = capitalize(name),
        snakeActionName = getSnakeActionName(name);

  factory Action.fromJson(Map<String, dynamic> json) {
    return Action(
        name: json['name'],
        parameters: [for (var j in json['parameters']) Parameter.fromJson(j)],
        implementation: json['implementation'] ?? "",
        isAsync: json['async']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'parameters': [for (var p in parameters) p.toJson()],
        'implementation': implementation,
        'async': isAsync,
      };

  String getDefaultImplementation() {
    String res = "return state.copyWith(";
    res += [
      for (var p in parameters) indent("${p.name}: action.${p.name},", tabs: 2)
    ].join();
    res += indent(");", tabs: 1);
    return res;
  }

  String buildActionDeclaration() {
    String res = "class $name {";
    res += [
      for (var p in parameters) indent(p.getParameterDeclaration(), tabs: 1)
    ].join();
    res += "\n";
    res += indent("$name({", tabs: 1);
    res += [
      for (var p in parameters) indent(p.getParameterConstructor(), tabs: 2)
    ].join(",");
    res += indent("});", tabs: 1);
    res += indent("}");
    return res;
  }

  String getReducerDeclaration(String stateName) {
    return "TypedReducer<$stateName, $name>($snakeActionName),";
  }

  String getReducerImplementation(String stateName) {
    String res =
        "$stateName $snakeActionName($stateName state, $name action) {";
    res += indent(
        implementation.isEmpty ? getDefaultImplementation() : implementation,
        tabs: 1);
    res += indent("}");
    return res;
  }

  String getVmActionDeclaration() {
    List<String> header = [for (var p in parameters) "${p.type} ${p.name}"];
    List<String> body = [for (var p in parameters) "${p.name}: ${p.name}"];
    String res =
        "${snakeActionName.replaceAll('_', '')}: (${header.join(',')}) =>";
    res += indent("store.dispatch($name(${body.join(',')})),", tabs: 4);
    return res;
  }
}

void main(List<String> args) {
  Action action = Action(
      name: "Prova",
      parameters: [
        Parameter(type: "int", name: "prova", isComp: false),
        Parameter(type: "String", name: "prova2", isComp: false)
      ],
      //implementation:
      //    "return state.copyWith(prova: action.prova, prova2: action.prova2)",
      isAsync: false);
  print(action.buildActionDeclaration());
  print(action.getReducerImplementation("ProvaState"));
}
