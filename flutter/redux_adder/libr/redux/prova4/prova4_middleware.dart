import 'package:redux/redux.dart';
import '../app/app_state.dart';

Middleware<AppState> createProva4Middleware() {
	return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    
		if (action is Action1) {

		}
		next(action);
	};
}
