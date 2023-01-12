import 'dart:html';
import 'package:js/js.dart';
import 'package:upload_largest_files/upload_largest_files_constants.dart';

@JS('UploadLargestFileJsEvent')
class UploadLargestFileJsEvent {
  @JS('key')
  external JsEvent key;

  @JS('progress')
  external ProgressEvent progress;
}

@JS('UploadLargestFilesJsProps')
@anonymous
class UploadLargestFilesJsProps {
  @JS('file')
  external File? file;

  @JS('url')
  external String? url;

  @JS('headers')
  external Object? headers;
}

@JS('jsOnEvent')
external set _jsOnEvent(void Function(UploadLargestFileJsEvent event) f);

@JS('jsInvokeMethod')
external Future<dynamic> jsInvokeMethod(String method, dynamic params);

class UploadLargestFilesProps {
  File? file;
  String? url;
  Object? headers;
  Function(ProgressEvent progress)? onProgress;
}

class UploadLargestFilesWeb {
  Function(ProgressEvent progress)? onProgress;

  UploadLargestFilesWeb(this.onProgress) {
    initialize();
  }

  initialize() {
    _jsOnEvent = allowInterop((UploadLargestFileJsEvent params) {
      handleJsCall(params);
    });
  }

  handleJsCall(dynamic params) {
    if (onProgress != null && JsEvent.progressUploadUpdate.name == params.key) {
      final progress = params?.progress;
      onProgress!(progress);
    }
  }
}
