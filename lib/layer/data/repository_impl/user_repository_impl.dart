import 'package:flutter_bloc_clean_architecture/layer/data/source/local/secure_storage.dart';
import 'package:flutter_bloc_clean_architecture/layer/data/source/network/app_api.dart';
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
  Future<BaseResponseModel<User>> getUser() async {
    final res = await AppApi.instance.swaggerApi((api) async {
      return await api.getUserAndAuthenticationApi().getCurrentUser();
    });
    return BaseResponseModel(
      code: res.statusCode ?? 500,
      message: res.statusMessage,
      data: res.data?.user,
    );
  }

  @override
  Future<BaseResponseModel<User>> signin({
    required String email,
    required String password,
  }) async {
    final res = await AppApi.instance.swaggerApi(
      withAuth: false,
      (api) async {
        return await api.getUserAndAuthenticationApi().login(
              body: LoginRequest(
                user: LoginUser(
                  email: email,
                  password: password,
                ),
              ),
            );
      },
    );
    return BaseResponseModel(
      code: res.statusCode ?? 500,
      message: res.statusMessage,
      data: res.data?.user,
    );
  }

  @override
  Future<BaseResponseModel<User>> signup({
    required String email,
    required String password,
    required String username,
  }) async {
    final res = await AppApi.instance.swaggerApi(
      withAuth: false,
      (api) async {
        return await api.getUserAndAuthenticationApi().createUser(
              body: CreateUserRequest(
                user: NewUser(
                  username: username,
                  email: email,
                  password: password,
                ),
              ),
            );
      },
    );
    return BaseResponseModel(
      code: res.statusCode ?? 500,
      message: res.statusMessage,
      data: res.data?.user,
    );
  }
}
