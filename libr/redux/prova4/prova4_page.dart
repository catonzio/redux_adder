import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'prova4_vm.dart';
import '../app/app_state.dart';

class Prova4Page extends StatelessWidget {

	static const String routeName = "Prova4Page";

	const Prova4Page({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return StoreConnector<AppState, Prova4ViewModel>(
			converter: (store) => Prova4ViewModel.fromStore(store: store),
			builder: (context, vm) => _Prova4Page(viewModel: vm),
		);
	}
}

class _Prova4Page extends StatelessWidget {

	final Prova4ViewModel viewModel;

	const _Prova4Page({required this.viewModel});

	@override
	Widget build(BuildContext context) {
    return Container();
  }
}
