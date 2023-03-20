import 'package:redux/redux.dart';
import 'prova2_state.dart';
import 'prova2_action.dart';

final prova2Reducer = combineReducers<Prova2State>([
	TypedReducer<Prova2State, UpdateProva2Param1Action>(_updateProva2Param1Action),
	TypedReducer<Prova2State, UpdateProva2Param2Action>(_updateProva2Param2Action),
]);


Prova2State _updateProva2Param1Action(Prova2State state, UpdateProva2Param1Action action) {
	return state.copyWith(
		param1: action.param1,
	);
}

Prova2State _updateProva2Param2Action(Prova2State state, UpdateProva2Param2Action action) {
	return state.copyWith(
		param2: action.param2,
	);
}