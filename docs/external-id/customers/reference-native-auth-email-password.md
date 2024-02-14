---
title: Native authentication with email and password API reference
description: Find out how to use native authentication with email and password API reference for Microsoft Entra ID for customers 
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: active-directory 
ms.subservice: ciam
ms.topic: reference
ms.date: 02/29/2024

#Customer intent: As a dev, devops, I want to learn how to integrate customer apps with Native authentication's email and password API that Microsoft Entra ID for customers supports.
---

# Native authentication with email and password API reference

Microsoft Entra ID's native authentication API with email and password allows you to build apps that enable users to sign up and sign in with their email and password. This API also allows you to enable self-service password reset (SSPR) in your apps. The email and password API provides three flows, sign-in, sign-up and SSPR flows.

[!INCLUDE [native-auth-api-common-description](./includes/native-auth-api/native-auth-api-common-description.md)]

[!INCLUDE [native-auth-api-cors-note](./includes/native-auth-api/native-auth-api-cors-note.md)]

## Prerequisites

1. Microsoft Entra External ID for customers tenant. If you don't already have one, [sign up for a free trial](https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl).

1. If you haven't already done so, [Register an application in the Microsoft Entra Admin center](tutorial-web-app-node-sign-in-prepare-tenant.md#register-the-web-app), then [enable public client flows](tutorial-web-app-node-sign-in-prepare-tenant.md#register-the-web-app).

1. If you haven't already done so, [Grant API permissions](tutorial-web-app-node-sign-in-prepare-tenant.md#grant-api-permissions) to your app registration.

1. If you haven't already done so, [Create a user flow in the Microsoft Entra Admin center](tutorial-web-app-node-sign-in-prepare-tenant.md#associate-the-web-application-with-the-user-flow).. While you create the user flow, take note of the user attributes you select as these are attributes Microsoft Entra ID expects your app to submit. Under **Identity providers**, select **Email with password** option.

