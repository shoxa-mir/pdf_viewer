// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File> getPdfFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null) {
    return File(result.files.single.path!);
  } else {
    throw Exception('No file selected.');
  }
}
