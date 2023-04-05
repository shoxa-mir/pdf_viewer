import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'functions.dart';

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
        primarySwatch: Colors.blue,
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
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late Future<String> _pdfFilePath;

  @override
  void initState() {
    super.initState();
    _pdfFilePath = getPdfFilePath("your_pdf_file_name.pdf");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _pdfViewerKey.currentState!.openBookmarkView();
              },
              icon: const Icon(
                Icons.bookmark,
                color: Colors.green,
                semanticLabel: "Bookmark",
              ))
        ],
      ),
      body: FutureBuilder<String>(
          future: _pdfFilePath,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return SfPdfViewer.file(File(snapshot.data!), key: _pdfViewerKey);
              } else {
                return const Center(child: Text("Failed to load  PDF file."));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
    // body: SfPdfViewer.network(
    //   'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
    //   key: _pdfViewerKey,
    // ),
  }
}
