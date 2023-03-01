import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() {
	WidgetsFlutterBinding.ensureInitialized();
	runApp(MyApp())
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