import 'package:redux/redux.dart';
import 'app_state.dart';
import '../home/home_reducer.dart';import '../prova/prova_reducer.dart';import '../prova2/prova2_reducer.dart';import '../prova3/prova3_reducer.dart';import '../prova4/prova4_reducer.dart';

final appReducer = combineReducers<AppState>([
	(state, action) => state.copyWith(
		homeState: homeReducer(state.homeState, action),
		provaState: provaReducer(state.provaState, action),
		prova2State: prova2Reducer(state.prova2State, action),
		prova3State: prova3Reducer(state.prova3State, action),
		prova4State: prova4Reducer(state.prova4State, action),
	)
]);