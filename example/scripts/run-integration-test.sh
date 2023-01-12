#!/bin/sh
chromeDriverPort=4444
clientPort=9191
serverPort=3000

killProcessInPort() {
	lsof -P | grep ":$1" | awk '{print $2}' | xargs kill -9 && reset
}

startChromeDriver() {
	killProcessInPort $chromeDriverPort && cd driver_test &&
		./chromedriver --port=$chromeDriverPort && cd ..
}

startServerUpload() {
	killProcessInPort $serverPort && dart lib/server/server.dart
}

startFlutterIntegrationTest() {
	killProcessInPort $clientPort &&
		flutter drive \
			--driver=driver_test/integration_test.dart \
			--target=integration_test/upload_largest_files_test.dart \
			-d chrome \
			--web-port $clientPort \
			--browser-name=chrome \
			--headless --release
}

generateUploadFiles() {
	dart integration_test/generate_files.dart && reset
}

removeUploadDir() {
	rm -rf assets
}

main() {
	generateUploadFiles &&
		startChromeDriver &
	startServerUpload &
	startFlutterIntegrationTest &&
		removeUploadDir
}
main
