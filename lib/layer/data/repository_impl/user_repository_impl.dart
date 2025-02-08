import 'package:flutter_bloc_clean_architecture/layer/data/source/secure_storage.dart';
import 'package:flutter_bloc_clean_architecture/layer/domain/repository/user_repository.dart';

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
}
