import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_bloc_singleton.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_state.dart';
import 'package:flutter_bloc_clean_architecture/core/router/app_router.dart';
import 'package:flutter_bloc_clean_architecture/core/usecase/usecase_provider.dart';
import 'package:flutter_bloc_clean_architecture/flavors.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/repository_impl/article_repository_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/repository_impl/article_repository_mock_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/repository_impl/user_repository_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/repository_impl/user_repository_mock_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/source/local/secure_storage_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/article_repository.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/user_repository.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/usecase/toggle_favorite.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test/src/channel.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpWidgetWithGoRouter({
    String initialTestRoute = AppRouter.root,
    AuthState? forcedAuthState,
  }) {
    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository>(
            create: (context) => F.appFlavor == Flavor.prod
                ? UserRepositoryImpl(
                    secureStorage: SecureStorageImpl(
                      storage: FlutterSecureStorage(),
                    ),
                  )
                : UserRepositoryMockImpl(
                    secureStorage: SecureStorageImpl(
                      storage: FlutterSecureStorage(),
                    ),
                  ),
          ),
          RepositoryProvider<ArticleRepository>(
            create: (context) => F.appFlavor == Flavor.prod
                ? ArticleRepositoryImpl()
                : ArticleRepositoryMockImpl(),
          ),
        ],
        child: MultiUsecaseProvider(
          providers: [
            UsecaseProvider(
              create: (context) => ToggleFavorite(
                articleRepository: context.read<ArticleRepository>(),
              ),
            ),
          ],
          child: Builder(
            builder: (context) {
              // Singleton Initialization
              AuthBlocSingleton.initialize(
                force: true,
                userRepository: context.read<UserRepository>(),
              );

              if (forcedAuthState != null) {
                AuthBlocSingleton.instance.testForceSetState(forcedAuthState);
              }
              // Because it uses [AuthBlocSingleton] internally,
              // its initialization must be later than [AuthBlocSingleton].
              AppRouter.initialize(
                force: true,
                initialTestRoute: initialTestRoute,
              );
              // Build routes
              return MaterialApp.router(
                routerConfig: AppRouter.instance.router,
                debugShowCheckedModeBanner: false,
              );
            },
          ),
        ),
      ),
    );
  }
}

extension FindBackButton on CommonFinders {
  Finder backButton() =>
      find.byWidgetPredicate((widget) => widget is BackButton);
}

extension TakePicture on WidgetTester {
  Future<void> takePicture(
    IntegrationTestWidgetsFlutterBinding binding, {
    required String path,
  }) async {
    if (kIsWeb) {
      await binding.takeScreenshot(path);
      return;
    }

    if (Platform.isAndroid) {
      // TODO: Change to binding.convertFlutterSurfaceToImage() when this issue is fixed: https://github.com/flutter/flutter/issues/92381
      await integrationTestChannel.invokeMethod<void>(
        'convertFlutterSurfaceToImage',
      );
    }
    // await pump();

    // TODO: Replace the following block with binding.takeScreenshot(name) when this issue is fixed: https://github.com/flutter/flutter/issues/92381
    binding.reportData ??= <String, dynamic>{};
    binding.reportData!['screenshots'] ??= <dynamic>[];
    integrationTestChannel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'scheduleFrame':
          PlatformDispatcher.instance.scheduleFrame();
          break;
      }
      return null;
    });
    final rawBytes = await integrationTestChannel.invokeMethod<List<int>>(
      'captureScreenshot',
      <String, dynamic>{'name': path},
    );
    if (rawBytes == null) {
      throw StateError(
          'Expected a list of bytes, but instead captureScreenshot returned null');
    }
    final data = <String, dynamic>{
      'screenshotName': path,
      'bytes': rawBytes,
    };
    assert(data.containsKey('bytes'), 'Missing bytes key');
    (binding.reportData!['screenshots'] as List<dynamic>).add(data);
    // Replace the above block with binding.takeScreenshot(name) when this issue is fixed: https://github.com/flutter/flutter/issues/92381

    if (Platform.isAndroid) {
      // TODO: Change to binding.revertFlutterImage() when this issue is fixed: https://github.com/flutter/flutter/issues/92381
      await integrationTestChannel.invokeMethod<void>(
        'revertFlutterImage',
      );
    }
  }
}
