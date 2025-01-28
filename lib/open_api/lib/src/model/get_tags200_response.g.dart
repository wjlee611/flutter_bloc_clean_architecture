// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_tags200_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTags200Response _$GetTags200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'GetTags200Response',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['tags'],
        );
        final val = GetTags200Response(
          tags: $checkedConvert('tags',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$GetTags200ResponseToJson(GetTags200Response instance) =>
    <String, dynamic>{
      'tags': instance.tags,
    };
