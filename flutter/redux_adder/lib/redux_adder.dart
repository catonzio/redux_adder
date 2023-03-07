import 'dart:io';

Future<int> calculate() async {
  File f = File('path/to/file.dart');
  await f.create(recursive: true);
  await f.writeAsString("import 'prova';\nciao");
  return 6 * 7;
}
