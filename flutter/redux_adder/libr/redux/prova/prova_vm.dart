import 'dart:convert';
import '../app/app_state.dart';
import 'package:redux/redux.dart';
import 'prova_state.dart';
import 'prova_action.dart';

class ProvaViewModel {

	final ProvaState state;
	final Function(int)? updateProvaParam1Action;
	final Function(bool)? updateProvaParam2Action;

	static ProvaViewModel fromStore({required Store<AppState> store}) {
		return ProvaViewModel(
			state: store.state.provaState,
			
			updateProvaParam1Action: (int param1) =>
				store.dispatch(UpdateProvaParam1Action(param1: param1)),
			updateProvaParam2Action: (bool param2) =>
				store.dispatch(UpdateProvaParam2Action(param2: param2)),
		);
	}

	ProvaViewModel({
		required this.state,
		this.updateProvaParam1Action,
		this.updateProvaParam2Action
	});

	factory ProvaViewModel.initial() {
		return ProvaViewModel(
			state: ProvaState.initial(),
		);
	}

	factory ProvaViewModel.fromJson(Map<String, dynamic> json) {
		return ProvaViewModel(
			state: ProvaState.fromJson(json['state']),
		);
	}

	Map<String, dynamic> toJson() => {
		'state': state.toJson(),
	};

	@override
	bool operator ==(Object other) =>
		identical(this, other) ||
		other is ProvaViewModel &&
		state == other.state
	;

	@override
	int get hashCode =>
		super.hashCode ^
		state.hashCode
	;
}