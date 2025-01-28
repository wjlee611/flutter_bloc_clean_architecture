// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericErrorModel _$GenericErrorModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'GenericErrorModel',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['errors'],
        );
        final val = GenericErrorModel(
          errors: $checkedConvert(
              'errors',
              (v) =>
                  GenericErrorModelErrors.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$GenericErrorModelToJson(GenericErrorModel instance) =>
    <String, dynamic>{
      'errors': instance.errors.toJson(),
    };
