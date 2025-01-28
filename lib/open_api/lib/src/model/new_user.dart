//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'new_user.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class NewUser {
  /// Returns a new [NewUser] instance.
  NewUser({

    required  this.username,

    required  this.email,

    required  this.password,
  });

  @JsonKey(
    
    name: r'username',
    required: true,
    includeIfNull: false,
  )


  final String username;



  @JsonKey(
    
    name: r'email',
    required: true,
    includeIfNull: false,
  )


  final String email;



  @JsonKey(
    
    name: r'password',
    required: true,
    includeIfNull: false,
  )


  final String password;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is NewUser &&
      runtimeType == other.runtimeType &&
      equals(
        [
            username,
            email,
            password,
        ],
        [
            other.username,
            other.email,
            other.password,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        username,
        email,
        password,
    ],);

  factory NewUser.fromJson(Map<String, dynamic> json) => _$NewUserFromJson(json);

  Map<String, dynamic> toJson() => _$NewUserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

