//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/new_user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'create_user_request.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateUserRequest {
  /// Returns a new [CreateUserRequest] instance.
  CreateUserRequest({

    required  this.user,
  });

  @JsonKey(
    
    name: r'user',
    required: true,
    includeIfNull: false,
  )


  final NewUser user;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is CreateUserRequest &&
      runtimeType == other.runtimeType &&
      equals(
        [
            user,
        ],
        [
            other.user,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        user,
    ],);

  factory CreateUserRequest.fromJson(Map<String, dynamic> json) => _$CreateUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

