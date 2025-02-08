import 'package:flutter_bloc_clean_architecture/layer/domain/model/base_response_model.dart';
import 'package:flutter_bloc_clean_architecture/open_api/lib/openapi.dart';

abstract class UserRepository {
  Future<bool> saveToken({required String token});

  Future<bool> removeToken();

  Future<BaseResponseModel<User>> getUser();

  Future<BaseResponseModel<User>> signin({
    required String email,
    required String password,
  });

  Future<BaseResponseModel<User>> signup({
    required String email,
    required String password,
    required String username,
  });
}
