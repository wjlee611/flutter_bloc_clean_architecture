// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => $checkedCreate(
      'User',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['email', 'token', 'username', 'bio', 'image'],
        );
        final val = User(
          email: $checkedConvert('email', (v) => v as String),
          token: $checkedConvert('token', (v) => v as String),
          username: $checkedConvert('username', (v) => v as String),
          bio: $checkedConvert('bio', (v) => v as String),
          image: $checkedConvert('image', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'token': instance.token,
      'username': instance.username,
      'bio': instance.bio,
      'image': instance.image,
    };
