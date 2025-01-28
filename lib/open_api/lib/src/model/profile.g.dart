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
          requiredKeys: const ['username', 'bio', 'image', 'following'],
        );
        final val = Profile(
          username: $checkedConvert('username', (v) => v as String),
          bio: $checkedConvert('bio', (v) => v as String),
          image: $checkedConvert('image', (v) => v as String),
          following: $checkedConvert('following', (v) => v as bool),
        );
        return val;
      },
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'username': instance.username,
      'bio': instance.bio,
      'image': instance.image,
      'following': instance.following,
    };
