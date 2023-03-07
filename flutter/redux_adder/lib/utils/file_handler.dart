import 'dart:io';

Future<bool> writeFile({path, content}) async {
  try {
    File file = File(path);
    await file.create(recursive: true);
    await file.writeAsString(content);
    return true;
  } catch (ex) {
    return false;
  }
}

Future<String> readFile({required path}) async {
  try {
    File file = File(path);
    return await file.readAsString();
  } catch (ex) {
    return Future.value("");
  }
}
