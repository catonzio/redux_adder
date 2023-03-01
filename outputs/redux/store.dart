
import 'app/app_state.dart';
import 'app/app_reducer.dart';

Store<AppState> createStore() {
	return Store(
		appReducer,
		initialState: AppState.initial(),
		distrinct: true,
		middleware: [
		]
	);
}