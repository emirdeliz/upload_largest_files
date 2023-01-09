import 'package:flutter/material.dart';
import 'package:upload_largest_files/upload_largest_files_app.dart';

void main() {
  runApp(const UploadLargestFilesApp());
}

class UploadLargestFilesApp extends StatelessWidget {
  const UploadLargestFilesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UploadLargestFiles Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UploadLargestFilesAppHomePage(
          title: 'UploadLargestFiles Example Home Page'),
    );
  }
}
