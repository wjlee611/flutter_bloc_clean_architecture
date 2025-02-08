import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/source/local/secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorage _secureStorage;

  AuthInterceptor({
    required SecureStorage secureStorage,
  }) : _secureStorage = secureStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.getToken();

    options.headers[HttpHeaders.authorizationHeader] = 'Token $token';

    handler.next(options);
  }
}
