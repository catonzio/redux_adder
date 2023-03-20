import 'package:redux/redux.dart';
import 'prova3_state.dart';
import 'prova3_action.dart';

final prova3Reducer = combineReducers<Prova3State>([
	TypedReducer<Prova3State, UpdateProva3Param1Action>(_updateProva3Param1Action),
	TypedReducer<Prova3State, UpdateProva3Param2Action>(_updateProva3Param2Action),
	TypedReducer<Prova3State, UpdateProva3ListAction>(_updateProva3ListAction),
]);


Prova3State _updateProva3Param1Action(Prova3State state, UpdateProva3Param1Action action) {
	return state.copyWith(
		param1: action.param1,
	);
}

Prova3State _updateProva3Param2Action(Prova3State state, UpdateProva3Param2Action action) {
	return state.copyWith(
		param2: action.param2,
	);
}

Prova3State _updateProva3ListAction(Prova3State state, UpdateProva3ListAction action) {
	return state.copyWith(
		list: action.list,
	);
}