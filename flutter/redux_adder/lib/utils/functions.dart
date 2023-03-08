import 'dart:convert';

import 'file_handler.dart';

String capitalize(String word) {
  return "${word[0].toUpperCase()}${word.substring(1)}";
}

String uncapitalize(String word) {
  return "${word[0].toLowerCase()}${word.substring(1)}";
}

String indent(String word, {int tabs = 0}) {
  return "\n${"\t" * tabs}$word";
}

String getActionFromName(String name, String stateName) {
  String capitalName = capitalize(name);
  return "Update$stateName${capitalName}Action";
}

String getSnakeActionName(String actionName) {
  return "_${actionName[0].toLowerCase()}${actionName.substring(1)}";
}

String camelToSnake(String word) {
  return [
    for (String i in word.split(''))
      // if the letter is uppercase, add an underscore in front of it
      i.toUpperCase() == i ? "_${i.toLowerCase()}" : i
  ].join().trim();
}

String snakeToCamel(String word) {
  List<String> components = word.split("_");
  return components[0] +
      [for (String i in components.sublist(1)) capitalize(i)].join();
}

String changeCase(String word) {
  return word.contains("_") ? snakeToCamel(word) : camelToSnake(word);
}

void printHeader(String word, {int size = 50}) {
  print("\n#${"-" * size}#");
  int spacing = ((size + 2) / 2 - (word.length / 2)).toInt();
  print("${" " * spacing}$word\n");
}

List<Map<String, dynamic>> getParamsFromUser() {
  return [
    {"type": "int", "name": "param1"},
    {"type": "bool", "name": "param2"},
    {"type": "List<int>", "name": "param3"},
  ];
}

List<dynamic> getNameParamsJson(inputFile) {
  String content = readFileSync(path: inputFile);
  Map<String, dynamic> jsonContent = jsonDecode(content);
  return [jsonContent["name"], jsonContent["params"]];
}

void main(List<String> args) {
  printHeader("Hello");
}
