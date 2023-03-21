import 'package:args/command_runner.dart';
import 'package:redux_adder/commands/command_delete.dart';
import 'package:redux_adder/commands/command_init.dart';
import 'package:redux_adder/commands/command_new.dart';

void parseArguments(List<String> arguments) {
  CommandRunner("redux_adder",
      "\nPlugin used to create and modify Redux components.\nEach component consists of a State, ViewModel, Reducer, Action, Middleware and Widget files, enabling the state management across the app.")
    ..addCommand(CommandInit())
    ..addCommand(CommandNew())
    ..addCommand(CommandDelete())
    ..run(arguments);
}

void main(List<String> arguments) async {
  // parseArguments(["init", "-d", "libr"]);
  // parseArguments(["new", "-d", "inputs", "-o", "libr"]);
  // parseArguments(["delete", "-d", "libr/redux/prova2", "-y"]);
  parseArguments(arguments);
}
