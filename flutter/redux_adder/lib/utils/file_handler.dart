import 'dart:io';
import 'package:path/path.dart';
import 'package:redux_adder/utils/constants.dart';
import 'package:redux_adder/utils/functions.dart';

Future<bool> writeFile({required path, required content}) async {
  try {
    File file = File(path);
    await file.create(recursive: true);
    await file.writeAsString(content);
    return true;
  } catch (ex) {
    return false;
  }
}

Future<String> readFile({required path}) async {
  try {
    File file = File(path);
    return await file.readAsString();
  } catch (ex) {
    return Future.value("");
  }
}

String readFileSync({required path}) {
  try {
    File file = File(path);
    return file.readAsStringSync();
  } catch (ex) {
    return "";
  }
}

Future<void> writePages(String componentName, List<List<String>> pages,
    {String dir = ""}) async {
  dir = dir.isEmpty ? Constants.basePath : dir;
  printHeader(componentName);
  for (List pagePost in pages) {
    String page = pagePost[0], post = pagePost[1];
    String filePath =
        [dir, componentName, "${componentName}_$post.dart"].join("/");
    print("Writing $post in ${absolute(filePath)}");
    writeFile(path: filePath, content: page);
  }
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

void main(List<String> args) {
  writePages("prova", [
    ["contenuto 1", "state"],
    ["contenuto 2", "vm"]
  ]);
}
