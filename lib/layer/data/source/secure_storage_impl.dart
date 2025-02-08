import 'package:flutter_bloc_clean_architecture/layer/data/source/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageImpl implements SecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorageImpl({
    required FlutterSecureStorage storage,
  }) : _storage = storage;

  @override
  Future<bool> saveToken({required String token}) async {
    try {
      await _storage.write(
        key: SecureStorage.token,
        value: token,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> removeToken() async {
    try {
      await _storage.delete(key: SecureStorage.token);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return await _storage.read(key: SecureStorage.token);
    } catch (e) {
      return null;
    }
  }
}
