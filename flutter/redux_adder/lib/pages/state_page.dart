import 'package:path/path.dart';
import 'package:redux_adder/utils/file_handler.dart';

import '../utils/functions.dart';

class StatePage {
  final String baseName;
  final List<Map<String, String>> parameters;
  final String stateName;

  StatePage({required this.baseName, required this.parameters})
      : stateName = "${capitalize(baseName)}State";

  Future<void> buildPage() async {
    String res = "import 'dart:convert';\n";
    res += indent("bella zio", tabs: 1);
    await writeFile(path: "libr/redux/prova", content: res);
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