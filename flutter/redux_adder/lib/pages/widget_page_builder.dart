import 'package:redux_adder/pages/base_page.dart';
import 'package:redux_adder/utils/functions.dart';

class WidgetPageBuilder extends BasePage {
  final String baseName;
  final String pageName;
  final String vmName;

  WidgetPageBuilder({required this.baseName})
      : pageName = "${capitalize(baseName)}Page",
        vmName = "${capitalize(baseName)}ViewModel";

  @override
  String buildPage() {
    String res = """
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '${baseName}_vm.dart';
import '../app/app_state.dart';

class $pageName extends StatelessWidget {

	static const String routeName = "$pageName";

	const $pageName({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return StoreConnector<AppState, $vmName>(
			converter: (store) => $vmName.fromStore(store: store),
			builder: (context, vm) => _$pageName(viewModel: vm),
		);
	}
}

class _$pageName extends StatelessWidget {

	final $vmName viewModel;

	const _$pageName({required this.viewModel});

	@override
	Widget build(BuildContext context) {
    return Container();
  }
}
""";
    return res;
  }
}
