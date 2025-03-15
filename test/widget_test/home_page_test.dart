import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_state.dart';
import 'package:flutter_bloc_clean_architecture/core/router/app_router.dart';
import 'package:flutter_bloc_clean_architecture/flavors.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/source/local/secure_storage.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/home/widget/favorite/favorite_button.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';
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

  testWidgets('Home Page', (widgetTester) async {
    await widgetTester.pumpWidgetWithGoRouter(
      initialTestRoute: AppRouter.home,
      forcedAuthState: AuthAuthenticatedState(
        user: User(
          username: 'tester',
          email: 'tester@email.com',
          bio: 'tester\'s bio',
          image:
              'https://raw.githubusercontent.com/flutter/website/master/src/_assets/image/flutter-logomark-320px.png',
          token: 'tester',
        ),
      ),
    );

    await homePageTest(widgetTester);
  });
}

Future<void> homePageTest(WidgetTester widgetTester) async {
  await widgetTester.pump(Duration(seconds: 1)); // Home init loading
  expect(find.text('title 0'), findsOneWidget);

  for (var i = 0; i < 3; i++) {
    final targetIdx = (i + 1) * 20 - 1;
    await widgetTester.scrollUntilVisible(
      find.text('title $targetIdx'),
      500.0,
    );
    expect(find.text('title $targetIdx'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsWidgets);
    await widgetTester.pump(Duration(seconds: 1)); // Home more loading
  }
  // last article: 59
  expect(find.text('title 60'), findsNothing);
  expect(find.byType(CircularProgressIndicator), findsNothing);

  final slug58FavoriteButton = find.byKey(Key('58-slug-favorite-button'));
  final slug59FavoriteButton = find.byKey(Key('59-slug-favorite-button'));
  final slug58Favor = find.byKey(Key('58-slug-favor'));
  final slug59Favor = find.byKey(Key('59-slug-favor'));
  final slug58Unfavor = find.byKey(Key('58-slug-unfavor'));
  final slug59Unfavor = find.byKey(Key('59-slug-unfavor'));

  expect(slug58Favor, findsWidgets);
  expect(slug59Unfavor, findsWidgets);

  await widgetTester.tap(slug58FavoriteButton);
  await widgetTester.tap(slug59FavoriteButton);
  await widgetTester.pump(Duration(seconds: 1)); // loading update

  expect(slug58Unfavor, findsWidgets);
  expect(slug59Favor, findsWidgets);

  await widgetTester.tap(find.text('title 59'));
  await widgetTester.pumpAndSettle();

  expect(find.text('Article'), findsWidgets);
  await widgetTester.pump(Duration(seconds: 1)); // loading hydration
  expect(find.text('Article - hydrated'), findsWidgets);

  await widgetTester.tap(find.byType(FavoriteButton));
  await widgetTester.pump(Duration(seconds: 1));
  await widgetTester.tap(find.bySemanticsLabel('Back'));
  await widgetTester.pumpAndSettle();
  expect(slug59Unfavor, findsWidgets);

  final signoutButton = find.byKey(Key('signout-button'));
  await widgetTester.tap(signoutButton);
  await widgetTester.pumpAndSettle();
  expect(find.text('Sign in'), findsWidgets);
}
