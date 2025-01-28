//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'new_article.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class NewArticle {
  /// Returns a new [NewArticle] instance.
  NewArticle({

    required  this.title,

    required  this.description,

    required  this.body,

     this.tagList,
  });

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
    
    name: r'body',
    required: true,
    includeIfNull: false,
  )


  final String body;



  @JsonKey(
    
    name: r'tagList',
    required: false,
    includeIfNull: false,
  )


  final List<String>? tagList;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is NewArticle &&
      runtimeType == other.runtimeType &&
      equals(
        [
            title,
            description,
            body,
            tagList,
        ],
        [
            other.title,
            other.description,
            other.body,
            other.tagList,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        title,
        description,
        body,
        tagList,
    ],);

  factory NewArticle.fromJson(Map<String, dynamic> json) => _$NewArticleFromJson(json);

  Map<String, dynamic> toJson() => _$NewArticleToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

