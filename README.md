# upload_largest_files

[![Upload largest files: Tests](https://github.com/emirdeliz/upload_largest_files/actions/workflows/main.yml/badge.svg)](https://github.com/emirdeliz/upload_largest_files/actions/workflows/main.yml)

This plugin is a wrapper for the project [Upload largest Files](https://github.com/emirdeliz/upload-largest-files) to make uploads on the web. See the example for more details. See the example for more details. Before running the example you should start the upload server on the folder: `example/lib/server`.

<img src="https://raw.githubusercontent.com/emirdeliz/upload_largest_files/master/assets/example.gif" width="300" height="auto" alt="Upload largest files - example"/>

## Getting Started

The use is very simple. The upload largest files receive an object to make an upload and then process in a native js.

```dart
Future<void> _uploadFile(File file) async {
	setState(() {
		_isProcessing = true;
		_progressValue = 0;
	});

	final props = UploadLargestFilesProps();
	props.file = file;
	props.url = '$serverHost/$uploadPath';
	props.onProgress = (ProgressEvent p) async {
		setState(() {
			_progressValue = (p.loaded ?? 0) / (p.total ?? 1);
			if (_progressValue >= 1) {
				_isProcessing = false;
			}
		});
	};

	await uploadLargestFiles.uploadFile(props);
}
```

About **UploadLargestFilesProps**:

| **Prop**                  | **Type**                         | **Description**                                            |
| ------------------------- | -------------------------------- | ---------------------------------------------------------- |
| **file** (required)       | File                             | The upload file.                                           |
| **url** (required)        | String                           | The server URL to make an upload.                          |
| **headers** (optional)    | Object                           | The request headers to make an upload.                     |
| **onProgress** (optional) | Function(ProgressEvent progress) | The callback function to make follow the upload progress.. |
