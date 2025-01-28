//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/profile.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'comment.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Comment {
  /// Returns a new [Comment] instance.
  Comment({

    required  this.id,

    required  this.createdAt,

    required  this.updatedAt,

    required  this.body,

    required  this.author,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final int id;



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
    
    name: r'body',
    required: true,
    includeIfNull: false,
  )


  final String body;



  @JsonKey(
    
    name: r'author',
    required: true,
    includeIfNull: false,
  )


  final Profile author;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is Comment &&
      runtimeType == other.runtimeType &&
      equals(
        [
            id,
            createdAt,
            updatedAt,
            body,
            author,
        ],
        [
            other.id,
            other.createdAt,
            other.updatedAt,
            other.body,
            other.author,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        id,
        createdAt,
        updatedAt,
        body,
        author,
    ],);

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

