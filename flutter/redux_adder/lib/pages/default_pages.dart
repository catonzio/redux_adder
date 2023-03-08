import 'dart:convert';

import 'package:path/path.dart';
import 'package:redux_adder/pages/action_page_builder.dart';
import 'package:redux_adder/pages/middleware_page_builder.dart';
import 'package:redux_adder/pages/reducer_page_builder.dart';
import 'package:redux_adder/pages/viewmodel_page_builder.dart';
import 'package:redux_adder/pages/widget_page_builder.dart';
import 'package:redux_adder/utils/constants.dart';
import 'package:redux_adder/utils/file_handler.dart';
import 'package:redux_adder/utils/functions.dart';

import 'state_page_builder.dart';

void writeReduxComponent(
    String componentName, List<Map<String, dynamic>> parameters) {
  String camelCase = changeCase(componentName);
  camelCase = capitalize(camelCase);

  String statePage =
      StatePageBuilder(baseName: componentName, parameters: parameters)
          .buildPage();
  String reducerPage =
      ReducerPageBuilder(baseName: componentName, parameters: parameters)
          .buildPage();
  String actionPage = ActionPageBuilder().buildPage();
  String middlewarePage =
      MiddlewarePageBuilder(baseName: componentName).buildPage();
  String viewModelPage = ViewModelPageBuilder().buildPage();
  String widgetPage = WidgetPageBuilder(baseName: componentName).buildPage();

  List<List<String>> pages = [
    [statePage, "state"],
    [reducerPage, "reducer"],
    [actionPage, "action"],
    [middlewarePage, "middleware"],
    [viewModelPage, "vm"],
    [widgetPage, "widget"],
  ];

  writePages(componentName, pages);
}

Future<void> makeHomepageComponent() async {
  List<Map<String, dynamic>> params = [
    {"type": "int", "name": "counter", "is_comp": false}
  ];
  writeReduxComponent("home", params);
  await writeFile(
      path: [Constants.basePath, "..", "models", "home.json"].join("/"),
      content: JsonEncoder.withIndent("\t").convert(params));
  String code = """
    return SafeArea(
        child: Scaffold(
        appBar: AppBar(
            title: const Text("MyApp"),
        ),
        body: Center(
            child: Text(
            "\${viewModel.state.counter}",
            style: const TextStyle(fontSize: 32),
        )),
        floatingActionButton: FloatingActionButton(
            onPressed: () =>
                viewModel.updateCounter!(viewModel.state.counter + 1),
            child: const Icon(Icons.add)),
        ),
    );
}
}
    """;
  String path = [Constants.basePath, "home", "home_widget.dart"].join("/");
  List<String> content = readFileSync(path: path).split("\n");
  String result = content.sublist(0, 28).join("\n");
  result += "\n$code";
  writeFile(path: path, content: result);
}

void makeAppComponent(List<Map<String, dynamic>> parameters) {
  String page =
      StatePageBuilder(baseName: "app", parameters: parameters).buildPage();
  String reducer = ReducerPageBuilder(baseName: "app", parameters: parameters)
      .buildAppPage();
  writePages("app", [
    [page, "state"],
    [reducer, "reducer"]
  ]);
}

void makeStorePage(List<Map<String, dynamic>> parameters) {
  List<String> baseComponentsNames = [
    for (var p in parameters) p['name'].replaceAll("State", "")
  ];
  String res = "import 'package:redux/redux.dart';\n";
  res += [
    for (String name in baseComponentsNames)
      "import '$name/${name}_middleware.dart';"
  ].join("\n");
  res += indent("import 'app/app_state.dart';");
  res += indent("import 'app/app_reducer.dart';");
  res += indent("\nStore<AppState> createStore() {");
  res += indent("return Store(", tabs: 1);
  res += indent("appReducer,", tabs: 2);
  res += indent("initialState: AppState.initial(),", tabs: 2);
  res += indent("distinct: true,", tabs: 2);
  res += indent("middleware: [", tabs: 2);
  res += [
    for (var p in parameters)
      indent("create${p['type'].replaceAll('State', '')}Middleware(),", tabs: 3)
  ].join("\n");
  res += indent("]", tabs: 2);
  res += indent(");", tabs: 1);
  res += indent("}");
  String path = [Constants.basePath, "store.dart"].join("/");
  printHeader("Store");
  print("Writing store in ${absolute(path)}");
  writeFile(path: path, content: res);
}

void makeMainPage() {
  String content = """
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
""";
  String path = [Constants.basePath, "..", "main.dart"].join("/");
  printHeader("Main");
  print("Writing main page in ${absolute(path)}");
  writeFile(path: path, content: content);
}

void makeKeysPage() {
  String content = """
import 'package:flutter/material.dart';

class Keys {
	static final scaffoldKey = GlobalKey<ScaffoldState>();
	static final navigatorKey = GlobalKey<NavigatorState>();
}
""";
  String path = [Constants.configPath, "keys.dart"].join("/");
  printHeader("Keys");
  print("Writing keys page in ${absolute(path)}");
  writeFile(path: join, content: content);
}

String buildCasePage(String name) {
  String res = indent("case $name.routeName:", tabs: 3);
  res += indent("return MaterialPageRoute(", tabs: 4);
  res += indent("builder: (_) => const $name(), settings: settings);", tabs: 6);
  return res;
}

void makeRouteGenerator(List<Map<String, dynamic>> parameters) {
  String res = "import 'package:flutter/material.dart';\n";
  List<String> baseComponentsNames = [
    for (var p in parameters) p['name'].replaceAll("State", "")
  ];
  res += [
    for (String name in baseComponentsNames)
      "import '../redux/$name/${name}_page.dart';"
  ].join("\n");
  res += "\n\nclass RouteGenerator {";
  res += indent("static Route<dynamic> generateRoute(RouteSettings settings) {",
      tabs: 1);
  res += indent("var args;", tabs: 2);
  res += indent("if (settings.arguments != null) {", tabs: 2);
  res += indent("args = settings.arguments as Map<String, dynamic>;", tabs: 3);
  res += indent("}\n", tabs: 2);
  res += indent("switch (settings.name) {", tabs: 2);
  res += [
    for (var p in parameters)
      buildCasePage(p["type"].replaceAll("State", "Page"))
  ].join("\n");
  res += indent("default:", tabs: 3);
  res += indent("// If there is no such named route in the switch statement",
      tabs: 4);
  res += indent("return MaterialPageRoute(", tabs: 4);
  res += indent("builder: (_) =>", tabs: 5);
  res += indent(
      "const Scaffold(body: SafeArea(child: Center(child: Text('Route Error')))),",
      tabs: 5);
  res += indent("settings: settings);", tabs: 5);
  res += indent("}", tabs: 3);
  res += indent("}", tabs: 2);
  res += indent("}", tabs: 1);
  String path = [Constants.configPath, "route_generator.dart"].join("/");
  printHeader("Route generator");
  print("Writing route generator in ${absolute(path)}");
  writeFile(path: path, content: res);
}

void main(List<String> args) {
  // makeMainPage();
  int x = 10;
  int y = 20;
  String s = """
The result of the multiplication between
  x = $x,
  y = $y,
  is equal to
    z = ${x * y}
""";
  print(s);
}
