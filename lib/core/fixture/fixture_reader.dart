import 'package:flutter/services.dart';

Future<String> fixture(String fileName) async {
  return await rootBundle.loadString('lib/core/fixture/$fileName');
}
