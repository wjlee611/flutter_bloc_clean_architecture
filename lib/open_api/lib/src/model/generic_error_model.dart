//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/generic_error_model_errors.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/src/equatable_utils.dart';

part 'generic_error_model.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GenericErrorModel {
  /// Returns a new [GenericErrorModel] instance.
  GenericErrorModel({

    required  this.errors,
  });

  @JsonKey(
    
    name: r'errors',
    required: true,
    includeIfNull: false,
  )


  final GenericErrorModelErrors errors;




    bool operator ==(Object other) {
      return identical(this, other) ||
      other is GenericErrorModel &&
      runtimeType == other.runtimeType &&
      equals(
        [
            errors,
        ],
        [
            other.errors,
        ]
      );
    }


    @override
    int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode([
        errors,
    ],);

  factory GenericErrorModel.fromJson(Map<String, dynamic> json) => _$GenericErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenericErrorModelToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

