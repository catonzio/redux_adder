import 'dart:convert';

import '../prova3/prova3_state.dart';
import '../prova2/prova2_state.dart';

class Prova4State {

	final int param1;
	final bool param2;
	final Prova3State prova3;
	final Prova2State prova2;

	Prova4State({
		required this.param1,
		required this.param2,
		required this.prova3,
		required this.prova2
	});

	Prova4State copyWith({
		int? param1,
		bool? param2,
		Prova3State? prova3,
		Prova2State? prova2,
	}) {
		return Prova4State(
			param1: param1 ?? this.param1,
			param2: param2 ?? this.param2,
			prova3: prova3 ?? this.prova3,
			prova2: prova2 ?? this.prova2,
		);
	}

	factory Prova4State.initial() {
		return Prova4State(
			param1: 0,
			param2: false,
			prova3: Prova3State.initial(),
			prova2: Prova2State.initial(),
		);
	}

	factory Prova4State.fromJson(Map<String, dynamic> json) {
		return Prova4State(
			param1: jsonDecode(json['param1']),
			param2: jsonDecode(json['param2']),
			prova3: Prova3State.fromJson(json['prova3']),
			prova2: Prova2State.fromJson(json['prova2']),
		);
	}

	Map<String, dynamic> toJson() => {
		'param1': jsonEncode(param1),
		'param2': jsonEncode(param2),
		'prova3': prova3.toJson(),
		'prova2': prova2.toJson(),
	};

	@override
	bool operator ==(Object other) =>
		identical(this, other) ||
		other is Prova4State
		&& param1 == other.param1
		&& param2 == other.param2
		&& prova3 == other.prova3
		&& prova2 == other.prova2
	;

	@override
	int get hashCode =>
		super.hashCode
		^ param1.hashCode
		^ param2.hashCode
		^ prova3.hashCode
		^ prova2.hashCode
	;
}