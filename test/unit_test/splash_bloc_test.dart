import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_bloc_singleton.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_state.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/repository_impl/user_repository_mock_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/source/local/secure_storage.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/source/local/secure_storage_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/user_repository.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/splash/bloc/splash_bloc.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/splash/bloc/splash_state.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final String username = 'test-username';
  late final User userTest;

  setUpAll(() {
    // If FlutterSecureStorage mock is not set, read/write will not work.
    FlutterSecureStorage.setMockInitialValues({
      SecureStorage.token: '',
    });

    userTest = User(
      username: username,
      email: '$username@email.com',
      bio: '$username\'s bio',
      image:
          'https://raw.githubusercontent.com/flutter/website/master/src/_assets/image/flutter-logomark-320px.png',
      token: username,
    );
  });

  group('[OK] SplashBloc', () {
    late final UserRepository userRepository;

    setUpAll(() {
      userRepository = UserRepositoryMockImpl(
        secureStorage: SecureStorageImpl(
          storage: FlutterSecureStorage(),
        ),
        delayms: 1,
      );
    });

    blocTest<SplashBloc, SplashState>(
      'Test SplashBloc success auto signin',
      build: () => SplashBloc(userRepository: userRepository),
      setUp: () {
        FlutterSecureStorage.setMockInitialValues({
          SecureStorage.token: username,
        });

        AuthBlocSingleton.initialize(
          userRepository: userRepository,
          force: true,
        );
        AuthBlocSingleton.instance.testForceSetState(AuthInitState());
      },
      act: (bloc) async {
        await Future.delayed(Duration.zero);
      },
      wait: const Duration(milliseconds: 1050),
      expect: () => [
        SplashGetUserState(),
        SplashLoadOtherState(),
        SplashAuthenticatedState(),
      ],
      verify: (bloc) {
        assert(AuthBlocSingleton.instance.state is AuthAuthenticatedState);
        assert(
          (AuthBlocSingleton.instance.state as AuthAuthenticatedState).user ==
              userTest,
        );
      },
    );

    blocTest<SplashBloc, SplashState>(
      'Test SplashBloc fail auto signin',
      build: () => SplashBloc(userRepository: userRepository),
      setUp: () {
        FlutterSecureStorage.setMockInitialValues({
          SecureStorage.token: '',
        });

        AuthBlocSingleton.initialize(
          userRepository: userRepository,
          force: true,
        );
        AuthBlocSingleton.instance.testForceSetState(AuthInitState());
      },
      act: (bloc) async {
        await Future.delayed(Duration.zero);
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        SplashGetUserState(),
      ],
      verify: (bloc) {
        assert(AuthBlocSingleton.instance.state is AuthUnAuthenticatedState);
      },
    );
  });

  group('[404 ERROR] SplashBloc', () {
    late final UserRepository userRepository;

    setUpAll(() {
      userRepository = UserRepositoryMockImpl(
        secureStorage: SecureStorageImpl(
          storage: FlutterSecureStorage(),
        ),
        delayms: 1,
        errorCode: 404,
      );
    });

    blocTest<SplashBloc, SplashState>(
      'Test SplashBloc auto signin',
      build: () => SplashBloc(userRepository: userRepository),
      setUp: () {
        FlutterSecureStorage.setMockInitialValues({
          SecureStorage.token: username,
        });

        AuthBlocSingleton.initialize(
          userRepository: userRepository,
          force: true,
        );
        AuthBlocSingleton.instance.testForceSetState(AuthInitState());
      },
      act: (bloc) async {
        await Future.delayed(Duration.zero);
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        SplashGetUserState(),
      ],
      verify: (bloc) {
        assert(AuthBlocSingleton.instance.state is AuthUnAuthenticatedState);
      },
    );
  });
}
