# openapi.api.ArticlesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://api.realworld.io/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createArticle**](ArticlesApi.md#createarticle) | **POST** /articles | Create an article
[**deleteArticle**](ArticlesApi.md#deletearticle) | **DELETE** /articles/{slug} | Delete an article
[**getArticle**](ArticlesApi.md#getarticle) | **GET** /articles/{slug} | Get an article
[**getArticles**](ArticlesApi.md#getarticles) | **GET** /articles | Get recent articles globally
[**getArticlesFeed**](ArticlesApi.md#getarticlesfeed) | **GET** /articles/feed | Get recent articles from users you follow
[**updateArticle**](ArticlesApi.md#updatearticle) | **PUT** /articles/{slug} | Update an article


# **createArticle**
> CreateArticle201Response createArticle(article)

Create an article

Create an article. Auth is required

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Token
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKeyPrefix = 'Bearer';

final api = Openapi().getArticlesApi();
final CreateArticleRequest article = ; // CreateArticleRequest | Article to create

try {
    final response = api.createArticle(article);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ArticlesApi->createArticle: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **article** | [**CreateArticleRequest**](CreateArticleRequest.md)| Article to create | 

### Return type

[**CreateArticle201Response**](CreateArticle201Response.md)

### Authorization

[Token](../README.md#Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteArticle**
> deleteArticle(slug)

Delete an article

Delete an article. Auth is required

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Token
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKeyPrefix = 'Bearer';

final api = Openapi().getArticlesApi();
final String slug = slug_example; // String | Slug of the article to delete

try {
    api.deleteArticle(slug);
} catch on DioException (e) {
    print('Exception when calling ArticlesApi->deleteArticle: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **slug** | **String**| Slug of the article to delete | 

### Return type

void (empty response body)

### Authorization

[Token](../README.md#Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getArticle**
> CreateArticle201Response getArticle(slug)

Get an article

Get an article. Auth not required

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getArticlesApi();
final String slug = slug_example; // String | Slug of the article to get

try {
    final response = api.getArticle(slug);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ArticlesApi->getArticle: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **slug** | **String**| Slug of the article to get | 

### Return type

[**CreateArticle201Response**](CreateArticle201Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getArticles**
> GetArticlesFeed200Response getArticles(tag, author, favorited, offset, limit)

Get recent articles globally

Get most recent articles globally. Use query parameters to filter results. Auth is optional

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getArticlesApi();
final String tag = tag_example; // String | Filter by tag
final String author = author_example; // String | Filter by author (username)
final String favorited = favorited_example; // String | Filter by favorites of a user (username)
final int offset = 56; // int | The number of items to skip before starting to collect the result set.
final int limit = 56; // int | The numbers of items to return.

try {
    final response = api.getArticles(tag, author, favorited, offset, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ArticlesApi->getArticles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **tag** | **String**| Filter by tag | [optional] 
 **author** | **String**| Filter by author (username) | [optional] 
 **favorited** | **String**| Filter by favorites of a user (username) | [optional] 
 **offset** | **int**| The number of items to skip before starting to collect the result set. | [optional] 
 **limit** | **int**| The numbers of items to return. | [optional] [default to 20]

### Return type

[**GetArticlesFeed200Response**](GetArticlesFeed200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getArticlesFeed**
> GetArticlesFeed200Response getArticlesFeed(offset, limit)

Get recent articles from users you follow

Get most recent articles from users you follow. Use query parameters to limit. Auth is required

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Token
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKeyPrefix = 'Bearer';

final api = Openapi().getArticlesApi();
final int offset = 56; // int | The number of items to skip before starting to collect the result set.
final int limit = 56; // int | The numbers of items to return.

try {
    final response = api.getArticlesFeed(offset, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ArticlesApi->getArticlesFeed: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **offset** | **int**| The number of items to skip before starting to collect the result set. | [optional] 
 **limit** | **int**| The numbers of items to return. | [optional] [default to 20]

### Return type

[**GetArticlesFeed200Response**](GetArticlesFeed200Response.md)

### Authorization

[Token](../README.md#Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateArticle**
> CreateArticle201Response updateArticle(slug, article)

Update an article

Update an article. Auth is required

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Token
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKeyPrefix = 'Bearer';

final api = Openapi().getArticlesApi();
final String slug = slug_example; // String | Slug of the article to update
final UpdateArticleRequest article = ; // UpdateArticleRequest | Article to update

try {
    final response = api.updateArticle(slug, article);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ArticlesApi->updateArticle: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **slug** | **String**| Slug of the article to update | 
 **article** | [**UpdateArticleRequest**](UpdateArticleRequest.md)| Article to update | 

### Return type

[**CreateArticle201Response**](CreateArticle201Response.md)

### Authorization

[Token](../README.md#Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

