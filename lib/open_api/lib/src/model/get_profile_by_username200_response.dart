//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/profile.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'get_profile_by_username200_response.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GetProfileByUsername200Response {
  /// Returns a new [GetProfileByUsername200Response] instance.
  GetProfileByUsername200Response({

    required  this.profile,
  });

  @JsonKey(
    
    name: r'profile',
    required: true,
    includeIfNull: false,
  )


  final Profile profile;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is GetProfileByUsername200Response &&
      runtimeType == other.runtimeType &&
      equals(
        [
            profile,
        ],
        [
            other.profile,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        profile,
    ],);

  factory GetProfileByUsername200Response.fromJson(Map<String, dynamic> json) => _$GetProfileByUsername200ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetProfileByUsername200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

