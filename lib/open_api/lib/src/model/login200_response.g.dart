// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login200_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login200Response _$Login200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'Login200Response',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['user'],
        );
        final val = Login200Response(
          user: $checkedConvert(
              'user', (v) => User.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$Login200ResponseToJson(Login200Response instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
    };
