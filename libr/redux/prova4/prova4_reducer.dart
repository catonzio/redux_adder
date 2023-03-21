import 'package:redux/redux.dart';
import 'prova4_state.dart';
import 'prova4_action.dart';

final prova4Reducer = combineReducers<Prova4State>([
	TypedReducer<Prova4State, Action1>(_action1),
	TypedReducer<Prova4State, Action2>(_action2),
	TypedReducer<Prova4State, UpdateProva4Param1Action>(_updateProva4Param1Action),
	TypedReducer<Prova4State, UpdateProva4Param2Action>(_updateProva4Param2Action),
	TypedReducer<Prova4State, Aggiunta>(_aggiunta),
	(state, action) => state.copyWith(
		prova3: prova3Reducer(state.prova3, action),
		prova2: prova2Reducer(state.prova2, action),
	)
]);


Prova4State _action1(Prova4State state, Action1 action) {
		  return state.copyWith(param1: action.param1);
}

Prova4State _action2(Prova4State state, Action2 action) {
		  return state.copyWith(param2: action.param2);
}

Prova4State _updateProva4Param1Action(Prova4State state, UpdateProva4Param1Action action) {
	  return state.copyWith(
    param1: action.param1,
  );
}

Prova4State _updateProva4Param2Action(Prova4State state, UpdateProva4Param2Action action) {
	  return state.copyWith(
    param2: action.param2,
  );
}

Prova4State _aggiunta(Prova4State state, Aggiunta action) {
		  return state.copyWith(
    param1: action.asd,
  );
}