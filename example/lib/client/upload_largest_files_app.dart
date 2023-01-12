import 'dart:async';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:upload_largest_files/upload_largest_files.dart';
import 'package:upload_largest_files/upload_largest_files_web.dart';

const serverHostname = '0.0.0.0';
const serverPort = 3000;
const serverHost = 'http://$serverHostname:$serverPort';
const uploadPath = 'upload';
const progressBarAnimationDuration = Duration(milliseconds: 300);

class UploadLargestFilesAppHomePage extends StatefulWidget {
  final Function(Function)? initializeTriggerUploadCallback;
  const UploadLargestFilesAppHomePage({
    Key? key,
    this.initializeTriggerUploadCallback,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  State<UploadLargestFilesAppHomePage> createState() =>
      _UploadLargestFilesAppHomePageState();
}

class _UploadLargestFilesAppHomePageState
    extends State<UploadLargestFilesAppHomePage> {
  final uploadLargestFiles = UploadLargestFiles();

  late bool _isProcessing = false;
  late double _progressValue = 0;

  @override
  void initState() {
    final uploadCallback = widget.initializeTriggerUploadCallback;
    if (uploadCallback != null) {
      uploadCallback(_uploadFile);
    }
    super.initState();
  }

  Future<void> _uploadFile(File file) async {
    setState(() {
      _isProcessing = true;
      _progressValue = 0;
    });

    final props = UploadLargestFilesProps();
    props.file = file;
    props.url = '$serverHost/$uploadPath';
    props.onProgress = (ProgressEvent p) async {
      setState(() {
        _progressValue = (p.loaded ?? 0) / (p.total ?? 1);
        if (_progressValue >= 1) {
          _isProcessing = false;
        }
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
                _isProcessing ? Colors.blue.shade300 : Colors.blue,
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.all(15),
              ),
            ),
            onPressed: _isProcessing ? null : () => _selectFile(),
            child: const Text(
              "Upload file",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ),
        if (_isProcessing || _progressValue > 0)
          Container(
            width: 300,
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  duration: progressBarAnimationDuration,
                  curve: Curves.easeInOut,
                  tween: Tween<double>(
                    begin: 0,
                    end: _progressValue,
                  ),
                  builder: (context, value, _) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LinearProgressIndicator(value: value),
                        Text(
                          '${(_progressValue * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            color: Colors.blueGrey.shade600,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          )
      ],
    );
  }
}
