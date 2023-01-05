import 'dart:async';
import 'package:upload_largest_files/upload_largest_files_constants.dart';
import 'package:upload_largest_files/upload_largest_files_channel_handler.dart';
import 'package:upload_largest_files/upload_largest_files_web.dart';
import 'package:upload_largest_files/upload_largest_files_platform.dart';

class UploadLargestFilesInterop extends UploadLargestFilesPlatform {
  /// It's a Dart function that calls the JavaScript function `uploadFile`
  @override
  Future<void> uploadFile(UploadLargestFilesProps arguments) async {
    final uploadLargestFilesChannelHandler = UploadLargestFilesChannelHandler();
    UploadLargestFilesWeb(arguments.onProgress);

    /// It's converting the JavaScript Promise to a Dart Future.
    await uploadLargestFilesChannelHandler.sendMethodMessage(
      JsEvent.uploadFile,
      arguments,
    );
  }
}
