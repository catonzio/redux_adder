import 'dart:convert';
import '../home/home_state.dart';

class AppState {

	final HomeState homeState;

	AppState({
		required this.homeState,
	});

	AppState copyWith({
		HomeState? homeState,
	}) {
		return AppState(
			homeState: homeState ?? this.homeState,
		);
	}

	factory AppState.initial() {
		return AppState(
			homeState: HomeState.initial(),
		);
	}

	factory AppState.fromJson(Map<String, dynamic> json) {
		return AppState(
			homeState: HomeState.fromJson(json['homeState']),
		);
	}

	Map<String, dynamic> toJson() => {
		'homeState': homeState.toJson(),
	};

	@override
	bool operator ==(Object other) => 
		identical(this, other) || 
		other is AppState && 
		homeState == other.homeState;

	@override
	int get hashCode => super.hashCode ^ 
		homeState.hashCode;
}