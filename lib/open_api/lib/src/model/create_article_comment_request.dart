//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/new_comment.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'create_article_comment_request.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateArticleCommentRequest {
  /// Returns a new [CreateArticleCommentRequest] instance.
  CreateArticleCommentRequest({

    required  this.comment,
  });

  @JsonKey(
    
    name: r'comment',
    required: true,
    includeIfNull: false,
  )


  final NewComment comment;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is CreateArticleCommentRequest &&
      runtimeType == other.runtimeType &&
      equals(
        [
            comment,
        ],
        [
            other.comment,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        comment,
    ],);

  factory CreateArticleCommentRequest.fromJson(Map<String, dynamic> json) => _$CreateArticleCommentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateArticleCommentRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

