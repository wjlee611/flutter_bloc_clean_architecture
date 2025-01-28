// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUser _$UpdateUserFromJson(Map<String, dynamic> json) => $checkedCreate(
      'UpdateUser',
      json,
      ($checkedConvert) {
        final val = UpdateUser(
          email: $checkedConvert('email', (v) => v as String?),
          password: $checkedConvert('password', (v) => v as String?),
          username: $checkedConvert('username', (v) => v as String?),
          bio: $checkedConvert('bio', (v) => v as String?),
          image: $checkedConvert('image', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$UpdateUserToJson(UpdateUser instance) =>
    <String, dynamic>{
      if (instance.email case final value?) 'email': value,
      if (instance.password case final value?) 'password': value,
      if (instance.username case final value?) 'username': value,
      if (instance.bio case final value?) 'bio': value,
      if (instance.image case final value?) 'image': value,
    };
