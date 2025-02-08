import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';

sealed class AuthState extends Equatable {}

class AuthInitState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthUnAuthenticatedState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthAuthenticatedState extends AuthState {
  final User user;

  AuthAuthenticatedState({
    required this.user,
  });

  @override
  List<Object?> get props => [
        user,
      ];
}
