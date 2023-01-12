import 'dart:io';
import 'dart:convert';
import 'package:alfred/alfred.dart';

const _uploadPath = 'upload';
final _currentPath = Directory.current.parent.parent.path;
final _uploadDirectoryDestination = '$_currentPath/assets';
final _uploadDirectory = Directory(_uploadDirectoryDestination);

Future<void> main(args) async {
  final app = Alfred();
  app.all('*', cors(origin: '*'));

  app.post(_uploadPath, (req, res) async {
    final body = await req.bodyAsJsonMap;
    // Create the upload directory if it doesn't exist.
    if (await _uploadDirectory.exists() == false) {
      await _uploadDirectory.create(recursive: true);
    }

    // Get the uploaded file content.
    final uploadedFile = (body['file'] as HttpBodyFileUpload);
    final fileBytes = utf8.encode(uploadedFile.content);

    // Create the local file name and save the file.
    final filePath = '${_uploadDirectory.path}/${uploadedFile.filename}';
    await File(filePath).writeAsBytes(fileBytes);
  });
  await app.listen();
}
