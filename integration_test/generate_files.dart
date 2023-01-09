import 'dart:io';

calcNumChartToMb(int sizeInMb) {
  const charSizeInBytes = 1;
  final sizeInBytes = sizeInMb / (1024 * 1024);
  return sizeInBytes / charSizeInBytes;
}

generateTempFile(int sizeInMb) async {
  List letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k"];
  File file = File("letters_${sizeInMb}_.txt");
  for (int i = 0; i < 10; i++) {
    await file.writeAsString("${letters[i]}", mode: FileMode.append);
  }
}
