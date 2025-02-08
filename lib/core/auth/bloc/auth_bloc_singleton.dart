import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_state.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/user_repository.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';

part 'auth_event.dart';

class AuthBlocSingleton extends Bloc<AuthEvent, AuthState> with ChangeNotifier {
  late UserRepository _userRepository;

  static AuthBlocSingleton? _instance;
  static AuthBlocSingleton get instance => _instance!;

  static initialize({
    required UserRepository userRepository,
  }) {
    _instance ??= AuthBlocSingleton._();
    _instance!._userRepository = userRepository;
  }

  AuthBlocSingleton._() : super(AuthInitState()) {
    on<AuthInitEvent>(_authInitEventHandler);
    on<AuthSigninEvent>(_authSigninEventHandler);
    on<AuthSignoutEvent>(_authSignoutEventHandler);
    on<AuthUpdateUserEvent>(_authUpdateUserEventHandler);
  }

  // =============================
  // MARK: Bloc event handlers
  // =============================

  ///
  ///
  ///
  Future<void> _authInitEventHandler(
    AuthInitEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInitState());
    notifyListeners();
  }

  ///
  ///
  ///
  Future<void> _authSigninEventHandler(
    AuthSigninEvent event,
    Emitter<AuthState> emit,
  ) async {
    bool notify = true;
    if (state is AuthAuthenticatedState &&
        event.user.email == (state as AuthAuthenticatedState).user.email) {
      notify = false;
    }
    emit(AuthAuthenticatedState(user: event.user));
    if (notify) notifyListeners();
  }

  ///
  ///
  ///
  Future<void> _authSignoutEventHandler(
    AuthSignoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _userRepository.removeToken();
    emit(AuthUnAuthenticatedState());
    notifyListeners();
  }

  ///
  ///
  ///
  Future<void> _authUpdateUserEventHandler(
    AuthUpdateUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (state is! AuthAuthenticatedState) return;
    emit(AuthAuthenticatedState(user: event.user));
  }
}
