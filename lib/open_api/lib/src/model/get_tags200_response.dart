//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'get_tags200_response.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GetTags200Response {
  /// Returns a new [GetTags200Response] instance.
  GetTags200Response({

    required  this.tags,
  });

  @JsonKey(
    
    name: r'tags',
    required: true,
    includeIfNull: false,
  )


  final List<String> tags;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is GetTags200Response &&
      runtimeType == other.runtimeType &&
      equals(
        [
            tags,
        ],
        [
            other.tags,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        tags,
    ],);

  factory GetTags200Response.fromJson(Map<String, dynamic> json) => _$GetTags200ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetTags200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

