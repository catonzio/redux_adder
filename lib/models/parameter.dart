import '../utils/functions.dart';

/// Class representing a parameter.
///
/// It has a type, a name and whether it refers to another component.
class Parameter {
  /// The type of the parameter
  final String type;

  /// The name of the parameter
  final String name;

  /// Whether the parameter refers to another component
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

  /// Generates a default initialization of this parameter, depending on its type
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

  /// The declaration of the parameter in the copyWith method, e.g.
  /// ```dart
  /// int? param,
  /// ```
  String getCopyWithArgument() {
    return "$type? $name,";
  }

  /// The body of the parameter in the copyWith method, e.g.
  /// ```dart
  /// param: param ?? this.param,
  /// ```
  String getCopyWithBody() {
    return "$name: $name ?? this.$name,";
  }

  /// Generates the conversion of the json value to the parameter, depending on the fact
  /// that this parameter refers to another component. For example,
  /// ```dart
  /// param: jsonDecode(json['param']),
  /// ```
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

  /// Generates the conversion of the parameter to the json value, depending on the fact
  /// that this parameter refers to another component. For example,
  /// ```dart
  /// 'param': jsonEncode(param),
  /// ```
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

  /// Generates the parameter's equality check, e.g.
  /// ```dart
  /// param == other.param
  /// ```
  String getParameterEquals() {
    return !(type.toLowerCase().contains("function"))
        ? "$name == other.$name"
        : "";
  }

  /// Generates the parameter's hash code computation, e.g.
  /// ```dart
  /// param.hashCode
  /// ```
  String getParameterHashcode() {
    return !(type.toLowerCase().contains("function")) ? "$name.hashCode" : "";
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
