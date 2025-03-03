// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Profile',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['username', 'following'],
        );
        final val = Profile(
          username: $checkedConvert('username', (v) => v as String),
          bio: $checkedConvert('bio', (v) => v as String?),
          image: $checkedConvert('image', (v) => v as String?),
          following: $checkedConvert('following', (v) => v as bool),
        );
        return val;
      },
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'username': instance.username,
      if (instance.bio case final value?) 'bio': value,
      if (instance.image case final value?) 'image': value,
      'following': instance.following,
    };
