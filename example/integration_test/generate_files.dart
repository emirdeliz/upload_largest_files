// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:math';

const filesSizeInMb = [15, 35, 57, 68, 88, 123, 300, 560, 800, 1100];

String buildFileNameTest(int sizeInMb) {
  return "content_${sizeInMb}MB_.txt";
}

String generateRandomString(int len) {
  var r = Random();
  return String.fromCharCodes(
    List.generate(
      len,
      (index) => r.nextInt(33) + 89,
    ),
  );
}

int calcNumChartToMb(int sizeInMb) {
  const charSizeInBytes = 1;
  const numBytesInOneMb = 1048576;
  final sizeInBytes = sizeInMb * numBytesInOneMb;
  return sizeInBytes ~/ charSizeInBytes;
}

Future<void> generateTempFile(int sizeInMb) async {
  final numLetters = calcNumChartToMb(sizeInMb);
  final letters = generateRandomString(numLetters);

  final currentPath = Directory.current.path;
  final file = File("$currentPath/assets/${buildFileNameTest(sizeInMb)}");
  file.createSync(recursive: true);
  await file.writeAsString(letters, mode: FileMode.writeOnly);
}

void main() async {
  for (int i = 0; i < filesSizeInMb.length; i++) {
    DateTime initialTime = DateTime.now();
    final sizeInMb = filesSizeInMb[i];
    await generateTempFile(sizeInMb);

    final timerDiff = DateTime.now().difference(initialTime).inMinutes;
    print('File with ${sizeInMb}MB generated in $timerDiff minutes.');
  }
}
