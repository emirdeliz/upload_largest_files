import 'package:upload_largest_files/upload_largest_files_interop.dart';
import 'package:upload_largest_files/upload_largest_files_web.dart';

abstract class UploadLargestFilesPlatform {
  static UploadLargestFilesPlatform instance = UploadLargestFilesInterop();

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UploadLargestFilesPlatform] when
  /// they register themselves.
  Future<void> uploadFile(UploadLargestFilesProps props) {
    throw UnimplementedError('uploadFile() has not been implemented.');
  }
}
