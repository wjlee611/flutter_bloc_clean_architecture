//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/new_article.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'create_article_request.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateArticleRequest {
  /// Returns a new [CreateArticleRequest] instance.
  CreateArticleRequest({

    required  this.article,
  });

  @JsonKey(
    
    name: r'article',
    required: true,
    includeIfNull: false,
  )


  final NewArticle article;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is CreateArticleRequest &&
      runtimeType == other.runtimeType &&
      equals(
        [
            article,
        ],
        [
            other.article,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        article,
    ],);

  factory CreateArticleRequest.fromJson(Map<String, dynamic> json) => _$CreateArticleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateArticleRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

