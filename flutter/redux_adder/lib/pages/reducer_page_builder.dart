import 'package:redux_adder/pages/base_page.dart';
import 'package:redux_adder/utils/functions.dart';
import 'package:redux_adder/utils/parameters_helper.dart';

class ReducerPageBuilder extends BasePage {
  final String baseName;
  final List<Map<String, dynamic>> parameters;
  late String reducerName;
  late String stateName;

  ReducerPageBuilder({required this.baseName, required this.parameters})
      : reducerName = "${uncapitalize(baseName)}Reducer",
        stateName = "${capitalize(baseName)}State";

  String buildAppPage() {
    List<String> paramsNames = [
      for (var p in parameters) uncapitalize(p["name"].replaceAll("State", ""))
    ];
    String res =
        "import 'package:redux/redux.dart';\nimport '${baseName}_state.dart';\n";
    res += [for (var pn in paramsNames) "import '../$pn/${pn}_reducer.dart';"]
        .join();
    res += "\n\nfinal $reducerName = combineReducers<$stateName>([";
    res += indent("(state, action) => ${capitalize(stateName)}(", tabs: 1);
    res += [
      for (var row in parameters)
        indent(
            "${row['name']}: ${uncapitalize(row['name'].replaceAll('State', ''))}Reducer(state.${row['name']}, action),",
            tabs: 2)
    ].join();
    res += indent(")", tabs: 1);
    res += indent("]);");
    return res;
  }

  @override
  String buildPage() {
    String res =
        "import 'package:redux/redux.dart';\nimport '${baseName}_state.dart';\nimport '${baseName}_action.dart';\n\n";
    res += buildDeclaration();
    res += buildImplementation();
    return res;
  }

  String buildDeclaration() {
    String res = "final $reducerName = combineReducers<$stateName>([";
    res += [
      for (var row in parameters)
        if (!row['is_comp'])
          indent(getParamReducerDeclaration(row, stateName), tabs: 1)
    ].join();
    res += getComponentsReducerDeclaration(
        parameters
            .where((p) =>
                p['is_comp'] &&
                !(p['name'].toLowerCase().contains(baseName.toLowerCase())))
            .toList(),
        stateName);
    res += indent("]);");
    return res;
  }

  String buildImplementation() {
    String res = "\n\n";
    res += [
      for (var row in parameters)
        if (!row['is_comp'])
          indent(getParameterReducerImplementation(row, stateName))
    ].join();
    return "$res\n";
  }
}
