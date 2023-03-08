import 'package:redux/redux.dart';
import '../app/app_state.dart';

Middleware<AppState> createHomeMiddleware() {
	return (Store<AppState> store, dynamic action, NextDispatcher next) async {
		next(action);
	};
}
