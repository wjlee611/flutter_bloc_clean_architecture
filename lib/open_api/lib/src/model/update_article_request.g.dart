// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_article_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateArticleRequest _$UpdateArticleRequestFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'UpdateArticleRequest',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['article'],
        );
        final val = UpdateArticleRequest(
          article: $checkedConvert('article',
              (v) => UpdateArticle.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$UpdateArticleRequestToJson(
        UpdateArticleRequest instance) =>
    <String, dynamic>{
      'article': instance.article.toJson(),
    };
