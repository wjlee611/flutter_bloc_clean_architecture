import 'package:equatable/equatable.dart';

class BaseResponseModel<T> extends Equatable {
  final int code;
  final String? message;
  final T? data;

  const BaseResponseModel({
    required this.code,
    this.message,
    this.data,
  });

  @override
  List<Object?> get props => [
        code,
        message,
        data,
      ];
}
