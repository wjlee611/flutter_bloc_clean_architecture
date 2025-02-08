sealed class SplashState {
  String get statusText;
}

class SplashInitState extends SplashState {
  @override
  String get statusText => 'Initializing...';
}

class SplashGetUserState extends SplashState {
  @override
  String get statusText => 'Getting user info...';
}

class SplashLoadOtherState extends SplashState {
  @override
  String get statusText => 'Loading other datas...';
}

class SplashAuthenticatedState extends SplashState {
  @override
  String get statusText => 'Authorized';
}
