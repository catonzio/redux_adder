import 'package:redux/redux.dart';
import 'app_state.dart';
import '../home/home_reducer.dart';

final appReducer = combineReducers<AppState>([
	(state, action) => AppState(
		homeState: homeReducer(state.homeState, action),
	)
]);