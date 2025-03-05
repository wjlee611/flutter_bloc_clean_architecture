import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_bloc_singleton.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_state.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/repository_impl/user_repository_mock_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/source/local/secure_storage_impl.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final User user1;
  late final User user2;

  setUpAll(() async {
    user1 = User(
      email: 'user1@email.com',
      token: 'user1-token',
      username: 'user1-name',
    );
    user2 = User(
      email: 'user2@email.com',
      token: 'user2-token',
      username: 'user2-name',
    );
  });

  group('[OK] AuthBlocSingleton', () {
    setUp(() {
      AuthBlocSingleton.initialize(
        force: true,
        userRepository: UserRepositoryMockImpl(
          secureStorage: SecureStorageImpl(
            storage: FlutterSecureStorage(),
          ),
        ),
      );
    });

    blocTest<AuthBlocSingleton, AuthState>(
      'Test AuthInitEvent',
      build: () => AuthBlocSingleton.instance,
      act: (bloc) {
        bloc.add(AuthInitEvent());
      },
      expect: () => [
        AuthInitState(),
      ],
    );

    blocTest<AuthBlocSingleton, AuthState>(
      'Test AuthSigninEvent',
      build: () => AuthBlocSingleton.instance,
      act: (bloc) {
        bloc.add(AuthSigninEvent(user: user1));
      },
      expect: () => [
        AuthAuthenticatedState(user: user1),
      ],
    );

    blocTest<AuthBlocSingleton, AuthState>(
      'Test AuthSigninEvent and AuthSignoutEvent',
      build: () => AuthBlocSingleton.instance,
      act: (bloc) async {
        bloc.add(AuthSigninEvent(user: user2));
        await Future.delayed(Duration.zero);
        bloc.add(AuthSignoutEvent());
      },
      expect: () => [
        AuthAuthenticatedState(user: user2),
        AuthUnAuthenticatedState(),
      ],
    );

    blocTest<AuthBlocSingleton, AuthState>(
      'Test AuthSignoutEvent',
      build: () => AuthBlocSingleton.instance,
      act: (bloc) {
        bloc.add(AuthSignoutEvent());
      },
      expect: () => [
        AuthUnAuthenticatedState(),
      ],
    );

    blocTest<AuthBlocSingleton, AuthState>(
      'Test AuthUpdateUserEvent from AuthAuthenticatedState',
      build: () => AuthBlocSingleton.instance,
      setUp: () {
        AuthBlocSingleton.instance.add(AuthSigninEvent(user: user1));
      },
      act: (bloc) {
        bloc.add(AuthUpdateUserEvent(user: user2));
      },
      expect: () => [
        AuthAuthenticatedState(user: user2),
      ],
    );

    blocTest<AuthBlocSingleton, AuthState>(
      'Test AuthUpdateUserEvent from !AuthAuthenticatedState',
      build: () => AuthBlocSingleton.instance,
      act: (bloc) {
        bloc.add(AuthUpdateUserEvent(user: user2));
      },
      expect: () => [],
    );

    blocTest<AuthBlocSingleton, AuthState>(
      'Test Custom',
      build: () => AuthBlocSingleton.instance,
      act: (bloc) async {
        bloc.add(AuthInitEvent());
        await Future.delayed(Duration.zero);

        bloc.add(AuthSigninEvent(user: user1));
        await Future.delayed(Duration.zero);

        bloc.add(AuthUpdateUserEvent(user: user2));
        await Future.delayed(Duration.zero);

        bloc.add(AuthSignoutEvent());
        await Future.delayed(Duration.zero);

        bloc.add(AuthSigninEvent(user: user1));
        await Future.delayed(Duration.zero);

        bloc.add(AuthSignoutEvent());
        await Future.delayed(Duration.zero);

        bloc.add(AuthUpdateUserEvent(user: user2));
      },
      expect: () => [
        AuthInitState(),
        AuthAuthenticatedState(user: user1),
        AuthAuthenticatedState(user: user2),
        AuthUnAuthenticatedState(),
        AuthAuthenticatedState(user: user1),
        AuthUnAuthenticatedState(),
      ],
    );
  });
}
