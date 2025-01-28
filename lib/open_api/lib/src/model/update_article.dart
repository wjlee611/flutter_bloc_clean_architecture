//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'update_article.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateArticle {
  /// Returns a new [UpdateArticle] instance.
  UpdateArticle({

     this.title,

     this.description,

     this.body,
  });

  @JsonKey(
    
    name: r'title',
    required: false,
    includeIfNull: false,
  )


  final String? title;



  @JsonKey(
    
    name: r'description',
    required: false,
    includeIfNull: false,
  )


  final String? description;



  @JsonKey(
    
    name: r'body',
    required: false,
    includeIfNull: false,
  )


  final String? body;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is UpdateArticle &&
      runtimeType == other.runtimeType &&
      equals(
        [
            title,
            description,
            body,
        ],
        [
            other.title,
            other.description,
            other.body,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        title,
        description,
        body,
    ],);

  factory UpdateArticle.fromJson(Map<String, dynamic> json) => _$UpdateArticleFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateArticleToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

