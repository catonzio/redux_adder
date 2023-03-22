import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:redux_adder/models/action.dart';
import 'package:redux_adder/models/parameter.dart';
import 'package:redux_adder/pages/default_pages.dart';
import 'package:redux_adder/utils/constants.dart';
import 'package:redux_adder/utils/file_handler.dart';

import '../models/component.dart';

/// This class represents the delete command.
/// It has one option, "--directory" or "-d", and one flag, "--yes" or "-y"
class CommandDelete extends Command {
  @override
  final name = "delete";
  @override
  final description = "delete the specified component";

  CommandDelete() {
    argParser.addOption("directory",
        abbr: "d",
        valueHelp: "path/to/component/directory",
        help: "The (relative) directory of the component to delete",
        mandatory: true);
    argParser.addFlag("yes",
        abbr: "y",
        defaultsTo: false,
        help: "Flag to determine if delete directly or not");
  }

  @override
  void run() {
    String directory = argResults!['directory'];
    deleteComponent(directory, delete: argResults!['yes']);
  }
}

/// <p>This function takes as input the path to the directory of the component to delete.<br>
/// The "delete" parameter is used when the there is the flag "-y"</p>
void deleteComponent(String directory, {required delete}) {
  List<String> splittedDirectory =
      directory.contains("/") ? directory.split("/") : directory.split("\\");
  // user can't delete app or store components
  if (splittedDirectory.last.toLowerCase() == "app" ||
      splittedDirectory.last.toLowerCase() == "store") {
    print("Cannot delete ${splittedDirectory.last} component!");
  } else {
    if (!delete) {
      print(
          "This will permanently delete the component located at $directory.");
      stdout.write("Do you whish to continue? [(y)/n] ");
      String? inp = stdin.readLineSync();
      delete = inp == null
          ? false
          : (inp.toLowerCase().contains("n") ? false : true);
    }
    if (delete) {
      // set the base path as the path to the parent of the folder of the component
      Constants.updateBasePath(
          splittedDirectory.sublist(0, splittedDirectory.length - 2).join("/"));
      // delete directory
      Directory(directory).deleteSync(recursive: true);
      print("Deleted component at $directory");
      // update app and store components
      List<Parameter> parameters = getFolderComponents();
      makeAppComponent(parameters);
      makeStorePage(parameters);
    }
  }
}
