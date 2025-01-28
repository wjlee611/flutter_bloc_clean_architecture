//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/article.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'create_article201_response.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateArticle201Response {
  /// Returns a new [CreateArticle201Response] instance.
  CreateArticle201Response({

    required  this.article,
  });

  @JsonKey(
    
    name: r'article',
    required: true,
    includeIfNull: false,
  )


  final Article article;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is CreateArticle201Response &&
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

  factory CreateArticle201Response.fromJson(Map<String, dynamic> json) => _$CreateArticle201ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateArticle201ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

