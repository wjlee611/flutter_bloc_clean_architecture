// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_article_comments200_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetArticleComments200Response _$GetArticleComments200ResponseFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'GetArticleComments200Response',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['comments'],
        );
        final val = GetArticleComments200Response(
          comments: $checkedConvert(
              'comments',
              (v) => (v as List<dynamic>)
                  .map((e) => Comment.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$GetArticleComments200ResponseToJson(
        GetArticleComments200Response instance) =>
    <String, dynamic>{
      'comments': instance.comments.map((e) => e.toJson()).toList(),
    };
