import 'package:flutter_bloc_clean_architecture/flavors.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/source/local/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../test/util/extensions.dart';
import '../test/widget_test/home_article_page_test.dart';
import '../test/widget_test/home_page_test.dart';
import '../test/widget_test/signin_page_test.dart';
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
          await widgetTester.pumpWidgetWithGoRouter();
          await widgetTester.pump();

          await widgetTester.takePicture(
            binding,
            path: 'screenshots/$deviceName/$deviceName-1.png',
          );

          await splashFromUnAuthPageTest(widgetTester, isE2E: true);

          await widgetTester.takePicture(
            binding,
            path: 'screenshots/$deviceName/$deviceName-2.png',
          );

          await signinPageTest(widgetTester);

          await widgetTester.pump(Duration(seconds: 1));
          await widgetTester.takePicture(
            binding,
            path: 'screenshots/$deviceName/$deviceName-3.png',
          );

          await homePageTest(widgetTester);

          await widgetTester.scrollUntilVisible(find.text('title 1'), -500.0);
          await widgetTester.pumpAndSettle();
          await widgetTester.tap(find.text('title 1'));
          await widgetTester.pumpAndSettle();

          await homeArticlePageTest(widgetTester, hasInitialData: true);

          await widgetTester.takePicture(
            binding,
            path: 'screenshots/$deviceName/$deviceName-4.png',
          );

          await homeArticlePagePopTest(widgetTester);
          await homePageSignoutTest(widgetTester);
        },
      );
    },
  );
}
