// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_profile_by_username200_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProfileByUsername200Response _$GetProfileByUsername200ResponseFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'GetProfileByUsername200Response',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['profile'],
        );
        final val = GetProfileByUsername200Response(
          profile: $checkedConvert(
              'profile', (v) => Profile.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$GetProfileByUsername200ResponseToJson(
        GetProfileByUsername200Response instance) =>
    <String, dynamic>{
      'profile': instance.profile.toJson(),
    };
