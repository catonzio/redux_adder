import 'dart:convert';
import '../app/app_state.dart';
import 'package:redux/redux.dart';
import 'prova4_state.dart';
import 'prova4_action.dart';

class Prova4ViewModel {

	final Prova4State state;
	final Function(int)? action1;
	final Function(bool)? action2;
	final Function(int)? updateProva4Param1Action;
	final Function(bool)? updateProva4Param2Action;
	final Function(List<int>,int,String?)? aggiunta;

	static Prova4ViewModel fromStore({required Store<AppState> store}) {
		return Prova4ViewModel(
			state: store.state.prova4State,
			
			action1: (int param1) =>
				store.dispatch(Action1(param1: param1)),
			action2: (bool param2) =>
				store.dispatch(Action2(param2: param2)),
			updateProva4Param1Action: (int param1) =>
				store.dispatch(UpdateProva4Param1Action(param1: param1)),
			updateProva4Param2Action: (bool param2) =>
				store.dispatch(UpdateProva4Param2Action(param2: param2)),
			aggiunta: (List<int> prova,int asd,String? pr) =>
				store.dispatch(Aggiunta(prova: prova,asd: asd,pr: pr)),
		);
	}

	Prova4ViewModel({
		required this.state,
		this.action1,
		this.action2,
		this.updateProva4Param1Action,
		this.updateProva4Param2Action,
		this.aggiunta
	});

	factory Prova4ViewModel.initial() {
		return Prova4ViewModel(
			state: Prova4State.initial(),
		);
	}

	factory Prova4ViewModel.fromJson(Map<String, dynamic> json) {
		return Prova4ViewModel(
			state: Prova4State.fromJson(json['state']),
		);
	}

	Map<String, dynamic> toJson() => {
		'state': state.toJson(),
	};

	@override
	bool operator ==(Object other) =>
		identical(this, other) ||
		other is Prova4ViewModel &&
		state == other.state
	;

	@override
	int get hashCode =>
		super.hashCode ^
		state.hashCode
	;
}