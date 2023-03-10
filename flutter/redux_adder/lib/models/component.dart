import 'package:redux_adder/models/action.dart';
import 'package:redux_adder/models/parameter.dart';

class Component {
  final String name;
  final List<Parameter> parameters;
  final List<Action> actions;

  Component(
      {required this.name, required this.parameters, required this.actions});

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
        name: json['name'],
        parameters: [for (var j in json['parameters']) Parameter.fromJson(j)],
        actions: [for (var j in json['actions']) Action.fromJson(j)]);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'parameters': [for (var p in parameters) p.toJson()],
        'actions': [for (var a in actions) a.toJson()]
      };
}
