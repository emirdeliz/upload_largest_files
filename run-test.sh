#!/bin/sh
cd driver_test && ./chromedriver --port=4444 &
flutter drive \
	--driver=driver_test/integration_test.dart \
	--target=integration_test/upload_largest_files_test.dart \
	--dart-define=TEST_ENV=true \
	-d chrome \
	--web-port=9191 --browser-name=chrome --headless
