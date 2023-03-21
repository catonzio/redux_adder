import 'package:redux_adder/models/action.dart';
import 'package:redux_adder/models/component.dart';
import 'package:redux_adder/models/parameter.dart';
import 'package:redux_adder/utils/constants.dart';
import 'package:redux_adder/utils/file_handler.dart';
import 'package:redux_adder/utils/functions.dart';

String getComponentsReducerDeclaration(
    List<Parameter> parameters, String stateName) {
  if (parameters.isEmpty) {
    return "";
  } else {
    String res = indent("(state, action) => state.copyWith(", tabs: 1);
    res += [
      for (var p in parameters)
        indent(
            "${p.name}: ${uncapitalize(p.name.replaceAll('State', ''))}Reducer(state.${p.name}, action),",
            tabs: 2)
    ].join("");
    res += indent(")", tabs: 1);
    return res;
  }
}

/// Creates a component scanning in the folder where are placed the files.
/// It scans the State file, the Action file and the Reducer file, searching for parameters
/// declarations and actions.
Component getComponentFromFolder(String componentPath) {
  String componentName = (componentPath.contains("/")
          ? componentPath.split("/")
          : componentPath.split("\\"))
      .last;
  List<Parameter> parameters = getParametersFromStateFile(
      [componentPath, "${componentName.toLowerCase()}_state.dart"].join("/"));
  Component component = Component(
      name: componentName,
      parameters: parameters,
      actions: getActionsFromFiles(
          // action file path
          [componentPath, "${componentName.toLowerCase()}_action.dart"]
              .join("/"),
          // reducer file path
          [componentPath, "${componentName.toLowerCase()}_reducer.dart"]
              .join("/")));
  return component;
}

List<Parameter> getParametersFromStateFile(String statePath) {
  String content = readFileSync(path: statePath);
  return extractParametersFromString(content);
}

/// Extracts the parameters of a Component from the string content of a file,
/// usually a definition of a Class.
List<Parameter> extractParametersFromString(String content) {
  List<Parameter> result = [];
  // get all the pieces containing the regex
  for (var c in getRegexContents(Constants.parameterRegex, content)) {
    List<String> param = c.split(" ");
    result.add(Parameter(
        type: param[1], name: param[2], isComp: param[1].contains("State")));
  }
  return result;
}

/// Scans through the actions file and reducer file to find all definitions of
/// actions and all the relative implementations
List<Action> getActionsFromFiles(String actionsPath, String reducerPath) {
  List<Action> result = [];
  // find all implementations.
  // key: action name, value: implementation
  Map<String, String> implementations =
      extractActionsImplementations(reducerPath);
  // get file content
  String actionsContent = readFileSync(path: actionsPath);
  // get the pieces containing the regex
  var matches = getRegexContents(Constants.actionRegex, actionsContent);
  // if the number of implementations and of actions definitions is different
  if (implementations.length != matches.length) {
    // something wrong
    throw Exception(
        "Error! Different number of actions between Actions and Reducer files!");
  }
  // for each action found
  for (int i = 0; i < matches.length; i++) {
    String actionContent = matches[i];
    // first action content is like "class ActionName {"
    String actionName = actionContent
        .split("\n")
        .first
        .replaceAll("class", "")
        .replaceAll("{", "")
        .trim();
    // extract parameters
    var parameters = extractParametersFromString(actionContent);

    // add new action to results
    result.add(Action(
        name: actionName,
        parameters: parameters,
        isAsync: false,
        implementation: implementations[actionName]!));
  }
  return result;
}

/// Scans the reducer file to find all the implementations of the actions
Map<String, String> extractActionsImplementations(String reducerPath) {
  // read file content
  String content = readFileSync(path: reducerPath);
  // TODO check if this code is required. Sometimes, when the code is reformatted
  // with VS Code, it is necessary

  // content = [
  //   for (var a in content.split("\n"))
  //     a.substring(0, a.length - 1 > 0 ? a.length - 1 : 0)
  // ].join("\n");

  // create result dict
  Map<String, String> d = {};
  for (var c
      in getRegexContents(Constants.actionImplementationRegex, content)) {
    // c is in the form State _actionName(State state, Action actionName)
    String actionName = getRegexContents(Constants.actionNameRegex, c)
        .first
        .split(" ")[1]
        .trim();
    // take everything between { and }
    String implementation = c
        .split("\n")
        .where((e) => !e.contains('{') && !e.contains('}'))
        .toList()
        .join("\n");
    d[actionName] = implementation;
  }
  return d;
}

/// Finds the parts in the content string that follows the regex, returning
/// a list of strings
List<String> getRegexContents(RegExp regex, String content) {
  return [
    for (var m in regex.allMatches(content)) content.substring(m.start, m.end)
  ];
}

void main(List<String> args) {
  getComponentFromFolder("libr\\redux\\prova4").refreshReduxComponent();
  /*print([
    for (var a in getActionsFromFiles("libr\\redux\\prova4\\prova4_action.dart",
        "libr\\redux\\prova4\\prova4_reducer.dart"))
      "${a.toJson()}\n"
  ]);*/
}
