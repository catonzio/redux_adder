import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'redux/store.dart';

import 'config/keys.dart';
import 'config/route_generator.dart';
import 'redux/app/app_state.dart';
import 'redux/home/home_page.dart';

void main() {
	WidgetsFlutterBinding.ensureInitialized();
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	MyApp({super.key});
	final Store<AppState> store = createStore();

	@override
	Widget build(BuildContext context) {
		return StoreProvider<AppState>(
			store: store,
			child: MaterialApp(
				title: 'AppName',
				initialRoute: HomePage.routeName,
				onGenerateRoute: RouteGenerator.generateRoute,
				navigatorKey: Keys.navigatorKey,
			)
		);
	}
}
