import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:file_picker/file_picker.dart';
// import 'functions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Viewer Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(title: 'PDF Viewer Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String? _pdfname;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  Future<File> getPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      _pdfname = result.files.single.name;
      return File(result.files.single.path!);
    } else {
      throw Exception('No file selected.');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void showPdfViewer(File file) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(_pdfname ?? "PDF Viewer"),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    _pdfViewerKey.currentState!.openBookmarkView();
                  },
                  icon: const Icon(
                    Icons.bookmark,
                    color: Colors.white,
                    semanticLabel: "Bookmark",
                  ))
            ],
          ),
          body: SfPdfViewer.file(file, key: _pdfViewerKey),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              File pdfFile = await getPdfFile();
              showPdfViewer(pdfFile);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error: ${e.toString()}")),
              );
            }
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          child: const Text("Select PDF"),
        ),
      ),
    );
  }
}
