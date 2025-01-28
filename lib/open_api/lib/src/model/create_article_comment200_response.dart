//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/comment.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'create_article_comment200_response.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateArticleComment200Response {
  /// Returns a new [CreateArticleComment200Response] instance.
  CreateArticleComment200Response({

    required  this.comment,
  });

  @JsonKey(
    
    name: r'comment',
    required: true,
    includeIfNull: false,
  )


  final Comment comment;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is CreateArticleComment200Response &&
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

  factory CreateArticleComment200Response.fromJson(Map<String, dynamic> json) => _$CreateArticleComment200ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateArticleComment200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

