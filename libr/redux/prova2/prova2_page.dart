import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'prova2_vm.dart';
import '../app/app_state.dart';

class Prova2Page extends StatelessWidget {

	static const String routeName = "Prova2Page";

	const Prova2Page({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return StoreConnector<AppState, Prova2ViewModel>(
			converter: (store) => Prova2ViewModel.fromStore(store: store),
			builder: (context, vm) => _Prova2Page(viewModel: vm),
		);
	}
}

class _Prova2Page extends StatelessWidget {

	final Prova2ViewModel viewModel;

	const _Prova2Page({required this.viewModel});

	@override
	Widget build(BuildContext context) {
    return Container();
  }
}
