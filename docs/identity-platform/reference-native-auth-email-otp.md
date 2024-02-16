---
title: Native authentication with email OTP API reference
description: Find out how to use native authentication with email OTP API reference for Microsoft Entra ID for customers. 
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: active-directory 
ms.subservice: ciam
ms.topic: reference
ms.date: 02/29/2024

#Customer intent: As a dev, devops, I want to learn how to integrate customer apps with Native authentication's email OTP API that in Microsoft Entra ID for customers supports.
---

# Native authentication with email OTP API reference

Microsoft Entra ID's native authentication API for email OTP allows you to build apps that sign up and sign in users with their email and a one-time password or passcode (OTP).

[!INCLUDE [native-auth-api-common-description](./includes/native-auth-api/native-auth-api-common-description.md)]

[!INCLUDE [native-auth-api-cors-note](./includes/native-auth-api/native-auth-api-cors-note.md)]

## Prerequisites

1. Microsoft Entra External ID for customers tenant. If you don't already have one, [sign up for a free trial](https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl).

1. If you haven't already done so, [Register an application in the Microsoft Entra admin center](../external-id/customers/how-to-register-ciam-app.md?tabs=nativeauth#choose-your-app-type). Make sure you grant delegated permissions, and enable public client and native authentication flows.

1. If you haven't already done so, [Create a user flow in the Microsoft Entra admin center](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md#to-add-a-new-user-flow). While you create the user flow, take note of the user attributes you select as these attributes are the ones that Microsoft Entra ID expects your app to submit. Under **Identity providers**, select **Email one-time-passcode** option.

1. [Associate your app registration with the user flow](../external-id/customers/how-to-user-flow-add-application.md).

1. If you haven't already done so, [enable email one-time passcode](../external-id/customers/how-to-enable-password-reset-customers.md#enable-email-one-time-passcode).

