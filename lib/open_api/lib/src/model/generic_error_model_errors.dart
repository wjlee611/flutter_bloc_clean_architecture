//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'generic_error_model_errors.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GenericErrorModelErrors {
  /// Returns a new [GenericErrorModelErrors] instance.
  GenericErrorModelErrors({

    required  this.body,
  });

  @JsonKey(
    
    name: r'body',
    required: true,
    includeIfNull: false,
  )


  final List<String> body;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is GenericErrorModelErrors &&
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

  factory GenericErrorModelErrors.fromJson(Map<String, dynamic> json) => _$GenericErrorModelErrorsFromJson(json);

  Map<String, dynamic> toJson() => _$GenericErrorModelErrorsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

