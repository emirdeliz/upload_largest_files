import 'dart:js_util';
import 'package:flutter/services.dart';
import 'package:upload_largest_files/upload_largest_files_constants.dart';
import 'package:upload_largest_files/upload_largest_files_web.dart';

class UploadLargestFilesChannelHandler {
  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method as ChannelMessage) {
      case ChannelMessage.sendMethodMessageToClient:
        return sendMethodMessage(call.method as JsEvent, call.arguments);
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details:
              'flutter_plugin for web doesn\'t implement \'${call.method}\'',
        );
    }
  }

  Future<dynamic> sendMethodMessage(JsEvent method, dynamic arguments) async {
    UploadLargestFilesJsProps jsProps = UploadLargestFilesJsProps();
    jsProps.file = arguments.file;
    jsProps.headers = arguments.headers;
    jsProps.url = arguments.url;

    final dynamic response = await promiseToFuture(jsInvokeMethod(
      method.name,
      jsProps,
    ));
    return response;
  }
}
