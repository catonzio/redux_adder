import 'package:args/command_runner.dart';
import 'package:redux_adder/redux_adder.dart';

class CommandNew extends Command {
  @override
  final name = "new";
  @override
  final description = "create new component(s)";

  CommandNew() {
    argParser.addOption("directory",
        abbr: "d",
        valueHelp: "path/to/directory",
        help:
            "The (relative) directory from which to take component skeletons");
    argParser.addOption("file",
        abbr: "f",
        valueHelp: "path/to/file.json",
        help: "The (relative) file from which to take component skeleton");
  }

  @override
  void run() {
    String? directory = argResults!['directory'];
    String? file = argResults!['file'];
    print("Directory: $directory\nFile: $file");
    newReduxComponent(inputFile: file, inputDirectory: directory);
  }
}
