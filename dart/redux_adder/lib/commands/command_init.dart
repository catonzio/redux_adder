import 'package:args/command_runner.dart';
import '../models/parameter.dart';
import '../pages/default_pages.dart';
import '../utils/constants.dart';
import '../utils/file_handler.dart';

class CommandInit extends Command {
  @override
  final name = "init";
  @override
  final description = "initialize the project";

  CommandInit() {
    argParser.addOption("directory",
        abbr: "d",
        valueHelp: "lib",
        defaultsTo: "lib/redux",
        help: "the (relative) directory in which initialize the app");
  }

  @override
  void run() {
    String dir = argResults!['directory'];
    Constants.updateBasePath(dir);
    initProject();
  }
}

void initProject() async {
  await makeHomepageComponent();
  List<Parameter> parameters = getFolderComponents();
  makeAppComponent(parameters);
  makeStorePage(parameters);
  makeMainPage();
  makeKeysPage();
  makeRouteGenerator(parameters);
  print("\nUse the following commands to install the needed packages:");
  print(
      "\tflutter pub add flutter_redux\t(https://pub.dev/packages/flutter_redux)");
  print("\tflutter pub add redux\t\t(https://pub.dev/packages/redux)");
  print("Have a nice day 😊");
}
