import 'package:equatable/equatable.dart';

sealed class SplashState extends Equatable {
  String get statusText;
}

class SplashInitState extends SplashState {
  @override
  String get statusText => 'Initializing...';

  @override
  List<Object?> get props => [];
}

class SplashGetUserState extends SplashState {
  @override
  String get statusText => 'Getting user info...';

  @override
  List<Object?> get props => [];
}

class SplashLoadOtherState extends SplashState {
  @override
  String get statusText => 'Loading other datas...';

  @override
  List<Object?> get props => [];
}

class SplashAuthenticatedState extends SplashState {
  @override
  String get statusText => 'Authorized';

  @override
  List<Object?> get props => [];
}
