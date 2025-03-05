import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_bloc_singleton.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_state.dart';
import 'package:flutter_bloc_clean_architecture/enum/loading_status.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/repository_impl/user_repository_mock_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/source/local/secure_storage.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/source/local/secure_storage_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/user_repository.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/signup/bloc/signup_bloc.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/signup/bloc/signup_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    // If FlutterSecureStorage mock is not set, read/write will not work.
    FlutterSecureStorage.setMockInitialValues({
      SecureStorage.token: '',
    });
  });

  group('[OK] SignupBloc', () {
    late final UserRepository userRepository;

    setUpAll(() {
      userRepository = UserRepositoryMockImpl(
        secureStorage: SecureStorageImpl(
          storage: FlutterSecureStorage(),
        ),
        delayms: 1,
      );
    });

    blocTest<SignupBloc, SignupState>(
      'Test SignupOnTapSignupEvent',
      build: () => SignupBloc(userRepository: userRepository),
      setUp: () {
        AuthBlocSingleton.initialize(
          userRepository: userRepository,
          force: true,
        );
        AuthBlocSingleton.instance
            .testForceSetState(AuthUnAuthenticatedState());
      },
      act: (bloc) async {
        bloc.setAccount(
          email: 'test-email',
          password: 'test-password',
          username: 'test-username',
        );
        await Future.delayed(Duration.zero);

        bloc.add(SignupOnTapSignupEvent());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        SignupState(status: ELoadingStatus.loading),
      ],
      verify: (bloc) {
        assert(AuthBlocSingleton.instance.state is AuthInitState);
      },
    );
  });

  group('[User ERROR] SignupBloc', () {
    late final UserRepository userRepository;

    setUpAll(() {
      userRepository = UserRepositoryMockImpl(
        secureStorage: SecureStorageImpl(
          storage: FlutterSecureStorage(),
        ),
        delayms: 1,
      );
    });

    blocTest<SignupBloc, SignupState>(
      'Test SignupOnTapSignupEvent blank email',
      build: () => SignupBloc(userRepository: userRepository),
      setUp: () {
        AuthBlocSingleton.initialize(
          userRepository: userRepository,
          force: true,
        );
        AuthBlocSingleton.instance
            .testForceSetState(AuthUnAuthenticatedState());
      },
      act: (bloc) async {
        bloc.setAccount(
          password: 'test-password',
          username: 'test-username',
        );
        await Future.delayed(Duration.zero);

        bloc.add(SignupOnTapSignupEvent());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        SignupState(
          status: ELoadingStatus.error,
          message: "Valid email required",
        ),
      ],
      verify: (bloc) {
        assert(AuthBlocSingleton.instance.state is AuthUnAuthenticatedState);
      },
    );

    blocTest<SignupBloc, SignupState>(
      'Test SignupOnTapSignupEvent blank password',
      build: () => SignupBloc(userRepository: userRepository),
      setUp: () {
        AuthBlocSingleton.initialize(
          userRepository: userRepository,
          force: true,
        );
        AuthBlocSingleton.instance
            .testForceSetState(AuthUnAuthenticatedState());
      },
      act: (bloc) async {
        bloc.setAccount(
          email: 'test-email',
          username: 'test-username',
        );
        await Future.delayed(Duration.zero);

        bloc.add(SignupOnTapSignupEvent());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        SignupState(
          status: ELoadingStatus.error,
          message: "Valid password required",
        ),
      ],
      verify: (bloc) {
        assert(AuthBlocSingleton.instance.state is AuthUnAuthenticatedState);
      },
    );

    blocTest<SignupBloc, SignupState>(
      'Test SignupOnTapSignupEvent blank username',
      build: () => SignupBloc(userRepository: userRepository),
      setUp: () {
        AuthBlocSingleton.initialize(
          userRepository: userRepository,
          force: true,
        );
        AuthBlocSingleton.instance
            .testForceSetState(AuthUnAuthenticatedState());
      },
      act: (bloc) async {
        bloc.setAccount(
          email: 'test-email',
          password: 'test-password',
        );
        await Future.delayed(Duration.zero);

        bloc.add(SignupOnTapSignupEvent());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        SignupState(
          status: ELoadingStatus.error,
          message: "Valid username required",
        ),
      ],
      verify: (bloc) {
        assert(AuthBlocSingleton.instance.state is AuthUnAuthenticatedState);
      },
    );
  });

  group('[404 ERROR] SignupBloc', () {
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

    blocTest<SignupBloc, SignupState>(
      'Test SignupOnTapSignupEvent',
      build: () => SignupBloc(userRepository: userRepository),
      setUp: () {
        AuthBlocSingleton.initialize(
          userRepository: userRepository,
          force: true,
        );
        AuthBlocSingleton.instance
            .testForceSetState(AuthUnAuthenticatedState());
      },
      act: (bloc) async {
        bloc.setAccount(
          email: 'test-email',
          password: 'test-password',
          username: 'test-username',
        );
        await Future.delayed(Duration.zero);

        bloc.add(SignupOnTapSignupEvent());
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        SignupState(status: ELoadingStatus.loading),
        SignupState(status: ELoadingStatus.error, message: "404-error"),
      ],
      verify: (bloc) {
        assert(AuthBlocSingleton.instance.state is AuthUnAuthenticatedState);
      },
    );
  });
}
