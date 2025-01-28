# openapi.api.UserAndAuthenticationApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://api.realworld.io/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createUser**](UserAndAuthenticationApi.md#createuser) | **POST** /users | 
[**getCurrentUser**](UserAndAuthenticationApi.md#getcurrentuser) | **GET** /user | Get current user
[**login**](UserAndAuthenticationApi.md#login) | **POST** /users/login | Existing user login
[**updateCurrentUser**](UserAndAuthenticationApi.md#updatecurrentuser) | **PUT** /user | Update current user


# **createUser**
> Login200Response createUser(body)



Register a new user

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserAndAuthenticationApi();
final CreateUserRequest body = ; // CreateUserRequest | Details of the new user to register

try {
    final response = api.createUser(body);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserAndAuthenticationApi->createUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**CreateUserRequest**](CreateUserRequest.md)| Details of the new user to register | 

### Return type

[**Login200Response**](Login200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCurrentUser**
> Login200Response getCurrentUser()

Get current user

Gets the currently logged-in user

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Token
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKeyPrefix = 'Bearer';

final api = Openapi().getUserAndAuthenticationApi();

try {
    final response = api.getCurrentUser();
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserAndAuthenticationApi->getCurrentUser: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Login200Response**](Login200Response.md)

### Authorization

[Token](../README.md#Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **login**
> Login200Response login(body)

Existing user login

Login for existing user

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserAndAuthenticationApi();
final LoginRequest body = ; // LoginRequest | Credentials to use

try {
    final response = api.login(body);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserAndAuthenticationApi->login: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**LoginRequest**](LoginRequest.md)| Credentials to use | 

### Return type

[**Login200Response**](Login200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateCurrentUser**
> Login200Response updateCurrentUser(body)

Update current user

Updated user information for current user

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Token
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Token').apiKeyPrefix = 'Bearer';

final api = Openapi().getUserAndAuthenticationApi();
final UpdateCurrentUserRequest body = ; // UpdateCurrentUserRequest | User details to update. At least **one** field is required.

try {
    final response = api.updateCurrentUser(body);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UserAndAuthenticationApi->updateCurrentUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**UpdateCurrentUserRequest**](UpdateCurrentUserRequest.md)| User details to update. At least **one** field is required. | 

### Return type

[**Login200Response**](Login200Response.md)

### Authorization

[Token](../README.md#Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

