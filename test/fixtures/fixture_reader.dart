import 'dart:io';

Future<String> fixture(String fileName) async {
  Directory current = Directory.current;

  String path =
      current.path.endsWith('/test') ? current.path : current.path + '/test';

  return File('$path/fixtures/$fileName').readAsStringSync();
}
