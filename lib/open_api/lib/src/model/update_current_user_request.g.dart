// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_current_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCurrentUserRequest _$UpdateCurrentUserRequestFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'UpdateCurrentUserRequest',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['user'],
        );
        final val = UpdateCurrentUserRequest(
          user: $checkedConvert(
              'user', (v) => UpdateUser.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$UpdateCurrentUserRequestToJson(
        UpdateCurrentUserRequest instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
    };
