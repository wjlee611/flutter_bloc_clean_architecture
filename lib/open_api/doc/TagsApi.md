# openapi.api.TagsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://api.realworld.io/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getTags**](TagsApi.md#gettags) | **GET** /tags | Get tags


# **getTags**
> GetTags200Response getTags()

Get tags

Get tags. Auth not required

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getTagsApi();

try {
    final response = api.getTags();
    print(response);
} catch on DioException (e) {
    print('Exception when calling TagsApi->getTags: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**GetTags200Response**](GetTags200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

