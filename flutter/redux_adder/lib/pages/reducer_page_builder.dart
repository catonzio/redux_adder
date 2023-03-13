import 'package:redux_adder/models/action.dart';
import 'package:redux_adder/models/parameter.dart';
import 'package:redux_adder/pages/base_page.dart';
import 'package:redux_adder/utils/functions.dart';
import 'package:redux_adder/utils/parameters_helper.dart';

class ReducerPageBuilder extends BasePage {
  final String baseName;
  final List<Action> actions;
  final List<Parameter> componentsParameters;
  late String reducerName;
  late String stateName;

  ReducerPageBuilder(
      {required this.baseName,
      required this.reducerName,
      required this.stateName,
      required this.actions,
      required this.componentsParameters});

  String buildAppPage() {
    List<String> paramsNames = [
      for (var p in componentsParameters)
        uncapitalize(p.name.replaceAll("State", ""))
    ];
    String res =
        "import 'package:redux/redux.dart';\nimport '${baseName}_state.dart';\n";
    res += [for (var pn in paramsNames) "import '../$pn/${pn}_reducer.dart';"]
        .join();
    res += "\n\nfinal $reducerName = combineReducers<$stateName>([";
    res += indent("(state, action) => state.copyWith(", tabs: 1);
    res += [
      for (var p in componentsParameters)
        indent(
            "${p.name}: ${uncapitalize(p.name.replaceAll('State', ''))}Reducer(state.${p.name}, action),",
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
      for (var a in actions) indent(a.getReducerDeclaration(stateName), tabs: 1)
    ].join();
    res += getComponentsReducerDeclaration(componentsParameters, stateName);
    res += indent("]);");
    return res;
  }

  String buildImplementation() {
    String res = "\n\n";
    res += [
      for (var a in actions) indent(a.getReducerImplementation(stateName))
    ].join("\n");
    return res;
  }
}
