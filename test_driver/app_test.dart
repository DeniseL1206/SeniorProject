//import 'package:flutter_test/flutter_test.dart';
//import 'dart:ffi';

import 'package:integration_test/integration_test.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
//import 'package:seniorproject/main.dart' as app;

void main() {
     //final welcomeQuestion = find.byValueKey('welcomeQuestion');
   FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    driver = await FlutterDriver.connect();
    if (driver != null) {
      driver.close();
    }
  });  

  group('end-to-end test', () {
    test('tap on the floating action button, verify counter', () async {
      //integration tests go here
    }, skip: true);
  }, skip: true);
}