1. For sign-in flow, [register a customer user](../external-id/customers/how-to-manage-customer-accounts.md#create-a-customer-account), which you use for test the sign in APIs. Alternatively, you get this test user after you run the sign-up flow.

## Continuation token

[!INCLUDE [entra-external-id-continuation-token](./includes/native-auth-api/continuation-token.md)]

## Sign up API reference

To complete a sign-up flow using email OTP, your app interacts with four endpoints,  `/signup/v1.0/start`, `/signup/v1.0/challenge`,  `/signup/v1.0/continue`, and `/token`.

### Sign-up API endpoints

A sign-up flow with email OTP uses similar endpoints as sign-up with email with password as described in [Sign-up API endpoints](/entra/identity-platform/reference-native-auth-email-password?bc=/entra/external-id/customers/breadcrumb/toc.json&toc=/entra/external-id/customers/toc.json#sign-up-api-endpoints).

### Challenge types

The API allows the app to advertise the authentication methods it supports to Microsoft Entra ID. To do so, the app uses the `challenge_type` parameter in its request. A sign-up flow with email OTP uses *oob* and *redirect* challenge types as described in [Challenge types](/entra/identity-platform/reference-native-auth-email-password?bc=/entra/external-id/customers/breadcrumb/toc.json&toc=/entra/external-id/customers/toc.json#self-service-password-reset-challenge-types).

### Sign-up flow protocol details

The sequence diagram demonstrates the basic flow of the sign-up process.

:::image type="content" source="media/reference-native-auth-api/sign-up-email-with-otp.png" alt-text="Diagram of native auth sign-up with email with OTP."::: 

This diagram indicates that the app collects all the sign-up information, then submits them via the `/signup/v1.0/start`. However, if the app doesn't submit all the required user attributes via the `/signup/v1.0/start`, it can do so via the `/signup/v1.0/continue` endpoint. Although submitting the user attributes via the `/signup/v1.0/continue` endpoint is marked as an optional step, it's a mandatory step if the app doesn't submit all the required user attributes via the `/signup/v1.0/start` endpoint.

### Step 1: Request to start the sign-up flow

The sign-up flow begins with the application making a POST request to the `/signup/v1.0/start` endpoint to start the sign-up flow.

Here's an example of the request(we present the example request in multiple lines for readability).

Examples 1:

```http
POST /{tenant_subdomain}.onmicrosoft.com/signup/v1.0/start HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded

client_id=111101-14a6-abcd-97bc-abcd1110011
&challenge_type=oob redirect
&username=contoso-consumer@contoso.com 
```

Example 2 (include user attributes in the request):

```http
POST /{tenant_subdomain}.onmicrosoft.com/signup/v1.0/start HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded

client_id=111101-14a6-abcd-97bc-abcd1110011
&challenge_type=oob redirect
&attributes={"name": "{user_name}", "extension_2588abcdwhtfeehjjeeqwertc_age": "{user_age}", "phone": "{user_phone}"}
&username=contoso-consumer@contoso.com 
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
| `client_id`         |   Yes    | The Application (client) ID of the app you registered in the Microsoft Entra admin center.                |
| `username`          |    Yes   | Email of the customer user that they want to sign up with, such as *contoso-consumer@contoso.com*.  |
| `challenge_type`    |   Yes  | A space-separated list of authorization [challenge type](#challenge-types) strings that the app supports such as `oob password redirect`. The list must always include the `redirect` challenge type. For the email OTP sign-up flow, the value is expected to contain `oob redirect`.|
|`attributes`| No | The user attributes values that the app collects from the customer user. The value is a string, but formatted as a JSON object whose key values are names of user attributes. These attributes can be built in or custom, and required or optional. The key names of the object depend on the attributes that the administrator configured in Microsoft Entra admin center. You can submit some or all user attributes via the `/signup/v1.0/start` endpoint or later in the `/signup/v1.0/continue` endpoint. If you submit all the required attributes via the `/signup/v1.0/start` endpoint, you're required to submit any attributes. However, if you submit some required attributes via `/signup/v1.0/start` endpoint, you can submit the remaining required later in the `/signup/v1.0/continue` endpoint. Replace `{user_name}`, `{user_age}` and `{user_phone}` with the name, age and phone number values respectively that the app collects from the customer user. **Microsoft Entra ID ignores any attributes that you submit, but don't exist**.|

#### Success response

Here's an example of a successful response:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```
```json
{
    "continuation_token":"AQABEQEAAA..."
}
```

|    Parameter     | Description        |
|----------------------|------------------------|
|`continuation_token`| [continuation_token](#continuation-token) that Microsoft Entra ID returns.|

If an app can't support a required authentication method by Microsoft Entra ID, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra ID informs the app by returning a *redirect* challenge type in its response:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{     
   "challenge_type": "redirect" 
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `challenge_type`  | Microsoft Entra ID returns a response with challenge type whose value is *redirect* to enable the app to use web-base authentication flow.|

This response is considered successful, but the app is required to switch to a web-based authentication flow. In this case, we recommend that you use a [Microsoft-built and supported authentication library](reference-v2-libraries.md).

#### Error response

Example:

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{
    "error": "user_already_exists", 
    "error_description": "AADSTS1003037: It looks like you may already have an account.... .\r\nTrace ID: b386ad47-23ae-4092-...-1000000\r\nCorrelation ID: 72f57f26-...-3fa6\r\nTimestamp: yyyy-...", 
    "error_codes": [ 
        1003037 
    ],
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "b386ad47-...-0000", 
    "correlation_id": "72f57f26-...-3fa6"
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra ID-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |
| `invalid_attributes`   |  A list (array of objects) of attributes that failed validation. This response is possible if the app submits user attributes, and the `error` parameter's value is *attribute_validation_failed*.    |

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |Request parameter validation failed such as when the challenge_type parameter value contains an unsupported authentication method.|
|`unsupported_challenge_type`|The `challenge_type` parameter value doesn't include the `redirect` challenge type.|
|`unauthorized_client`|The client ID included in the request doesn't exist.  |  
|`attribute_validation_failed`|  Validation of one or more attributes failed. This response is possible if the app submits user attributes.|
|`user_already_exists` |  User already exists.  |  

> [!NOTE]
> If you submit all the required attributes, but not all the optional attributes via the `/signup/v1.0/start` endpoint, you won't be able to submit any additional optional attributes later via the  `/signup/v1.0/continue` endpoint. This is so because Microsoft Entra ID doesn't explicitly request for optional attributes. 

### Step 2: Select an authentication method

When the request for the continuation token is done, the app needs to request Microsoft Entra ID to select one of the supported challenge types for the user to authenticate with. To do so, the app makes a request to the `/signup/v1.0/challenge` endpoint. The app adds the continuation token that it obtains from the `/signup/v1.0/start` endpoint in the request.

Here's an example of the request(we present the example request in multiple lines for readability):

```http
POST /{tenant_subdomain}.onmicrosoft.com/signup/v1.0/challenge HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded

client_id=111101-14a6-abcd-97bc-abcd1110011
&challenge_type=oob redirect
&continuation_token=AQABAAEAAA...
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
| `client_id`         |   Yes    | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|
| `challenge_type`    |   No  | A space-separated list of authorization [challenge type](#challenge-types) strings that the app supports such as `oob password redirect`. The list must always include the `redirect` challenge type. For the email with password sign-up flow, the value is expected to contain `oob redirect`.|
|`continuation_token`| Yes | [continuation_token](#continuation-token) that Microsoft Entra ID returned in the previous request.|

#### Success response

If the tenant administrator configured email OTP in the Microsoft Entra Admin Center as the user’s authentication method, Microsoft Entra ID sends an OTP code to the user’s email, then responds with a challenge type of *oob* and provides more information about the OTP code:



```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{
    "interval": 300,
    "continuation_token": "AQABAAEAAAYn...",
    "challenge_type": "oob",
    "binding_method": "prompt",
    "challenge_channel": "email",
    "challenge_target_label": "c***r@co**o**o.com",
    "code_length": 8
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
|`interval`| The length of time in seconds the app needs to wait before it attempts to resend OTP. |
| `continuation_token`  | [continuation_token](#continuation-token) that Microsoft Entra IDreturns. |
|`challenge_type`| Challenge type selected for the user to authenticate with.|
|`binding_method`|The only valid value is *prompt*. This parameter can be used in the future to offer more ways for the user to enter the OTP code. Issued if `challenge_type` is *oob*  |
|`challenge_channel`| The type of the channel through which the OTP code was sent. At the moment, only email channel is supported. |
|`challenge_target_label` |An obfuscated email where the OTP code was sent.|
|`code_length`|The length of the OTP code that Microsoft Entra ID generates. |

If an app can't support a required authentication method by Microsoft Entra ID, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra ID informs the app by returning a *redirect* challenge type in its response:

```http
HTTP/1.1 200 OK
Content-Type: application/json
``` 

```json
{     
   "challenge_type": "redirect" 
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `challenge_type`  | Microsoft Entra ID returns a response that has a challenge type. The value of this challenge type is redirect, which enables the app to use the web-based authentication flow. |  

This response is considered successful, but the app is required to switch to a web-based authentication flow. In this case, we recommend that you use a [Microsoft-built and supported authentication library](reference-v2-libraries.md).

#### Error response

Example:

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{ 
    "error": "invalid_request", 
    "error_description": "AADSTS901007: The challenge_type list parameter does not include the 'redirect' type.\r\nTrace ID: b386ad47-23ae-4092-...-1000000\r\nCorrelation ID: 72f57f26-...-3fa6\r\nTimestamp: yyyy-...",
    "error_codes": [ 
        901007 
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "b386ad47-...-0000", 
    "correlation_id": "72f57f26-...-3fa6"
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra ID-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as when the `challenge_type` parameter includes an invalid challenge type or continuation token validation failed.   |
|`invalid_client`|The client ID included in the request doesn't exist or isn't for a public client. |
|`expired_token`|The continuation token is expired. |
|`unsupported_challenge_type`|The `challenge_type` parameter value isn't supported or doesn't include the `redirect` challenge type.|

### Step 3: Submit OTP

The app submits the  OTP code sent to the user's email. To do so, the app makes a POST request to the `/signup/v1.0/continue` endpoint. Since we're submitting OTP code, the request includes `oob` parameter whose value is the OTP code received in the user's emails, and a `grant_type` parameter whose value must be *oob*.

Here's an example of the request(we present the example request in multiple lines for readability):

```http
POST /{tenant_subdomain}.onmicrosoft.com/signup/v1.0/continue HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded

continuation_token = uY29tL2F1dGhlbnRpY...
&client_id=111101-14a6-abcd-97bc-abcd1110011 
&grant_type=oob 
&oob={otp_code}
&signup-token=AQABAAEAAAYn...
```

|    Parameter     | Required | Description        |
|----------------------|------------------------|------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
| `continuation_token`  | Yes | [continuation_token](#continuation-token) that Microsoft Entra ID returned in the previous request. |
|`client_id`| Yes | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|
|`grant_type` | Yes | A request to the `/signup/v1.0/continue` endpoint can be used for submitting OTP code or user attributes. In this case, the `grant_type` value is used to differentiate between these two use cases. For email OTP flow, the possible values for the `grant_type` are *oob* and *attributes*. In this request, since we're sending OTP code, the value is expected to be *oob*.|
|`oob`| Yes | The OTP code that the customer user received in their email. Replace `{otp_code}` with the OTP code that the customer user received in their email. To **resend an OTP code**, the app needs to make a request to the `/signup/v1.0/challenge` endpoint again. |

#### Success response

If the request is successful, but no attributes were configured in the Microsoft Entra admin center or all the required user attributes were submitted via the `/signup/v1.0/start` endpoint, the app gets a continuation token without submitting any attributes, see success response in [step 4](#step-4-authenticate-and-get-token-to-sign-in). In this case, the app can use the continuation token to request for security tokens as shown in [step 5](#step-5-request-for-security-tokens). Otherwise, Microsoft Entra ID's response indicates that the app needs to submit the required attributes. These attributes, built-in, or custom, were configured in the Microsoft Entra admin center by the tenant administrator.

Example:

This response requests the app to submit required attributes, that is, values for *name*, *age* and *hobbies* attributes.

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{
    "error": "attributes_required",
    "error_description": "AADSTS55106: User attributes required. \r\nTrace ID: b386ad47-23ae-4092-...-1000000\r\nCorrelation ID: 72f57f26-...-3fa6\r\nTimestamp: yyyy-...",
    "error_codes": [
        55106
    ],
    "timestamp": "yyyy-mm-dd 15:43:10Z",
    "trace_id": "0dd748bf-...-0baa8c6b0500",
    "correlation_id": "d58ee8c8-...-fdc4cd4c7b5d",
    "continuation_token": "AQABEQEAAAAmoFf...",
    "required_attributes": [
        {
            "name": "city",
            "type": "Text",
            "required": true,
            "options": {
                "regex": "^.*"
            }
        },
        {
            "name": "extension_1333e9187c514426a8277bcd91badd5a_MarketingEmails",
            "type": "Boolean",
            "required": true,
            "options": {
                "regex": ""
            }
        }
    ]
}
```

[!INCLUDE [custom-attribute-note](./includes/native-auth-api/custom-attributes-note.md)]

|    Parameter     | Description        |
|----------------------|------------------------|
| `error`  | This attribute is set if Microsoft Entra ID can't create the user account because an attribute needs to be verified or submitted.  |  
|`error_description` | A specific error message that can help you to identify the cause of the error. |
|`error_codes`| A list of Microsoft Entra ID-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |
|`continuation_token`| [continuation_token](#continuation-token) that Microsoft Entra ID returns. |
|`required_attributes`|A list (array of objects) of attributes that the app needs to submit next call to continue. These attributes are the extra attributes that app needs to submit apart from the username. Microsoft Entra ID includes this parameter is the response if the value of `error` parameter is *attributes_required*.|

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  | Request parameter validation failed, or when continuation token validation fails.|  
|`invalid_grant`| The grant type included in the request isn't valid or supported. The possible values for the `grant_type` are *oob*, *password*, *attributes* |
|`expired_token`| The continuation token included in the request is expired. |
|`attributes_required`  |  One or more of user attributes is required.   |

If an app can't support a required authentication method by Microsoft Entra ID, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra ID informs the app by returning a *redirect* challenge type in its response:

```http
HTTP/1.1 200 OK
Content-Type: application/json 
```

```json
{     
   "challenge_type": "redirect" 
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `challenge_type`  | Microsoft Entra ID returns a response that has a challenge type. The value of this challenge type is redirect, which enables the app to use the web-based authentication flow.  |  

This response is considered successful, but the app is required to switch to a web-based authentication flow. In this case, we recommend that you use a [Microsoft-built and supported authentication library](reference-v2-libraries.md).

#### Error response

Example:

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{  
    "error": "invalid_grant",
    "error_description": "AADSTS50181: Unable to validate the otp.",  
    "error_codes": [
        50181
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "b386ad47-...-0000", 
    "correlation_id": "72f57f26-...-3fa6",
    "suberror": "invalid_oob_value"
}  
```

|    Parameter     | Description        |
|----------------------|------------------------|
|`error` | An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes` | A list of Microsoft Entra ID-specific error codes that can help you to diagnose errors.  |
|`timestamp` | The time when the error occurred.|
|`trace_id` | A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id` | A  unique identifier for the request that can help in diagnostics across components. |
|`suberror` | An error code string that can be used to further classify types of errors, and to react to errors.|
|`invalid_attributes` |  A list (array of objects) of attributes that failed validation. This parameter is included in the response when the `error` parameter's value is *attribute_validation_failed*. |

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as when the continuation token or OTP validation fails. OTP code validation can fail as a result of the code expiring or providing an incorrect OTP code.|  
|`invalid_grant`|The grant type provided isn't valid or supported.|
|`invalid_client`|The client ID included in the request doesn't exist. |
|`expired_token`|The continuation token is expired. |
|`attribute_validation_failed`  |  Validation of one or more attributes failed. |

### Step 4: Authenticate and get token to sign in

To continue with the flow, the app needs to make a request to the `/signup/v1.0/continue` endpoint to submit the required user attributes. Since we're submitting attributes, in the request, an `attributes` parameter is required, and the `grant_type` parameter's value is equal to *attributes*.

Here's an example of the request(we present the example request in multiple lines for readability):

```http
POST /{tenant_subdomain}.onmicrosoft.com/signup/v1.0/continue HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded
 
&client_id=111101-14a6-abcd-97bc-abcd1110011 
&grant_type=attributes 
&attributes={"name": "{user_name}", "age": "{user_age}", "hobbies": "{comma_separated_hobbies}"}
&continuation_token=AQABAAEAAAAtn...
```

|    Parameter     | Required | Description        |
|----------------------|------------------------|------------------|
| `tenant_subdomain` | Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
|`continuation_token` | Yes | [continuation_token](#continuation-token) that Microsoft Entra ID returned in the previous request. |
|`client_id`| Yes | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|
|`grant_type` | Yes | A request to the `/signup/v1.0/continue` endpoint can be used to submit OTP code or user attributes. In this case, we use the `grant_type` value to differentiate between these two use cases. The possible values for the `grant_type` are *oob*, and *attributes*. In this call, since we're sending user attributes, the value expected to be *attributes*.|
|`attributes`| Yes | The user attribute values that the app collects from the customer user. The value is a string, but formatted as a JSON object whose keys are names of user attributes, built-in or custom. The key names of the object depend on the attributes that the administrator configured in the Microsoft Entra admin center. Replace `{user_name}`, `{user_age}` and `{comma_separated_hobbies}` with the name, age and hobbies values respectively that the app collects from the customer user. In the portal, you can configure user attributes values to be collected using different **User Input Type**, such as **TextBox**, **RadioSingleSelect, and **CheckboxMultiSelect**. In this case, we collect name and age using a TextBox, and hobbies using a CheckboxMultiSelect. **Microsoft Entra ID ignores any attributes that you submit, which don't exist**. Learn [how to configure user attribute collection during sign-up](../external-id/customers/how-to-define-custom-attributes.md).|

#### Success response

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{  
    "continuation_token": "AQABAAEAAAYn...",
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `continuation_token`  | [continuation_token](#continuation-token) that Microsoft Entra ID returns. |

If an app can't support a required authentication method by Microsoft Entra ID, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra ID informs the app by returning a *redirect* challenge type in its response:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{     
   "challenge_type": "redirect" 
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `challenge_type`  | Microsoft Entra ID returns a response that has a challenge type. The value of this challenge type is redirect, which enables the app to use the web-based authentication flow.  |  

This response is considered successful, but the app is required to switch to a web-based authentication flow. In this case, we recommend that you use a [Microsoft-built and supported authentication library](reference-v2-libraries.md).

#### Error response

Example:

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{  
    "error": "",
    "error_description": "AADSTS901007: User already exists.  .\r\nTrace ID: b386ad47-23ae-4092-...-1000000\r\nCorrelation ID: 72f57f26-...-3fa6\r\nTimestamp: yyyy-...", 
    "error_codes": [
        399246
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "b386ad47-...-0000", 
    "correlation_id": "72f57f26-...-3fa6" 
}  
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra ID-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |
|`continuation_token`| [continuation_token](#continuation-token) that Microsoft Entra ID returns. |
| `unverified_attributes`  |  A list (array of objects) of attribute key names that must be verified. This parameter is included in the response when the `error` parameter's value is *verification_required*.|
|`required_attributes`| A list (array of objects) of attributes that the app needs to be submit. Microsoft Entra ID includes this parameter in its response when the `error` parameter's value is equal to *attributes_required*.|
| `invalid_attributes`   |  A list (array of objects) of attributes that failed validation. This parameter is included in the response when the `error` parameter's value is *attribute_validation_failed*.    |

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
|`invalid_request`  |Request parameter validation failed such as when a continuation token fails validation.|
|`invalid_client`|The client ID included in the request doesn't exist.  |  
|`invalid_grant`|The grant type provided isn't valid or supported.|
|`expired_token`|The continuation token included in the request is expired.|
|`user_already_exists` |  User already exists.  |
|`attributes_required`  |  One or more of user attributes is required.   |
|`attribute_validation_failed`|  Validation of one or more attributes failed. |

### Step 5: Request for security tokens

The app makes a POST request to the `/token` endpoint and provides the continuation token that it obtained from the previous step to acquire security tokens.

Here's an example of the request (we present the example request in multiple lines for readability):

```http
POST /{tenant_subdomain}.onmicrosoft.com/oauth2/v2.0/token HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded

continuation_token=ABAAEAAAAtyo... 
&client_id=111101-14a6-abcd-97bc-abcd1110011 
&username=contoso-consumer@contoso.com
&scope={scopes}
&grant_type=continuation_token 
```

|    Parameter     | Required | Description        |
|----------------------|------------------------|------------------|
| `tenant_subdomain`  | Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
|`client_id`| Yes | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|
|`grant_type` | Yes | The parameter value must be *continuation token*. |
|`continuation_token`|Yes    | [continuation_token](#continuation-token) that Microsoft Entra ID returned in the previous call. |
|`scope`| Yes | A space-separated list of scopes that the access token is valid for. Replace `{scopes}` with the valid scopes that the access token Microsoft Entra ID returns is valid for.|
| `username`          |    Yes   | Email of the customer user that they want to sign up with, such as *contoso-consumer@contoso.com*.  |

#### Successful response

Here's an example of a successful response:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{
    "token_type": "Bearer",
    "scope": "openid profile",    
    "expires_in": 4141,    
    "access_token": "eyJ0eXAiOiJKV1Qi...",    
    "refresh_token": "AwABAAAA...",    
    "id_token": "eyJ0eXAiOiJKV1Q..."    
}
```

|    Parameter     | Description        |
|----------------------|------------------------|
|`token_type` |  Indicates the token type value. The only type that Microsoft Entra ID supports is *Bearer*.|
|`scope`|  A space-separated list of scopes that the access token is valid for.|
|`expires_in`|   The length of time in seconds the access token remains valid.|
| `access_token`  |    The access token that the app requested from the `/token` endpoint. The app can use this access token to request access to secured resources such as web APIs.|  
|`refresh_token` |  An OAuth 2.0 refresh token. The app can use this token to acquire other access tokens after the current access token expires. Refresh tokens are long-lived. They can maintain access to resources for extended periods. For more detail on refreshing an access token, refer to [Refresh the access token](v2-oauth2-auth-code-flow.md#refresh-the-access-token) article. <br> **Note**: Only issued if *offline_access* scope is requested.   |
|`id_token`|  A JSON Web Token (Jwt) used to identify the customer user. The app can decode the token to request information about the user who signed in. The app can cache the values and display them, and confidential clients can use this token for authorization. For more information about ID tokens, see [ID tokens]id-tokens.md).<br> **Note**: Only issued if *openid* scope is requested. |

#### Error response 

Example:

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{ 
    "error": "invalid_request", 
    "error_description": "AADSTS901007: The client doesn't have consent for the requested scopes.\r\nTrace ID: b386ad47-23ae-4092-...-1000000\r\nCorrelation ID: 72f57f26-...-3fa6\r\nTimestamp: yyyy-...",
    "error_codes": [ 
        50126 
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "b386ad47-...-0000", 
    "correlation_id": "72f57f26-...-3fa6"
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra ID-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as the client/app doesn't have consent for the requested scopes.|  
|`invalid_grant`|The continuation token included in the request is invalid.|
|`unauthorized_client`| The client ID included in the request is invalid or doesn't exist. |
|`unsupported_grant_type`| The grant type included in the request isn't supported or is incorrect. |

## Format of user attributes values

You specify the information you want to collect from the user by configuring the [user flow](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md#create-and-customize-a-user-flow) settings in the Microsoft Entra admin center. Use the [Collect user attributes during sign-up](../external-id/customers/how-to-define-custom-attributes.md) article to learn how to collect values for both built-in and custom attributes.

You can also specify the **User Input Type** for the attributes you configure. The following table summarizes supported user input types, and how to submit values collected by the UI controls to Microsoft Entra ID.

|    User Input Type     |     Format of submitted values    |
|----------------------|----------------------|
|   TextBox   |   A single value such as job title, *Software Engineer*.  |
|   SingleRadioSelect   |  A single value such as Language, *Norwegian*.  |
|   CheckboxMultiSelect   |  One or multiple values such as a hobby or hobbies, *Dancing* or *Dancing, Swimming, Traveling*.  | 

Here's a sample request that shows how you submit the attribute values:

```http
POST /{tenant_subdomain}.onmicrosoft.com/signup/v1.0/continue HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded 

&client_id=111101-14a6-abcd-97bc-abcd1110011 
&grant_type=attributes 
&attributes={"jobTitle": "Software Engineer", "extension_2588abcdwhtfeehjjeeqwertc_language": "Norwegian", "extension_2588abcdwhtfeehjjeeqwertc_hobbies": "Dancing, Swimming, Traveling"}
&continuation-token=AQABAAEAAAAtn...
```

## Sign in API reference

To request your security tokens, your app interacts with three endpoints, `/initiate`, `/challenge` and `/token`.

### Sign-in API Endpoints

Sign in with email OTP uses similar endpoints as email with password as described in [Sign-in API endpoints](/entra/identity-platform/reference-native-auth-email-password?bc=/entra/external-id/customers/breadcrumb/toc.json&toc=/entra/external-id/customers/toc.json.md#sign-in-api-endpoints).

### Challenge types
(/entra/identity-platform/reference-native-auth-email-password?bc=/entra/external-id/customers/breadcrumb/toc.json&toc=/entra/external-id/customers/toc.json)

The API allows the app to advertise the authentication methods it supports to Microsoft Entra ID. To do so, s the `challenge_type` parameter in its requests. Sign in with mail OTP uses *oob* and *redirect* challenge types as described in [Challenge types](/entra/identity-platform/reference-native-auth-email-password?bc=/entra/external-id/customers/breadcrumb/toc.json&toc=/entra/external-id/customers/toc.json#sign-in-challenge-types).

### Sign-in flow protocol details

The sequence diagram demonstrates the basic flow of email OTP sign in process.

:::image type="content" source="media/reference-native-auth-api/sign-in-email-otp.png" alt-text="Diagram of native auth sign in with email with OTP."::: 

After the app verifies the user's email with OTP, it receives security tokens. If the delivery of the OTP code delays or is never delivered to the user's email, the user can request to be sent another OTP code. Microsoft Entra ID resends another OTP code if the previous one hasn't been verified. When Microsoft Entra ID resends an OTP code, it invalidates the previously sent code.

### Step 1: Request to start the sign-in flow

The authentication flow begins with the application making a POST request to the `/initiate` endpoint to start the sign-in flow.

Here's an example of the request(we present the example request in multiple lines for readability):

```http
POST /{tenant_subdomain}.onmicrosoft.com/oauth2/v2.0/initiate HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded 

client_id=111101-14a6-abcd-97bc-abcd1110011
&challenge_type=oob redirect
&username=contoso-consumer@contoso.com 
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
| `client_id`         |   Yes    | The Application (client) ID of the app you registered in the Microsoft Entra admin center.                |
| `username`          |    Yes   |   Email of the customer user such as *contoso-consumer@contoso.com*.  |
| `challenge_type`    |   Yes  | A space-separated list of authorization [challenge type](#challenge-types) strings that the app supports such as `oob password redirect`. The list must always include the `redirect` challenge type. For the email OTP sign in flow, the value is expected to contain `oob redirect`.|

#### Success response

Here's an example of a successful response:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{
    "continuation_token": "uY29tL2F1dGhlbnRpY..."
}
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `continuation_token`  | [continuation_token](#continuation-token) that Microsoft Entra IDreturns. |  

If an app can't support a required authentication method by Microsoft Entra ID, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra ID informs the app by returning a *redirect* challenge type in its response:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{     
   "challenge_type": "redirect" 
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `challenge_type`  | Microsoft Entra ID returns a response that has a challenge type. The value of this challenge type is redirect, which enables the app to use the web-based authentication flow.  |  

This response is considered successful, but the app is required to switch to a web-based authentication flow. In this case, we recommend that you use a [Microsoft-built and supported authentication library](reference-v2-libraries.md).

#### Error response

Example:

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{ 
    "error": "invalid_request", 
    "error_description": "AADSTS901007: The challenge_type list parameter does not include the 'redirect' type.\r\nTrace ID: b386ad47-23ae-4092-...-1000000\r\nCorrelation ID: 72f57f26-...-3fa6\r\nTimestamp: yyyy-...",
    "error_codes": [ 
        901007 
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "b386ad47-...-0000", 
    "correlation_id": "72f57f26-...-3fa6"
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra ID-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as when the `challenge_type` parameter includes an invalid challenge type.   |  
|`unauthorized_client` | The client ID used in the request doesn't exist.|
|`invalid_grant`|The username doesn't exist.|
|`unsupported_challenge_type`|The `challenge_type` parameter value doesn't include the `redirect` challenge type.|

### Step 2: Select an authentication method

To continue with the flow, the app uses the continuation token acquired from the previous step to request Microsoft Entra ID to select one of the supported challenge types for the user to authenticate with. The app makes a POST request to the `/challenge` endpoint.

Here's an example of the request (we present the example request in multiple lines for readability):

```http
POST /{tenant_subdomain}.onmicrosoft.com/oauth2/v2.0/challenge HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded 

client_id=111101-14a6-abcd-97bc-abcd1110011
&challenge_type=oob redirect 
&continuation_token= uY29tL2F1dGhlbnRpY... 
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
| `client_id`       |   Yes   | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|
| `continuation_token` | Yes | [continuation_token](#continuation-token) that Microsoft Entra ID returned from the previous request. |
| `challenge_type`    |   No  | A space-separated list of authorization [challenge type](#challenge-types) strings that the app supports such as `oob password redirect`. The list must always include the `redirect` challenge type. For the email OTP sign in flow, the value is expected to be `oob redirect`.|

#### Success response

If the tenant administrator configured email OTP in the Microsoft Entra Admin Center as the user’s authentication method, Microsoft Entra ID sends an OTP code to the user’s email, then responds with a challenge type of *oob* and provides more information about the OTP code.

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{
    "continuation_token": "uY29tL2F1dGhlbnRpY...",
    "challenge_type": "oob",
    "binding_method": "prompt ", 
    "challenge_channel": "email",
    "challenge_target_label ": "c***r@co**o**o.com ",
    "code_length": 8
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `continuation_token`  | [continuation_token](#continuation-token) that Microsoft Entra ID returns. |
|`challenge_type`| Challenge type selected for the user to authenticate with.|
|`binding_method`|The only valid value is *prompt*. This parameter can be used in the future to offer more ways for the user to enter the OTP code. Issued if `challenge_type` is *oob*  |
|`challenge_channel`| The type of the channel through which the OTP code was sent. At the moment, we support email. |
|`challenge_target_label` |An obfuscated email where the OTP code was sent.|
|`code_length`|The length of the OTP code that Microsoft Entra IDgenerates. |

If an app can't support a required authentication method by Microsoft Entra ID, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra ID informs the app by returning a *redirect* challenge type in its response:

```http
HTTP/1.1 200 OK
Content-Type: application/json 
```

```json
{     
   "challenge_type": "redirect" 
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `challenge_type`  | Microsoft Entra ID returns a response that has a challenge type. The value of this challenge type is redirect, which enables the app to use the web-based authentication flow.  |  

This response is considered successful, but the app is required to switch to a web-based authentication flow. In this case, we recommend that you use a [Microsoft-built and supported authentication library](reference-v2-libraries.md).

#### Error response

Example:

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{ 
    "error": "invalid_request", 
    "error_description": "AADSTS901007: The challenge_type list parameter does not include the 'redirect' type.\r\nTrace ID: b386ad47-23ae-4092-...-1000000\r\nCorrelation ID: 72f57f26-...-3fa6\r\nTimestamp: yyyy-...",
    "error_codes": [ 
        901007 
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "b386ad47-...-0000", 
    "correlation_id": "72f57f26-...-3fa6"
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra ID-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as when the `challenge_type` parameter includes an invalid challenge type or *continuation token* validation failed.   |
|`invalid_grant`|The continuation token isn't valid. |
|`expired_token`|The continuation token is expired. |
|`unsupported_challenge_type`|The `challenge_type` parameter value doesn't include the `redirect` challenge type.|

### Step 3: Request for security tokens

The app makes a POST request to the `/token` endpoint and provides the user’s credentials chosen in the previous step, in this case OTP code, to acquire security tokens.

Here's an example of the request(we present the example request in multiple lines for readability):

```http
POST /{tenant_subdomain}.onmicrosoft.com/oauth2/v2.0/token HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded 

continuation_token=uY29tL2F1dGhlbnRpY...
&client_id=111101-14a6-abcd-97bc-abcd1110011 
&grant_type=oob 
&oob={otp_code}
&scope= openid offline_access 
```

|    Parameter     | Required | Description        |
|----------------------|------------------------|------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
| `continuation_token`  | Yes | [continuation_token](#continuation-token) that Microsoft Entra ID returned from the previous request. |
|`client_id`| Yes | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|
|`grant_type` | Yes | Value must be *oob* for email OTP flow.  |
|`oob`| Yes |The OTP code that the customer user received in their email. Replace `{otp_code}` with the OTP code that the customer user received in their email. To **resend an OTP code**, the app needs to make a request to the `/challenge` endpoint again. |
|`scope`| Yes |A space-separated list of scopes. All the scopes must be from a single resource, along with OpenID Connect (OIDC) scopes, such as *profile*, *openid, and *email*. The app needs to include *openid* scope for Microsoft Entra ID to issue an ID token. The app needs to include *offline_access* scope for Microsoft Entra ID to issue a refresh token. Learn more about [Permissions and consent in the Microsoft identity platform](permissions-consent-overview.md).|

#### Successful response

Here's an example of a successful response:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{
    "token_type": "Bearer",
    "scope": "openid profile",   
    "expires_in": 4141,   
    "access_token": "eyJ0eXAiOiJKV1Qi...",   
    "refresh_token": "AwABAAAA...",   
    "id_token": "eyJ0eXAiOiJKV1Q..."   
}
```

|    Parameter     | Description        |
|----------------------|------------------------|
|`token_type` |  Indicates the token type value. The only type that Microsoft Entra ID supports is *Bearer*.|
|`scopes`|  A space-separated list of scopes that the access token is valid for.|
|`expires_in`|   The length of time in seconds the access token remains valid.|
| `access_token`  |    The access token that the app requested from the `/token` endpoint. The app can use this access token to request access to secured resources such as web APIs.|  
|`refresh_token` |  An OAuth 2.0 refresh token. The app can use this token to acquire other access tokens after the current access token expires. Refresh tokens are long-lived. They can maintain access to resources for extended periods. For more detail on refreshing an access token, refer to [refresh the access token](v2-oauth2-auth-code-flow.md#refresh-the-access-token) article. <br> **Note**: Only issued if *offline_access* scope was requested.   |
|`id_token`|  A JSON Web Token (Jwt) used to identify the customer user. The app can decode the token to request information about the user who signed in. The app can cache the values and display them, and confidential clients can use this token for authorization. For more information about ID tokens, see [ID tokens](id-tokens.md).<br> **Note**: Only issued if *openid* scope was requested. |

#### Error response 

Example:

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{ 
    "error": "expired_token", 
    "error_description": "AADSTS55112: The continuation_token is expired.\r\nTrace ID: b386ad47-23ae-4092-...-1000000\r\nCorrelation ID: 72f57f26-...-3fa6\r\nTimestamp: yyyy-...",
    "error_codes": [ 
        552003 
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "b386ad47-...-0000", 
    "correlation_id": "72f57f26-...-3fa6"
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra ID-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed. To understand what happened, use the message in the error description.|  
|`invalid_grant`|The continuation token included in the request isn't valid or OTP code included in the request is invalid or the grant type included in the request is unknown.|
|`expired_token`|The continuation token included in the request is expired. |
|`invalid_scope`| One or more of the scoped included in the request are invalid.|
|`invalid_client`| The client ID included in the request isn't for a public client. |

## Next steps

- [Native authentication email with password API reference](/entra/identity-platform/reference-native-auth-email-password?bc=/entra/external-id/customers/breadcrumb/toc.json&toc=/entra/external-id/customers/toc.json).

- Learn how to [create custom attributes](../external-id/customers/how-to-define-custom-attributes.md#create-custom-user-attributes).