import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/flavors.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/repository_impl/article_repository_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/repository_impl/article_repository_mock_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/repository_impl/user_repository_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/repository_impl/user_repository_mock_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/source/local/secure_storage.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/source/local/secure_storage_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/article_repository.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/user_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppDI {
  static AppDI? _instance;
  static AppDI get instance {
    _instance ??= AppDI._();
    return _instance!;
  }

  late final SecureStorage secureStorage;

  late final UserRepository userRepository;
  late final ArticleRepository articleRepository;

  AppDI._() {
    debugPrint('APP DI INITIALIZED WITH FLAVOR: ${F.appFlavor}');
    secureStorage = SecureStorageImpl(
      storage: const FlutterSecureStorage(),
    );

    userRepository = F.appFlavor == Flavor.prod
        ? UserRepositoryImpl(
            secureStorage: secureStorage,
          )
        : UserRepositoryMockImpl(
            secureStorage: secureStorage,
          );
    articleRepository = F.appFlavor == Flavor.prod
        ? ArticleRepositoryImpl()
        : ArticleRepositoryMockImpl();
  }
}
