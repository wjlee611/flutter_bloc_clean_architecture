// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_article201_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateArticle201Response _$CreateArticle201ResponseFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'CreateArticle201Response',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['article'],
        );
        final val = CreateArticle201Response(
          article: $checkedConvert(
              'article', (v) => Article.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$CreateArticle201ResponseToJson(
        CreateArticle201Response instance) =>
    <String, dynamic>{
      'article': instance.article.toJson(),
    };
