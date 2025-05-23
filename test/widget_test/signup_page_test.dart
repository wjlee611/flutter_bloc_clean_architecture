import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_state.dart';
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
      SecureStorage.token: '',
    });
  });

  testWidgets('Signup Page', (widgetTester) async {
    await widgetTester.pumpWidgetWithGoRouter(
      initialTestRoute: AppRouter.signup,
      forcedAuthState: AuthUnAuthenticatedState(),
    );

    await signupPageTest(widgetTester);
  });
}

Future<void> signupPageTest(WidgetTester widgetTester) async {
  final usernameFieldFinder = find.byKey(Key('username-field'));
  final emailFieldFinder = find.byKey(Key('email-field'));
  final passwordFieldFinder = find.byKey(Key('password-field'));
  final signupButtonFinder = find.byKey(Key('signup-button'));

  await widgetTester.tap(signupButtonFinder);
  await widgetTester.pumpAndSettle();
  expect(find.text('Valid username required'), findsOneWidget);
  // Wait for collapse snackbar
  await widgetTester.pump(Duration(seconds: 2));

  await widgetTester.enterText(usernameFieldFinder, 'tester');
  FocusManager.instance.primaryFocus?.unfocus();
  await widgetTester
      .pumpAndSettle(Duration(seconds: 1)); // Wait for dismiss keyboard

  await widgetTester.tap(signupButtonFinder);
  await widgetTester.pumpAndSettle();
  expect(find.text('Valid email required'), findsOneWidget);
  // Wait for collapse snackbar
  await widgetTester.pump(Duration(seconds: 2));

  await widgetTester.enterText(emailFieldFinder, 'tester@test.com');
  FocusManager.instance.primaryFocus?.unfocus();
  await widgetTester
      .pumpAndSettle(Duration(seconds: 1)); // Wait for dismiss keyboard

  await widgetTester.tap(signupButtonFinder);
  await widgetTester.pumpAndSettle();
  expect(find.text('Valid password required'), findsOneWidget);
  // Wait for collapse snackbar
  await widgetTester.pump(Duration(seconds: 2));

  await widgetTester.enterText(passwordFieldFinder, 'password');
  FocusManager.instance.primaryFocus?.unfocus();
  await widgetTester
      .pumpAndSettle(Duration(seconds: 1)); // Wait for dismiss keyboard

  await widgetTester.tap(signupButtonFinder);
  await widgetTester.pump(Duration(seconds: 1)); // Signin button loading
  await widgetTester.pump(Duration(seconds: 2)); // Splash loading
  expect(find.text("Splash Page"), findsOneWidget);
  await widgetTester.pump(Duration(seconds: 1)); // Home init loading
  expect(find.text("Home"), findsOneWidget);
}
