import 'package:flutter/material.dart';
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

extension PumpApp on WidgetTester {
  Future<void> pumpWidgetWithGoRouter({
    String initialTestRoute = AppRouter.root,
    AuthState? forcedAuthState,
  }) {
    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository>(
            create: (context) => F.appFlavor == Flavor.dev
                ? UserRepositoryMockImpl(
                    secureStorage: SecureStorageImpl(
                      storage: FlutterSecureStorage(),
                    ),
                  )
                : UserRepositoryImpl(
                    secureStorage: SecureStorageImpl(
                      storage: FlutterSecureStorage(),
                    ),
                  ),
          ),
          RepositoryProvider<ArticleRepository>(
            create: (context) => F.appFlavor == Flavor.dev
                ? ArticleRepositoryMockImpl()
                : ArticleRepositoryImpl(),
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
