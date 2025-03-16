import 'package:flutter/foundation.dart';
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

  testWidgets('Signin Page', (widgetTester) async {
    await widgetTester.pumpWidgetWithGoRouter(
      initialTestRoute: AppRouter.signin,
      forcedAuthState: AuthUnAuthenticatedState(),
    );

    await signinPageTest(widgetTester);
  });
}

Future<void> signinPageTest(WidgetTester widgetTester) async {
  final emailFieldFinder = find.byKey(Key('email-field'));
  final passwordFieldFinder = find.byKey(Key('password-field'));
  final createAccountFinder = find.byKey(Key('create-account'));
  final signinButtonFinder = find.byKey(Key('signin-button'));

  await widgetTester.tap(signinButtonFinder);
  await widgetTester.pumpAndSettle();
  expect(find.text('Valid email required'), findsOneWidget);
  // Wait for collapse snackbar
  await widgetTester.pump(Duration(seconds: 2));

  await widgetTester.enterText(emailFieldFinder, 'tester@test.com');
  FocusManager.instance.primaryFocus?.unfocus();
  await widgetTester
      .pumpAndSettle(Duration(seconds: 1)); // Wait for dismiss keyboard

  await widgetTester.tap(signinButtonFinder);
  await widgetTester.pumpAndSettle();
  expect(find.text('Valid password required'), findsOneWidget);
  // Wait for collapse snackbar
  await widgetTester.pump(Duration(seconds: 2));

  await widgetTester.enterText(passwordFieldFinder, 'password');
  FocusManager.instance.primaryFocus?.unfocus();
  await widgetTester.pumpAndSettle(Duration(seconds: 1));

  await widgetTester.tap(createAccountFinder);
  await widgetTester.pumpAndSettle();
  expect(find.text("Sign up"), findsWidgets);

  await widgetTester.tap(find.backButton());
  await widgetTester.pumpAndSettle();
  expect(find.text("Sign in"), findsWidgets);

  await widgetTester.tap(signinButtonFinder);
  await widgetTester.pump(Duration(seconds: 1)); // Signin button loading
  await widgetTester.pump(Duration(seconds: 2)); // Splash loading
  expect(find.text("Splash Page"), findsOneWidget);
  await widgetTester.pump(Duration(seconds: 1)); // Home init loading
  expect(find.text("Home"), findsOneWidget);
}
