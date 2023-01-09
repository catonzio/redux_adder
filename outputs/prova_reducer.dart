final provaReducer = combineReducers<ProvaState>([
	TypedReducer<ProvaState, UpdateProvaStateIsFetchingAction>(_updateProvaStateIsFetchingAction),
	TypedReducer<ProvaState, UpdateProvaStateHasErrorAction>(_updateProvaStateHasErrorAction),
	TypedReducer<ProvaState, UpdateProvaStateIdAction>(_updateProvaStateIdAction),
	TypedReducer<ProvaState, UpdateProvaStateNomeAction>(_updateProvaStateNomeAction),
	TypedReducer<ProvaState, UpdateProvaStateIndirizzoAction>(_updateProvaStateIndirizzoAction),
]);

ProvaState _updateProvaStateIsFetchingAction(ProvaState state, UpdateProvaStateIsFetchingAction action) {
	return state.copyWith(
		isFetching: action.value
	);
}

ProvaState _updateProvaStateHasErrorAction(ProvaState state, UpdateProvaStateHasErrorAction action) {
	return state.copyWith(
		hasError: action.value
	);
}

ProvaState _updateProvaStateIdAction(ProvaState state, UpdateProvaStateIdAction action) {
	return state.copyWith(
		id: action.value
	);
}

ProvaState _updateProvaStateNomeAction(ProvaState state, UpdateProvaStateNomeAction action) {
	return state.copyWith(
		nome: action.value
	);
}

ProvaState _updateProvaStateIndirizzoAction(ProvaState state, UpdateProvaStateIndirizzoAction action) {
	return state.copyWith(
		indirizzo: action.value
	);
}
