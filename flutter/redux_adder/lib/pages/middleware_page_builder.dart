import 'package:redux_adder/models/parameter.dart';
import 'package:redux_adder/pages/base_page.dart';
import '../models/action.dart';
import '../utils/functions.dart';

class MiddlewarePageBuilder extends BasePage {
  final String middlewareName;
  final List<Action> asyncActions;

  MiddlewarePageBuilder(
      {required this.middlewareName, required this.asyncActions});

  @override
  String buildPage() {
    String res = """
import 'package:redux/redux.dart';
import '../app/app_state.dart';

Middleware<AppState> $middlewareName() {
	return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    ${getActionsDeclarations()}
		next(action);
	};
}
""";
    return res;
  }

  String getActionsDeclarations() {
    if (asyncActions.isEmpty) {
      return "";
    }
    return [
      for (var a in asyncActions)
        indent("if (action is ${a.name}) {\n", tabs: 2) + indent("}", tabs: 2)
    ].join();
  }
}

void main(List<String> args) {
  var mdpg = MiddlewarePageBuilder(middlewareName: "middleware", asyncActions: [
    Action(
        name: "Prova",
        parameters: [
          Parameter(type: "int", name: "par1"),
          Parameter(type: "bool", name: "par2")
        ],
        isAsync: true),
    Action(
        name: "Prova",
        parameters: [
          Parameter(type: "int", name: "par1"),
          Parameter(type: "bool", name: "par2")
        ],
        isAsync: true)
  ]);
  print(mdpg.buildPage());
}
