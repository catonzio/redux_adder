import 'package:redux_adder/models/parameter.dart';

class Action {
  final String name;
  final List<Parameter> parameters;
  final String implementation;
  final bool isAsync;

  Action(
      {required this.name,
      required this.parameters,
      required this.implementation,
      required this.isAsync});

  factory Action.fromJson(Map<String, dynamic> json) {
    return Action(
        name: json['name'],
        parameters: [for (var j in json['parameters']) Parameter.fromJson(j)],
        implementation: json['implementation'],
        isAsync: json['async']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'parameters': [for (var p in parameters) p.toJson()],
        'implementation': implementation,
        'async': isAsync,
      };
}
