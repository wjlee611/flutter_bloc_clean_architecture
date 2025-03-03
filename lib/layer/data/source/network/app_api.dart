import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_clean_architecture/core/auth/bloc/auth_bloc_singleton.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/source/local/secure_storage.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/source/local/secure_storage_impl.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/source/network/interceptor/auth_interceptor.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/model/base_response_model.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';
import 'package:flutter_bloc_clean_architecture/util/app_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// A singleton class that manages [Openapi] instances used throughout the app.
///
/// Only the [swaggerApi] function is public. \
/// {@macro swagger_api}
class AppApi {
  late final SecureStorage _secureStorage;

  static final AppApi _instance = AppApi._();
  static AppApi get instance => _instance;

  /// Variables to check if token is being renewed.
  ///
  /// This is used to avoid duplicate token renewals when multiple API
  /// calls are made at the same time.
  bool _isRefreshing = false;

  /// List to store API calls to retry after token renewal
  ///
  /// Set [_isRefreshing] to true before API 1 refreshes the token. \
  /// APIs 2, 3... that are called during token renewal and retry are stored
  /// in [_refreshSubscribers].
  ///
  /// When API 1 finishes retrying, call the [_onTokenRefreshed] function
  /// to retry APIs 2, 3... stored in [_refreshSubscribers].
  final List<Function()> _refreshSubscribers = [];

  // Openapi 인스턴스
  late Openapi _apiWithAuth;
  late Openapi _apiWithUnAuth;

  AppApi._() {
    // Singleton DI
    // Trade-off: Duplicate instances may be created, but can be accessed outside of context.
    // final flavor = F.appFlavor;
    _secureStorage = SecureStorageImpl(
      storage: FlutterSecureStorage(),
    );

    _apiWithAuth = Openapi(
      basePathOverride: AppConfig.instance.baseUrl,
      interceptors: [
        AuthInterceptor(secureStorage: _secureStorage),
      ],
    );
    _apiWithUnAuth = Openapi(
      basePathOverride: AppConfig.instance.baseUrl,
    );
  }

  /// swaggerApi private function
  ///
  /// {@template swagger_api}
  /// _Params_
  /// - [cb] - An asynchronous callback function that takes an [Openapi] instance as an argument. \
  ///   You can use code-generated API interfaces with an openapi instance.
  ///
  ///   _Example_
  ///   ```dart
  ///   final res = await AppApi.instance.swaggerApi(
  ///     withAuth: false,
  ///     (api) async {
  ///       return await api.getClass1Api().authOtp(
  ///         authOtpRequest: AuthOtpRequest(
  ///           userName: name,
  ///           userPhoneNumber: phone,
  ///         ),
  ///       );
  ///     },
  ///   );
  ///   ```
  ///
  /// _Named params_
  /// - [withAuth] - Whether to use tokens. The default is true.
  /// {@endtemplate}
  /// - [withRetry] - Whether to retry after token renewal. Defaults to false. \
  ///   Must be set to false except when called from the [swaggerApi] function.
  Future<Response<T>> _swaggerApiHandleException<T>(
    Future<Response<T>> Function(Openapi api) cb, {
    bool withAuth = true,
    bool withRetry = false,
  }) async {
    try {
      return await cb(withAuth ? _apiWithAuth : _apiWithUnAuth);
    }
    // DioException is an exception class provided by the Dio package.
    on DioException catch (e) {
      // TODO: Modifications are required to match the server response format.
      final errorCode =
          e.message?.split('status code of').last.split(' ')[1] ?? '500';
      final err = e.response?.data as Map<String, dynamic>;
      final errRes = BaseResponseModel(
        code: int.parse(errorCode),
        message: err['errors']['body'].toString(),
        data: err['errors'].toString(),
      );
      if (errRes.code == 401) {
        // Check for retries for 401 (authentication) errors.
        // If you don't retry, you'll be logged out.
        if (withRetry) {
          return await _refreshTokenAndRetry<T>(cb);
        } else {
          AuthBlocSingleton.instance.add(AuthSignoutEvent());
        }
      }
      return Response(
        requestOptions: RequestOptions(),
        statusCode: errRes.code,
        statusMessage: errRes.message,
        data: null,
      );
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(),
        statusCode: 500,
        statusMessage: e.toString(),
        data: null,
      );
    }
  }

  /// {@macro swagger_api}
  Future<Response<T>> swaggerApi<T>(
    Future<Response<T>> Function(Openapi api) cb, {
    bool withAuth = true,
  }) async {
    return await _swaggerApiHandleException(
      cb,
      withAuth: withAuth,
      // withRetry: true, // TODO: for refreshing accesstoken and antomatically recall apis
    );
  }

  /// Token renewal and retry private function
  ///
  /// Called from [_swaggerApiHandleException] only if [withRetry] is true.
  Future<Response<T>> _refreshTokenAndRetry<T>(
    Future<Response<T>> Function(Openapi api) cb,
  ) async {
    if (_isRefreshing) {
      final completer = Completer<Response<T>>();
      _refreshSubscribers.add(() async {
        final res = await _swaggerApiHandleException(cb);
        completer.complete(res);
      });
      return completer.future;
    }

    // Prevent duplicate renewal requests
    _isRefreshing = true;

    // Renewing tokens
    final refreshRes = await _refreshToken();
    if (!refreshRes) {
      // If the token renewal fails, we turn off the Prevent duplicate renewal requests flag,
      // initialize the [_refreshSubscribers] list (to prevent API calls that will be failed),
      // and process the logout.
      _isRefreshing = false;
      await Future.delayed(const Duration(milliseconds: 50));
      _refreshSubscribers.clear();
      AuthBlocSingleton.instance.add(AuthSignoutEvent());
      return Response(
        requestOptions: RequestOptions(),
        statusCode: 401,
        statusMessage: 'Refresh token failed',
        data: null,
      );
    }

    // If the token renewal succeeds, retry.
    final res = await _swaggerApiHandleException(cb);
    _onTokenRefreshed();
    return res;
  }

  /// Private function called after token renewal
  ///
  /// Called after a retry after a successful token refresh in [_refreshTokenAndRetry].
  void _onTokenRefreshed() {
    // Retry the API call stored in [_refreshSubscribers].
    for (final subscriber in _refreshSubscribers) {
      subscriber.call();
    }
    // Initialize the [_refreshSubscribers] list and turn off the Prevent duplicate renewal requests flag.
    _refreshSubscribers.clear();
    _isRefreshing = false;
  }

  /// Token renewal private function.
  ///
  /// Returns true if token renewal succeeds (false on failure)
  Future<bool> _refreshToken() async {
    return false;
    // final token = await _secureStorage.getToken();
    // if (token.refreshToken == null) return false;

    // try {
    //   final res = await _apiWithUnAuth.refreshToken();
    //   if (res.statusCode == 200) {
    //     return await _secureStorage.saveToken(token: res.data);
    //   }
    //   return false;
    // } catch (e) {
    //   return false;
    // }
  }
}
