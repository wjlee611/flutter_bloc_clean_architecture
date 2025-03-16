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

  testWidgets('Home Article Page', (widgetTester) async {
    await widgetTester.pumpWidgetWithGoRouter(
      initialTestRoute: '${AppRouter.home}/${AppRouter.homeSubArticle}/1-slug',
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

    await homeArticlePageTest(widgetTester);
    await homeArticlePagePopTest(widgetTester);
  });
}

Future<void> homeArticlePageTest(
  WidgetTester widgetTester, {
  bool hasInitialData = false,
}) async {
  final slug1Favor = find.byKey(Key('1-slug-favor'));
  final slug1Unfavor = find.byKey(Key('1-slug-unfavor'));

  expect(find.text('Article'), findsOneWidget);
  // In the integration test, the favorited are preloaded
  // during the hydration process because there is initial data.
  if (!hasInitialData) {
    expect(find.byType(FavoriteButton), findsNothing);
  }

  await widgetTester.pump(Duration(seconds: 1)); // loading hydration
  expect(find.text('Article - hydrated'), findsWidgets);
  expect(slug1Unfavor, findsOneWidget);
  expect(find.text('title 1'), findsWidgets);
  expect(find.text('description 1'), findsWidgets);
  expect(find.text('body 1'), findsWidgets);

  await widgetTester.tap(find.byType(FavoriteButton));
  await widgetTester.pump(Duration(seconds: 1));
  expect(slug1Favor, findsOneWidget);
}

Future<void> homeArticlePagePopTest(WidgetTester widgetTester) async {
  await widgetTester.tap(find.backButton());
  await widgetTester.pump(Duration(seconds: 1));
  expect(find.text('Home'), findsWidgets);
}
