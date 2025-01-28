// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateArticle _$UpdateArticleFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'UpdateArticle',
      json,
      ($checkedConvert) {
        final val = UpdateArticle(
          title: $checkedConvert('title', (v) => v as String?),
          description: $checkedConvert('description', (v) => v as String?),
          body: $checkedConvert('body', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$UpdateArticleToJson(UpdateArticle instance) =>
    <String, dynamic>{
      if (instance.title case final value?) 'title': value,
      if (instance.description case final value?) 'description': value,
      if (instance.body case final value?) 'body': value,
    };
