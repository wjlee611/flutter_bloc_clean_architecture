import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/flavors.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/source/local/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../test/util/extensions.dart';
import '../test/widget_test/home_article_page_test.dart';
import '../test/widget_test/home_page_test.dart';
import '../test/widget_test/signin_page_test.dart';
import '../test/widget_test/signup_page_test.dart';
import '../test/widget_test/splash_page_from_unauth_test.dart';

void main() {
  setUpAll(() {
    F.appFlavor = Flavor.e2e;
    // If FlutterSecureStorage mock is not set, read/write will not work.
    FlutterSecureStorage.setMockInitialValues({
      SecureStorage.token: '',
    });
  });

  const deviceName = String.fromEnvironment(
    'DEVICE_NAME',
    defaultValue: 'unknown_device',
  );

  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group(
    'OK Page transition',
    () {
      testWidgets(
        'Progress to Setting',
        (widgetTester) async {
          // Build the splash page, and wait for it to pass
          // the “Test Starting...” screen.
          await widgetTester.pumpWidgetWithGoRouter();
          await widgetTester.pump();

          // Capture Splash Page
          await widgetTester.takePicture(
            binding,
            path: 'screenshots/$deviceName/$deviceName-1.png',
          );

          // Simulates the Splash Page and navigation to the Signin Page.
          await splashFromUnAuthPageTest(widgetTester, isE2E: true);

          // Capture Signin Page
          await widgetTester.takePicture(
            binding,
            path: 'screenshots/$deviceName/$deviceName-2.png',
          );

          // Simulates the Signin Page and navigation to the Home Page.
          // There's a short detour to the Signup Page in the middle.
          await signinPageTest(widgetTester);

          // MAGIC: Differences in behavior on AOS and iOS.
          // (Capture on iOS is slightly faster, showing loading indicator)
          // Therefore, wait a little more time for the loading indicator to disappear.
          await widgetTester.pump(Duration(seconds: 1));
          // Capture Home Page
          await widgetTester.takePicture(
            binding,
            path: 'screenshots/$deviceName/$deviceName-4.png',
          );

          // Simulates the Home Page.
          // There's a short detour to the Article Page in the middle.
          await homePageTest(widgetTester);

          // Scroll to the top and navigate to the Articles Page.
          await widgetTester.scrollUntilVisible(find.text('title 1'), -500.0);
          await widgetTester.pumpAndSettle();
          await widgetTester.tap(find.text('title 1'));
          await widgetTester.pumpAndSettle();

          // Simulates the Article Page.
          await homeArticlePageTest(widgetTester, hasInitialData: true);

          // Capture Article Page
          await widgetTester.takePicture(
            binding,
            path: 'screenshots/$deviceName/$deviceName-5.png',
          );

          // Simulates Returning to the Home Page, signing out.
          await homeArticlePagePopTest(widgetTester);
          await homePageSignoutTest(widgetTester);

          // Navigate to the Signup Page.
          final createAccountFinder = find.byKey(Key('create-account'));
          await widgetTester.tap(createAccountFinder);
          await widgetTester.pumpAndSettle();

          // Capture Signup Page
          await widgetTester.takePicture(
            binding,
            path: 'screenshots/$deviceName/$deviceName-3.png',
          );

          // Simulates the Signup Page and navigation to the Home Page.
          await signupPageTest(widgetTester);
        },
      );
    },
  );
}
