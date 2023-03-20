import 'package:redux/redux.dart';
import 'home/home_middleware.dart';
import 'prova/prova_middleware.dart';
import 'prova2/prova2_middleware.dart';
import 'prova3/prova3_middleware.dart';
import 'prova4/prova4_middleware.dart';
import 'app/app_state.dart';
import 'app/app_reducer.dart';

Store<AppState> createStore() {
	return Store(
		appReducer,
		initialState: AppState.initial(),
		distinct: true,
		middleware: [
			createHomeMiddleware(),
			createProvaMiddleware(),
			createProva2Middleware(),
			createProva3Middleware(),
			createProva4Middleware(),
		]
	);
}