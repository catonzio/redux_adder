import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'prova_vm.dart';
import '../app/app_state.dart';

class ProvaPage extends StatelessWidget {

	static const String routeName = "ProvaPage";

	const ProvaPage({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return StoreConnector<AppState, ProvaViewModel>(
			converter: (store) => ProvaViewModel.fromStore(store: store),
			builder: (context, vm) => _ProvaPage(viewModel: vm),
		);
	}
}

class _ProvaPage extends StatelessWidget {

	final ProvaViewModel viewModel;

	const _ProvaPage({required this.viewModel});

	@override
	Widget build(BuildContext context) {
    return Container();
  }
}
