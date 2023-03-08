import 'package:redux_adder/pages/base_page.dart';
import 'package:redux_adder/utils/functions.dart';

class ViewModelPageBuilder extends BasePage {
  final String baseName;
  final String vmName;
  final String stateName;
  final List<Map<String, dynamic>> parameters;
  late List<String> actionNames;
  late List<Map<String, dynamic>> functionNames;

  ViewModelPageBuilder({required this.baseName, required this.parameters})
      : vmName = "${capitalize(baseName)}ViewModel",
        stateName = "${capitalize(baseName)}State" {
    actionNames = [
      for (var p in parameters)
        if (!p['is_comp'])
          getActionFromName(p['name'], stateName).replaceAll("State", "")
    ];
    functionNames = [
      for (var p in parameters)
        if (!p['is_comp'])
          {
            'type': p['type'],
            'name': "update${capitalize(p['name'])}",
            "is_comp": false
          }
    ];
  }

  @override
  String buildPage() {
    return "";
  }
}
