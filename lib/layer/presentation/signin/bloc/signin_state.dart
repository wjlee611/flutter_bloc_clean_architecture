import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_clean_architecture/enum/loading_status.dart';

class SigninState extends Equatable {
  final ELoadingStatus status;
  final String? message;

  const SigninState({
    required this.status,
    this.message,
  });

  @override
  List<Object?> get props => [
        status,
        message,
      ];
}
