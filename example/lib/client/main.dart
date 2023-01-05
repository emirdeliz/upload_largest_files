import 'dart:async';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:upload_largest_files/upload_largest_files.dart';
import 'package:upload_largest_files/upload_largest_files_web.dart';

const serverHostname = '0.0.0.0';
const serverPort = 3003;
const serverHost = 'http://$serverHostname:$serverPort';
const uploadPath = 'upload';

void main() {
  runApp(const UploadLargestFilesExampleApp());
}

class UploadLargestFilesExampleApp extends StatelessWidget {
  const UploadLargestFilesExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UploadLargestFiles Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'UploadLargestFiles Example Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final uploadLargestFiles = UploadLargestFiles();
  late AnimationController controller;

  bool isProcessing = false;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        if (controller.value >= 1) {
          setState(() {
            isProcessing = false;
          });
        } else {
          setState(() {});
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _uploadFile(File file) async {
    setState(() {
      isProcessing = true;
    });
    controller.value = 0;

    final props = UploadLargestFilesProps();
    props.file = file;
    props.url = '$serverHost/$uploadPath';
    props.onProgress = (ProgressEvent p) {
      Timer(const Duration(seconds: 1), () {
        controller.value = (p.loaded ?? 0) / (p.total ?? 1);
      });
    };

    await uploadLargestFiles.uploadFile(props);
  }

  void _selectFile() {
    InputElement uploadInput = FileUploadInputElement() as InputElement;
    uploadInput.draggable = true;
    uploadInput.multiple = false;
    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      File file = uploadInput.files![0];
      await _uploadFile(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: 124.0,
          height: 48.0,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  isProcessing ? Colors.blue.shade300 : Colors.blue),
              padding: MaterialStateProperty.all(
                const EdgeInsets.all(15),
              ),
            ),
            onPressed: isProcessing ? null : () => _selectFile(),
            child: const Text(
              "Upload file",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ),
        if (isProcessing || controller.value > 0)
          Container(
            width: 300,
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LinearProgressIndicator(
                  value: controller.value,
                ),
                Text(
                  '${(controller.value * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    color: Colors.blueGrey.shade600,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}
