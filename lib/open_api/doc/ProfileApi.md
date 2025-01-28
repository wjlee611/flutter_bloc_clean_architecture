# openapi.api.ProfileApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://api.realworld.io/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**followUserByUsername**](ProfileApi.md#followuserbyusername) | **POST** /profiles/{username}/follow | Follow a user
[**getProfileByUsername**](ProfileApi.md#getprofilebyusername) | **GET** /profiles/{username} | Get a profile
[**unfollowUserByUsername**](ProfileApi.md#unfollowuserbyusername) | **DELETE** /profiles/{username}/follow | Unfollow a user


# **followUserByUsername**
> GetProfileByUsername200Response followUserByUsername(username)

Follow a user

Follow a user by username

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Token
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKeyPrefix = 'Bearer';

final api = Openapi().getProfileApi();
final String username = username_example; // String | Username of the profile you want to follow

try {
    final response = api.followUserByUsername(username);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ProfileApi->followUserByUsername: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **username** | **String**| Username of the profile you want to follow | 

### Return type

[**GetProfileByUsername200Response**](GetProfileByUsername200Response.md)

### Authorization

[Token](../README.md#Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getProfileByUsername**
> GetProfileByUsername200Response getProfileByUsername(username)

Get a profile

Get a profile of a user of the system. Auth is optional

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getProfileApi();
final String username = username_example; // String | Username of the profile to get

try {
    final response = api.getProfileByUsername(username);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ProfileApi->getProfileByUsername: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **username** | **String**| Username of the profile to get | 

### Return type

[**GetProfileByUsername200Response**](GetProfileByUsername200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unfollowUserByUsername**
> GetProfileByUsername200Response unfollowUserByUsername(username)

Unfollow a user

Unfollow a user by username

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Token
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKeyPrefix = 'Bearer';

final api = Openapi().getProfileApi();
final String username = username_example; // String | Username of the profile you want to unfollow

try {
    final response = api.unfollowUserByUsername(username);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ProfileApi->unfollowUserByUsername: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **username** | **String**| Username of the profile you want to unfollow | 

### Return type

[**GetProfileByUsername200Response**](GetProfileByUsername200Response.md)

### Authorization

[Token](../README.md#Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

