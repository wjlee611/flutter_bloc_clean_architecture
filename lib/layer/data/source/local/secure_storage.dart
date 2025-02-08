abstract class SecureStorage {
  static String token = 'token';

  Future<bool> saveToken({required String token});

  Future<bool> removeToken();

  Future<String?> getToken();
}
