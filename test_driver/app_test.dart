//import 'package:flutter_test/flutter_test.dart';
//import 'dart:ffi';

//import 'package:integration_test/integration_test.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
//import 'package:seniorproject/main.dart' as app;

void main() {
  //final welcomeQuestion = find.byValueKey('welcomeQuestion');
  late FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  group(
    'Happy Paths',
    () {
      /*
      Given I am on the login Screen
      When I tap "Email"
      And I enter "goob@utrgv.edu"
      And I tap "Login"
      Then I should be on the Home Screen
      And I should see "This is the Home Screen"
    */
      test(
          "A valid utrgv email should direct the user to the next screen when user clicks on the login button",
          () async {
        final email_textfield = find.byValueKey("email-input");
        await driver.tap(email_textfield);
        await driver.enterText('goob@utrgv.edu');
        await driver.waitFor(find.text('goob@utrgv.edu'));

        final login_button = find.byValueKey("login-button");
        await driver.tap(login_button);

        final title_text = find.byValueKey("home-text");
        expect(await driver.getText(title_text), "Home");
      });
      /*
      Given I am on the Home Screen
      And I should see "This is the Home Screen"
      When I tap "Explore"
      Then I should see "This is the Explore Screen"
      When I tap "Rating System"
      Then I should see "This is the rating System Screen"
      When I tap "Notifications"
      Then I should see "This is the Notifications Screen"
      When I tap "Resources"
      Then I should see "This is the Resources Screen"
    */
      test(
          "Clicking a button on the navigation bar should direct the user to the appropriate screen",
          () async {
        final home_text = find.byValueKey("home-text");
        expect(await driver.getText(home_text), "Home");

        await driver.waitFor(find.byValueKey('navigation-bar'));
        await Future.delayed(Duration(seconds: 10));
        await driver.tap(find.text('Explorer'));
        await Future.delayed(Duration(seconds: 10));
        final explorer_text = find.byValueKey("explorer-text");
        expect(await driver.getText(explorer_text), "Swim to");

        await driver.waitFor(find.byValueKey('navigation-bar'));
        await driver.tap(find.text('Rating System'));
        final ratingsystem_text = find.byValueKey("rating-system-text");
        expect(await driver.getText(ratingsystem_text), "Explore the Pond");

        await driver.waitFor(find.byValueKey('navigation-bar'));
        await driver.tap(find.text('Notifications'));
        final notifications_text = find.byValueKey("notifications-text");
        expect(await driver.getText(notifications_text),
            "Someone smiled at your post");

        await driver.waitFor(find.byValueKey('navigation-bar'));
        await driver.tap(find.text('Resources'));
        // final resources_text = find.byValueKey("resources-text");
        // expect(await driver.getText(resources_text),
        //   "This is the Resources Screen");
      });
      group('Resources', () {
        /*
    Given I am on the Resources Screen
    And I see two icon tabs
    When I tap the school icon
    Then I should see a list of campus resources
    */
        test(
            "Clicking the school icon should direct the user to the campus resources tab",
            () async {
          final schoolResources = find.byValueKey("school-icon");
          await driver.tap(schoolResources);
          await driver.waitFor(find.text('Dean of Students'));
        });

        /*
    Given I am on the Resources Screen
    And I see two icon tabs
    When I tap the arrow icon
    Then I should see a list of external resources
    */
        test(
            "Clicking the external icon should direct the user to the external resources tab",
            () async {
          final externalResources = find.byValueKey("external-icon");
          await driver.tap(externalResources);
          await driver
              .waitFor(find.text('National Suicide Prevention Hotline'));
        });
      });
    },
  );

  // group('Sad Paths', () {
  //   /*Given I am on the Login Screen
  //   When I tap "Email"
  //   And I enter "goob@gmail.com"
  //   And I tap "Login"
  //   Then I should remain on the Login Screen*/
  //   test(
  //       "An invalid utrgv email should not direct the user to another screen and user should remain on the login screen",
  //       () async {
  //     //backbutton to get back to main screen for test to implement properly
  //     final backButton = find.byValueKey("back-button");
  //     await driver.tap(backButton);

  //     final email_textfield = find.byValueKey("email-input");
  //     await driver.tap(email_textfield);
  //     await driver.enterText('goob@gmail.com');
  //     await driver.waitFor(find.text('goob@gmail.com'));

  //     final login_button = find.byValueKey("login-button");
  //     await driver.tap(login_button);

  //     await driver.tap(email_textfield);
  //   });
  //   /*Given I am on the Login Screen
  //   When I tap "Email"
  //   And I do not enter anything
  //   And I tap "Login"
  //   Then I should remain on the Login Screen*/
  //   test(
  //       "An invalid utrgv email should not direct the user to another screen and user should remain on the login screen",
  //       () async {
  //     final email_textfield = find.byValueKey("email-input");
  //     await driver.tap(email_textfield);

  //     final login_button = find.byValueKey("login-button");
  //     await driver.tap(login_button);

  //     await driver.tap(email_textfield);
  //   });
  // });

  // group('Back Buttons', () {
  //   test(
  //       "Back button on any screen should take the user back to the login screen",
  //       () async {
  //     final email_textfield = find.byValueKey("email-input");
  //     await driver.tap(email_textfield);
  //     await driver.enterText('goob@utrgv.edu');
  //     await driver.waitFor(find.text('goob@utrgv.edu'));

  //     final login_button = find.byValueKey("login-button");
  //     await driver.tap(login_button);

  //     final back_button = find.byValueKey("back-button");
  //     await driver.tap(back_button);

  //     final login_text = find.byValueKey("new-user");

  //     expect(await driver.getText(login_text), "New User? Create Account");
  //   });
  // });
}
