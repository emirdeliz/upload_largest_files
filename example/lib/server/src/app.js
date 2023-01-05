const express = require('express');
const multer = require('multer');
const fs = require('fs');

const serverHostname = '0.0.0.0';
const serverPort = 3003;

const clientPort = 9191;
const clientHost = `http://${serverHostname}:${clientPort}`;

const uploadPath = 'upload';
const uploadDirectoryDestination = `../../__${uploadPath}__`;

if (!fs.existsSync(uploadDirectoryDestination)) {
	fs.mkdirSync(uploadDirectoryDestination);
}

const app = express();
app.use(function (_req, res, next) {
	res.header('Access-Control-Allow-Origin', clientHost);
	res.header('Access-Control-Allow-Headers', '*');
	res.header('Access-Control-Allow-Methods', '*');
	next();
});

const storage = multer.diskStorage({
	destination: function (_req, _file, cb) {
		cb(null, uploadDirectoryDestination);
	},
	filename: function (_req, file, cb) {
		cb(null, file.originalname);
	},
});

const upload = multer({ storage });
app.post(`/${uploadPath}`, upload.single('file'), function (_req, res) {
	res.write('Upload successfully');
});

app.listen(serverPort);
