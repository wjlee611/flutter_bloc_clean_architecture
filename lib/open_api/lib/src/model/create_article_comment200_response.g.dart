// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_article_comment200_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateArticleComment200Response _$CreateArticleComment200ResponseFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'CreateArticleComment200Response',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['comment'],
        );
        final val = CreateArticleComment200Response(
          comment: $checkedConvert(
              'comment', (v) => Comment.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$CreateArticleComment200ResponseToJson(
        CreateArticleComment200Response instance) =>
    <String, dynamic>{
      'comment': instance.comment.toJson(),
    };
