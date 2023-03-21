import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:redux_adder/utils/constants.dart';

import '../models/component.dart';
import '../models/parameter.dart';
import '../pages/default_pages.dart';
import '../utils/file_handler.dart';
import '../utils/functions.dart';

class CommandNew extends Command {
  @override
  final name = "new";
  @override
  final description = "create new component(s)";

  CommandNew() {
    argParser.addOption("directory",
        abbr: "d",
        valueHelp: "path/to/directory",
        // defaultsTo: Constants.jsonModelsPath,
        help:
            "The (relative) directory from which to take component skeletons");
    argParser.addOption("file",
        abbr: "f",
        valueHelp: "path/to/file.json",
        help: "The (relative) file from which to take component skeleton");
    argParser.addOption("output",
        abbr: "o",
        valueHelp: "path/to/output/folder",
        help: "The (relative) directory in which save the new component");
  }

  @override
  void run() {
    String? directory = argResults!['directory'];
    String? file = argResults!['file'];
    String? output = argResults!['output'];
    if (output != null) {
      Constants.updateBasePath(output);
    }
    newReduxComponent(inputFile: file, inputDirectory: directory);
  }
}

Future<void> newReduxComponent(
    {String? inputFile, String? inputDirectory}) async {
  printHeader("Creating new component");

  if (inputFile == null && inputDirectory == null) {
    stdout.write("Insert the name of the component (snake_case): ");
    String componentName = snakeToCamel(stdin.readLineSync() ?? "");
    List<Parameter> parameters = getParamsFromUser();
    Component component =
        Component(name: componentName, actions: [], parameters: parameters);
    component.writeReduxComponent();
    // writeReduxComponent(componentName!, parameters);
  } else if (inputFile != null && inputDirectory == null) {
    Component component = getComponentFromJson(inputFile);
    component.writeReduxComponent();
  } else if (inputFile == null && inputDirectory != null) {
    List<String> filesPaths = await getFilesInDirectory(inputDirectory);
    List<Component> components = [
      for (var f in filesPaths) getComponentFromJson(f)
    ];

    for (var c in components) {
      c.writeReduxComponent();
    }
  }

  List<Parameter> parameters = getFolderComponents();
  makeAppComponent(parameters);
  makeStorePage(parameters);
}
