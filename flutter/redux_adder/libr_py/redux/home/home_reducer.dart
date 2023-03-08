import 'package:redux/redux.dart';
import 'home_state.dart';
import 'home_action.dart';

final homeReducer = combineReducers<HomeState>([
	TypedReducer<HomeState, UpdateHomeCounterAction>(_updateHomeCounterAction),
]);

HomeState _updateHomeCounterAction(HomeState state, UpdateHomeCounterAction action) {
	return state.copyWith(
		counter: action.value
	);
}
