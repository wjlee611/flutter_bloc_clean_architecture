// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_article_comment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateArticleCommentRequest _$CreateArticleCommentRequestFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'CreateArticleCommentRequest',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['comment'],
        );
        final val = CreateArticleCommentRequest(
          comment: $checkedConvert(
              'comment', (v) => NewComment.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$CreateArticleCommentRequestToJson(
        CreateArticleCommentRequest instance) =>
    <String, dynamic>{
      'comment': instance.comment.toJson(),
    };
