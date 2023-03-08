import 'package:redux_adder/pages/base_page.dart';
import 'package:redux_adder/utils/file_handler.dart';

import '../utils/functions.dart';

class StatePageBuilder extends BasePage {
  final String baseName;
  final List<Map<String, dynamic>> parameters;
  final String stateName;

  StatePageBuilder({required this.baseName, required this.parameters})
      : stateName = "${capitalize(baseName)}State";

  @override
  String buildPage() {
    String res = "import 'dart:convert';\n";
    res += indent("bella zio", tabs: 1);
    return res;
  }
}

void main(List<String> args) {
  List<String> strs = ["ciao", "a", "tutti"];
  print([
    for (String s in strs)
      if (s != "a") s
  ].join("\n"));
}

/*Future<void> main(List<String> arguments) async {
  StatePage sp = StatePage(baseName: "prova", parameters: [
    {'type': "prova"}
  ]);
  await sp.buildPage();
  String val = await readFile(path: "libr/redux/prova");
  print(val);
}
*/