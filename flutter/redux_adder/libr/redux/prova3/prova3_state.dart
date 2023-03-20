import 'dart:convert';


class Prova3State {

	final int param1;
	final bool param2;
	final List<int> list;

	Prova3State({
		required this.param1,
		required this.param2,
		required this.list
	});

	Prova3State copyWith({
		int? param1,
		bool? param2,
		List<int>? list,
	}) {
		return Prova3State(
			param1: param1 ?? this.param1,
			param2: param2 ?? this.param2,
			list: list ?? this.list,
		);
	}

	factory Prova3State.initial() {
		return Prova3State(
			param1: 0,
			param2: false,
			list: <int>[],
		);
	}

	factory Prova3State.fromJson(Map<String, dynamic> json) {
		return Prova3State(
			param1: jsonDecode(json['param1']),
			param2: jsonDecode(json['param2']),
			list: jsonDecode(json['list']),
		);
	}

	Map<String, dynamic> toJson() => {
		'param1': jsonEncode(param1),
		'param2': jsonEncode(param2),
		'list': jsonEncode(list),
	};

	@override
	bool operator ==(Object other) =>
		identical(this, other) ||
		other is Prova3State
		&& param1 == other.param1
		&& param2 == other.param2
		&& list == other.list
	;

	@override
	int get hashCode =>
		super.hashCode
		^ param1.hashCode
		^ param2.hashCode
		^ list.hashCode
	;
}