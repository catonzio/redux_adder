import 'dart:convert';


class HomeState {

	final int counter;

	HomeState({
		required this.counter
	});

	HomeState copyWith({
		int? counter,
	}) {
		return HomeState(
			counter: counter ?? this.counter,
		);
	}

	factory HomeState.initial() {
		return HomeState(
			counter: 0,
		);
	}

	factory HomeState.fromJson(Map<String, dynamic> json) {
		return HomeState(
			counter: jsonDecode(json['counter']),
		);
	}

	Map<String, dynamic> toJson() => {
		'counter': jsonEncode(counter),
	};

	@override
	bool operator ==(Object other) =>
		identical(this, other) ||
		other is HomeState
		&& counter == other.counter
	;

	@override
	int get hashCode =>
		super.hashCode
		^ counter.hashCode
	;
}