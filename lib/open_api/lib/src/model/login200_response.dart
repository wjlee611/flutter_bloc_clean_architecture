//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'login200_response.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Login200Response {
  /// Returns a new [Login200Response] instance.
  Login200Response({

    required  this.user,
  });

  @JsonKey(
    
    name: r'user',
    required: true,
    includeIfNull: false,
  )


  final User user;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is Login200Response &&
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

  factory Login200Response.fromJson(Map<String, dynamic> json) => _$Login200ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$Login200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

