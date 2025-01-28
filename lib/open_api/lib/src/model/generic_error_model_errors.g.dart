// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_error_model_errors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericErrorModelErrors _$GenericErrorModelErrorsFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'GenericErrorModelErrors',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['body'],
        );
        final val = GenericErrorModelErrors(
          body: $checkedConvert('body',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$GenericErrorModelErrorsToJson(
        GenericErrorModelErrors instance) =>
    <String, dynamic>{
      'body': instance.body,
    };
