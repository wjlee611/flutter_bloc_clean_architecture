import 'package:openapi/src/model/article.dart';
import 'package:openapi/src/model/comment.dart';
import 'package:openapi/src/model/create_article201_response.dart';
import 'package:openapi/src/model/create_article_comment200_response.dart';
import 'package:openapi/src/model/create_article_comment_request.dart';
import 'package:openapi/src/model/create_article_request.dart';
import 'package:openapi/src/model/create_user_request.dart';
import 'package:openapi/src/model/generic_error_model.dart';
import 'package:openapi/src/model/generic_error_model_errors.dart';
import 'package:openapi/src/model/get_article_comments200_response.dart';
import 'package:openapi/src/model/get_articles_feed200_response.dart';
import 'package:openapi/src/model/get_articles_feed200_response_articles_inner.dart';
import 'package:openapi/src/model/get_profile_by_username200_response.dart';
import 'package:openapi/src/model/get_tags200_response.dart';
import 'package:openapi/src/model/login200_response.dart';
import 'package:openapi/src/model/login_request.dart';
import 'package:openapi/src/model/login_user.dart';
import 'package:openapi/src/model/new_article.dart';
import 'package:openapi/src/model/new_comment.dart';
import 'package:openapi/src/model/new_user.dart';
import 'package:openapi/src/model/profile.dart';
import 'package:openapi/src/model/update_article.dart';
import 'package:openapi/src/model/update_article_request.dart';
import 'package:openapi/src/model/update_current_user_request.dart';
import 'package:openapi/src/model/update_user.dart';
import 'package:openapi/src/model/user.dart';

final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

  ReturnType deserialize<ReturnType, BaseType>(dynamic value, String targetType, {bool growable= true}) {
      switch (targetType) {
        case 'String':
          return '$value' as ReturnType;
        case 'int':
          return (value is int ? value : int.parse('$value')) as ReturnType;
        case 'bool':
          if (value is bool) {
            return value as ReturnType;
          }
          final valueString = '$value'.toLowerCase();
          return (valueString == 'true' || valueString == '1') as ReturnType;
        case 'double':
          return (value is double ? value : double.parse('$value')) as ReturnType;
        case 'Article':
          return Article.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Comment':
          return Comment.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateArticle201Response':
          return CreateArticle201Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateArticleComment200Response':
          return CreateArticleComment200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateArticleCommentRequest':
          return CreateArticleCommentRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateArticleRequest':
          return CreateArticleRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'CreateUserRequest':
          return CreateUserRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'GenericErrorModel':
          return GenericErrorModel.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'GenericErrorModelErrors':
          return GenericErrorModelErrors.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'GetArticleComments200Response':
          return GetArticleComments200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'GetArticlesFeed200Response':
          return GetArticlesFeed200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'GetArticlesFeed200ResponseArticlesInner':
          return GetArticlesFeed200ResponseArticlesInner.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'GetProfileByUsername200Response':
          return GetProfileByUsername200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'GetTags200Response':
          return GetTags200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Login200Response':
          return Login200Response.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'LoginRequest':
          return LoginRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'LoginUser':
          return LoginUser.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'NewArticle':
          return NewArticle.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'NewComment':
          return NewComment.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'NewUser':
          return NewUser.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'Profile':
          return Profile.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateArticle':
          return UpdateArticle.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateArticleRequest':
          return UpdateArticleRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateCurrentUserRequest':
          return UpdateCurrentUserRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateUser':
          return UpdateUser.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'User':
          return User.fromJson(value as Map<String, dynamic>) as ReturnType;
        default:
          RegExpMatch? match;

          if (value is List && (match = _regList.firstMatch(targetType)) != null) {
            targetType = match![1]!; // ignore: parameter_assignments
            return value
              .map<BaseType>((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable))
              .toList(growable: growable) as ReturnType;
          }
          if (value is Set && (match = _regSet.firstMatch(targetType)) != null) {
            targetType = match![1]!; // ignore: parameter_assignments
            return value
              .map<BaseType>((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable))
              .toSet() as ReturnType;
          }
          if (value is Map && (match = _regMap.firstMatch(targetType)) != null) {
            targetType = match![1]!.trim(); // ignore: parameter_assignments
            return Map<String, BaseType>.fromIterables(
              value.keys as Iterable<String>,
              value.values.map((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable)),
            ) as ReturnType;
          }
          break;
    }
    throw Exception('Cannot deserialize');
  }