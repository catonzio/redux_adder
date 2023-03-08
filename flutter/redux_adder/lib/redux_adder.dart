import 'dart:convert';
import 'dart:io';

import 'package:redux_adder/pages/default_pages.dart';
import 'package:redux_adder/utils/constants.dart';
import 'package:redux_adder/utils/file_handler.dart';
import 'package:redux_adder/utils/functions.dart';

void handleArguments() {
  newReduxComponent(inputFile: "inputs/prova.json");
}

Future<void> newReduxComponent(
    {String? inputFile, String? inputDirectory}) async {
  printHeader("Creating new component");

  if (inputFile == null && inputDirectory == null) {
    stdout.write("Insert the name of the component (snake_case): ");
    String? componentName = stdin.readLineSync();
    List<Map<String, dynamic>> parameters = getParamsFromUser();
    writeReduxComponent(componentName!, parameters);
  } else if (inputFile != null && inputDirectory == null) {
    List<dynamic> nameParams = getNameParamsJson(inputFile);
    writeReduxComponent(nameParams[0], nameParams[1]);
  } else if (inputFile == null && inputDirectory != null) {
    List<String> filesPaths = await getFilesInDirectory(inputDirectory);
    List<List<dynamic>> namesParams = [
      for (var f in filesPaths) getNameParamsJson(f)
    ];

    for (var np in namesParams) {
      writeReduxComponent(np[0], np[1]);
    }
  }

  List<Map<String, dynamic>> parameters = await getFolderComponents();
  makeAppComponent(parameters);
  makeStorePage(parameters);
}

Future<List<Map<String, dynamic>>> getFolderComponents() async {
  final dir = Directory(Constants.basePath);
  final List<FileSystemEntity> entities = await dir.list().toList();
  final List<String> names = [
    for (var e in entities)
      if (FileSystemEntity.isDirectorySync(e.path) && !e.path.contains("app"))
        e.path.split("\\").last
  ];
  return [
    for (String n in names)
      {
        "type": "${capitalize(n)}State",
        "name": "${n}State",
        "is_comp": true,
      }
  ];
}

Future<List<String>> getFilesInDirectory(inputDirectory) async {
  final dir = Directory(inputDirectory);
  final List<FileSystemEntity> entities = await dir.list().toList();
  return [
    for (var e in entities)
      if (FileSystemEntity.isFileSync(e.path)) e.path
  ];
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
  Map<dynamic, dynamic> jsonContent = jsonDecode(content);
  return [jsonContent["name"], jsonContent["params"]];
}
