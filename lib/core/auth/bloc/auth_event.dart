part of 'auth_bloc_singleton.dart';

abstract class AuthEvent {}

class AuthInitEvent extends AuthEvent {}

class AuthSigninEvent extends AuthEvent {
  final User user;

  AuthSigninEvent({
    required this.user,
  });
}

class AuthSignoutEvent extends AuthEvent {}

class AuthUpdateUserEvent extends AuthEvent {
  final User user;

  AuthUpdateUserEvent({
    required this.user,
  });
}
