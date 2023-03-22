import 'dart:convert';

import 'package:redux_adder/models/parameter.dart';

import '../models/component.dart';
import 'file_handler.dart';

/// Capitalizes a given [word]
String capitalize(String word) {
  return "${word[0].toUpperCase()}${word.substring(1)}";
}

/// Uncapitalizes a given [word]
String uncapitalize(String word) {
  return "${word[0].toLowerCase()}${word.substring(1)}";
}

/// Wraps the word with a newline and a number of [tabs]
String indent(String word, {int tabs = 0}) {
  return "\n${"\t" * tabs}$word";
}

/// Given the [name] of a parameter and the [stateName],
/// generates the name of the action, e.g.
/// ```dart
/// Update{StateName}{ParamName}Action
/// ```
String getActionFromName(String name, String stateName) {
  String capitalName = capitalize(name);
  return "Update$stateName${capitalName}Action";
}

/// Given the [actionName], generates the corresponding "snake" action name,
/// uncapitalizing the [actionName] and adding an underscore at beginning
String getSnakeActionName(String actionName) {
  return "_${actionName[0].toLowerCase()}${actionName.substring(1)}";
}

/// Converts a [word] from camelCase to snake_case
String camelToSnake(String word) {
  return [
    for (String i in word.split(''))
      // if the letter is uppercase, add an underscore in front of it
      i.toUpperCase() == i ? "_${i.toLowerCase()}" : i
  ].join().trim();
}

/// Converts a [word] from snake_case to camelCase
String snakeToCamel(String word) {
  List<String> components = word.split("_");
  return components[0] +
      [for (String i in components.sublist(1)) capitalize(i)].join();
}

/// Changes the case of a [word], depending on actual case
String changeCase(String word) {
  return word.contains("_") ? snakeToCamel(word) : camelToSnake(word);
}

/// Prints a given number of '#' characters and on a new line, centered with the
/// above line, prints the given [word]
void printHeader(String word, {int size = 50}) {
  print("\n#${"-" * size}#");
  int spacing = ((size + 2) / 2 - (word.length / 2)).toInt();
  print("${" " * spacing}$word\n");
}

/// DEPRECATED
List<Parameter> getParamsFromUser() {
  return [
    Parameter.fromJson({"type": "int", "name": "param1"}),
    Parameter.fromJson({"type": "bool", "name": "param2"}),
    Parameter.fromJson({"type": "List<int>", "name": "param3"}),
  ];
}

/// Parses a json file, located at [inputFile], and creates a component from it
Component getComponentFromJson(String inputFile) {
  String content = readFileSync(path: inputFile);
  if (content != "invalid") {
    return Component.fromJson(jsonDecode(content));
  } else {
    return Component.initial();
  }
}

/// Whether a given [type] is a function
bool isFunction(String type) {
  return type.toLowerCase().contains("function");
}

/// Removes all " ", "\t", "\n" characters from the given [word]
String removeAllWhitespaces(String word) {
  return word.replaceAll(" ", "").replaceAll("\t", "").replaceAll("\n", "");
}

void main(List<String> args) {
  print(getComponentFromJson("inputs/rova_con_actions.json").toJson());
}
