# openapi.api.FavoritesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://api.realworld.io/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createArticleFavorite**](FavoritesApi.md#createarticlefavorite) | **POST** /articles/{slug}/favorite | Favorite an article
[**deleteArticleFavorite**](FavoritesApi.md#deletearticlefavorite) | **DELETE** /articles/{slug}/favorite | Unfavorite an article


# **createArticleFavorite**
> CreateArticle201Response createArticleFavorite(slug)

Favorite an article

Favorite an article. Auth is required

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Token
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKeyPrefix = 'Bearer';

final api = Openapi().getFavoritesApi();
final String slug = slug_example; // String | Slug of the article that you want to favorite

try {
    final response = api.createArticleFavorite(slug);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FavoritesApi->createArticleFavorite: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **slug** | **String**| Slug of the article that you want to favorite | 

### Return type

[**CreateArticle201Response**](CreateArticle201Response.md)

### Authorization

[Token](../README.md#Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteArticleFavorite**
> CreateArticle201Response deleteArticleFavorite(slug)

Unfavorite an article

Unfavorite an article. Auth is required

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Token
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKeyPrefix = 'Bearer';

final api = Openapi().getFavoritesApi();
final String slug = slug_example; // String | Slug of the article that you want to unfavorite

try {
    final response = api.deleteArticleFavorite(slug);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FavoritesApi->deleteArticleFavorite: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **slug** | **String**| Slug of the article that you want to unfavorite | 

### Return type

[**CreateArticle201Response**](CreateArticle201Response.md)

### Authorization

[Token](../README.md#Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

