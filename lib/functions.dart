import 'dart:io';
// ignore: import_of_legacy_library_into_null_safe
import 'package:path_provider/path_provider.dart';

Future<String> getPdfFilePath(String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  return "${directory.path}/$fileName";
}
