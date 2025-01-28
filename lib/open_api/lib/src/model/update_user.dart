//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'update_user.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateUser {
  /// Returns a new [UpdateUser] instance.
  UpdateUser({

     this.email,

     this.password,

     this.username,

     this.bio,

     this.image,
  });

  @JsonKey(
    
    name: r'email',
    required: false,
    includeIfNull: false,
  )


  final String? email;



  @JsonKey(
    
    name: r'password',
    required: false,
    includeIfNull: false,
  )


  final String? password;



  @JsonKey(
    
    name: r'username',
    required: false,
    includeIfNull: false,
  )


  final String? username;



  @JsonKey(
    
    name: r'bio',
    required: false,
    includeIfNull: false,
  )


  final String? bio;



  @JsonKey(
    
    name: r'image',
    required: false,
    includeIfNull: false,
  )


  final String? image;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is UpdateUser &&
      runtimeType == other.runtimeType &&
      equals(
        [
            email,
            password,
            username,
            bio,
            image,
        ],
        [
            other.email,
            other.password,
            other.username,
            other.bio,
            other.image,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        email,
        password,
        username,
        bio,
        image,
    ],);

  factory UpdateUser.fromJson(Map<String, dynamic> json) => _$UpdateUserFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

