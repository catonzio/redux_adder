import 'package:args/command_runner.dart';
import 'package:redux_adder/commands/command_init.dart';
import 'package:redux_adder/commands/command_new.dart';

void parseArguments(List<String> arguments) {
  CommandRunner("redux_adder",
      "\nPlugin used to create and modify Redux components.\nEach component consists of a State, ViewModel, Reducer, Action, Middleware and Widget files, enabling the state management across the app.")
    ..addCommand(CommandInit())
    ..addCommand(CommandNew())
    ..run(arguments);
}

void main(List<String> arguments) {
  // parseArguments(["init", "-d", "libr"]);
  parseArguments(["new", "-d", "inputs"]);
  // parseArguments(arguments);
}
