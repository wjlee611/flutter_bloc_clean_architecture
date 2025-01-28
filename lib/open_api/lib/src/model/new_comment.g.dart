// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewComment _$NewCommentFromJson(Map<String, dynamic> json) => $checkedCreate(
      'NewComment',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['body'],
        );
        final val = NewComment(
          body: $checkedConvert('body', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$NewCommentToJson(NewComment instance) =>
    <String, dynamic>{
      'body': instance.body,
    };
