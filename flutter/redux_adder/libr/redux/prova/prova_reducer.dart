import 'package:redux/redux.dart';
import 'prova_state.dart';
import 'prova_action.dart';

final provaReducer = combineReducers<ProvaState>([
	TypedReducer<ProvaState, UpdateProvaParam1Action>(_updateProvaParam1Action),
	TypedReducer<ProvaState, UpdateProvaParam2Action>(_updateProvaParam2Action),
]);


ProvaState _updateProvaParam1Action(ProvaState state, UpdateProvaParam1Action action) {
	return state.copyWith(
		param1: action.param1,
	);
}

ProvaState _updateProvaParam2Action(ProvaState state, UpdateProvaParam2Action action) {
	return state.copyWith(
		param2: action.param2,
	);
}