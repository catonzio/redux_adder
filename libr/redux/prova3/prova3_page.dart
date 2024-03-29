import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'prova3_vm.dart';
import '../app/app_state.dart';

class Prova3Page extends StatelessWidget {

	static const String routeName = "Prova3Page";

	const Prova3Page({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return StoreConnector<AppState, Prova3ViewModel>(
			converter: (store) => Prova3ViewModel.fromStore(store: store),
			builder: (context, vm) => _Prova3Page(viewModel: vm),
		);
	}
}

class _Prova3Page extends StatelessWidget {

	final Prova3ViewModel viewModel;

	const _Prova3Page({required this.viewModel});

	@override
	Widget build(BuildContext context) {
    return Container();
  }
}
