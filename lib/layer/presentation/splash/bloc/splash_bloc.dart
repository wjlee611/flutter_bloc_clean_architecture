import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_bloc_singleton.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/user_repository.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/splash/bloc/splash_state.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';

part 'splash_event.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final UserRepository _userRepository;

  /// [SplashGetUserEvent] sets the user information, but it is not validated.
  /// Validation is checked by calling the API in initialization logic, such as [SplashLoadOtherEvent].
  /// If you pass all other events, sign in with this.
  User? _tempUser;

  SplashBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(SplashInitState()) {
    on<SplashGetUserEvent>(_splashGetUserEventHandler);
    on<SplashLoadOtherEvent>(_splashLoadOtherEventHandler);
    on<SplashAuthenticatedEvent>(_splashAuthenticatedEventHandler);

    add(SplashGetUserEvent());
  }

  // =============================
  // MARK: Bloc event handlers
  // =============================

  ///
  ///
  ///
  Future<void> _splashGetUserEventHandler(
    SplashGetUserEvent event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashGetUserState());

    final res = await _userRepository.getUser();
    if (res.code != 200) {
      AuthBlocSingleton.instance.add(AuthSignoutEvent());
      return;
    }
    _tempUser = res.data;

    add(SplashLoadOtherEvent());
  }

  ///
  ///
  ///
  Future<void> _splashLoadOtherEventHandler(
    SplashLoadOtherEvent event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoadOtherState());

    // Extra init process
    await Future.delayed(const Duration(seconds: 1));

    add(SplashAuthenticatedEvent());
  }

  ///
  ///
  ///
  Future<void> _splashAuthenticatedEventHandler(
    SplashAuthenticatedEvent event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashAuthenticatedState());

    if (_tempUser == null) {
      AuthBlocSingleton.instance.add(AuthSignoutEvent());
      return;
    }

    AuthBlocSingleton.instance.add(AuthSigninEvent(user: _tempUser!));
  }
}
