// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_articles_feed200_response_articles_inner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetArticlesFeed200ResponseArticlesInner
    _$GetArticlesFeed200ResponseArticlesInnerFromJson(
            Map<String, dynamic> json) =>
        $checkedCreate(
          'GetArticlesFeed200ResponseArticlesInner',
          json,
          ($checkedConvert) {
            $checkKeys(
              json,
              requiredKeys: const [
                'slug',
                'title',
                'description',
                'tagList',
                'createdAt',
                'updatedAt',
                'favorited',
                'favoritesCount',
                'author'
              ],
            );
            final val = GetArticlesFeed200ResponseArticlesInner(
              slug: $checkedConvert('slug', (v) => v as String),
              title: $checkedConvert('title', (v) => v as String),
              description: $checkedConvert('description', (v) => v as String),
              tagList: $checkedConvert('tagList',
                  (v) => (v as List<dynamic>).map((e) => e as String).toList()),
              createdAt: $checkedConvert(
                  'createdAt', (v) => DateTime.parse(v as String)),
              updatedAt: $checkedConvert(
                  'updatedAt', (v) => DateTime.parse(v as String)),
              favorited: $checkedConvert('favorited', (v) => v as bool),
              favoritesCount:
                  $checkedConvert('favoritesCount', (v) => (v as num).toInt()),
              author: $checkedConvert(
                  'author', (v) => Profile.fromJson(v as Map<String, dynamic>)),
            );
            return val;
          },
        );

Map<String, dynamic> _$GetArticlesFeed200ResponseArticlesInnerToJson(
        GetArticlesFeed200ResponseArticlesInner instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'title': instance.title,
      'description': instance.description,
      'tagList': instance.tagList,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'favorited': instance.favorited,
      'favoritesCount': instance.favoritesCount,
      'author': instance.author.toJson(),
    };
