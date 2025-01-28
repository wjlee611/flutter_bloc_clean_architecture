//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/update_user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'update_current_user_request.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateCurrentUserRequest {
  /// Returns a new [UpdateCurrentUserRequest] instance.
  UpdateCurrentUserRequest({

    required  this.user,
  });

  @JsonKey(
    
    name: r'user',
    required: true,
    includeIfNull: false,
  )


  final UpdateUser user;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is UpdateCurrentUserRequest &&
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

  factory UpdateCurrentUserRequest.fromJson(Map<String, dynamic> json) => _$UpdateCurrentUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCurrentUserRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

