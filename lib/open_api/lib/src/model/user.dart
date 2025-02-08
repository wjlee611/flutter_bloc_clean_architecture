//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'user.g.dart';

@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class User {
  /// Returns a new [User] instance.
  User({
    required this.email,
    required this.token,
    required this.username,
    this.bio,
    this.image,
  });

  @JsonKey(
    name: r'email',
    required: true,
    includeIfNull: false,
  )
  final String email;

  @JsonKey(
    name: r'token',
    required: true,
    includeIfNull: false,
  )
  final String token;

  @JsonKey(
    name: r'username',
    required: true,
    includeIfNull: false,
  )
  final String username;

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
        other is User &&
            runtimeType == other.runtimeType &&
            equals([
              email,
              token,
              username,
              bio,
              image,
            ], [
              other.email,
              other.token,
              other.username,
              other.bio,
              other.image,
            ]);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      mapPropsToHashCode(
        [
          email,
          token,
          username,
          bio,
          image,
        ],
      );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
