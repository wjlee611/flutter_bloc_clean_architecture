//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/get_articles_feed200_response_articles_inner.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'get_articles_feed200_response.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GetArticlesFeed200Response {
  /// Returns a new [GetArticlesFeed200Response] instance.
  GetArticlesFeed200Response({

    required  this.articles,

    required  this.articlesCount,
  });

  @JsonKey(
    
    name: r'articles',
    required: true,
    includeIfNull: false,
  )


  final List<GetArticlesFeed200ResponseArticlesInner> articles;



  @JsonKey(
    
    name: r'articlesCount',
    required: true,
    includeIfNull: false,
  )


  final int articlesCount;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is GetArticlesFeed200Response &&
      runtimeType == other.runtimeType &&
      equals(
        [
            articles,
            articlesCount,
        ],
        [
            other.articles,
            other.articlesCount,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        articles,
        articlesCount,
    ],);

  factory GetArticlesFeed200Response.fromJson(Map<String, dynamic> json) => _$GetArticlesFeed200ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetArticlesFeed200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

