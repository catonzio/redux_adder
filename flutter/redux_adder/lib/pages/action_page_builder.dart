import 'package:redux_adder/pages/base_page.dart';
import 'package:redux_adder/utils/functions.dart';
import 'package:redux_adder/utils/parameters_helper.dart';

import '../models/parameter.dart';

class ActionPageBuilder extends BasePage {
  final String baseName;
  final List<Parameter> parameters;
  late String stateName;

  ActionPageBuilder({required this.baseName, required this.parameters})
      : stateName = capitalize(baseName);

  @override
  String buildPage() {
    String res = [
      for (var p in parameters)
        if (!p.isComp) buildActionDeclaration(p, stateName)
    ].join("\n\n");
    return res;
  }
}
