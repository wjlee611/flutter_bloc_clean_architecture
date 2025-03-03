//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// ========================================
// MODIFIED: bio, image to nullable
// ========================================
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'profile.g.dart';

@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Profile {
  /// Returns a new [Profile] instance.
  Profile({
    required this.username,
    this.bio,
    this.image,
    required this.following,
  });

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

  @JsonKey(
    name: r'following',
    required: true,
    includeIfNull: false,
  )
  final bool following;

  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Profile &&
            runtimeType == other.runtimeType &&
            equals([
              username,
              bio,
              image,
              following,
            ], [
              other.username,
              other.bio,
              other.image,
              other.following,
            ]);
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      mapPropsToHashCode(
        [
          username,
          bio,
          image,
          following,
        ],
      );

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
