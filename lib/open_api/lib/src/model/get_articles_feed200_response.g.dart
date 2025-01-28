// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_articles_feed200_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetArticlesFeed200Response _$GetArticlesFeed200ResponseFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'GetArticlesFeed200Response',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['articles', 'articlesCount'],
        );
        final val = GetArticlesFeed200Response(
          articles: $checkedConvert(
              'articles',
              (v) => (v as List<dynamic>)
                  .map((e) => GetArticlesFeed200ResponseArticlesInner.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
          articlesCount:
              $checkedConvert('articlesCount', (v) => (v as num).toInt()),
        );
        return val;
      },
    );

Map<String, dynamic> _$GetArticlesFeed200ResponseToJson(
        GetArticlesFeed200Response instance) =>
    <String, dynamic>{
      'articles': instance.articles.map((e) => e.toJson()).toList(),
      'articlesCount': instance.articlesCount,
    };
