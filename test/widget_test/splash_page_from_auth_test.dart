import 'package:flutter_bloc_clean_architecture/core/router/app_router.dart';
import 'package:flutter_bloc_clean_architecture/flavors.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/source/local/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import '../util/extensions.dart';

void main() {
  setUpAll(() {
    F.appFlavor = Flavor.dev;
    // If FlutterSecureStorage mock is not set, read/write will not work.
    FlutterSecureStorage.setMockInitialValues({
      SecureStorage.token: 'tester',
    });
  });

  testWidgets('Splash Page From Auth', (widgetTester) async {
    await widgetTester.pumpWidgetWithGoRouter(
      initialTestRoute: AppRouter.root,
    );

    await splashFromAuthPageTest(widgetTester);
  });
}

Future<void> splashFromAuthPageTest(WidgetTester widgetTester) async {
  expect(find.text("Initializing..."), findsOneWidget);
  await widgetTester.pump();
  expect(find.text("Getting user info..."), findsOneWidget);
  await widgetTester.pump(Duration(seconds: 1));
  expect(find.text("Loading other datas..."), findsOneWidget);
  await widgetTester.pump(Duration(seconds: 1));
  expect(find.text("Authorized"), findsOneWidget);

  await widgetTester.pump(Duration(seconds: 1)); // Home init loading
  expect(find.text('Home'), findsWidgets);
}
