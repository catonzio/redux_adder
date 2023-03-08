import 'package:redux_adder/pages/base_page.dart';

import '../utils/functions.dart';

class ReducerPageBuilder extends BasePage {
  final String baseName;
  final List<Map<String, dynamic>> parameters;
  final String stateName;

  ReducerPageBuilder({required this.baseName, required this.parameters})
      : stateName = "${capitalize(baseName)}State";

  @override
  String buildPage() {
    return "";
  }

  String buildAppPage() {
    return "";
  }
}
