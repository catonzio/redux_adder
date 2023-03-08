import 'dart:io';
import 'package:redux_adder/pages/default_pages.dart';
import 'package:redux_adder/utils/file_handler.dart';
import 'package:redux_adder/utils/functions.dart';

void handleArguments() {
  // newReduxComponent(inputFile: "inputs/prova.json");
  initProject();
}

Future<void> newReduxComponent(
    {String? inputFile, String? inputDirectory}) async {
  printHeader("Creating new component");

  if (inputFile == null && inputDirectory == null) {
    stdout.write("Insert the name of the component (snake_case): ");
    String? componentName = stdin.readLineSync();
    List<Map<String, dynamic>> parameters = getParamsFromUser();
    writeReduxComponent(componentName!, parameters);
  } else if (inputFile != null && inputDirectory == null) {
    List<dynamic> nameParams = getNameParamsJson(inputFile);
    writeReduxComponent(nameParams[0], nameParams[1]);
  } else if (inputFile == null && inputDirectory != null) {
    List<String> filesPaths = await getFilesInDirectory(inputDirectory);
    List<List<dynamic>> namesParams = [
      for (var f in filesPaths) getNameParamsJson(f)
    ];

    for (var np in namesParams) {
      writeReduxComponent(np[0], np[1]);
    }
  }

  List<Map<String, dynamic>> parameters = await getFolderComponents();
  makeAppComponent(parameters);
  makeStorePage(parameters);
}

void initProject() async {
  await makeHomepageComponent();
  List<Map<String, dynamic>> parameters = await getFolderComponents();
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
