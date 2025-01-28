// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_article_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateArticleRequest _$CreateArticleRequestFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'CreateArticleRequest',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['article'],
        );
        final val = CreateArticleRequest(
          article: $checkedConvert(
              'article', (v) => NewArticle.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$CreateArticleRequestToJson(
        CreateArticleRequest instance) =>
    <String, dynamic>{
      'article': instance.article.toJson(),
    };
