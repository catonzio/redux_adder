import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:redux_adder/utils/constants.dart';

import '../models/component.dart';
import '../models/parameter.dart';
import '../pages/default_pages.dart';
import '../utils/file_handler.dart';
import '../utils/functions.dart';

class CommandRefresh extends Command {
  @override
  final name = "refresh";
  @override
  final description =
      "refresh existing component(s), creating it if it (they) doesn't exist";

  CommandRefresh() {
    argParser.addOption("directory",
        abbr: "d",
        valueHelp: "path/to/directory",
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
    refreshReduxComponent(inputFile: file, inputDirectory: directory);
  }
}

Future<void> refreshReduxComponent(
    {String? inputFile, String? inputDirectory}) async {
  bool appAndStore = true;
  if (inputFile == null && inputDirectory == null) {
    print(
        "Error! You must specify either the input file or the input directory.");
    appAndStore = false;
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

  if (appAndStore) {
    List<Parameter> parameters = getFolderComponents();
    makeAppComponent(parameters);
    makeStorePage(parameters);
  }
}
