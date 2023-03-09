import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:redux_adder/redux_adder.dart';
import 'package:redux_adder/utils/constants.dart';

void parseArguments(List<String> arguments) {
  // var parser = ArgParser();
  // var commandNew = parser.addCommand("new");
  // commandNew.addOption("file", abbr: "f");
  // commandNew.addOption("directory", abbr: "d");

  // parser.addCommand("init");
  // ArgResults results = parser.parse(arguments);
  // return results;
  var runner = CommandRunner("ReduxAdder", "Description")
    ..addCommand(CommandInit())
    ..addCommand(CommandNew())
    ..run(arguments);
}

class CommandInit extends Command {
  @override
  final name = "init";
  @override
  final description = "description";

  CommandInit() {
    argParser.addOption("directory", abbr: "d", defaultsTo: "libr/redux");
  }

  @override
  void run() {
    // print(argResults!['directory']);
    Constants.basePath = argResults!['directory'];
  }
}

class CommandNew extends Command {
  @override
  final name = "new";
  @override
  final description = "description";

  CommandNew() {
    argParser.addOption("directory",
        abbr: "d", valueHelp: "Help with directory", defaultsTo: "inputs");
    argParser.addOption("file", abbr: "f");
  }

  @override
  void run() {
    print(argResults!['directory']);
    Constants.basePath = argResults!['directory'];
    print(argResults!['file']);
  }
}

void main(List<String> arguments) {
  // handleArguments();
  parseArguments(["init", "-d", "libretto"]);
  // parseArguments(["new", "-d", "libretto"]);
  print("Base path: ${Constants.basePath}");
  // parseArguments(arguments);
}
