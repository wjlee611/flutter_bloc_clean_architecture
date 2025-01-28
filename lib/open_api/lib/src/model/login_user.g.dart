// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginUser _$LoginUserFromJson(Map<String, dynamic> json) => $checkedCreate(
      'LoginUser',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['email', 'password'],
        );
        final val = LoginUser(
          email: $checkedConvert('email', (v) => v as String),
          password: $checkedConvert('password', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$LoginUserToJson(LoginUser instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