1. [Associate your app registration with the user flow](tutorial-web-app-node-sign-in-prepare-tenant.md#associate-the-web-application-with-the-user-flow).

1. For sign-in flow, [register a customer user](how-to-manage-customer-accounts.md#create-a-customer-account), which you use for test the sign in APIs. Alternatively, you get this test user after you run the sign-up flow.

1. For self-service password reset flow, [enable self-service password reset](how-to-enable-password-reset-customers.md) for customer users in the customers tenant.

## Continuation token

[!INCLUDE [entra-external-id-continuation-token](./includes/native-auth-api/continuation-token.md)]

Each continuation token is valid for a specific period and can only be used for the subsequent requests within the same flow.

## Sign-up API reference

To complete a user sign-up flow, your app interacts with four endpoints, `/signup/v1.0/start`, `/signup/v1.0/challenge`,  `/signup/v1.0/continue` and `/token`.

### Sign-up API endpoints

|    Endpoint           | Description                                |
|-----------------------|--------------------------------------------|
| `/signup/v1.0/start`  | This endpoint starts the sign-up flow. You pass valid application ID, new username, and [challenge type](#sign-up-challenge-types), then you get back a new continuation token. The endpoint can return a response to indicate to the application to use a web authentication flow if the application’s chosen authentication methods aren't supported by Microsoft Entra ID.|
|   `/signup/v1.0/challenge`   | Your app calls this endpoint with a list of [challenge types](#sign-up-challenge-types) supported by Microsoft Entra ID. Microsoft Entra ID then selects one of the supported authentication for the user to authenticate with. |
|  `/signup/v1.0/continue`  | This endpoint helps to continue the flow to create the user account or interrupt the flow due to missing requirements such as password policy requirements or wrong attribute formats. This endpoint generates a continuation token, then returns it to the app. The endpoint can return a response to indicate to the application to use a web-based authentication flow if the application doesn't an authentication method chosen by  Microsoft Entra ID.|
|`/token`| The application calls this endpoint to finally request for security tokens. The app needs to include the continuation token it acquired from the last successful call to the `/signup/v1.0/continue` endpoint.|

### Sign-up challenge types

The API allows the app to advertise the authentication methods it supports, when it makes a call to Microsoft Entra ID. To do so, the app uses the `challenge_type` parameter in the its requests. This parameter holds pre-defined values, which represent different authentication methods. The following table contains the authentication methods the API supports. New values will be added in the future when the API supports new authentication methods.

|    Challenge type     | Description                                |
|-----------------------|--------------------------------------------|
| password              | This challenge type indicates that the app supports the collection of a password credential from the user.                   |
| oob   | This challenge type indicates that the application supports the use of OTP codes sent to the user using a secondary channel. Currently, the API supports only email OTPs.|
| redirect  | This challenge type indicates that the application supports fallback to web-based authentication. All Native Auth compliant applications must support this authentication method. In every call the app makes, it must include this challenge type. If Microsoft Entra ID returns this challenges type as a response, then it indicates that the app needs to fallback to web-based authentication. In this case, we recommend that you use a [Microsoft-built and supported authentication library](../../identity-platform/reference-v2-libraries.md).|

### Sign-up flow protocol details

The sequence diagram demonstrates the flow of the sign-up process.

:::image type="content" source="media/reference-native-auth-api/sign-up-email-with-password.png" alt-text="Diagram of native auth sign up with email and password option."::: 

This diagram indicates that the app collects username (email), password and attributes from the user at different times (and possibly on separate screens). However, you can design your app to collect the username (email), password and all the required, and optional attribute values in the same screen, then submit all of them via the `/signup/v1.0/start` endpoint. In this case, the app doesn't need to make calls and handle responses indicated as optional steps. This approach gives you the flexibility to collect information from the user in whichever order you want.  

### Step 1: Request to start the sign-up flow

The sign-up flow begins with the application making a POST request to the `/signup/v1.0/start` endpoint to start the sign-up flow.

Here are examples of the request(we present the example request in multiple lines for readability):

Example 1:

```http
POST /{tenant_subdomain}.onmicrosoft.com/signup/v1.0/start HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded

client_id=111101-14a6-abcd-97bc-abcd1110011
&challenge_type=oob password redirect
&username=contoso-consumer@contoso.com 
```

Example 2 (include user attributes and password in the request):

```http
POST /{tenant_subdomain}.onmicrosoft.com/signup/v1.0/start HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded

client_id=111101-14a6-abcd-97bc-abcd1110011
&challenge_type=oob password redirect
&password={secure_password}
&attributes={"name": "{user_name}", "extension_2588abcdwhtfeehjjeeqwertc_age": "{user_age}", "phone": "{user_phone}"}
&username=contoso-consumer@contoso.com 
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
| `client_id`         |   Yes    | The Application (client) ID of the app you registered in the Microsoft Entra Admin center.                |
| `username`          |    Yes   | Email of the customer user that they want to sign up with, such as *contoso-consumer@contoso.com*.  |
| `challenge_type`    |   Yes  | A space-separated list of authorization challenge type strings that the app supports such as `oob password redirect`. The list must always include the `redirect` challenge type. For the email with password sign-up flow, the value is expected to contain `oob password redirect`.|
|`password`| No | The password value that the app collects from the customer user. You can submit a user's password via the  `/signup/v1.0/start` or later in the `/signup/v1.0/continue` endpoint. Replace `{secure_password}` with the password value that the app collects from the customer user. It's your responsibility to confirm that the user is aware of the password they want to use by providing the password confirm field in the app's UI. You must also ensure that the user is aware of what constitutes a strong password per your organization's policy. [Learn more about Microsoft Entra ID's password policies](../../identity/authentication/concept-password-ban-bad-combined-policy.md#azure-ad-password-policies).|
|`attributes`| No | The user attributes values that the app collects from the customer user. The value is a string, but formatted as a JSON object whose key values are names of user attributes. These attributes can be built in or custom, and required or optional. The key names of the object depend on the attributes that the administrator configured in Microsoft Entra Admin center. You can submit some or all user attributes via the `/signup/v1.0/start` endpoint or later in the `/signup/v1.0/continue` endpoint. If you submit all the required attributes via the `/signup/v1.0/start` endpoint, you won't be required to submit any attributes. However, if you submit some required attributes via `/signup/v1.0/start` endpoint, you can submit the remaining required attributes later in the `/signup/v1.0/continue` endpoint. Replace `{user_name}`, `{user_age}` and `{user_phone}` with the name, age and phone number values respectively that the app collects from the customer user. **Microsoft Entra ID ignores any attributes that you submit, which don't exist**.|

#### Success response

Here's an example of a successful response:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{
    "continuation_token": "AQABAAEAAA…",
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
| `challenge_type`  | Microsoft Entra ID returns a response that has a challenge type. The value of this challenge type is redirect, which enables the app to use the web-based authentication flow.  |

This response is considered successful, but the app is required to switch to a web-based authentication flow. In this case, we recommend that you use a [Microsoft-built and supported authentication library](../../identity-platform/reference-v2-libraries.md).

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
|`unauthorized_client`| The client ID used in the request doesn't exist. |
|`unsupported_challenge_type`|The `challenge_type` parameter value doesn't include the `redirect` challenge type.| 
|`attribute_validation_failed`|  Validation of one or more attributes failed. This response is possible if the app submits user attributes.|
|`user_already_exists` |  User already exists.  |
|`password_too_weak`|Password is too weak as it doesn't meet complexity requirements. [Learn more about Microsoft Entra ID's password policies](../../identity/authentication/concept-password-ban-bad-combined-policy.md#azure-ad-password-policies). This response is possible if the app submits a user password.|
|`password_too_short`|New password is less than 8 characters. [Learn more about Microsoft Entra ID's password policies](../../identity/authentication/concept-password-ban-bad-combined-policy.md#azure-ad-password-policies). This response is possible if the app submits a user password.|
|`password_too_long` |New password is longer than 256 characters. [Learn more about Microsoft Entra ID's password policies](../../identity/authentication/concept-password-ban-bad-combined-policy.md#azure-ad-password-policies). This response is possible if the app submits a user password.|
|`password_recently_used`|The new password must not be the same as one recently used. [Learn more about Microsoft Entra ID's password policies](../../identity/authentication/concept-password-ban-bad-combined-policy.md#azure-ad-password-policies). This response is possible if the app submits a user password.|
|`password_banned`|New password contains a word, phrase, or pattern that is banned. [Learn more about Microsoft Entra ID's password policies](../../identity/authentication/concept-password-ban-bad-combined-policy.md#azure-ad-password-policies). This response is possible if the app submits a user password.|

> [!NOTE]
> If you submit all the required attributes via `/signup/v1.0/start` endpoint, but not all optional attributes, you won't be able to submit any additional optional attributes later via the  `/signup/v1.0/continue` endpoint. This is so because Microsoft Entra ID doesn't explicitly request for optional attributes.

### Step 2: Select an authentication method

When the request for the continuation token is done, the app needs to request Microsoft Entra ID to select one of the supported challenge types for the user to authenticate with. To do so, it calls the `/signup/v1.0/challenge` endpoint and it includes the continuation token which it acquired from the `/signup/v1.0/start` endpoint in the request.

Here's an example of the request(we present the example request in multiple lines for readability).

```http
POST /{tenant_subdomain}.onmicrosoft.com/signup/v1.0/challenge HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded

client_id=111101-14a6-abcd-97bc-abcd1110011
&challenge_type=oob password redirect
&continuation_token=AQABAAEAAA…
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
| `client_id`         |   Yes    | The Application (client) ID of the app you registered in the Microsoft Entra Admin center.|
| `challenge_type`    |   No  | A space-separated list of authorization [challenge type](#sign-up-challenge-types) strings that the app supports such as `oob password redirect`. The list must always include the `redirect` challenge type. For the email with password sign-up flow, the value is expected to contain `oob password redirect`.|
|`continuation_token`| Yes |[continuation_token](#continuation-token) that Microsoft Entra ID returned in the previous request.|

#### Success response

Microsoft Entra ID sends an OTP code to the user's email, then responds with the challenge type with value of *oob* and additional information about the OTP code:

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
| `continuation_token`  | [continuation_token](#continuation-token) that Microsoft Entra ID returns. |
|`challenge_type`| Challenge type selected for the user to authenticate with.|
|`binding_method`|The only valid value is *prompt*. This parameter can be used in the future to offer additional ways to the user to enter the OTP code. Issued if `challenge_type` is *oob*  |
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
| `challenge_type`  | Microsoft Entra ID returns a response that has a challenge type. The value of this challenge type is redirect, which enables the app to use the web-based authentication flow.  |  

This response is considered successful, but the app is required to switch to a web-based authentication flow. In this case, we recommend that you use a [Microsoft-built and supported authentication library](../../identity-platform/reference-v2-libraries.md).

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
| `invalid_request`  |  Request parameter validation failed such as client ID is empty or invalid.   |
|`expired_token`|The continuation token is expired. |
|`unsupported_challenge_type`|The `challenge_type` parameter value doesn't include the `redirect` challenge type.|
|`invalid_grant` | The continuation token is invalid. |

### Step 3: Submit OTP code

The app submits the  OTP code sent to the users email. Since we're submitting OTP code, an `oob` parameter is required, and the `grant_type` parameter must have a value *oob*.

Here's an example of the request(we present the example request in multiple lines for readability):

```http
POST /{tenant_subdomain}.onmicrosoft.com/signup/v1.0/continue HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded

continuation_token=uY29tL2F1dGhlbnRpY...
&client_id=111101-14a6-abcd-97bc-abcd1110011 
&grant_type=oob 
&oob={otp_code}
```

|    Parameter     | Required | Description        |
|----------------------|------------------------|------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
| `continuation_token`  | Yes |[continuation_token](#continuation-token) that Microsoft Entra ID returned in the previous request.|
|`client_id`| Yes | The Application (client) ID of the app you registered in the Microsoft Entra Admin center.|
|`grant_type` | Yes | A request to the  `/signup/v1.0/continue` endpoint can be used to submit OTP code, password or user attributes. In this case, the `grant_type` value is used to differentiate between these three use cases. The possible values for the grant_type are *oob*, *password*, *attributes*. In this call, since we're sending OTP code, the value is expected to be *oob*.|
|`oob`| Yes | The OTP code that the customer user received in their email. Replace `{otp_code}` with the OTP code that the customer user received in their email. To **resend an OTP code**, the app needs to make a request to the `/signup/v1.0/challenge` endpoint again. The OTP code |

#### Response

Once the OTP code has been submitted successfully, Microsoft Entra ID's response depends on the following scenarios:

1. If the app successfully submitted user's password via the `/signup/v1.0/start` endpoint, and no attributes were configured in Microsoft Entra Admin center or all the required user attributes were submitted via the `/signup/v1.0/start` endpoint, Microsoft Entra ID issues a continuation token. The app can use the continuation token to request for security tokens as shown in [step 5](#step-5-request-for-security-tokens).

1. If the app successfully submitted user's password via the `/signup/v1.0/start`, but not all the required user attributes, Microsoft Entra ID indicates the attributes that the app needs to submit as shown in [user attributes required](#user-attributes-required). In this case, the app needs to submit the required user attributes via the `/signup/v1.0/continue` endpoint as shown in [submit user attributes](#submit-user-attributes).

1. If the app didn't submit the user's password via `/signup/v1.0/start` endpoint, then the response looks similar to the following:

    ```http
    HTTP/1.1 400 Bad Request
    Content-Type: application/json
    ```

    ```json
    {
        "error": "credential_required",
        "error_description": "AADSTS55103: Credential required. Trace ID: d6966055-...-80500 Correlation ID: 3944-...-60d6 Timestamp: yy-mm-dd 02:37:33Z",
        "error_codes": [
            55103
        ],
        "timestamp": "yy-mm-dd 02:37:33Z",
        "trace_id": "d6966055-...-80500",
        "correlation_id": "3944-...-60d6",
        "continuation_token": "AQABEQEAAAA..."
    } 
    ```
    
    |    Parameter     | Description        |
    |----------------------|------------------------|
    | `error`  |  An error code string that can be used to classify types of errors, and to react to errors.   |  
    |`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
    |`error_codes`| A list of Microsoft Entra ID-specific error codes that can help you to diagnose errors.  |
    |`timestamp`|The time when the error occurred.|
    |`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
    |`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |
    |`continuation_token`| [continuation_token](#continuation-token) that Microsoft Entra ID returns. |
    
    Here are the possible errors you can encounter (possible values of the `error` parameter):
    
    |    Error value     | Description        |
    |----------------------|------------------------|
    |`credential_required`|Authentication is required for account creation, so you've to make a call to the `/signup/v1.0/challenge` endpoint to determine the credential the user is required to provide.|
    |`invalid_request`  |  Request parameter validation failed such as if the continuation token validation failed .   |  
    |`invalid_grant`|The grant type included in the request isn't valid or supported.|
    |`expired_token`|The continuation token included in the request is expired. |

    For the password credential to be collected from the user, the app needs to make a call to the `/signup/v1.0/challenge` endpoint to determine the credential the user is required to provide.

    Here's an example of the request(we present the example request in multiple lines for readability):

    ```http
    POST /{tenant_subdomain}.onmicrosoft.com/signup/v1.0/challenge HTTP/1.1
    Host: {tenant_subdomain}.ciamlogin.com
    Content-Type: application/x-www-form-urlencoded
 
    client_id=111101-14a6-abcd-97bc-abcd1110011
    &challenge_type=oob password redirect
    &continuation_token=AQABAAEAAA…
    ```
    
    |    Parameter     | Required                     |           Description        |
    |-----------------------|-------------------------|------------------------|
    | `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
    | `client_id`         |   Yes    | The Application (client) ID of the app you registered in the Microsoft Entra Admin center.|
    | `challenge_type`    |   No  | A space-separated list of authorization [challenge type](#sign-up-challenge-types) strings that the app supports such as `oob password redirect`. The list must always include the `redirect` challenge type. For the email with password sign-up flow, the value is expected to contain `password redirect`.|
    |`continuation_token`| Yes |[continuation_token](#continuation-token) that Microsoft Entra ID returned in the previous request.|

    #### Success response
    
    If password is the authentication method configured for the user in the Microsoft Entra Admin center, a success response with the continuation token is returned to the app.
    
    ```http
    HTTP/1.1 200 OK
    Content-Type: application/json
    ```

    ```json
    {    
        "challenge_type": "password", 
        "continuation_token": " AQABAAEAAAAty..."  
    }  
    ```
    
    |    Parameter     | Description        |
    |----------------------|------------------------|
    | `challenge_type`  |  *password* is returned in the response for the required credential.   |
    |`continuation_token`| [continuation_token](#continuation-token) that Microsoft Entra ID returns.   |
    
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
    
    This response is considered successful, but the app is required to switch to a web-based authentication flow. In this case, we recommend that you use a [Microsoft-built and supported authentication library](../../identity-platform/reference-v2-libraries.md).

### Step 4: Authenticate and get token to sign in

The app needs to submit the user's credential, in this case password, that Microsoft Entra ID requested in the previous step. The app needs to submit a password credential if it didn't do so via the `/signup/v1.0/start` endpoint. The app makes a request to the `/signup/v1.0/continue` endpoint to submit the password. Since we're submitting a password, a `password` parameter is required, and the `grant_type` parameter must have a value *password*.

Here's an example of the request(we present the example request in multiple lines for readability):

```http
POST /{tenant_subdomain}.onmicrosoft.com/signup/v1.0/continue HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded

continuation_token=uY29tL2F1dGhlbnRpY...
&client_id=111101-14a6-abcd-97bc-abcd1110011 
&grant_type=password 
&password={secure_password}
```

|    Parameter     | Required | Description        |
|----------------------|------------------------|------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
| `continuation_token`  | Yes |[continuation_token](#continuation-token) that Microsoft Entra ID returned in the previous step.|
|`client_id`| Yes | The Application (client) ID of the app you registered in the Microsoft Entra Admin center.|
|`grant_type` | Yes | A request to the `/signup/v1.0/continue` endpoint can be used to submit OTP code, password or user attributes. In this case, the `grant_type` value is used to differentiate between these three use cases. The possible values for the grant_type are *oob*, *password*, *attributes*. In this call, since we're sending user's password, the value is expected to be *password*.|
|`password`| Yes | The password value that the app collects from the customer user. Replace `{secure_password}` with the password value that the app collects from the customer user. It's your responsibility to confirm that the user is aware of the password they want to use by providing the password confirm field in the app's UI. You must also ensure that the user is aware of what constitutes a strong password per your organization's policy. [Learn more about Microsoft Entra ID's password policies](../../identity/authentication/concept-password-ban-bad-combined-policy.md#azure-ad-password-policies).|

#### Success response

If the request is successful, but no attributes were configured in Microsoft Entra Admin center or all the required attributes were submitted via the `/signup/v1.0/start` endpoint, the app gets a continuation token without submitting any attributes. The app can use the continuation token to request for security tokens as shown in [step 5](#step-5-request-for-security-tokens). Otherwise, Microsoft Entra ID's response indicates that the app needs to submit required attributes. These attributes, built in or custom, were configured in the Microsoft Entra Admin center by the tenant administrator.

##### User attributes required

This response requests the app to submit values for *name*, *age* and *phone* attributes.

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{  
    "error": "attributes_required",  
    "error_description": "User attributes required",
    "error_codes": [
            55106
        ],
    "timestamp": "yy-mm-dd 02:37:33Z",
    "trace_id": "d6966055-...-80500",
    "correlation_id": "3944-...-60d6",
    "continuation_token": "AQABAAEAAAAtn..."  
    "required_attributes": [
        {  
            "name": "name",  
            "type": "string",  
            "required": true,  
            "options": {  
              "regex": ".*@.**$"  
            }  
        }, 
        {  
            "name": "extension_2588abcdwhtfeehjjeeqwertc_age",  
            "type": "string",  
            "required": true  
        }, 
        {  
            "name": "phone",  
            "type": "string",  
            "required": true,  
            "options": {  
              "regex":"^[1-9][0-9]*$"  
            }  
        }
    ],  
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
|`continuation_token`| [continuation_token](#continuation-token) that Microsoft Entra ID returns.  |
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

This response is considered successful, but the app is required to switch to a web-based authentication flow. In this case, we recommend that you use a [Microsoft-built and supported authentication library](../../identity-platform/reference-v2-libraries.md).

#### Error response

Example:

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{  
    "error": "password_too_weak",
    "error_description": "Password too weak",  
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

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as when the `challenge_type` parameter includes an invalid challenge type.   |  
|`invalid_grant`|The grant type provided isn't valid or supported.|
|`expired_token`|The continuation token is expired. |
|`attributes_required`  |  One or more of user attributes is required.   |
|`password_too_weak`|Password is too weak as it doesn't meet complexity requirements. [Learn more about Microsoft Entra ID's password policies](../../identity/authentication/concept-password-ban-bad-combined-policy.md#azure-ad-password-policies).|
|`password_too_short`|New password is less than 8 characters. [Learn more about Microsoft Entra ID's password policies](../../identity/authentication/concept-password-ban-bad-combined-policy.md#azure-ad-password-policies).|
|`password_too_long` |New password is longer than 256 characters. [Learn more about Microsoft Entra ID's password policies](../../identity/authentication/concept-password-ban-bad-combined-policy.md#azure-ad-password-policies). |
|`password_recently_used`|The new password must not be the same as one recently used. [Learn more about Microsoft Entra ID's password policies](../../identity/authentication/concept-password-ban-bad-combined-policy.md#azure-ad-password-policies).|
|`password_banned`|New password contains a word, phrase, or pattern that is banned. [Learn more about Microsoft Entra ID's password policies](../../identity/authentication/concept-password-ban-bad-combined-policy.md#azure-ad-password-policies).|

#### Submit user attributes

To continue with the flow, the app needs to make a call to the `/signup/v1.0/continue` endpoint to submit the required user attributes. Since we're submitting attributes, an `attributes` parameter is required, and the `grant_type` parameter must have a value *attributes*.

Here's an example of the request(we present the example request in multiple lines for readability):

```http
POST /{tenant_subdomain}.onmicrosoft.com/signup/v1.0/continue HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded

&client_id=111101-14a6-abcd-97bc-abcd1110011 
&grant_type=attributes 
&attributes={"name": "{user_name}", "extension_2588abcdwhtfeehjjeeqwertc_age": "{user_age}", "phone": "{user_phone}"}
&continuation_token=AQABAAEAAAAtn...
```

|    Parameter     | Required | Description        |
|----------------------|------------------------|------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
| `continuation_token`  | Yes |[continuation_token](#continuation-token) that Microsoft Entra ID returned in the previous request.  |
|`client_id`| Yes | The Application (client) ID of the app you registered in the Microsoft Entra Admin center.|
|`grant_type` | Yes | A request to the `/signup/v1.0/continue` endpoint can be used to submit OTP code, password or user attributes. In this case, the `grant_type` value is used to differentiate between these three use cases. The possible values for the grant_type are *oob*, *password*, *attributes*. In this call, since we're sending user attributes, the value is expected to be *attributes*.|
|`attributes`| Yes | The user attribute values that the app collects from the customer user. The value is a string, but formatted as a JSON object whose key values are names of user attributes, built in or custom. The key names of the object depend on the attributes that the administrator configured in Microsoft Entra Admin center. Replace `{user_name}`, `{user_age}` and `{user_phone}` with the name, age and phone number values respectively that the app collects from the customer user. **Microsoft Entra ID ignores any attributes that you submit, which don't exist**.|

#### Success response

If the request is successful, Microsoft Entra ID issues a continuation token, which the app can use to request for security tokens.

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{  
    "continuation_token": "AQABAAEAAAYn..."
} 
```

|    Parameter   |   Description        |
|----------------------|------------------------|
| `continuation_token`  | [continuation_token](#continuation-token) that Microsoft Entra ID returns.|  

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

This response is considered successful, but the app is required to switch to a web-based authentication flow. In this case, we recommend that you use a [Microsoft-built and supported authentication library](../../identity-platform/reference-v2-libraries.md).

#### Error response

Example:

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{  
    "error": "expired_token",
    "error_description": "AADSTS901007: The continuation_token is expired.  .\r\nTrace ID: b386ad47-23ae-4092-...-1000000\r\nCorrelation ID: 72f57f26-...-3fa6\r\nTimestamp: yyyy-...", 
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
|`continuation_token`| [continuation_token](#continuation-token) that Microsoft Entra ID returns.  |
| `unverified_attributes`  |  A list (array of objects) of attribute key names that must be verified. This parameter is included in the response when the `error` parameter's value is *verification_required*.|
|`required_attributes`| A list (array of objects) of attributes that the app needs to submit. Microsoft Entra ID includes this parameter in its response when the `error` parameter's value is *attributes_required*.|
| `invalid_attributes`   |  A list (array of objects) of attributes that failed validation. This parameter is included in the response when the `error` parameter's value is *attribute_validation_failed*.    |

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |Request parameter validation failed such as when a continuation token fails validation or client ID is invalid.|
|`invalid_grant`|The grant type provided isn't valid or supported.|
|`expired_token`|The continuation token included in the request is expired.|
|`attributes_required`  |  One or more of user attributes is required.   |
|`attribute_validation_failed`|  Validation of one or more attributes failed. |

### Step 5: Request for security tokens

The app makes a POST request to the `/token` endpoint and provides the continuation token obtained from the previous step to acquire security tokens.

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
| `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
|`client_id`| Yes | The Application (client) ID of the app you registered in the Microsoft Entra Admin center.|
|`grant_type` | Yes | The parameter value must be *continuation token*. |
|`continuation_token`|Yes    |[continuation_token](#continuation-token) that Microsoft Entra ID returned in the previous step. |
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
| `access_token`  |    The access token that the app requested from the `/token` endpoint. The app can use this access token to request access to secured resources such as web APIs.|  
|`token_type` |  Indicates the token type value. The only type that Microsoft Entra ID supports is *Bearer*.|
|`expires_in`|   The length of time in seconds the access token remains valid.|
|`scopes`|  A space-separated list of scopes that the access token is valid for.|
|`refresh_token` |  An OAuth 2.0 refresh token. The app can use this token to acquire other access tokens after the current access token expires. Refresh tokens are long-lived. They can maintain access to resources for extended periods. For more detail on refreshing an access token, refer to [Refresh the access token](../../identity-platform/v2-oauth2-auth-code-flow.md#refresh-the-access-token) article. <br> **Note**: Only issued if *offline_access* scope was requested.   |
|`id_token`|  A JSON Web Token (Jwt) used to identify the customer user. The app can decode the token to request information about the user who signed in. The app can cache the values and display them, and confidential clients can use this token for authorization. For more information about ID tokens, see [ID tokens](../../identity-platform/id-tokens.md).<br> **Note**: Only issued if *openid* scope is requested. |

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
|`invalid_grant`|The continuation token included in the request  is invalid.|
|`unauthorized_client`| The client ID included in the request is invalid or doesn't exist. |
|`unsupported_grant_type`| The grant type included in the request isn't supported or is incorrect. |

## Format of user attributes values

You specify the information you want to collect from the user by configuring the user flow settings in the Microsoft Entra Admin center. Use the [Collect user attributes during sign-up](how-to-define-custom-attributes.md) article to learn how to collect values for both built in and custom attributes.

You can also specify the **User Input Type** for the attributes you configure. The following table summarizes supported user input types, and how to submit values collected by the UI controls to Microsoft Entra ID.

|    User Input Type     |     Format of submitted values    |
|----------------------|----------------------|
|   TextBox   |   A single value such as job title, *Software Engineer*.  |
|   SingleRadioSelect   |  A single value such as Language, *Norwegian*.  |
|   CheckboxMultiSelect   |  One or multiple values such as a hobby or hobbies, *Dancing* or *Dancing,Swimming,Traveling*. |

Here's an example request that show how you submit the attributes values:

```http
POST /{tenant_subdomain}.onmicrosoft.com/signup/v1.0/continue HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded
 
continuation_token=ABAAEAAAAtyo... 
&client_id=111101-14a6-abcd-97bc-abcd1110011 
&grant_type=attributes 
&attributes={"jobTitle": "Software Engineer", "extension_2588abcdwhtfeehjjeeqwertc_language": "Norwegian", "extension_2588abcdwhtfeehjjeeqwertc_hobbies": "Dancing,Swimming,Traveling"}
&continuation_token=AQABAAEAAAAtn...
```

## Sign-in API reference

To request your security tokens, your app interacts with three endpoints, `/initiate`, `/challenge` and `/token`.

### Sign-in API endpoints

|    Endpoint           | Description                                |
|-----------------------|--------------------------------------------|
| `/initiate`  | This endpoint initiates the sign-in flow. If your app calls it with a username of a user account that already exists, it returns a success response with a continuation token. If your app requests to use authentication methods that are not supported by Microsoft Entra ID, this endpoint response can indicate to your app that it needs to use a browser-based authentication flow.|
|   `/challenge`   | your app calls this endpoint with a list of [challenge types](#sign-in-challenge-types) supported by the our identity service. Our identity service generates, then sends an OTP code to the chosen challenge channel such as email. If your app calls this endpoint repeatedly, a new OTP is sent each time a call is made.|
|  `/token`  | This endpoint verifies the OTP code it receives from your app, then it issues security tokens to your app.|

### Sign-in challenge types

The API allows the app to advertise the authentication methods it supports to Microsoft Entra ID. To do so, the app includes the `challenge_type` parameter in its requests. This parameter holds pre-defined values, which represent different authentication methods. The following table contains the authentication methods the API supports. New values will be added in the future when the API supports new authentication methods.

|    Challenge type     | Description                                |
|-----------------------|--------------------------------------------|
| password              | This challenge type indicates that the app supports the collection of a password credential from the user.                   |
| oob   | This challenge type indicates that the application supports the use of OTP codes sent to the user using a secondary channel. Currently, the API supports only email OTPs.|
| redirect  | This challenge type indicates that the application supports fallback to web-based authentication. All Native Auth compliant applications must support this authentication method. In every call the app makes, it must include this challenge type. If Microsoft Entra ID returns this challenges type as a response, then it indicates that the app needs to fallback to web-based authentication. In this case, we recommend that you use a [Microsoft-built and supported authentication library](../../identity-platform/reference-v2-libraries.md).|

### Sign-in flow protocol details

The sequence diagram demonstrates the flow of the sign in process.

:::image type="content" source="media/reference-native-auth-api/sign-in-email-with-password.png" alt-text="Diagram of native auth sign in with email and password option."::: 

This diagram indicates that the app collects username (email) and password from the user at different times (and possibly on separate screens). However, you can design your app to collect the two values in the same screen. If you collect the username (email) and password in the same screen, steps **two** and **three** gets merged with steps **eight** and **nine**. In this case, the app holds the password, then submits it in step **ten** where it's required.

In the sections that follow, we summarize the sequence diagram flow into three basic steps.

### Step 1: Request to start the sign-in flow

The authentication flow begins with the application making a POST request to the `/initiate` endpoint to start the sign-in flow.

Here's an example of the request(we present the example request in multiple lines for readability):

```http
POST /{tenant_subdomain}.onmicrosoft.com/oauth2/v2.0/initiate HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded

client_id=111101-14a6-abcd-97bc-abcd1110011
&challenge_type=password redirect
&username=contoso-consumer@contoso.com 
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
| `client_id`         |   Yes    | The Application (client) ID of the app you registered in the Microsoft Entra Admin center.                |
| `username`          |    Yes   |   Email of the customer user such as *contoso-consumer@contoso.com*.  |
| `challenge_type`    |   Yes  | A space-separated list of authorization [challenge type](#sign-in-challenge-types) strings that the app supports such as `oob password redirect`. The list must always include the `redirect` challenge type. For the email with password sign-in flow, the value is expected to contain `password redirect`.|

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

This response is considered successful, but the app is required to switch to a web-based authentication flow. In this case, we recommend that you use a [Microsoft-built and supported authentication library](../../identity-platform/reference-v2-libraries.md).

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

To continue with the flow, the app uses the continuation token acquired from the previous step to request Microsoft Entra ID to select one of the supported challenge types for the user to authenticate with. The app makes a POST request to the The `/challenge` endpoint.

Here's an example of the request (we present the example request in multiple lines for readability):

```http
POST /{tenant_subdomain}.onmicrosoft.com/oauth2/v2.0/challenge HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded

client_id=111101-14a6-abcd-97bc-abcd1110011
&challenge_type=password redirect 
&continuation_token=uY29tL2F1dGhlbnRpY... 
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
| `client_id`       |   Yes   | The Application (client) ID of the app you registered in the Miscrosoft Entra Admin center.|
| `continuation_token` |    Yes   | [continuation_token](#continuation-token) that Microsoft Entra ID returned in the previous request. |
| `challenge_type`    |   No  | A space-separated list of authorization [challenge type](#sign-in-challenge-types) strings that the app supports such as `oob password redirect`. The list must always include the `redirect` challenge type. For the email with password flow, the value is expected to be `password redirect`.|

#### Success response

If the tenant administrator configured email with password in the Microsoft Entra Admin Center as the user’s authentication method, Microsoft Entra ID returns a success response, which includes a challenge type of *password*.

Example:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{   
   "continuation_token": "uY29tL2F1dGhlbnRpY",   
   "challenge_type": "password" 
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `continuation_token`  |  [continuation_token](#continuation-token) that Microsoft Entra ID returns. |  
|`challenge_type`|Microsoft Entra ID returns the supported challenge type configured for the user in the Microsoft Entra Admin center. In this case the values is expected to be *password*.|

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

This response is considered successful, but the app is required to switch to a web-based authentication flow. In this case, we recommend that you use a [Microsoft-built and supported authentication library](../../identity-platform/reference-v2-libraries.md).

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
|--------------------|--------------------|
| `invalid_request`  |  Request parameter validation failed such as when the `challenge_type` parameter includes an invalid challenge type. |  
|`invalid_grant`|The continuation token included in the request isn't valid.  |
|`expired_token`|The continuation token included in the request is expired. |
|`unsupported_challenge_type`|The `challenge_type` parameter value doesn't include the `redirect` challenge type. |

### Step 3: Request for security tokens

The app makes a POST request to the `/token` endpoint and provides the user’s credentials chosen in the previous step, in this case password, to acquire security tokens.  

Here's an example of the request(we present the example request in multiple lines for readability):

```http
POST /{tenant_subdomain}.onmicrosoft.com/oauth2/v2.0/token HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded

continuation_token=uY29tL2F1dGhlbnRpY...
&client_id=111101-14a6-abcd-97bc-abcd1110011 
&grant_type=password 
&password={secure_password}
&scope=openid offline_access 
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
| `client_id`       |   Yes   | The Application (client) ID of the app you registered in the Microsoft Entra Admin center.|
| `continuation_token`          |    Yes   |  [continuation_token](#continuation-token) that Microsoft Entra ID returned in the previous request. |
|`grant_type`| Yes |The value must be *password*. |
|`scope`| Yes | A space-separated list of scopes. All the scopes must be from a single resource, along with OpenID Connect (OIDC) scopes, such as *profile*, *openid* and *email*. The app needs to include *openid* scope for Microsoft Entra ID to issue an ID token. The app needs to includes *offline_access* scope for Microsoft Entra ID to issue a refresh token. Learn more about [Permissions and consent in the Microsoft identity platform](../../identity-platform/permissions-consent-overview.md). |
|   `password`    | Yes | The password value that the app collects from the customer user. Replace `{secure_password}` with the password value that the app collects from the customer user.|

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
|`refresh_token` |  An OAuth 2.0 refresh token. The app can use this token to acquire other access tokens after the current access token expires. Refresh tokens are long-lived. They can maintain access to resources for extended periods. For more detail on refreshing an access token, refer to [Refresh the access token](../../identity-platform/v2-oauth2-auth-code-flow.md#refresh-the-access-token) article. <br> **Note**: Only issued if *offline_access* scope is requested.   |
|`id_token`|  A JSON Web Token (Jwt) used to identify the customer user. The app can decode the token to request information about the user who signed in. The app can cache the values and display them, and confidential clients can use this token for authorization. For more information about ID tokens, see [ID tokens](../../identity-platform/id-tokens.md).<br> **Note**: Only issued if *openid* scope was requested. |

#### Error response 

Example:

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{ 
    "error": "invalid_grant", 
    "error_description": "AADSTS901007: Error validating credentials due to invalid username or password.\r\nTrace ID: b386ad47-23ae-4092-...-1000000\r\nCorrelation ID: 72f57f26-...-3fa6\r\nTimestamp: yyyy-...",
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
| `invalid_request`  |  Request parameter validation failed. To understand what happened, use the message in the error description.   |  
|`invalid_grant`|The continuation token included in the request isn't valid or customer user sign in credentials included in the request are invalid or the grant type included in the request is unknown.  |
|`expired_token`|The continuation token included in the request is is expired. |
|`invalid_scope`| One or more of the scoped included in the request are invalid.|

## Self-service password reset (SSPR)

If you use email and password as the authentication method in your app, use the self-service password reset (SSPR) API enable customer users to reset their password. You use this API for forgot password or change password scenarios.

### Self-service password reset API endpoints

To use this API, the app interacts with the endpoint shown in the following table:

|    Endpoint     | Description        |
|----------------------|------------------------|
| `/start`  | Your app calls this endpoint when the customer user selects **Forgot password** or **Change password** link or button in the app. This endpoint validates the user's username (email), then returns a *continuation token* for use in the password reset flow. If your app requests to use authentication methods that are not supported by Microsoft Entra ID, this endpoint response can indicate to your app that it needs to use a browser-based authentication flow. |
|`/challenge`|  Accepts a list of challenge types supported by the client and the *continuation token*. A challenge is issued to one of the preferred recovery credentials. For example, oob challenge issues an out-of-band OTP code to the email associated with the customer user account. If your app requests to use authentication methods that are not supported by Microsoft Entra ID, this endpoint response can indicate to your app that it needs to use a browser-based authentication flow.    |
|`/continue`| Validates the challenge issued by the `/challenge` endpoint, then either returns a *continuation token* for the `/submit` endpoint, or issues another challenge to the user.  |
|`/submit`|  Accepts a new password input by the user along with the *continuation token* to complete the password reset flow. This endpoint issues another *continuation token*. |
|`/poll_completion`|  Finally, the app can use the *continuation token* issued by the `/submit` endpoint to check the status of the password reset request.    |

### Self-service password reset challenge types

|    Challenge type     | Description                                |
|-----------------------|--------------------------------------------|
| oob   | This challenge type indicates that the application supports the use of OTP codes sent to the user using a secondary channel. Currently, the API supports only email OTPs.|
| redirect  | This challenge type indicates that the application supports fallback to web-based authentication. All Native Auth compliant applications must support this authentication method. In every call the app makes, it must include this challenge type. If Microsoft Entra ID returns this challenge type as a response, then it indicates that the app needs to fallback to web-based authentication. In this case, we recommend that you use a [Microsoft-built and supported authentication library](../../identity-platform/reference-v2-libraries.md).|

### Self-service password reset flow protocol details

The sequence diagram demonstrates the flow for the password reset process.

:::image type="content" source="media/reference-native-auth-api/self-service-password-reset.png" alt-text="Diagram of native auth self-service password reset flow."::: 

This diagram indicates that the app collects username (email) and password from the user at different times (and possibly on separate screens). However, you can design your app to collect the username (email) and new password on the same screen. In this case, the app holds the password, then submits it via the `/submit` endpoint where it's required.

### Step 1: Request to start the self-service password reset flow

The password reset flow starts with the app making a POST request to the `/start` endpoint to start the self-service password reset flow.

Here's an example of the request (we present the example request in multiple lines for readability):

```http
POST /{tenant_subdomain}.onmicrosoft.com/resetpassword/v1.0/start HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded

client_id=111101-14a6-abcd-97bc-abcd1110011 
&challenge_type=oob redirect 
&username=contoso-consumer@contoso.com 
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
| `client_id`         |   Yes    | The Application (client) ID of the app you registered in the Microsoft Entra Admin center.                |
| `username`          |    Yes   |   Email of the customer user such as *contoso-consumer@contoso.com*.  |
| `challenge_type`    |   Yes  | A space-separated list of authorization [challenge type](#self-service-password-reset-challenge-types) strings that the app supports such as `oob password redirect`. The list must always include the `redirect` challenge type. For this request, the value is expected to contain `oob redirect`.|

#### Success response

Example:

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
| `continuation_token`  |  [continuation_token](#continuation-token) that Microsoft Entra ID returns. |

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

This response is considered successful, but the app is required to switch to a web-based authentication flow. In this case, we recommend that you use a [Microsoft-built and supported authentication library](../../identity-platform/reference-v2-libraries.md).

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
|`user_not_found`|The username doesn't exist.|
|`unsupported_challenge_type`|The `challenge_type` parameter value doesn't include the `redirect` challenge type.|

### Step 2: Select an authentication method

To continue with the flow, the app uses the continuation token acquired from the previous step to request Microsoft Entra ID to select one of the supported challenge types for the user to authenticate with. The app makes a POST request to the The `/challenge` endpoint. If this request is successful, Microsoft Entra ID sends an OTP code to the user's account email. At the moment, we only support email otp.

Here's an example (we present the example request in multiple lines for readability):

```http
POST /{tenant_subdomain}.onmicrosoft.com/resetpassword/v1.0/challenge HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded

client_id=client_id=111101-14a6-abcd-97bc-abcd1110011
&challenge_type=oob redirect
&continuation_token=uY29tL2F1dGhlbnRpY... 
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
| `client_id`         |   Yes    | The Application (client) ID of the app you registered in the Microsoft Entra Admin center.                |
| `continuation_token`          |    Yes   |   [continuation_token](#continuation-token) that Microsoft Entra ID returned in the previous request. |
| `challenge_type`    |   No  | A space-separated list of authorization [challenge type](#self-service-password-reset-challenge-types) strings that the app supports such as `oob redirect`. The list must always include the `redirect` challenge type. For this request, the value is expected to contain `oob redirect`.|

#### Success response

Example:

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
|`binding_method`|The only valid value is *prompt*. This parameter can be used in the future to offer additional ways to the user to enter the otp code. Issued if `challenge_type` is *oob*  |
|`challenge_channel`| The type of the channel through which the otp code was sent. At the moment, we support email. |
|`challenge_target_label` |An obfuscated email where the otp code was sent.|
|`code_length`|The length of the otp code that Microsoft Entra ID generates. |

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

This response is considered successful, but the app is required to switch to a web-based authentication flow. In this case, we recommend that you use a [Microsoft-built and supported authentication library](../../identity-platform/reference-v2-libraries.md).

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
|`expired_token`|The continuation token is expired.  |
|`unsupported_challenge_type`|The `challenge_type` parameter value doesn't include the `redirect` challenge type.|

### Step 3: Submit OTP code

The app then makes a POST request to the `/continue` endpoint. In the request, the app need to include the user’s credentials chosen in the previous step and the continuation token issued from the `/challenge` endpoint.

Here's an example of the request (we present the example request in multiple lines for readability):

```http
POST /{tenant_subdomain}.onmicrosoft.com/resetpassword/v1.0/continue HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded

continuation_token=uY29tL2F1dGhlbnRpY... 
&client_id=6731de76-14a6-49ae-97bc-6eba6914391e 
&grant_type=oob 
&oob={otp_code}
```

|    Parameter     | Required | Description        |
|----------------------|------------------------|------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
| `continuation_token`  | Yes | [continuation_token](#continuation-token) that Microsoft Entra ID returned in the previous request. |
|`client_id`| Yes | The Application (client) ID of the app you registered in the Microsoft Entra Admin center.|
|`grant_type` | Yes | The only valid value is oob.  |
|`oob`| Yes |The OTP code that the customer user received in their email. Replace `{otp_code}` with the OTP code that the customer user received in their email. To **resend an OTP code**, the app needs to make a request to the `/challenge` endpoint again. |

#### Success response

Example:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{ 
    "expires_in": 600,
    "continuation_token": "czZCaGRSa3F0MzpnW...",
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
|`expires_in`|Time in seconds before the *continuation_token* expires. The maximum value of `expires_in` is **600 seconds**. |
| `continuation_token`  |  [continuation_token](#continuation-token) that Microsoft Entra ID returns.  |

#### Error response

Example:

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{ 
    "error": "invalid_request", 
    "error_description": "AADSTS55200: The continuation_token is invalid.\r\nTrace ID: b386ad47-23ae-4092-...-1000000\r\nCorrelation ID: 72f57f26-...-3fa6\r\nTimestamp: yyyy-...",
    "error_codes": [ 
        55200 
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
| `invalid_request`  |  Request parameter validation failed such as a validation of *continuation token* failed.   |
|`invalid_grant` |The grant type is unknown or doesn't match the expected grant type value. |
|`expired_token`|The OTP code provided by the user or  *continuation token* is expired.    |
|`invalid_oob_value`|The OTP code provided by the user is invalid.|

### Step 4: Submit a new password

The app collects a new password from the user, then uses the *continuation token* issued by the `/continue` endpoint to submit the password by making a POST request to the `/submit` endpoint.

Here's an example (we present the example request in multiple lines for readability):

```http
POST /{tenant_subdomain}.onmicrosoft.com/resetpassword/v1.0/submit HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded

client_id=111101-14a6-abcd-97bc-abcd1110011
&continuation_token=czZCaGRSa3F0Mzp...
&new_password={new_password}
```

|    Parameter     | Required | Description        |
|----------------------|------------------------|------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
| `continuation_token`  |Yes |[continuation_token](#continuation-token) that Microsoft Entra ID returned in the previous request.  |
|`client_id`| Yes | The Application (client) ID of the app you registered in the Microsoft Entra Admin center.|
|`new_password` | Yes | User’s new password. Replace `{new_password}` with the user's new password. It's your responsibility to confirm that the user is aware of the password they want to use by providing the password confirm field in the app's UI. You must also ensure that the user is aware of what constitutes a strong password per your organization's policy. [Learn more about Microsoft Entra ID's password policies](../../identity/authentication/concept-password-ban-bad-combined-policy.md#azure-ad-password-policies). |

#### Success response

Example:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{
    "continuation_token": "uY29tL2F1dGhlbnRpY...",
    "poll_interval": 2
}  
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `continuation_token`  |  [continuation_token](#continuation-token) that Microsoft Entra ID returns.  |
|`poll_interval`|The minimum amount of time in seconds that the app should wait between polling requests to check the status of the password reset request via the `/poll_completion` endpoint, see [step 5](#step-5-poll-for-password-reset-status)  |

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
| `invalid_request`  |  Request parameter validation failed such as a validation of *continuation token* failed.   |
|`expired_token`|The *continuation token* is expired.    |
|`password_too_weak`|Password is too weak as it doesn't meet complexity requirements. [Learn more about Microsoft Entra ID's password policies](../../identity/authentication/concept-password-ban-bad-combined-policy.md#azure-ad-password-policies).|
|`password_too_short`|New password is less than 8 characters. [Learn more about Microsoft Entra ID's password policies](../../identity/authentication/concept-password-ban-bad-combined-policy.md#azure-ad-password-policies).|
|`password_too_long` |New password is longer than 256 characters. [Learn more about Microsoft Entra ID's password policies](../../identity/authentication/concept-password-ban-bad-combined-policy.md#azure-ad-password-policies). |
|`password_recently_used`|The new password must not be the same as one recently used. [Learn more about Microsoft Entra ID's password policies](../../identity/authentication/concept-password-ban-bad-combined-policy.md#azure-ad-password-policies).|
|`password_banned`|New password contains a word, phrase, or pattern that is banned. [Learn more about Microsoft Entra ID's password policies](../../identity/authentication/concept-password-ban-bad-combined-policy.md#azure-ad-password-policies).|

### Step 5: Poll for password reset status

Lastly, since updating of the user’s configuration with the new password incurs some delay, the app can use the `/poll_completion` endpoint to poll Microsoft Entra ID for password reset status. The minimum amount of time in seconds that the app should wait between polling requests is returned from the `/submit` endpoint in the `poll_interval` parameter.  

Here's an example (we present the example request in multiple lines for readability):

```http
POST /{tenant_subdomain}.onmicrosoft.com /resetpassword/v1.0/poll_completion HTTP/1.1
Host: {tenant_subdomain}.ciamlogin.com
Content-Type: application/x-www-form-urlencoded

client_id=111101-14a6-abcd-97bc-abcd1110011
&continuation_token=czZCaGRSa3F0... 
```

|    Parameter     | Required | Description        |
|----------------------|------------------------|------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the customer tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).|
| `continuation_token`  |Yes | [continuation_token](#continuation-token) that Microsoft Entra ID returned in the previous request. |
|`client_id`| Yes | The Application (client) ID of the app you registered in the Microsoft Entra Admin center.|

#### Success response

Example:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{
    "status": "succeeded" 
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `status`  | The status of the reset password request. If Microsoft Entra ID returns a status of **, the app can re-submit the new password by making another request to the `/submit` endpoint.|

Here are the possible statuses that Microsoft Entra ID returns (possible values of the `status` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `succeeded` |  Password reset completed successfully. |
| `failed` |Password reset failed. The app can re-submit the new password by making another request to the `/submit` endpoint.|
| `not_started` |Password reset hasn't started. The app can check the status again later. |
| `in_progress` |Password reset is in progress. The app can check the status again later.|

#### Error response

Example:

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{ 
    "error": "expired_token", 
    "error_description": "AADSTS901007: The continuation_token is expired.\r\nTrace ID: b386ad47-23ae-4092-...-1000000\r\nCorrelation ID: 72f57f26-...-3fa6\r\nTimestamp: yyyy-...",
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
| `invalid_request`  |  Request parameter validation failed such as validation of *continuation token* failed.   |
|`expired_token`|The *continuation token* is expired.    |

## Next steps

- [Native authentication email OTP API reference](reference-native-auth-email-otp.md).