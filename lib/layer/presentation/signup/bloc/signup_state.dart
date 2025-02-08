import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_clean_architecture/enum/loading_status.dart';

class SignupState extends Equatable {
  final ELoadingStatus status;
  final String? message;

  const SignupState({
    required this.status,
    this.message,
  });

  @override
  List<Object?> get props => [
        status,
        message,
      ];
}
