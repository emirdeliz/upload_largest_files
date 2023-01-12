import 'dart:async';
import 'dart:html';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:upload_largest_files/upload_largest_files_channel_handler.dart';

const uploadLargestFilesChannel = 'upload_largest_files';

class UploadLargestFilesPlugin {
  static late MethodChannel channel;

  static void registerWith(Registrar registrar) async {
    await loadJs('upload-largest-files.js');
    await loadJs('index.js');

    channel = MethodChannel(
      uploadLargestFilesChannel,
      const StandardMethodCodec(),
      registrar,
    );

    final channelHandlerInstance = UploadLargestFilesChannelHandler();
    channel.setMethodCallHandler(channelHandlerInstance.handleMethodCall);
  }

  /// It loads the JavaScript file that contains the Js code
  ///
  /// Returns:
  ///   A Future<void>
  static Future<void> loadJs(String filename) {
    final Completer completer = Completer();
    final scriptUploadLargestFilesLib = ScriptElement();

    scriptUploadLargestFilesLib.type = 'text/javascript';
    scriptUploadLargestFilesLib.onLoad.listen((_) {
      completer.complete();
    });

    /// It's loading the JavaScript file that contains the upload code.
    scriptUploadLargestFilesLib.src =
        '/assets/packages/upload_largest_files/assets/$filename';

    /// It's adding the JavaScript file to the body of the HTML page.
    document.body!.append(scriptUploadLargestFilesLib);
    return completer.future;
  }
}
