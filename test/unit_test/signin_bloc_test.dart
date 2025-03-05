import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_bloc_singleton.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_state.dart';
import 'package:flutter_bloc_clean_architecture/enum/loading_status.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/repository_impl/user_repository_mock_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/source/local/secure_storage.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/source/local/secure_storage_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/user_repository.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/signin/bloc/signin_bloc.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/signin/bloc/signin_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    // If FlutterSecureStorage mock is not set, read/write will not work.
    FlutterSecureStorage.setMockInitialValues({
      SecureStorage.token: '',
    });
  });

  group('[OK] SigninBloc', () {
    late final UserRepository userRepository;

    setUpAll(() {
      userRepository = UserRepositoryMockImpl(
        secureStorage: SecureStorageImpl(
          storage: FlutterSecureStorage(),
        ),
        delayms: 1,
      );
    });

    blocTest<SigninBloc, SigninState>(
      'Test SigninOnTapSigninEvent',
      build: () => SigninBloc(userRepository: userRepository),
      setUp: () {
        AuthBlocSingleton.initialize(
          userRepository: userRepository,
          force: true,
        );
        AuthBlocSingleton.instance
            .testForceSetState(AuthUnAuthenticatedState());
      },
      act: (bloc) async {
        bloc.setAccount(email: 'test-email', password: 'test-password');
        await Future.delayed(Duration.zero);

        bloc.add(SigninOnTapSigninEvent());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        SigninState(status: ELoadingStatus.loading),
      ],
      verify: (bloc) {
        assert(AuthBlocSingleton.instance.state is AuthInitState);
      },
    );
  });

  group('[User ERROR] SigninBloc', () {
    late final UserRepository userRepository;

    setUpAll(() {
      userRepository = UserRepositoryMockImpl(
        secureStorage: SecureStorageImpl(
          storage: FlutterSecureStorage(),
        ),
        delayms: 1,
      );
    });

    blocTest<SigninBloc, SigninState>(
      'Test SigninOnTapSigninEvent blank email',
      build: () => SigninBloc(userRepository: userRepository),
      setUp: () {
        AuthBlocSingleton.initialize(
          userRepository: userRepository,
          force: true,
        );
        AuthBlocSingleton.instance
            .testForceSetState(AuthUnAuthenticatedState());
      },
      act: (bloc) async {
        bloc.setAccount(password: 'test-password');
        await Future.delayed(Duration.zero);

        bloc.add(SigninOnTapSigninEvent());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        SigninState(
          status: ELoadingStatus.error,
          message: "Valid email required",
        ),
      ],
      verify: (bloc) {
        assert(AuthBlocSingleton.instance.state is AuthUnAuthenticatedState);
      },
    );

    blocTest<SigninBloc, SigninState>(
      'Test SigninOnTapSigninEvent blank password',
      build: () => SigninBloc(userRepository: userRepository),
      setUp: () {
        AuthBlocSingleton.initialize(
          userRepository: userRepository,
          force: true,
        );
        AuthBlocSingleton.instance
            .testForceSetState(AuthUnAuthenticatedState());
      },
      act: (bloc) async {
        bloc.setAccount(email: 'test-email');
        await Future.delayed(Duration.zero);

        bloc.add(SigninOnTapSigninEvent());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        SigninState(
          status: ELoadingStatus.error,
          message: "Valid password required",
        ),
      ],
      verify: (bloc) {
        assert(AuthBlocSingleton.instance.state is AuthUnAuthenticatedState);
      },
    );
  });

  group('[404 ERROR] SigninBloc', () {
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

    blocTest<SigninBloc, SigninState>(
      'Test SigninOnTapSigninEvent',
      build: () => SigninBloc(userRepository: userRepository),
      setUp: () {
        AuthBlocSingleton.initialize(
          userRepository: userRepository,
          force: true,
        );
        AuthBlocSingleton.instance
            .testForceSetState(AuthUnAuthenticatedState());
      },
      act: (bloc) async {
        bloc.setAccount(email: 'test-email', password: 'test-password');
        await Future.delayed(Duration.zero);

        bloc.add(SigninOnTapSigninEvent());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        SigninState(status: ELoadingStatus.loading),
        SigninState(status: ELoadingStatus.error, message: "404-error"),
      ],
      verify: (bloc) {
        assert(AuthBlocSingleton.instance.state is AuthUnAuthenticatedState);
      },
    );
  });
}
