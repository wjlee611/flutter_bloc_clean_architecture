//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/update_article.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'update_article_request.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateArticleRequest {
  /// Returns a new [UpdateArticleRequest] instance.
  UpdateArticleRequest({

    required  this.article,
  });

  @JsonKey(
    
    name: r'article',
    required: true,
    includeIfNull: false,
  )


  final UpdateArticle article;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is UpdateArticleRequest &&
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

  factory UpdateArticleRequest.fromJson(Map<String, dynamic> json) => _$UpdateArticleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateArticleRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

