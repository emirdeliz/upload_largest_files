import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:upload_largest_files/upload_largest_files_app.dart';

Future<Function> initializeUploadLargestFilesTest({
  required WidgetTester tester,
}) async {
  final Completer<Function> completer = Completer<Function>();
  await tester.pumpWidget(
    MaterialApp(
      home: UploadLargestFilesAppHomePage(
        title: 'Test',
        initializeTriggerUploadCallback: (Function trigger) {
          completer.complete(trigger);
        },
      ),
    ),
  );
  return completer.future;
}

Future<File> readFileFromTestResourcesFolder(String filename) async {
  final response = await window.fetch('/assets/test_resources/$filename');
  final data = await response.blob();
  final metadata = {"type": 'text/plain'};
  final file = File([data], filename, metadata);
  return file;
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Upload Largest File test', () {
    // UploadLargestFiles uploadLargestFilesPlugin;
    // setUpAll(() async {
    //   uploadLargestFilesPlugin = UploadLargestFiles();
    //   // await awaitInitializeUploadLargestFilesJs(uploadLargestFilesPlugin);
    // });

    testWidgets('Have a simple upload', (tester) async {
      Function triggerUpload = await initializeUploadLargestFilesTest(
        tester: tester,
      );

      final file = await readFileFromTestResourcesFolder('DIT.pdf');
      print(file);

      // assets/test_resources/DIT.pdf

      // File file =

      // print(file.name + ' ' + file.size.toString());

      // await triggerUpload(File);

      // new File('test_resources/contacts.json');

      // tester.
      // final barcodeData = barcodeMock.elementAt(0);
      // final result = await barcodeReaderWebassemblyPlugin.readBarcodeFromStack(
      //     compileFileMockPath(barcodeData['fileName'] as String));
      // expect(result, barcodeData['barcode']);
    });
  });

//   group('Upload Largest File test', () {
//     late UploadLargestFiles uploadLargestFilesPlugin;
//     setUpAll(() async {
//       uploadLargestFilesPlugin = UploadLargestFiles();
//       await awaitInitializeUploadLargestFilesJs(uploadLargestFilesPlugin);
//     });
//   });
// }

// Future awaitInitializeUploadLargestFilesJs(
//     UploadLargestFiles? uploadLargestFilesPlugin) async {
//   final initializedUploadLargestFiles = uploadLargestFilesPlugin != null;
//   if (initializedUploadLargestFiles) {
//     return Future.value(null);
//   }
//   await Future.delayed(const Duration(milliseconds: 300));
//   return awaitInitializeUploadLargestFilesJs(uploadLargestFilesPlugin);
// }

// UploadLargestFilesProps compileFileMockPath(String fileName) {
//   final readUploadLargestFilesProps = UploadLargestFilesProps();
//   // readUploadLargestFilesProps.file =
//   //     'http://${window.location.host}/integration_test/__mock__/assets/$fileName';
//   return readUploadLargestFilesProps;
//
}
