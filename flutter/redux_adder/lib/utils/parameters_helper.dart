import 'package:redux_adder/utils/functions.dart';

String getParameterDeclaration(Map<String, dynamic> parameter) {
  return "final ${parameter['type']} ${parameter['name']};";
}

String getParameterConstructor(Map<String, dynamic> parameter) {
  return "${parameter['type']!.endsWith('?') ? '' : 'required '}this.${parameter['name']}";
}

String getParameterInitialization(Map<String, dynamic> parameter) {
  String type = parameter['type'];
  String initialization = "";
  if (parameter['is_comp']) {
    initialization = "${parameter['type']}.initial()";
  } else if (!type.endsWith('?')) {
    switch (type) {
      case "int":
        initialization = "0";
        break;
      case "String":
        initialization = "\"\"";
        break;
      case "bool":
        initialization = "false";
        break;
      case "DateTime":
        initialization = "DateTime.now()";
        break;
    }
    if (type.contains("List")) {
      String newType = type.substring(type.indexOf('<') + 1, type.indexOf('>'));
      initialization = "<$newType>[]";
    }
  }
  return type.endsWith("?") ? "" : "${parameter['name']}: $initialization,";
}

String getCopyWithArgument(Map<String, dynamic> parameter) {
  return parameter['type'] + "? " + parameter['name'] + ",";
}

String getCopyWithBody(Map<String, dynamic> parameter) {
  return parameter['name'] +
      ": " +
      parameter['name'] +
      " ?? this." +
      parameter['name'] +
      ",";
}

String getParameterFromJson(Map<String, dynamic> parameter) {
  if (parameter['type'].toLowerCase().contains("function")) {
    return "";
  } else {
    if (parameter['is_comp']) {
      return "'${parameter['name']}': ${parameter['name']}.toJson(),";
    } else {
      return "'${parameter['name']}': jsonEncode(${parameter['name']}),";
    }
  }
}

String getParameterFunctionVm(
    Map<String, dynamic> parameter, String actionName) {
  String name = parameter['name'], type = parameter['type'];
  String result = "$name: ($type value) =>";
  result += indent("store.dispatch($actionName(value: value)),", tabs: 3);
  return result;
}

String getParamReducerDeclaration(
    Map<String, dynamic> parameter, String stateName) {
  if (parameter['is_comp']) {
    String res = "(state, action) =>";
    res += indent(
        "${uncapitalize(parameter['name'].replaceAll('State', ''))}Reducer(state, action),",
        tabs: 2);
    return res;
  } else {
    String actionName =
        getActionFromName(parameter['name'], stateName.replaceAll("State", ""));
    String snakeActionName = getSnakeActionName(actionName);
    return "TypedReducer<$stateName, $actionName>($snakeActionName),";
  }
}

String getComponentsReducerDeclaration(
    List<Map<String, dynamic>> parameters, String stateName) {
  if (parameters.isEmpty) {
    return "";
  } else {
    String res = indent("(state, action) => $stateName(", tabs: 1);
    res += [
      for (var p in parameters)
        indent(
            "${p['name']}: ${uncapitalize(p['name'].replaceAll('State', ''))}Reducer(state.${p['name']}, action),",
            tabs: 2)
    ].join("");
    res += indent(")", tabs: 1);
    return res;
  }
}

String getParameterReducerImplementation(
    Map<String, dynamic> parameter, String stateName) {
  return "";
}
