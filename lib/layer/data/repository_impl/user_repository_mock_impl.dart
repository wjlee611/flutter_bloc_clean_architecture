import 'package:flutter_bloc_clean_architecture/layer/data/source/secure_storage.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/model/base_response_model.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/user_repository.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';

class UserRepositoryMockImpl implements UserRepository {
  final SecureStorage _secureStorage;

  UserRepositoryMockImpl({
    required SecureStorage secureStorage,
  }) : _secureStorage = secureStorage;

  @override
  Future<bool> saveToken({required String token}) async {
    return await _secureStorage.saveToken(token: token);
  }

  @override
  Future<bool> removeToken() async {
    return await _secureStorage.removeToken();
  }

  @override
  Future<BaseResponseModel<User>> getUser() async {
    await Future.delayed(Duration(seconds: 1));
    final username = await _secureStorage.getToken();
    if (username == null) {
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
    await Future.delayed(Duration(seconds: 1));
    return BaseResponseModel(
      code: 200,
      data: User(
        username: 'woong',
        email: 'woong@email.com',
        bio: 'woong\'s bio',
        image:
            'https://raw.githubusercontent.com/flutter/website/master/src/_assets/image/flutter-logomark-320px.png',
        token: 'woong',
      ),
    );
  }

  @override
  Future<BaseResponseModel<User>> signup({
    required String email,
    required String password,
    required String username,
  }) async {
    await Future.delayed(Duration(seconds: 1));
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
