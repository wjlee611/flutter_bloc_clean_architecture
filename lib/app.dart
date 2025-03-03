import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_bloc_singleton.dart';
import 'package:flutter_bloc_clean_architecture/core/constant/sizes.dart';
import 'package:flutter_bloc_clean_architecture/core/router/app_router.dart';
import 'package:flutter_bloc_clean_architecture/flavors.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/repository_impl/article_repository_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/repository_impl/user_repository_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/repository_impl/user_repository_mock_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/source/local/secure_storage_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/article_repository.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/user_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
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
          create: (context) => ArticleRepositoryImpl(),
        ),
      ],
      child: Builder(
        builder: (context) {
          // Singleton Initialization
          AuthBlocSingleton.initialize(
            userRepository: context.read<UserRepository>(),
          );
          // Because it uses [AuthBlocSingleton] internally,
          // its initialization must be later than [AuthBlocSingleton].
          AppRouter.initialize();
          // Build routes
          return MaterialApp.router(
            routerConfig: AppRouter.instance.router,
            debugShowCheckedModeBanner: false,
            title: F.title,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            builder: (context, child) => _flavorBanner(
              child: child ?? SizedBox(),
              show: kDebugMode,
            ),
          );
        },
      ),
    );
  }

  Widget _flavorBanner({
    required Widget child,
    bool show = true,
  }) {
    if (show) {
      return Banner(
        location: BannerLocation.topStart,
        message: F.name,
        color: Colors.green.withAlpha(150),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: Sizes.size12,
          letterSpacing: Sizes.size1,
        ),
        textDirection: TextDirection.ltr,
        child: child,
      );
    }
    return Container(
      child: child,
    );
  }
}
