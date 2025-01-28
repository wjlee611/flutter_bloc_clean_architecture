// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewUser _$NewUserFromJson(Map<String, dynamic> json) => $checkedCreate(
      'NewUser',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['username', 'email', 'password'],
        );
        final val = NewUser(
          username: $checkedConvert('username', (v) => v as String),
          email: $checkedConvert('email', (v) => v as String),
          password: $checkedConvert('password', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$NewUserToJson(NewUser instance) => <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
    };
