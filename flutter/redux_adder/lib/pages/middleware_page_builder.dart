import 'package:redux_adder/pages/base_page.dart';
import 'package:redux_adder/utils/functions.dart';

class MiddlewarePageBuilder extends BasePage {
  final String baseName;
  final String middlewareName;

  MiddlewarePageBuilder({required this.baseName})
      : middlewareName = "create${capitalize(baseName)}Middleware";

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
