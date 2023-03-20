import 'dart:convert';
import '../app/app_state.dart';
import 'package:redux/redux.dart';
import 'prova3_state.dart';
import 'prova3_action.dart';

class Prova3ViewModel {

	final Prova3State state;
	final Function(int)? updateProva3Param1Action;
	final Function(bool)? updateProva3Param2Action;
	final Function(List<int>)? updateProva3ListAction;

	static Prova3ViewModel fromStore({required Store<AppState> store}) {
		return Prova3ViewModel(
			state: store.state.prova3State,
			
			updateProva3Param1Action: (int param1) =>
				store.dispatch(UpdateProva3Param1Action(param1: param1)),
			updateProva3Param2Action: (bool param2) =>
				store.dispatch(UpdateProva3Param2Action(param2: param2)),
			updateProva3ListAction: (List<int> list) =>
				store.dispatch(UpdateProva3ListAction(list: list)),
		);
	}

	Prova3ViewModel({
		required this.state,
		this.updateProva3Param1Action,
		this.updateProva3Param2Action,
		this.updateProva3ListAction
	});

	factory Prova3ViewModel.initial() {
		return Prova3ViewModel(
			state: Prova3State.initial(),
		);
	}

	factory Prova3ViewModel.fromJson(Map<String, dynamic> json) {
		return Prova3ViewModel(
			state: Prova3State.fromJson(json['state']),
		);
	}

	Map<String, dynamic> toJson() => {
		'state': state.toJson(),
	};

	@override
	bool operator ==(Object other) =>
		identical(this, other) ||
		other is Prova3ViewModel &&
		state == other.state
	;

	@override
	int get hashCode =>
		super.hashCode ^
		state.hashCode
	;
}