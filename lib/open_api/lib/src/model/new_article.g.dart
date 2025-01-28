// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewArticle _$NewArticleFromJson(Map<String, dynamic> json) => $checkedCreate(
      'NewArticle',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['title', 'description', 'body'],
        );
        final val = NewArticle(
          title: $checkedConvert('title', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          body: $checkedConvert('body', (v) => v as String),
          tagList: $checkedConvert('tagList',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$NewArticleToJson(NewArticle instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'body': instance.body,
      if (instance.tagList case final value?) 'tagList': value,
    };
