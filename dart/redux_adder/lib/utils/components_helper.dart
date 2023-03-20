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

Component getComponentFromFiles(String componentPath) {
  String componentName = (componentPath.contains("/")
          ? componentPath.split("/")
          : componentPath.split("\\"))
      .last;
  List<Parameter> parameters = getParametersFromStateFile(
      [componentPath, "${componentName.toLowerCase()}_state.dart"].join("/"));
  Component component =
      Component(name: componentName, parameters: parameters, actions: []);
  return component;
}

List<Parameter> getParametersFromStateFile(String statePath) {
  List<Parameter> result = [];
  String content = readFileSync(path: statePath);

  for (var m in Constants.parameterRegex.allMatches(content)) {
    int start = m.start, end = m.end;
    List<String> param = content.substring(start, end).split(" ");
    result.add(Parameter(
        type: param[1], name: param[2], isComp: param[1].contains("State")));
  }
  return result;
}

List<Action> getActionsFromFiles(String actionsPath, String reducerPath) {
  List<Action> result = [];
  String actionsContent = readFileSync(path: actionsPath);
  for (var m in Constants.actionRegex.allMatches(actionsContent)) {
    int start = m.start, end = m.end;
    print(actionsContent.substring(start, end));
  }
  return result;
}

void main(List<String> args) {
  // print(getComponentFromFiles("libr\\redux\\prova4").toJson());
  print(getActionsFromFiles("libr\\redux\\prova4\\prova4_action.dart",
      "libr\\redux\\prova4\\prova4_reducer.dart"));
}
