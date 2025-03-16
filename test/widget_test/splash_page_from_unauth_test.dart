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
      SecureStorage.token: '',
    });
  });

  testWidgets('Splash Page From UnAuth', (widgetTester) async {
    await widgetTester.pumpWidgetWithGoRouter();

    await splashFromUnAuthPageTest(widgetTester);
  });
}

Future<void> splashFromUnAuthPageTest(
  WidgetTester widgetTester, {
  bool isE2E = false,
}) async {
  if (!isE2E) {
    expect(find.text("Initializing..."), findsOneWidget);
    await widgetTester.pump();
  }
  expect(find.text("Getting user info..."), findsOneWidget);
  await widgetTester.pumpAndSettle();

  expect(find.text('Sign in'), findsWidgets);
}
