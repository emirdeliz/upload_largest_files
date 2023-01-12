import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:upload_largest_files/upload_largest_files_plugin.dart';
import 'package:upload_largest_files_example/client/upload_largest_files_app.dart';

import 'generate_files.dart';

Future _awaitInitializePluginJs(
  UploadLargestFilesPlugin? uploadLargestFilesPlugin,
) async {
  final initializedPlugin = uploadLargestFilesPlugin != null;
  if (initializedPlugin) {
    return Future.value(null);
  }

  await Future.delayed(const Duration(milliseconds: 300));
  return _awaitInitializePluginJs(uploadLargestFilesPlugin);
}

Future<Function> _initializeUploadLargestFilesTest({
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

Future<File> _readFileFromTestResourcesFolder({
  required String filePath,
}) async {
  final response = await window.fetch(filePath);
  final data = await response.blob();
  final metadata = {'type': 'text/plain'};
  final filename = '${filePath.split('/').last.split('.').first}upload.txt';
  final file = File([data], filename, metadata);
  return file;
}

Future<File> _runApp({
  required WidgetTester tester,
  required String filename,
}) async {
  Function triggerUpload = await _initializeUploadLargestFilesTest(
    tester: tester,
  );

  final file = await _readFileFromTestResourcesFolder(
    filePath: '/assets/$filename',
  );
  await triggerUpload(file);
  await tester.pumpAndSettle(const Duration(seconds: 7));
  return file;
}

Future<void> _runTestForLabelAndProgressBar({
  required WidgetTester tester,
  required String filename,
}) async {
  final fileExpected = await _runApp(tester: tester, filename: filename);
  const labelExpect = 100;
  expect(find.text('$labelExpect%'), findsOneWidget);

  final progress = find.byType(LinearProgressIndicator);
  expect(progress, findsOneWidget);

  final widget = progress.evaluate().single.widget as LinearProgressIndicator;
  expect(widget.value, 1);

  final fileUpload = await _readFileFromTestResourcesFolder(
    filePath: '/assets/$filename',
  );

  expect(fileUpload.size.toString(), fileExpected.size.toString());
  expect(fileUpload.type, fileExpected.type);
  expect(fileUpload.name, fileExpected.name);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Upload Largest File test', () {
    late UploadLargestFilesPlugin uploadLargestFilesPlugin;
    setUpAll(() async {
      uploadLargestFilesPlugin = UploadLargestFilesPlugin();
      await _awaitInitializePluginJs(uploadLargestFilesPlugin);
    });

    for (int i = 0; i < filesSizeInMb.length; i++) {
      final size = filesSizeInMb[i];
      testWidgets('Have a upload to file with: ${size}MB', (tester) async {
        await _runTestForLabelAndProgressBar(
          tester: tester,
          filename: buildFileNameTest(size),
        );
      });
    }
  });
}
