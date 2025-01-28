# openapi.api.CommentsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://api.realworld.io/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createArticleComment**](CommentsApi.md#createarticlecomment) | **POST** /articles/{slug}/comments | Create a comment for an article
[**deleteArticleComment**](CommentsApi.md#deletearticlecomment) | **DELETE** /articles/{slug}/comments/{id} | Delete a comment for an article
[**getArticleComments**](CommentsApi.md#getarticlecomments) | **GET** /articles/{slug}/comments | Get comments for an article


# **createArticleComment**
> CreateArticleComment200Response createArticleComment(slug, comment)

Create a comment for an article

Create a comment for an article. Auth is required

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Token
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKeyPrefix = 'Bearer';

final api = Openapi().getCommentsApi();
final String slug = slug_example; // String | Slug of the article that you want to create a comment for
final CreateArticleCommentRequest comment = ; // CreateArticleCommentRequest | Comment you want to create

try {
    final response = api.createArticleComment(slug, comment);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CommentsApi->createArticleComment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **slug** | **String**| Slug of the article that you want to create a comment for | 
 **comment** | [**CreateArticleCommentRequest**](CreateArticleCommentRequest.md)| Comment you want to create | 

### Return type

[**CreateArticleComment200Response**](CreateArticleComment200Response.md)

### Authorization

[Token](../README.md#Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteArticleComment**
> deleteArticleComment(slug, id)

Delete a comment for an article

Delete a comment for an article. Auth is required

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Token
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKeyPrefix = 'Bearer';

final api = Openapi().getCommentsApi();
final String slug = slug_example; // String | Slug of the article that you want to delete a comment for
final int id = 56; // int | ID of the comment you want to delete

try {
    api.deleteArticleComment(slug, id);
} catch on DioException (e) {
    print('Exception when calling CommentsApi->deleteArticleComment: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **slug** | **String**| Slug of the article that you want to delete a comment for | 
 **id** | **int**| ID of the comment you want to delete | 

### Return type

void (empty response body)

### Authorization

[Token](../README.md#Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getArticleComments**
> GetArticleComments200Response getArticleComments(slug)

Get comments for an article

Get the comments for an article. Auth is optional

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getCommentsApi();
final String slug = slug_example; // String | Slug of the article that you want to get comments for

try {
    final response = api.getArticleComments(slug);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CommentsApi->getArticleComments: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **slug** | **String**| Slug of the article that you want to get comments for | 

### Return type

[**GetArticleComments200Response**](GetArticleComments200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

