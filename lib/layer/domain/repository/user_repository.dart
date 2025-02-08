abstract class UserRepository {
  Future<bool> saveToken({required String token});

  Future<bool> removeToken();
}
