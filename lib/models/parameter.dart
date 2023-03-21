import '../utils/functions.dart';

class Parameter {
  final String type;
  final String name;
  final bool isComp;

  Parameter({required this.type, required this.name, this.isComp = false});

  factory Parameter.fromJson(Map<String, dynamic> json) {
    return Parameter(
        type: json['type'],
        name: json['name'],
        isComp: json['is_comp'] ?? false);
  }

  Map<String, dynamic> toJson() =>
      {'type': type, 'name': name, 'is_comp': isComp};

  String getParameterDeclaration() {
    return "final $type $name;";
  }

  String getParameterConstructor() {
    return "${type.endsWith('?') ? '' : 'required '}this.$name";
  }

  String getParameterInitialization() {
    String initialization = "";
    if (isComp) {
      initialization = "$type.initial()";
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
        String newType =
            type.substring(type.indexOf('<') + 1, type.indexOf('>'));
        initialization = "<$newType>[]";
      }
    }
    return type.endsWith("?") ? "" : "$name: $initialization,";
  }

  String getCopyWithArgument() {
    return "$type? $name,";
  }

  String getCopyWithBody() {
    return "$name: $name ?? this.$name,";
  }

  String getParameterFromJson() {
    if (type.toLowerCase().contains("function")) {
      return "";
    } else {
      if (isComp) {
        return "$name: $type.fromJson(json['$name']),";
      } else {
        return "$name: jsonDecode(json['$name']),";
      }
    }
  }

  String getParameterToJson() {
    if (isFunction(type)) {
      return "";
    } else {
      if (isComp) {
        return "'$name': $name.toJson(),";
      } else {
        return "'$name': jsonEncode($name),";
      }
    }
  }

  String getParameterEquals() {
    return !(type.toLowerCase().contains("function"))
        ? "$name == other.$name"
        : "";
  }

  String getParameterHashcode() {
    return !(type.toLowerCase().contains("function")) ? "$name.hashCode" : "";
  }

  String getParamReducerDeclaration(String stateName) {
    if (isComp) {
      String res = "(state, action) =>";
      res += indent(
          "${uncapitalize(name.replaceAll('State', ''))}Reducer(state, action),",
          tabs: 2);
      return res;
    } else {
      String actionName =
          getActionFromName(name, stateName.replaceAll("State", ""));
      String snakeActionName = getSnakeActionName(actionName);
      return "TypedReducer<$stateName, $actionName>($snakeActionName),";
    }
  }

  @override
  int get hashCode =>
      super.hashCode ^ name.hashCode ^ type.hashCode ^ isComp.hashCode;

  @override
  bool operator ==(Object other) {
    return super == other ||
        other is Parameter &&
            name == other.name &&
            type == other.type &&
            isComp == other.isComp;
  }
}
