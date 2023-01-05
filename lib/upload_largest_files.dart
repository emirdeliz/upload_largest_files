import 'package:upload_largest_files/upload_largest_files_platform.dart';
import 'package:upload_largest_files/upload_largest_files_web.dart';

/// This class is used to upload the largest files in a directory to a specified url.
class UploadLargestFiles {
  Future<void> uploadFile(UploadLargestFilesProps props) async {
    return await UploadLargestFilesPlatform.instance.uploadFile(
      props,
    );
  }
}
