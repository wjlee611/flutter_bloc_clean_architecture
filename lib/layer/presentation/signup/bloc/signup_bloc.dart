import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_bloc_singleton.dart';
import 'package:flutter_bloc_clean_architecture/enum/loading_status.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/user_repository.dart';
import 'package:flutter_bloc_clean_architecture/layer/presentation/signup/bloc/signup_state.dart';
import 'package:flutter_bloc_clean_architecture/util/app_snackbar.dart';

part 'signup_event.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepository _userRepository;

  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  SignupBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(SignupState(status: ELoadingStatus.init)) {
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    on<SignupOnTapSignupEvent>(_signupOnTapSignupEventHandler);
  }

  @override
  Future<void> close() async {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.close();
  }

  Future<void> _signupOnTapSignupEventHandler(
    SignupOnTapSignupEvent event,
    Emitter<SignupState> emit,
  ) async {
    // Validation
    if (_usernameController.text.isEmpty) {
      emit(SignupState(
        status: ELoadingStatus.error,
        message: 'Valid username required',
      ));
      appSnackbar(message: 'Valid username required');
      return;
    }
    if (_emailController.text.isEmpty) {
      emit(SignupState(
        status: ELoadingStatus.error,
        message: 'Valid email required',
      ));
      appSnackbar(message: 'Valid email required');
      return;
    }
    if (_passwordController.text.isEmpty) {
      emit(SignupState(
        status: ELoadingStatus.error,
        message: 'Valid password required',
      ));
      appSnackbar(message: 'Valid password required');
      return;
    }

    emit(SignupState(status: ELoadingStatus.loading));

    // Call API
    final res = await _userRepository.signup(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (300 <= res.code) {
      emit(SignupState(
        status: ELoadingStatus.error,
        message: res.message ?? 'Sign up failed [${res.code}]',
      ));
      appSnackbar(message: res.message ?? 'Sign up failed [${res.code}]');
      return;
    }

    // Save token
    if (!await _userRepository.saveToken(token: res.data!.token)) {
      emit(SignupState(
        status: ELoadingStatus.error,
        message: res.message ?? 'Sign up failed [${res.code}]',
      ));
      appSnackbar(message: res.message ?? 'Sign up failed [${res.code}]');
      return;
    }

    // Return to splash
    AuthBlocSingleton.instance.add(AuthInitEvent());
  }
}
