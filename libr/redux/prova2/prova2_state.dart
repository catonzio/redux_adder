import 'dart:convert';


class Prova2State {

	final int param1;
	final bool param2;

	Prova2State({
		required this.param1,
		required this.param2
	});

	Prova2State copyWith({
		int? param1,
		bool? param2,
	}) {
		return Prova2State(
			param1: param1 ?? this.param1,
			param2: param2 ?? this.param2,
		);
	}

	factory Prova2State.initial() {
		return Prova2State(
			param1: 0,
			param2: false,
		);
	}

	factory Prova2State.fromJson(Map<String, dynamic> json) {
		return Prova2State(
			param1: jsonDecode(json['param1']),
			param2: jsonDecode(json['param2']),
		);
	}

	Map<String, dynamic> toJson() => {
		'param1': jsonEncode(param1),
		'param2': jsonEncode(param2),
	};

	@override
	bool operator ==(Object other) =>
		identical(this, other) ||
		other is Prova2State
		&& param1 == other.param1
		&& param2 == other.param2
	;

	@override
	int get hashCode =>
		super.hashCode
		^ param1.hashCode
		^ param2.hashCode
	;
}