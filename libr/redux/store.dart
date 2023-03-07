import 'package:redux/redux.dart';
import 'home/home_middleware.dart';
import 'app/app_state.dart';
import 'app/app_reducer.dart';

Store<AppState> createStore() {
	return Store(
		appReducer,
		initialState: AppState.initial(),
		distinct: true,
		middleware: [
			createHomeMiddleware(),
		]
	);
}