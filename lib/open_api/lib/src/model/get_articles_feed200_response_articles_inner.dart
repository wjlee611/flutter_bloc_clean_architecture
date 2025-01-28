//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/profile.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'get_articles_feed200_response_articles_inner.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GetArticlesFeed200ResponseArticlesInner {
  /// Returns a new [GetArticlesFeed200ResponseArticlesInner] instance.
  GetArticlesFeed200ResponseArticlesInner({

    required  this.slug,

    required  this.title,

    required  this.description,

    required  this.tagList,

    required  this.createdAt,

    required  this.updatedAt,

    required  this.favorited,

    required  this.favoritesCount,

    required  this.author,
  });

  @JsonKey(
    
    name: r'slug',
    required: true,
    includeIfNull: false,
  )


  final String slug;



  @JsonKey(
    
    name: r'title',
    required: true,
    includeIfNull: false,
  )


  final String title;



  @JsonKey(
    
    name: r'description',
    required: true,
    includeIfNull: false,
  )


  final String description;



  @JsonKey(
    
    name: r'tagList',
    required: true,
    includeIfNull: false,
  )


  final List<String> tagList;



  @JsonKey(
    
    name: r'createdAt',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'updatedAt',
    required: true,
    includeIfNull: false,
  )


  final DateTime updatedAt;



  @JsonKey(
    
    name: r'favorited',
    required: true,
    includeIfNull: false,
  )


  final bool favorited;



  @JsonKey(
    
    name: r'favoritesCount',
    required: true,
    includeIfNull: false,
  )


  final int favoritesCount;



  @JsonKey(
    
    name: r'author',
    required: true,
    includeIfNull: false,
  )


  final Profile author;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is GetArticlesFeed200ResponseArticlesInner &&
      runtimeType == other.runtimeType &&
      equals(
        [
            slug,
            title,
            description,
            tagList,
            createdAt,
            updatedAt,
            favorited,
            favoritesCount,
            author,
        ],
        [
            other.slug,
            other.title,
            other.description,
            other.tagList,
            other.createdAt,
            other.updatedAt,
            other.favorited,
            other.favoritesCount,
            other.author,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        slug,
        title,
        description,
        tagList,
        createdAt,
        updatedAt,
        favorited,
        favoritesCount,
        author,
    ],);

  factory GetArticlesFeed200ResponseArticlesInner.fromJson(Map<String, dynamic> json) => _$GetArticlesFeed200ResponseArticlesInnerFromJson(json);

  Map<String, dynamic> toJson() => _$GetArticlesFeed200ResponseArticlesInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

