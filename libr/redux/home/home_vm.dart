import 'dart:convert';
import '../app/app_state.dart';
import 'package:redux/redux.dart';
import 'home_state.dart';
import 'home_action.dart';

class HomeViewModel {

	final HomeState state;
	final Function(int)? updateCounter;

	static HomeViewModel fromStore({required Store<AppState> store}) {
		return HomeViewModel(
			state: store.state.homeState,
			
			updateCounter: (int value) =>
          store.dispatch(UpdateHomeCounterAction(value: value)),
		);
	}

	HomeViewModel({
		required this.state,
		this.updateCounter,
	});

	factory HomeViewModel.initial() {
		return HomeViewModel(
			state: HomeState.initial(),
		);
	}

	factory HomeViewModel.fromJson(Map<String, dynamic> json) {
		return HomeViewModel(
			state: HomeState.fromJson(json['state']),
		);
	}

	Map<String, dynamic> toJson() => {
		'state': state.toJson(),
	};

	@override
	bool operator ==(Object other) => 
		identical(this, other) || 
		other is HomeViewModel && 
		state == other.state;

	@override
	int get hashCode => super.hashCode ^ 
		state.hashCode;
}