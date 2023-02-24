import 'json';
import 'package:openeyed/redux/states/app_state.dart';
import 'package:redux/redux.dart';

class ProvaViewModel {

	final ProvaState state;

	static ProvaViewModel fromStore(Store<AppState> store) {
		return ProvaViewModel(
			state: store.state.pagesState.provaState
		);
	}

	ProvaViewModel({
		required this.state,
	});

	factory ProvaViewModel.initial() {
		return ProvaViewModel(
			state: ProvaState.initial(),
		);
	}

	factory ProvaViewModel.fromJson(Map<String, dynamic> json) {
		return ProvaViewModel(
			state: json.decode(json['state']),
		);
	}

	Map<String, dynamic> toJson() => {
		'state': json.encode(state),
	};

	@override
	bool operator ==(Object other) => 
		identical(this, other) || 
		other is ProvaViewModel && 
		state == other.state;

	@override
	int get hashCode => super.hashCode ^ 
		state.hashCode;
}