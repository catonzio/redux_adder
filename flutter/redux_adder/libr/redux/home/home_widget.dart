import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'home_vm.dart';
import '../app/app_state.dart';

class HomePage extends StatelessWidget {

	static const String routeName = "HomePage";

	const HomePage({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return StoreConnector<AppState, HomeViewModel>(
			converter: (store) => HomeViewModel.fromStore(store: store),
			builder: (context, vm) => _HomePage(viewModel: vm),
		);
	}
}

class _HomePage extends StatelessWidget {

	final HomeViewModel viewModel;

	const _HomePage({required this.viewModel});

	@override
	Widget build(BuildContext context) {
    return Container();
  }
}
