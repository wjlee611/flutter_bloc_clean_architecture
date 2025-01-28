//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/comment.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'get_article_comments200_response.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GetArticleComments200Response {
  /// Returns a new [GetArticleComments200Response] instance.
  GetArticleComments200Response({

    required  this.comments,
  });

  @JsonKey(
    
    name: r'comments',
    required: true,
    includeIfNull: false,
  )


  final List<Comment> comments;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is GetArticleComments200Response &&
      runtimeType == other.runtimeType &&
      equals(
        [
            comments,
        ],
        [
            other.comments,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        comments,
    ],);

  factory GetArticleComments200Response.fromJson(Map<String, dynamic> json) => _$GetArticleComments200ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetArticleComments200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

