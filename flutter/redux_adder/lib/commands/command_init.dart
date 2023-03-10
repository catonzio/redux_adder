import 'package:args/command_runner.dart';
import 'package:redux_adder/redux_adder.dart';
import '../utils/constants.dart';

class CommandInit extends Command {
  @override
  final name = "init";
  @override
  final description = "initialize the project";

  CommandInit() {
    argParser.addOption("directory",
        abbr: "d",
        valueHelp: "lib",
        defaultsTo: "libr/redux",
        help: "the (relative) directory in which initialize the app");
  }

  @override
  void run() {
    String dir = argResults!['directory'];
    Constants.basePath =
        dir + (dir.toLowerCase().contains("redux") ? "" : "/redux");
    initProject();
  }
}
