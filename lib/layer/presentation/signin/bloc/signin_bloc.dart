import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_bloc_singleton.dart';
import 'package:flutter_bloc_clean_architecture/enum/loading_status.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/user_repository.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/signin/bloc/signin_state.dart';
import 'package:flutter_bloc_clean_architecture/util/app_snackbar.dart';

part 'signin_event.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final UserRepository _userRepository;

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  SigninBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(SigninState(status: ELoadingStatus.init)) {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    on<SigninOnTapSigninEvent>(_signinOnTapSigninEventHandler);
  }

  @override
  Future<void> close() async {
    _emailController.dispose();
    _passwordController.dispose();

    super.close();
  }

  Future<void> _signinOnTapSigninEventHandler(
    SigninOnTapSigninEvent event,
    Emitter<SigninState> emit,
  ) async {
    // Validation
    if (_emailController.text.isEmpty) {
      emit(SigninState(
        status: ELoadingStatus.error,
        message: 'Valid email required',
      ));
      appSnackbar(message: 'Valid email required');
      return;
    }
    if (_passwordController.text.isEmpty) {
      emit(SigninState(
        status: ELoadingStatus.error,
        message: 'Valid password required',
      ));
      appSnackbar(message: 'Valid password required');
      return;
    }

    emit(SigninState(status: ELoadingStatus.loading));

    // Call API
    final res = await _userRepository.signin(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (res.code != 200) {
      emit(SigninState(
        status: ELoadingStatus.error,
        message: res.message ?? 'Sign in failed [${res.code}]',
      ));
      appSnackbar(message: res.message ?? 'Sign in failed [${res.code}]');
      return;
    }

    // Save token
    if (!await _userRepository.saveToken(token: res.data!.token)) {
      emit(SigninState(
        status: ELoadingStatus.error,
        message: res.message ?? 'Sign in failed [${res.code}]',
      ));
      appSnackbar(message: res.message ?? 'Sign in failed [${res.code}]');
      return;
    }

    // Return to splash
    AuthBlocSingleton.instance.add(AuthInitEvent());
  }
}
