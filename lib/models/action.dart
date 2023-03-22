import 'package:redux_adder/models/parameter.dart';

import '../utils/functions.dart';

/// Class representing an Action.
///
/// Thanks to this class, we can write pieces of code for the action page, the reducer page,
/// the middleware page and the viewmodel.
class Action {
  /// The name of the action.
  ///
  /// It is in camel case and capitalized
  late String name;

  /// The name of the action in snake case, e.g.
  /// ```dart
  ///_nameOfAction
  /// ```
  late String snakeActionName;

  /// The [String] representing the implementation of the action
  final String implementation;

  /// The [List] of parameters of the action
  final List<Parameter> parameters;

  /// Whether the action is async or not
  final bool isAsync;

  Action(
      {required String name,
      required this.parameters,
      this.implementation = "",
      required this.isAsync})
      : name = capitalize(snakeToCamel(name)),
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
        'implementation': implementation.isEmpty
            ? getDefaultImplementation()
            : implementation,
        'async': isAsync,
      };

  /// creates a [String] with the default implementation of an action e.g.
  /// ```dart
  /// return state.copyWith(param: action.param);
  /// ```
  String getDefaultImplementation() {
    String res = "return state.copyWith(";
    res += [
      for (var p in parameters) indent("${p.name}: action.${p.name},", tabs: 2)
    ].join();
    res += indent(");", tabs: 1);
    return res;
  }

  /// Builds the declaration of the action's class, e.g.
  ///
  /// ```dart
  /// class Action {
  ///   final int param;
  ///   Action({required this.param});
  /// }
  /// ```
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

  /// The implementation of the action in the reducer page is
  /// ```dart
  /// StateName _actionName(StateName state, ActionName action) {
  ///   // implementation
  /// }
  /// ```
  String getReducerImplementation(String stateName) {
    String res =
        "$stateName $snakeActionName($stateName state, $name action) {";
    res += indent(
        implementation.isEmpty ? getDefaultImplementation() : implementation,
        tabs: 1);
    res += indent("}");
    return res;
  }

  /// The declaration of the action in the viewmodel is like this
  /// ```dart
  /// actionName: (int param1) =>
  ///		store.dispatch(ActionName(param1: param1)),
  /// ```
  String getVmActionDeclaration() {
    List<String> header = [for (var p in parameters) "${p.type} ${p.name}"];
    List<String> body = [for (var p in parameters) "${p.name}: ${p.name}"];
    String res =
        "${snakeActionName.replaceAll('_', '')}: (${header.join(',')}) =>";
    res += indent("store.dispatch($name(${body.join(',')})),", tabs: 4);
    return res;
  }

  @override
  int get hashCode => super.hashCode ^ name.hashCode;

  /// Two actions are equals when they have the same name and the same implementation,
  /// considering them without any whitespace.
  @override
  bool operator ==(Object other) {
    return super == other ||
        other is Action &&
            name == other.name &&
            removeAllWhitespaces(implementation.isEmpty
                    ? getDefaultImplementation()
                    : implementation) ==
                removeAllWhitespaces(other.implementation.isEmpty
                    ? other.getDefaultImplementation()
                    : other.implementation);
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
