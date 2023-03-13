import 'package:redux_adder/models/parameter.dart';
import 'package:redux_adder/utils/functions.dart';

import '../models/action.dart';

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

/*String getParameterReducerImplementation(
    Parameter parameter, String stateName) {
  String actionName =
      getActionFromName(parameter.name, stateName.replaceAll("State", ""));
  String snakeActionName = getSnakeActionName(actionName);
  String res =
      "$stateName $snakeActionName($stateName state, $actionName action) {";
  res += indent("return state.copyWith(", tabs: 1);
  res += indent("${parameter.name}: action.value", tabs: 2);
  res += indent(")", tabs: 1);
  res += indent("}");
  return res;
}*/


