import 'package:redux_adder/models/action.dart';
import 'package:redux_adder/pages/base_page.dart';
import 'package:redux_adder/utils/parameters_helper.dart';

import '../models/parameter.dart';

class ActionPageBuilder extends BasePage {
  late String stateName;
  final List<Action> actions;

  ActionPageBuilder({required this.stateName, required this.actions});

  @override
  String buildPage() {
    String res = [
      for (var a in actions)
        a.buildActionDeclaration()
    ].join("\n\n");
    return res;
  }
}
