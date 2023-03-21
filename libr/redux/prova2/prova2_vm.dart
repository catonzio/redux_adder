import 'dart:convert';
import '../app/app_state.dart';
import 'package:redux/redux.dart';
import 'prova2_state.dart';
import 'prova2_action.dart';

class Prova2ViewModel {

	final Prova2State state;
	final Function(int)? updateProva2Param1Action;
	final Function(bool)? updateProva2Param2Action;

	static Prova2ViewModel fromStore({required Store<AppState> store}) {
		return Prova2ViewModel(
			state: store.state.prova2State,
			
			updateProva2Param1Action: (int param1) =>
				store.dispatch(UpdateProva2Param1Action(param1: param1)),
			updateProva2Param2Action: (bool param2) =>
				store.dispatch(UpdateProva2Param2Action(param2: param2)),
		);
	}

	Prova2ViewModel({
		required this.state,
		this.updateProva2Param1Action,
		this.updateProva2Param2Action
	});

	factory Prova2ViewModel.initial() {
		return Prova2ViewModel(
			state: Prova2State.initial(),
		);
	}

	factory Prova2ViewModel.fromJson(Map<String, dynamic> json) {
		return Prova2ViewModel(
			state: Prova2State.fromJson(json['state']),
		);
	}

	Map<String, dynamic> toJson() => {
		'state': state.toJson(),
	};

	@override
	bool operator ==(Object other) =>
		identical(this, other) ||
		other is Prova2ViewModel &&
		state == other.state
	;

	@override
	int get hashCode =>
		super.hashCode ^
		state.hashCode
	;
}