import 'package:flutter_bloc_clean_architecture/layer/data/source/local/secure_storage.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/model/base_response_model.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/user_repository.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';

class UserRepositoryMockImpl implements UserRepository {
  final SecureStorage _secureStorage;

  final int? errorCode;
  final int delayms;

  UserRepositoryMockImpl({
    required SecureStorage secureStorage,
    this.errorCode,
    this.delayms = 1000,
  }) : _secureStorage = secureStorage;

  @override
  Future<bool> saveToken({required String token}) async {
    if (errorCode != null) return false;

    return await _secureStorage.saveToken(token: token);
  }

  @override
  Future<bool> removeToken() async {
    if (errorCode != null) return false;

    return await _secureStorage.removeToken();
  }

  @override
  Future<BaseResponseModel<User>> getUser() async {
    await Future.delayed(Duration(milliseconds: delayms));

    if (errorCode != null) {
      return BaseResponseModel(code: errorCode!, message: '$errorCode-error');
    }

    final username = await _secureStorage.getToken();
    if (username == null || username.isEmpty) {
      return BaseResponseModel(
        code: 404,
        message: "Failed to get user",
      );
    }
    return BaseResponseModel(
      code: 200,
      data: User(
        username: username,
        email: '$username@email.com',
        bio: '$username\'s bio',
        image:
            'https://raw.githubusercontent.com/flutter/website/master/src/_assets/image/flutter-logomark-320px.png',
        token: username,
      ),
    );
  }

  @override
  Future<BaseResponseModel<User>> signin({
    required String email,
    required String password,
  }) async {
    await Future.delayed(Duration(milliseconds: delayms));

    if (errorCode != null) {
      return BaseResponseModel(code: errorCode!, message: '$errorCode-error');
    }

    final username = email.split('@')[0];
    return BaseResponseModel(
      code: 200,
      data: User(
        username: username,
        email: '$username@email.com',
        bio: '$username\'s bio',
        image:
            'https://raw.githubusercontent.com/flutter/website/master/src/_assets/image/flutter-logomark-320px.png',
        token: username,
      ),
    );
  }

  @override
  Future<BaseResponseModel<User>> signup({
    required String email,
    required String password,
    required String username,
  }) async {
    await Future.delayed(Duration(milliseconds: delayms));

    if (errorCode != null) {
      return BaseResponseModel(code: errorCode!, message: '$errorCode-error');
    }

    return BaseResponseModel(
      code: 200,
      data: User(
        username: username,
        email: '$username@email.com',
        bio: '$username\'s bio',
        image:
            'https://raw.githubusercontent.com/flutter/website/master/src/_assets/image/flutter-logomark-320px.png',
        token: username,
      ),
    );
  }
}
