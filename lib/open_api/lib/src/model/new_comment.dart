//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'new_comment.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class NewComment {
  /// Returns a new [NewComment] instance.
  NewComment({

    required  this.body,
  });

  @JsonKey(
    
    name: r'body',
    required: true,
    includeIfNull: false,
  )


  final String body;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is NewComment &&
      runtimeType == other.runtimeType &&
      equals(
        [
            body,
        ],
        [
            other.body,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        body,
    ],);

  factory NewComment.fromJson(Map<String, dynamic> json) => _$NewCommentFromJson(json);

  Map<String, dynamic> toJson() => _$NewCommentToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

