import 'dart:convert';

import '../home/home_state.dart';
import '../prova/prova_state.dart';
import '../prova2/prova2_state.dart';
import '../prova3/prova3_state.dart';
import '../prova4/prova4_state.dart';

class AppState {

	final HomeState homeState;
	final ProvaState provaState;
	final Prova2State prova2State;
	final Prova3State prova3State;
	final Prova4State prova4State;

	AppState({
		required this.homeState,
		required this.provaState,
		required this.prova2State,
		required this.prova3State,
		required this.prova4State
	});

	AppState copyWith({
		HomeState? homeState,
		ProvaState? provaState,
		Prova2State? prova2State,
		Prova3State? prova3State,
		Prova4State? prova4State,
	}) {
		return AppState(
			homeState: homeState ?? this.homeState,
			provaState: provaState ?? this.provaState,
			prova2State: prova2State ?? this.prova2State,
			prova3State: prova3State ?? this.prova3State,
			prova4State: prova4State ?? this.prova4State,
		);
	}

	factory AppState.initial() {
		return AppState(
			homeState: HomeState.initial(),
			provaState: ProvaState.initial(),
			prova2State: Prova2State.initial(),
			prova3State: Prova3State.initial(),
			prova4State: Prova4State.initial(),
		);
	}

	factory AppState.fromJson(Map<String, dynamic> json) {
		return AppState(
			homeState: HomeState.fromJson(json['homeState']),
			provaState: ProvaState.fromJson(json['provaState']),
			prova2State: Prova2State.fromJson(json['prova2State']),
			prova3State: Prova3State.fromJson(json['prova3State']),
			prova4State: Prova4State.fromJson(json['prova4State']),
		);
	}

	Map<String, dynamic> toJson() => {
		'homeState': homeState.toJson(),
		'provaState': provaState.toJson(),
		'prova2State': prova2State.toJson(),
		'prova3State': prova3State.toJson(),
		'prova4State': prova4State.toJson(),
	};

	@override
	bool operator ==(Object other) =>
		identical(this, other) ||
		other is AppState
		&& homeState == other.homeState
		&& provaState == other.provaState
		&& prova2State == other.prova2State
		&& prova3State == other.prova3State
		&& prova4State == other.prova4State
	;

	@override
	int get hashCode =>
		super.hashCode
		^ homeState.hashCode
		^ provaState.hashCode
		^ prova2State.hashCode
		^ prova3State.hashCode
		^ prova4State.hashCode
	;
}