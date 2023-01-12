import 'package:flutter/material.dart';
import 'package:upload_largest_files_example/client/upload_largest_files_app.dart';

void main() {
  runApp(const UploadLargestFilesApp());
}

class UploadLargestFilesApp extends StatelessWidget {
  const UploadLargestFilesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'UploadLargestFiles Example',
      home: Scaffold(
        backgroundColor: Color.fromRGBO(22, 27, 34, 1),
        body: Center(
          child: UploadLargestFilesAppHomePage(
            title: 'UploadLargestFiles Example Home Page',
          ),
        ),
      ),
    );
  }
}
