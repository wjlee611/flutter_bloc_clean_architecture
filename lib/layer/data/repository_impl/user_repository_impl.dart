import 'package:flutter_bloc_clean_architecture/layer/data/source/secure_storage.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/model/base_response_model.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/user_repository.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';

class UserRepositoryImpl implements UserRepository {
  final SecureStorage _secureStorage;

  UserRepositoryImpl({
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
  Future<BaseResponseModel<User>> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<BaseResponseModel<User>> signin({
    required String email,
    required String password,
  }) {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  Future<BaseResponseModel<User>> signup({
    required String email,
    required String password,
    required String username,
  }) {
    // TODO: implement signup
    throw UnimplementedError();
  }
}
