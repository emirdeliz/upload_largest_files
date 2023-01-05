const Methods = {
	uploadFile: 'uploadFile',
	progressUploadUpdate: 'progressUploadUpdate',
};

window.jsInvokeMethod = async (method, uploadProps) => {
	switch (method) {
		case Methods.uploadFile: {
			uploadProps.onProgress = function (progress) {
				callDart({ key: Methods.progressUploadUpdate, progress });
			};
			window.UploadLargestFiles.uploadFile(uploadProps);
			break;
		}
	}
};

function callDart(e) {
	window.jsOnEvent(e);
}
