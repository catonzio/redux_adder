import 'package:redux_adder/pages/base_page.dart';
import '../models/action.dart';
class MiddlewarePageBuilder extends BasePage {
  final String middlewareName;
  final List<Action> asyncActions;

  MiddlewarePageBuilder({required this.middlewareName, required this.asyncActions});

  @override
  String buildPage() {
    String res = """
import 'package:redux/redux.dart';
import '../app/app_state.dart';

Middleware<AppState> $middlewareName() {
	return (Store<AppState> store, dynamic action, NextDispatcher next) async {
		next(action);
	};
}
""";
    return res;
  }
}
