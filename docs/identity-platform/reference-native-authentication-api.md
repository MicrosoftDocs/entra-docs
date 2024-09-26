---
title: Native authentication API reference documentation
description: Find out how to use native authentication APIs to authenticate users into your customer-facing apps with the external tenant.
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: entra-external-id 
ms.subservice: customers
ms.topic: reference
ms.date: 30/09/2024

#Customer intent: As an identity developer, I want to learn how to integrate customer-facing apps with native authentication API so that I can sign in customer users into external tenant.
---

# Native authentication API reference

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

Microsoft Entra's [native authentication](../external-id/customers/concept-native-authentication.md) enables you to host the user interface of your app in the client application instead of delegating authentication to browsers, resulting in a natively integrated authentication experience. As a developer, you have full control over the look and feel of the sign-in interface.

[!INCLUDE [native-auth-api-common-description](./includes/native-auth-api/native-auth-api-common-description.md)]

Microsoft Entra's native authentication API supports sign-up and sign-in for two authentication methods:

- Email with password, which supports sign-up and sign-in with an email and password, and self-service password reset (SSPR).

- Email one-time passcode, which supports sign-up and sign-in with email one-time passcode.

[!INCLUDE [native-auth-api-cors-note](./includes/native-auth-api/native-auth-api-cors-note.md)]

## Prerequisites

1. A Microsoft Entra external tenant. If you don't already have one, [create an external tenant](../external-id/customers/how-to-create-external-tenant-portal.md).

1. If you haven't already done so, [Register an application in the Microsoft Entra admin center](../external-id/customers/how-to-register-ciam-app.md?tabs=nativeauthentication#choose-your-app-type). Make sure you grant delegated permissions, and enable public client and native authentication flows.

1. If you haven't already done so, [Create a user flow in the Microsoft Entra admin center](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md#to-add-a-new-user-flow). When you create the user flow, take note of the user attributes you configure as required as these attributes are the ones that Microsoft Entra expects your app to submit.

1. [Associate your app registration with the user flow](../external-id/customers/how-to-user-flow-add-application.md).

1. For sign-in flow, [register a customer user](../external-id/customers/how-to-manage-customer-accounts.md#create-a-customer-account), which you use for test the sign-in APIs. Alternatively, you can get this test user after you run the sign-up flow.

1. For SSPR flow, [enable self-service password reset](../external-id/customers/how-to-enable-password-reset-customers.md) for customer users in the external tenant. SSPR is available for customer users who use email with password authentication method.  

## Continuation token

[!INCLUDE [entra-external-id-continuation-token](./includes/native-auth-api/continuation-token.md)]

## Sign-up API reference

To complete a user sign-up flow for either authentication method, your app interacts with four endpoints, `/signup/v1.0/start`, `/signup/v1.0/challenge`,  `/signup/v1.0/continue`, and `/token`.

### Sign-up API endpoints

|    Endpoint           | Description                                |
|-----------------------|--------------------------------------------|
| `/signup/v1.0/start`  | This endpoint starts the sign-up flow. You pass valid application ID, new username, and [challenge type](#sign-up-challenge-types), then you get back a new continuation token. The endpoint can return a response to indicate to the application to use a web authentication flow if the application’s chosen authentication methods aren't supported by Microsoft Entra.|
|   `/signup/v1.0/challenge`   | Your app calls this endpoint with a list of [challenge types](#sign-up-challenge-types) supported by Microsoft Entra. Microsoft Entra then selects one of the supported authentication methods for the user to authenticate with. |
|  `/signup/v1.0/continue`  | This endpoint helps to continue the flow to create the user account or interrupt the flow due to missing requirements such as password policy requirements or wrong attribute formats. This endpoint generates a continuation token, then returns it to the app. The endpoint can return a response to indicate to the application to use a web-based authentication flow if the application doesn't an authentication method chosen by  Microsoft Entra.|
|`/token`| The application calls this endpoint to finally request for security tokens. The app needs to include the continuation token it acquires from the last successful call to the `/signup/v1.0/continue` endpoint.|

### Sign-up challenge types

The API allows the client app to advertise the authentication methods it supports, when it makes a call to Microsoft Entra. To do so, the app uses the `challenge_type` parameter in the app's request. This parameter holds predefined values, which represent different authentication methods.

Learn more about challenge types in the [native authentication challenge types](../external-id/customers/concept-native-authentication-challenge-types.md). This article explains the challenge type values you should for an authentication method.

### Sign-up flow protocol details

The sequence diagram demonstrates the flow of the sign-up process.

:::image type="content" source="media/reference-native-auth-api/sign-up-email-with-password.png" alt-text="Diagram of native authentication sign-up flow."::: 

This diagram indicates that the app collects username (email), password (for email with password authentication methods), and attributes from the user at different times (and possibly on separate screens). However, you can design your app to collect the username (email), password and all the required, and optional attribute values in the same screen, then submit all of them via the `/signup/v1.0/start` endpoint. In this case, the app doesn't need to make calls and handle responses for the optional steps.

### Step 1: Request to start the sign-up flow

The sign-up flow begins with the application making a POST request to the `/signup/v1.0/start` endpoint to start the sign-up flow.

Here are examples of the request(we present the example request in multiple lines for readability):

Example 1:

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/signup/v1.0/start
Content-Type: application/x-www-form-urlencoded

client_id=00001111-aaaa-2222-bbbb-3333cccc4444
&challenge_type=oob password redirect
&username=contoso-consumer@contoso.com 
```

Example 2 (include user attributes and password in the request):

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/signup/v1.0/start
Content-Type: application/x-www-form-urlencoded

client_id=00001111-aaaa-2222-bbbb-3333cccc4444
&challenge_type=oob password redirect
&password={secure_password}
&attributes={"displayName": "{given_name}", "extension_2588abcdwhtfeehjjeeqwertc_age": "{user_age}", "postalCode": "{user_postal_code}"}
&username=contoso-consumer@contoso.com 
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
| `client_id`         |   Yes    | The Application (client) ID of the app you registered in the Microsoft Entra admin center.                |
| `username`          |    Yes   | Email of the customer user that they want to sign up with, such as *contoso-consumer@contoso.com*.  |
| `challenge_type`    |   Yes  | A space-separated list of authorization challenge type strings that the app supports such as `oob password redirect`. The list must always include the `redirect` challenge type. The value is expected to `oob redirect` or `oob password redirect` for email with password authentication method.|
|`password`| No | The password value that the app collects from the customer user. You can submit a user's password via the  `/signup/v1.0/start` or later in the `/signup/v1.0/continue` endpoint. Replace `{secure_password}` with the password value that the app collects from the customer user. It's your responsibility to confirm that the user is aware of the password they want to use by providing the password confirm field in the app's UI. You must also ensure that the user is aware of what constitutes a strong password per your organization's policy. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md). <br> **This parameter is only applicable for email with password authentication method**.|
|`attributes`| No | The user attributes values that the app collects from the customer user. The value is a string, but formatted as a JSON object whose key values are [programmable name](../external-id/customers/concept-user-attributes.md#built-in-user-attributes) of user attributes. These attributes can be built in or custom, and required or optional. The key names of the object depend on the attributes that the administrator configured in Microsoft Entra admin center. You can submit some or all user attributes via the `/signup/v1.0/start` endpoint or later in the `/signup/v1.0/continue` endpoint. If you submit all the required attributes via the `/signup/v1.0/start` endpoint, you don't need to submit any attributes in the `/signup/v1.0/continue` endpoint. However, if you submit some required attributes via `/signup/v1.0/start` endpoint, you can submit the remaining required attributes later in the `/signup/v1.0/continue` endpoint. Replace `{given_name}`, `{user_age}` and `{postal_code}` with the name, age and postal code values respectively that the app collects from the customer user. **Microsoft Entra ignores any attributes that you submit, which don't exist**.|

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
|`continuation_token`| [Continuation token](#continuation-token) that Microsoft Entra returns.|

If an app can't support a required authentication method by Microsoft Entra, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra informs the app by returning a *redirect* challenge type in its response:

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
| `challenge_type`  | Microsoft Entra returns a response that has a challenge type. The value of this challenge type is redirect, which enables the app to use the web-based authentication flow.  |

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
    "error_description": "AADSTS1003037: It looks like you may already have an account.... .\r\nTrace ID: 0000aaaa-11bb-cccc-dd22-eeeeee333333\r\nCorrelation ID: aaaa0000-bb11-2222-33cc-444444dddddd\r\nTimestamp: yyyy-...", 
    "error_codes": [ 
        1003037 
    ],
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "0000aaaa-11bb-cccc-dd22-eeeeee333333", 
    "correlation_id": "aaaa0000-bb11-2222-33cc-444444dddddd"
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
|`error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |
|`invalid_attributes`   |  A list (array of objects) of attributes that failed validation. This response is possible if the app submits user attributes, and the `suberror` parameter's value is *attribute_validation_failed*.    |
|`suberror` | An error code string that can be used to further classify types of errors.|

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
|`invalid_request`  |Request parameter validation failed such as when the challenge_type parameter value contains an unsupported authentication method or the request didn't include `client_id` parameter the client ID value is empty or invalid. Use the `error_description` parameter to learn the exact cause of the error.|
|`invalid_client`| The client ID that the app includes in the request is for an app that lacks native authentication configuration, such as it isn't a public client or isn't enabled for native authentication. Use the `suberror` parameter to learn the exact cause of the error.|
|`unauthorized_client`| The client ID used in the request has a valid client ID format, but doesn't exist in the external tenant or is incorrect. |
|`unsupported_challenge_type`|The `challenge_type` parameter value doesn't include the `redirect` challenge type.| 
|`user_already_exists` |  User already exists.  |
|`invalid_grant`| The password that the app submits doesn't meet all the complexity requirements, such as the password is too short. Use the `suberror` parameter to learn the exact cause of the error. <br> **This parameter is only applicable for email with password authentication method**.|

If the error parameter has a value of *invalid_grant*, Microsoft Entra includes a `suberror` parameter in its response. Here are the possible values of the `suberror` parameter for an *invalid_grant* error:

|    Suberror value     | Description        |
|----------------------|------------------------|
|`password_too_weak`|Password is too weak as it doesn't meet complexity requirements. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md). This response is possible if the app submits a user password.|
|`password_too_short`|New password is fewer than 8 characters. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md). This response is possible if the app submits a user password.|
|`password_too_long` |New password is longer than 256 characters. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md). This response is possible if the app submits a user password.|
|`password_recently_used`|The new password must not be the same as one recently used. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md). This response is possible if the app submits a user password.|
|`password_banned`|New password contains a word, phrase, or pattern that is banned. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md). This response is possible if the app submits a user password.|
|`password_is_invalid`| Password is invalid, for example because it uses disallowed characters. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md). This response is possible if the app submits a user password.|


If the error parameter has a value of *invalid_client*, Microsoft Entra includes a `suberror` parameter in its response. Here are the possible values of the `suberror` parameter for an *invalid_client* error:

|    Suberror value     | Description        |
|----------------------|------------------------|
|`nativeauthapi_disabled`| The client ID for an app that isn't enable for native authentication.|

> [!NOTE]
> If you submit all the required attributes via `/signup/v1.0/start` endpoint, but not all optional attributes, you won't be able to submit any additional optional attributes later via the  `/signup/v1.0/continue` endpoint. Microsoft Entra doesn't explicitly request for optional attributes as they aren't mandatory for the sign-up flow to complete. See the table in the [Submitting user attributes to endpoints](#submitting-user-attributes-to-endpoints) section to learn the user attributes you can submit to the `/signup/v1.0/start` and `/signup/v1.0/continue` endpoints. 

### Step 2: Select an authentication method

The app requests Microsoft Entra to select one of the supported challenge types for the user to authenticate with. To do so, the app makes a call to the `/signup/v1.0/challenge` endpoint. The app needs to include the continuation token that it acquires from the `/signup/v1.0/start` endpoint in the request.

Here's an example of the request(we present the example request in multiple lines for readability).

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/signup/v1.0/challenge
Content-Type: application/x-www-form-urlencoded

client_id=00001111-aaaa-2222-bbbb-3333cccc4444
&challenge_type=oob password redirect
&continuation_token=AQABAAEAAA…
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
| `client_id`         |   Yes    | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|
| `challenge_type`    |   No  | A space-separated list of authorization [challenge type](#sign-in-challenge-types) strings that the app supports such as `oob password redirect`. The list must always include the `redirect` challenge type. The value is expected to `oob redirect` for email one-time passcode and `oob password redirect` for email with password authentication method.|
|`continuation_token`| Yes |[Continuation token](#continuation-token) that Microsoft Entra returned in the previous request.|

#### Success response

Microsoft Entra sends a one-time passcode to the user's email, then responds with the challenge type with value of *oob* and additional information about the one-time passcode:

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
| `continuation_token`  | [Continuation token](#continuation-token) that Microsoft Entra returns. |
|`challenge_type`| Challenge type selected for the user to authenticate with.|
|`binding_method`|The only valid value is *prompt*. This parameter can be used in the future to offer more ways to the user to enter the one-time passcode. Issued if `challenge_type` is *oob*  |
|`challenge_channel`| The type of the channel through which the one-time passcode was sent. At the moment, only email channel is supported. |
|`challenge_target_label` |An obfuscated email where the one-time passcode was sent.|
|`code_length`|The length of the one-time passcode that Microsoft Entra generates. |


If an app can't support a required authentication method by Microsoft Entra, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra informs the app by returning a *redirect* challenge type in its response:

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
| `challenge_type`  | Microsoft Entra returns a response that has a challenge type. The value of this challenge type is redirect, which enables the app to use the web-based authentication flow.  |  

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
    "error_description": "AADSTS901007: The challenge_type list parameter does not include the 'redirect' type.\r\nTrace ID: 0000aaaa-11bb-cccc-dd22-eeeeee333333\r\nCorrelation ID: aaaa0000-bb11-2222-33cc-444444dddddd\r\nTimestamp: yyyy-...",
    "error_codes": [ 
        901007 
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "0000aaaa-11bb-cccc-dd22-eeeeee333333", 
    "correlation_id": "aaaa0000-bb11-2222-33cc-444444dddddd"
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as client ID is empty or invalid.   |
|`expired_token`|The continuation token is expired. |
|`unsupported_challenge_type`|The `challenge_type` parameter value doesn't include the `redirect` challenge type.|
|`invalid_grant` | The continuation token is invalid. |

### Step 3: Submit one-time passcode

The app submits the  one-time passcode sent to the user's email. Since we're submitting one-time passcode, an `oob` parameter is required, and the `grant_type` parameter must have a value *oob*.

Here's an example of the request(we present the example request in multiple lines for readability):

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/signup/v1.0/continue
Content-Type: application/x-www-form-urlencoded

continuation_token=uY29tL2F1dGhlbnRpY...
&client_id=00001111-aaaa-2222-bbbb-3333cccc4444 
&grant_type=oob 
&oob={otp_code}
```

|    Parameter     | Required | Description        |
|----------------------|------------------------|------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
| `continuation_token`  | Yes |[Continuation token](#continuation-token) that Microsoft Entra returned in the previous request.|
|`client_id`| Yes | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|
|`grant_type` | Yes | A request to the  `/signup/v1.0/continue` endpoint can be used to submit one-time passcode, password, or user attributes. In this case, the `grant_type` value is used to differentiate between these three use cases. The possible values for the grant_type are *oob*, *password*, *attributes*. In this call, since we're sending one-time passcode, the value is expected to be *oob*.|
|`oob`| Yes | The one-time passcode that the customer user received in their email. Replace `{otp_code}` with the one-time passcode values that the customer user received in their email. To **resend a one-time passcode**, the app needs to make a request to the `/signup/v1.0/challenge` endpoint again.|


Once the app successfully submits the one-time passcode, the sign-up flow depends on the scenarios as shown the table:

|    Scenario          | How to proceed |
|----------------------|------------------------|
|The app successfully submits the user's password (for email with password authentication method) via the `/signup/v1.0/start` endpoint, and no attributes are configured in Microsoft Entra admin center or all the required user attributes are submitted via the `/signup/v1.0/start` endpoint. |Microsoft Entra issues a continuation token. The app can use the continuation token to request for security tokens as shown in [step 5](#step-5-request-for-security-tokens).|
|The app successfully submits the user's password(for email with password authentication method) via the `/signup/v1.0/start`, but not all the required user attributes, Microsoft Entra indicates the attributes that the app needs to submit as shown in [user attributes required](#user-attributes-required). | The app needs to submit the required user attributes via the `/signup/v1.0/continue` endpoint. The response is similar to the one in [User attributes required](#user-attributes-required). Submit the user attributes a shown in [submit user attributes](#submit-user-attributes).|
|The app doesn't submit the user's password (for email with password authentication method) via `/signup/v1.0/start` endpoint.| Microsoft Entra's response indicates that credential is required. See [response](#response). <br> **This response is possible for email with password authentication method**.|

#### Response

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
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |
|`continuation_token`| [Continuation token](#continuation-token) that Microsoft Entra returns. |
|`suberror` | An error code string that can be used to further classify types of errors.|

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
|`credential_required`|Authentication is required for account creation, so you have to make a call to the `/signup/v1.0/challenge` endpoint to determine the credential the user is required to provide.|
|`invalid_request`  | Request parameter validation failed such as a validation of *continuation token* failed or the request didn't include `client_id` parameter the client ID value is empty or invalid or the external tenant administrator hasn't enabled email OTP for all tenant users.   |  
|`invalid_grant`|The grant type included in the request isn't valid or supported, or OTP value is incorrect.|
|`expired_token`|The continuation token included in the request is expired. |

If the error parameter has a value of *invalid_grant*, Microsoft Entra includes a `suberror` parameter in its response. Here are the possible values of the `suberror` parameter for an *invalid_grant* error:

|    Suberror value     | Description        |
|----------------------|------------------------|
|`invalid_oob_value`| The value of one-time passcode is invalid.|

For the password credential to be collected from the user, the app needs to make a call to the `/signup/v1.0/challenge` endpoint to determine the credential the user is required to provide.

Here's an example of the request(we present the example request in multiple lines for readability):

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/signup/v1.0/challenge
Content-Type: application/x-www-form-urlencoded

client_id=00001111-aaaa-2222-bbbb-3333cccc4444
&challenge_type=oob password redirect
&continuation_token=AQABAAEAAA…
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
| `client_id`         |   Yes    | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|
| `challenge_type`    |   No  | A space-separated list of authorization [challenge type](#sign-up-challenge-types) strings that the app supports such as `oob password redirect`. The list must always include the `redirect` challenge type. For the email with password sign-up flow, the value is expected to contain `password redirect`.|
|`continuation_token`| Yes |[Continuation token](#continuation-token) that Microsoft Entra returned in the previous request.|

#### Success response

If password is the authentication method configured for the user in the Microsoft Entra admin center, a success response with the continuation token is returned to the app.

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
|`continuation_token`| [Continuation token](#continuation-token) that Microsoft Entra returns.   |

If an app can't support a required authentication method by Microsoft Entra, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra informs the app by returning a *redirect* challenge type in its response:

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
| `challenge_type`  | Microsoft Entra returns a response that has a challenge type. The value of this challenge type is redirect, which enables the app to use the web-based authentication flow.  |  

This response is considered successful, but the app is required to switch to a web-based authentication flow. In this case, we recommend that you use a [Microsoft-built and supported authentication library](reference-v2-libraries.md).

### Step 4: Authenticate and get token to sign up

The app needs to submit the user's credential, in this case password, that Microsoft Entra requested in the previous step. The app needs to submit a password credential if it didn't do so via the `/signup/v1.0/start` endpoint. The app makes a request to the `/signup/v1.0/continue` endpoint to submit the password. Since we're submitting a password, a `password` parameter is required, and the `grant_type` parameter must have a value *password*.

Here's an example of the request(we present the example request in multiple lines for readability):

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/signup/v1.0/continue
Content-Type: application/x-www-form-urlencoded

continuation_token=uY29tL2F1dGhlbnRpY...
&client_id=00001111-aaaa-2222-bbbb-3333cccc4444 
&grant_type=password 
&password={secure_password}
```

|    Parameter     | Required | Description        |
|----------------------|------------------------|------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
| `continuation_token`  | Yes |[Continuation token](#continuation-token) that Microsoft Entra returned in the previous step.|
|`client_id`| Yes | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|
|`grant_type` | Yes | A request to the `/signup/v1.0/continue` endpoint can be used to submit one-time passcode, password, or user attributes. In this case, the `grant_type` value is used to differentiate between these three use cases. The possible values for the grant_type are *oob*, *password*, *attributes*. In this call, since we're sending user's password, the value is expected to be *password*.|
|`password`| Yes | The password value that the app collects from the customer user. Replace `{secure_password}` with the password value that the app collects from the customer user. It's your responsibility to confirm that the user is aware of the password they want to use by providing the password confirm field in the app's UI. You must also ensure that the user is aware of what constitutes a strong password per your organization's policy. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md).|

#### Success response

If the request is successful, but no attributes were configured in Microsoft Entra admin center or all the required attributes were submitted via the `/signup/v1.0/start` endpoint, the app gets a continuation token without submitting any attributes. The app can use the continuation token to request for security tokens as shown in [step 5](#step-5-request-for-security-tokens). Otherwise, Microsoft Entra's response indicates that the app needs to submit required attributes. These attributes, built in or custom, were configured in the Microsoft Entra admin center by the tenant administrator.

##### User attributes required

This response requests the app to submit values for *name*, *age, and *phone* attributes.

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
    "continuation_token": "AQABAAEAAAAtn...",
    "required_attributes": [
        {
            "name": "displayName",
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
            "name": "postalCode",
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
| `error`  | This attribute is set if Microsoft Entra can't create the user account because an attribute needs to be verified or submitted.  |  
|`error_description` | A specific error message that can help you to identify the cause of the error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |
|`continuation_token`| [Continuation token](#continuation-token) that Microsoft Entra returns.  |
|`required_attributes`|A list (array of objects) of attributes that the app needs to submit next call to continue. These attributes are the extra attributes that app needs to submit apart from the username. Microsoft Entra includes this parameter is the response if the value of `error` parameter is *attributes_required*.|

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  | Request parameter validation failed such as a validation of *continuation token* failed or the request didn't include `client_id` parameter the client ID value is empty or invalid.|  
|`invalid_grant`| The grant type included in the request isn't valid or supported. The possible values for the `grant_type` are *oob*, *password*, *attributes* |
|`expired_token`| The continuation token included in the request is expired. |
|`attributes_required`  |  One or more of user attributes is required.   |

If an app can't support a required authentication method by Microsoft Entra, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra informs the app by returning a *redirect* challenge type in its response:

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
| `challenge_type`  | Microsoft Entra returns a response that has a challenge type. The value of this challenge type is redirect, which enables the app to use the web-based authentication flow.  |  

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
    "error_description": "New password is too weak",
    "error_codes": [
        399246
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "0000aaaa-11bb-cccc-dd22-eeeeee333333", 
    "correlation_id": "aaaa0000-bb11-2222-33cc-444444dddddd",
    "suberror": "password_too_weak"
}
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |
|`suberror` | An error code string that can be used to further classify types of errors.|

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as when the `challenge_type` parameter includes an invalid challenge type.   |  
|`invalid_grant`| The grant submitted is invalid, such as the password submitted is too short. Use the `suberror` parameter to learn the exact cause of the error.|
|`expired_token`|The continuation token is expired. |
|`attributes_required`  |  One or more of user attributes is required.   |


If the error parameter has a value of *invalid_grant*, Microsoft Entra includes a `suberror` parameter in its response. Here are the possible values of the `suberror` parameter:

|    Suberror value     | Description        |
|----------------------|------------------------|
|`password_too_weak`|Password is too weak as it doesn't meet complexity requirements. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md).|
|`password_too_short`|New password is fewer than 8 characters. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md).|
|`password_too_long` |New password is longer than 256 characters. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md). |
|`password_recently_used`|The new password must not be the same as one recently used. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md).|
|`password_banned`|New password contains a word, phrase, or pattern that is banned. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md).|
|`password_is_invalid`| Password is invalid, for example because it uses disallowed characters. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md). This response is possible if the app submits a user password.|

#### Submit user attributes

To continue with the flow, the app needs to make a call to the `/signup/v1.0/continue` endpoint to submit the required user attributes. Since we're submitting attributes, an `attributes` parameter is required, and the `grant_type` parameter must have a value equal to *attributes*.

Here's an example of the request(we present the example request in multiple lines for readability):

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/signup/v1.0/continue
Content-Type: application/x-www-form-urlencoded

&client_id=00001111-aaaa-2222-bbbb-3333cccc4444 
&grant_type=attributes 
&attributes={"displayName": "{given_name}", "extension_2588abcdwhtfeehjjeeqwertc_age": "{user_age}", "postaCode": "{postal_code}"}
&continuation_token=AQABAAEAAAAtn...
```

|    Parameter     | Required | Description        |
|----------------------|------------------------|------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
| `continuation_token`  | Yes |[Continuation token](#continuation-token) that Microsoft Entra returned in the previous request.  |
|`client_id`| Yes | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|
|`grant_type` | Yes | A request to the `/signup/v1.0/continue` endpoint can be used to submit one-time passcode, password, or user attributes. In this case, the `grant_type` value is used to differentiate between these three use cases. The possible values for the grant_type are *oob*, *password*, *attributes*. In this call, since we're sending user attributes, the value is expected to be *attributes*.|
|`attributes`| Yes | The user attribute values that the app collects from the customer user. The value is a string, but formatted as a JSON object whose key values are names of user attributes, built in or custom. The key names of the object depend on the attributes that the administrator configured in Microsoft Entra admin center. Replace `{given_name}`, `{user_age}` and `{postal_code}` with the name, age and postal code values respectively that the app collects from the customer user. **Microsoft Entra ignores any attributes that you submit, which don't exist**.|

#### Success response

If the request is successful, Microsoft Entra issues a continuation token, which the app can use to request for security tokens.

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
| `continuation_token`  | [Continuation token](#continuation-token) that Microsoft Entra returns.|  

If an app can't support a required authentication method by Microsoft Entra, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra informs the app by returning a *redirect* challenge type in its response:

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
| `challenge_type`  | Microsoft Entra returns a response that has a challenge type. The value of this challenge type is redirect, which enables the app to use the web-based authentication flow.  |  

This response is considered successful, but the app is required to switch to a web-based authentication flow. In this case, we recommend that you use a [Microsoft-built and supported authentication library](reference-v2-libraries.md).

#### Error response

Example:

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{
    "error": "expired_token",
    "error_description": "AADSTS901007: The continuation_token is expired.  .\r\nTrace ID: 0000aaaa-11bb-cccc-dd22-eeeeee333333\r\nCorrelation ID: aaaa0000-bb11-2222-33cc-444444dddddd\r\nTimestamp: yyyy-...", 
    "error_codes": [
        552003
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "0000aaaa-11bb-cccc-dd22-eeeeee333333", 
    "correlation_id": "aaaa0000-bb11-2222-33cc-444444dddddd" 
}
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |
|`continuation_token`| [Continuation token](#continuation-token) that Microsoft Entra returns.  |
| `unverified_attributes`  |  A list (array of objects) of attribute key names that must be verified. This parameter is included in the response when the `error` parameter's value is *verification_required*.|
|`required_attributes`| A list (array of objects) of attributes that the app needs to submit. Microsoft Entra includes this parameter in its response when the `error` parameter's value is *attributes_required*.|
| `invalid_attributes`   |  A list (array of objects) of attributes that failed validation. This parameter is included in the response when the `suberror` parameter's value is *attribute_validation_failed*.    |
|`suberror` | An error code string that can be used to further classify types of errors.|

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |Request parameter validation failed such as a validation of *continuation token* failed or the request didn't include `client_id` parameter the client ID value is empty or invalid.|
|`invalid_grant`|The grant type provided isn't valid or supported or failed validation, such as attributes validation failed. Use the `suberror` parameter to learn the exact cause of the error.| 
|`expired_token`|The continuation token included in the request is expired.|
|`attributes_required`  |  One or more of user attributes is required.   |


If the error parameter has a value of *invalid_grant*, Microsoft Entra includes a `suberror` parameter in its response. Here are the possible values of the `suberror` parameter for an *invalid_grant* error:

|    Suberror value     | Description        |
|----------------------|------------------------|
|`attribute_validation_failed`| User attribute validation failed. `invalid_attributes` parameter contains the list (array of objects) of attributes that failed validation.|


### Step 5: Request for security tokens

The app makes a POST request to the `/token` endpoint and provides the continuation token obtained from the previous step to acquire security tokens.

Here's an example of the request (we present the example request in multiple lines for readability):

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/oauth2/v2.0/token
Content-Type: application/x-www-form-urlencoded
 
continuation_token=ABAAEAAAAtyo... 
&client_id=00001111-aaaa-2222-bbbb-3333cccc4444 
&username=contoso-consumer@contoso.com
&scope={scopes}
&grant_type=continuation_token 
```

|    Parameter     | Required | Description        |
|----------------------|------------------------|------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
|`client_id`| Yes | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|
|`grant_type` | Yes | The parameter value must be *continuation token*. |
|`continuation_token`|Yes    |[Continuation token](#continuation-token) that Microsoft Entra returned in the previous step. |
|`scope`| Yes | A space-separated list of scopes that the access token is valid for. Replace `{scopes}` with the valid scopes that the access token Microsoft Entra returns is valid for.|
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
|`token_type` |  Indicates the token type value. The only type that Microsoft Entra supports is *Bearer*.|
|`expires_in`|   The length of time in seconds the access token remains valid.|
|`scopes`|  A space-separated list of scopes that the access token is valid for.|
|`refresh_token` |  An OAuth 2.0 refresh token. The app can use this token to acquire other access tokens after the current access token expires. Refresh tokens are long-lived. They can maintain access to resources for extended periods. For more detail on refreshing an access token, refer to [Refresh the access token](v2-oauth2-auth-code-flow.md#refresh-the-access-token) article. <br> **Note**: Only issued if *offline_access* scope was requested.   |
|`id_token`|  A JSON Web Token (Jwt) used to identify the customer user. The app can decode the token to read information about the user who signed in. The app can cache the values and display them, and confidential clients can use this token for authorization. For more information about ID tokens, see [ID tokens](id-tokens.md).<br> **Note**: Only issued if *openid* scope is requested. |

#### Error response

Example:

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{ 
    "error": "invalid_request", 
    "error_description": "AADSTS901007: The client doesn't have consent for the requested scopes.\r\nTrace ID: 0000aaaa-11bb-cccc-dd22-eeeeee333333\r\nCorrelation ID: aaaa0000-bb11-2222-33cc-444444dddddd\r\nTimestamp: yyyy-...",
    "error_codes": [ 
        50126 
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "0000aaaa-11bb-cccc-dd22-eeeeee333333", 
    "correlation_id": "aaaa0000-bb11-2222-33cc-444444dddddd"
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
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

## Submitting user attributes to endpoints

[!INCLUDE [submit-user-attributes-to-endpoints](./includes/native-auth-api/submit-user-attributes-to-endpoints.md)]

## Format of user attributes values

[!INCLUDE [native-auth-api-cors-note](./includes/native-auth-api/user-attribute-format.md)]

## Sign-in API reference

Users need to sign in with the authentication method that they use sign up. For example, users who sign up using email with password authentication method must sign in email and password.

To request for security tokens, your app interacts with three endpoints, `/initiate`, `/challenge` and `/token`.

### Sign-in API endpoints

|    Endpoint           | Description                                |
|-----------------------|--------------------------------------------|
| `/initiate`  | This endpoint initiates the sign-in flow. If your app calls it with a username of a user account that already exists, it returns a success response with a continuation token. If your app requests to use authentication methods that aren't supported by Microsoft Entra, this endpoint response can indicate to your app that it needs to use a browser-based authentication flow.|
|   `/challenge`   | your app calls this endpoint with a list of [challenge types](#sign-in-challenge-types) supported by the identity service. Our identity service generates, then sends a one-time passcode to the chosen challenge channel such as email. If your app calls this endpoint repeatedly, a new OTP is sent each time a call is made.|
|  `/token`  | This endpoint verifies the one-time passcode it receives from your app, then it issues security tokens to your app.|

### Sign-in challenge types

The API allows the app to advertise the authentication methods it supports, when it makes a call to Microsoft Entra. To do so, the app uses the `challenge_type` parameter in its requests. This parameter holds predefined values, which represent different authentication methods.

For a given authentication method, the challenge type values an app sends to Microsoft Entra during sign-up flow are same to when the app signs in. For example, the email with password authentication method uses *oob*, *password* and *redirect* challenge type values for both sign-up and sign-in flows.  

Learn more about challenge types in the [native authentication challenge types](../external-id/customers/concept-native-authentication-challenge-types.md) article.

### Sign-in flow protocol details

The sequence diagram demonstrates the flow of the sign in process.

# [Email one-time passcode](#tab/emailOtp)

:::image type="content" source="media/reference-native-auth-api/sign-in-email-otp.png" alt-text="Diagram of native authentication sign-in with email one-time passcode."::: 

After the app verifies the user's email with OTP, it receives security tokens. If the delivery of the one-time passcode delays or is never delivered to the user's email, the user can request to be sent another one-time passcode. Microsoft Entra resends another one-time passcode if the previous one hasn't been verified. When Microsoft Entra resends a one-time passcode, it invalidates the previously sent code.

# [Email with password](#tab/emailPassword)

:::image type="content" source="media/reference-native-auth-api/sign-in-email-with-password.png" alt-text="Diagram of native auth sign in with email and password option."::: 

This diagram indicates that the app collects username (email) and password from the user at different times (and possibly on separate screens). However, you can design your app to collect the two values in the same screen. If you collect the username (email) and password in the same screen, steps **two** and **three** gets merged with steps **eight** and **nine**. In this case, the app holds the password, then submits it in step **ten** where it's required.

---

In the sections that follow, we summarize the sequence diagram flow into three basic steps.

### Step 1: Request to start the sign-in flow

The authentication flow begins with the application making a POST request to the `/initiate` endpoint to start the sign-in flow.

Here's an example of the request(we present the example request in multiple lines for readability):

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/oauth2/v2.0/initiate
Content-Type: application/x-www-form-urlencoded

client_id=00001111-aaaa-2222-bbbb-3333cccc4444
&challenge_type=password redirect
&username=contoso-consumer@contoso.com 
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
| `client_id`         |   Yes    | The Application (client) ID of the app you registered in the Microsoft Entra admin center.                |
| `username`          |    Yes   |   Email of the customer user such as *contoso-consumer@contoso.com*.  |
| `challenge_type`    |   Yes  | A space-separated list of authorization [challenge type](#sign-in-challenge-types) strings that the app supports such as `oob password redirect`. The list must always include the `redirect` challenge type. The value is expected to `oob redirect` for email one-time passcode and `password redirect` for email with password.|

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
| `continuation_token`  | [Continuation token](#continuation-token) that Microsoft Entra returns. |  

If an app can't support a required authentication method by Microsoft Entra, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra informs the app by returning a *redirect* challenge type in its response:

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
| `challenge_type`  | Microsoft Entra returns a response that has a challenge type. The value of this challenge type is redirect, which enables the app to use the web-based authentication flow.  |  

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
    "error_description": "AADSTS901007: The challenge_type list parameter does not include the 'redirect' type.\r\nTrace ID: 0000aaaa-11bb-cccc-dd22-eeeeee333333\r\nCorrelation ID: aaaa0000-bb11-2222-33cc-444444dddddd\r\nTimestamp: yyyy-...",
    "error_codes": [ 
        901007 
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "0000aaaa-11bb-cccc-dd22-eeeeee333333", 
    "correlation_id": "aaaa0000-bb11-2222-33cc-444444dddddd"
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as when the `challenge_type` parameter includes an invalid challenge type. or the request didn't include `client_id` parameter the client ID value is empty or invalid. Use the `error_description` parameter to learn the exact cause of the error.|  
|`unauthorized_client`| The client ID used in the request has a valid client ID format, but doesn't exist in the external tenant or is incorrect. |
|`invalid_client`| The client ID that the app includes in the request is for an app that lacks native authentication configuration, such as it isn't a public client or isn't enabled for native authentication. Use the `suberror` parameter to learn the exact cause of the error.|
|`user_not_found`|The username doesn't exist.|
|`unsupported_challenge_type`|The `challenge_type` parameter value doesn't include the `redirect` challenge type.|

If the error parameter has a value of *invalid_client*, Microsoft Entra includes a `suberror` parameter in its response. Here are the possible values of the `suberror` parameter for an *invalid_client* error:

|    Suberror value     | Description        |
|----------------------|------------------------|
|`nativeauthapi_disabled`| The client ID for an app that isn't enable for native authentication.|

### Step 2: Select an authentication method

To continue with the flow, the app uses the continuation token it acquires from the previous step to request Microsoft Entra to select one of the supported challenge types for the user to authenticate with. The app makes a POST request to the `/challenge` endpoint.

Here's an example of the request (we present the example request in multiple lines for readability):

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/oauth2/v2.0/challenge
Content-Type: application/x-www-form-urlencoded

client_id=00001111-aaaa-2222-bbbb-3333cccc4444
&challenge_type=password redirect 
&continuation_token=uY29tL2F1dGhlbnRpY... 
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
| `client_id`       |   Yes   | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|
| `continuation_token` |    Yes   | [Continuation token](#continuation-token) that Microsoft Entra returned in the previous request. |
| `challenge_type`    |   No  | A space-separated list of authorization [challenge type](#sign-in-challenge-types) strings that the app supports such as `oob password redirect`. The list must always include the `redirect` challenge type. The value is expected to `oob redirect` for email one-time passcode and `password redirect` for email with password.|

#### Success response
# [Email one-time passcode](#tab/emailOtp)
If the tenant administrator configured email one-time passcode in the Microsoft Entra admin center as the user’s authentication method, Microsoft Entra sends a one-time passcode to the user’s email, then responds with a challenge type of *oob* and provides more information about the one-time passcode.

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
| `continuation_token`  | [Continuation token](#continuation-token) that Microsoft Entra returns. |
|`challenge_type`| Challenge type selected for the user to authenticate with.|
|`binding_method`|The only valid value is *prompt*. This parameter can be used in the future to offer more ways for the user to enter the one-time passcode. Issued if `challenge_type` is *oob*  |
|`challenge_channel`| The type of the channel through which the one-time passcode was sent. At the moment, we support email. |
|`challenge_target_label` |An obfuscated email where the one-time passcode was sent.|
|`code_length`|The length of the one-time passcode that Microsoft Entra generates. |

# [Email with password](#tab/emailPassword)
If the tenant administrator configured email with password in the Microsoft Entra admin center as the user’s authentication method, Microsoft Entra returns a success response, which includes a challenge type of *password*.

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
| `continuation_token`  |  [Continuation token](#continuation-token) that Microsoft Entra returns. |  
|`challenge_type`|Microsoft Entra returns the supported challenge type configured for the user in the Microsoft Entra admin center. In this case the values is expected to be *password*.|

---

If an app can't support a required authentication method by Microsoft Entra, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra informs the app by returning a *redirect* challenge type in its response:

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
| `challenge_type`  | Microsoft Entra returns a response that has a challenge type. The value of this challenge type is redirect, which enables the app to use the web-based authentication flow.  |  

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
    "error_description": "AADSTS901007: The challenge_type list parameter does not include the 'redirect' type.\r\nTrace ID: 0000aaaa-11bb-cccc-dd22-eeeeee333333\r\nCorrelation ID: aaaa0000-bb11-2222-33cc-444444dddddd\r\nTimestamp: yyyy-...",
    "error_codes": [ 
        901007 
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "0000aaaa-11bb-cccc-dd22-eeeeee333333", 
    "correlation_id": "aaaa0000-bb11-2222-33cc-444444dddddd"
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|--------------------|--------------------|
| `invalid_request`  |  Request parameter validation failed such as when the `challenge_type` parameter includes an invalid challenge type. |  
|`invalid_grant`|The continuation token included in the request isn't valid.  |
|`expired_token`|The continuation token included in the request is expired. |
|`unsupported_challenge_type`|The `challenge_type` parameter value doesn't include the `redirect` challenge type. |

### Step 3: Request for security tokens

The app makes a POST request to the `/token` endpoint and provides the user’s credentials chosen in the previous step, in this case password, to acquire security tokens.  

Here's an example of the request(we present the example request in multiple lines for readability):

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/oauth2/v2.0/token
Content-Type: application/x-www-form-urlencoded

continuation_token=uY29tL2F1dGhlbnRpY...
&client_id=00001111-aaaa-2222-bbbb-3333cccc4444 
&grant_type=password 
&password={secure_password}
&scope=openid offline_access 
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
| `client_id`       |   Yes   | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|
| `continuation_token`          |    Yes   |  [Continuation token](#continuation-token) that Microsoft Entra returned in the previous request. |
|`grant_type`| Yes |The value must be *password* for email with password authentication method and *oob* for email one-time passcode authentication method. |
|`scope`| Yes | A space-separated list of scopes. All the scopes must be from a single resource, along with OpenID Connect (OIDC) scopes, such as *profile*, *openid, and *email*. The app needs to include *openid* scope for Microsoft Entra to issue an ID token. The app needs to include *offline_access* scope for Microsoft Entra to issue a refresh token. Learn more about [Permissions and consent in the Microsoft identity platform](permissions-consent-overview.md). |
|   `password`    | Yes <br> (for email with password) | The password value that the app collects from the customer user. Replace `{secure_password}` with the password value that the app collects from the customer user.|
|`oob`| Yes <br> (for email one-time passcode) |The one-time passcode that the customer user received in their email. Replace `{otp_code}` with the one-time passcode that the customer user received in their email. To **resend a one-time passcode**, the app needs to make a request to the `/challenge` endpoint again. |

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
|`token_type` |  Indicates the token type value. The only type that Microsoft Entra supports is *Bearer*.|
|`scopes`|  A space-separated list of scopes that the access token is valid for.|
|`expires_in`|   The length of time in seconds the access token remains valid.|
| `access_token`  |    The access token that the app requested from the `/token` endpoint. The app can use this access token to request access to secured resources such as web APIs.| 
|`refresh_token` |  An OAuth 2.0 refresh token. The app can use this token to acquire other access tokens after the current access token expires. Refresh tokens are long-lived. They can maintain access to resources for extended periods. For more detail on refreshing an access token, refer to [Refresh the access token](v2-oauth2-auth-code-flow.md#refresh-the-access-token) article. <br> **Note**: Only issued if you request *offline_access* scope.   |
|`id_token`|  A JSON Web Token (Jwt) used to identify the customer user. The app can decode the token to request information about the user who signed in. The app can cache the values and display them, and confidential clients can use this token for authorization. For more information about ID tokens, see [ID tokens](id-tokens.md).<br> **Note**: Only issued if you request *openid* scope. |

#### Error response 

Example:

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{ 
    "error": "invalid_grant", 
    "error_description": "AADSTS901007: Error validating credentials due to invalid username or password.\r\nTrace ID: 0000aaaa-11bb-cccc-dd22-eeeeee333333\r\nCorrelation ID: aaaa0000-bb11-2222-33cc-444444dddddd\r\nTimestamp: yyyy-...",
    "error_codes": [ 
        50126 
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "0000aaaa-11bb-cccc-dd22-eeeeee333333", 
    "correlation_id": "aaaa0000-bb11-2222-33cc-444444dddddd"
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed. To understand what happened, use the message in the error description.   |  
|`invalid_grant`|The continuation token included in the request isn't valid or customer user sign in credentials included in the request are invalid or the grant type included in the request is unknown.  |
|`invalid_client`| The client ID included in the request isn't for a public client. |
|`expired_token`|The continuation token included in the request is expired. |
|`invalid_scope`| One or more of the scoped included in the request are invalid.|

If the error parameter has a value of *invalid_grant*, Microsoft Entra includes a `suberror` parameter in its response. Here are the possible values of the `suberror` parameter for an *invalid_grant* error:

|    Suberror value     | Description        |
|----------------------|------------------------|
|`invalid_oob_value`| The value of one-time passcode is invalid. This sub-error only applies email one-time passcode |

## Self-service password reset (SSPR)

If you use email and password as the authentication method in your app, use the self-service password reset (SSPR) API to enable customer users to reset their password. Use this API for forgot password or change password scenarios.

### Self-service password reset API endpoints

To use this API, the app interacts with the endpoint shown in the following table:

|    Endpoint     | Description        |
|----------------------|------------------------|
| `/start`  | Your app calls this endpoint when the customer user selects **Forgot password** or **Change password** link or button in the app. This endpoint validates the user's username (email), then returns a *continuation token* for use in the password reset flow. If your app requests to use authentication methods that aren't supported by Microsoft Entra, this endpoint response can indicate to your app that it needs to use a browser-based authentication flow. |
|`/challenge`|  Accepts a list of challenge types supported by the client and the *continuation token*. A challenge is issued to one of the preferred recovery credentials. For example, oob challenge issues an out-of-band one-time passcode to the email associated with the customer user account. If your app requests to use authentication methods that aren't supported by Microsoft Entra, this endpoint response can indicate to your app that it needs to use a browser-based authentication flow.    |
|`/continue`| Validates the challenge issued by the `/challenge` endpoint, then either returns a *continuation token* for the `/submit` endpoint, or issues another challenge to the user.  |
|`/submit`|  Accepts a new password input by the user along with the *continuation token* to complete the password reset flow. This endpoint issues another *continuation token*. |
|`/poll_completion`|  Finally, the app can use the *continuation token* issued by the `/submit` endpoint to check the status of the password reset request.    |

### Self-service password reset challenge types

The API allows the app to advertise the authentication methods it supports, when it makes a call to Microsoft Entra. To do so, the app uses the `challenge_type` parameter in its requests. This parameter holds predefined values, which represent different authentication methods.

For the SSPR flow, the challenge type values are *oob*, and *redirect*.  

Learn more about challenge types in the [native authentication challenge types](../external-id/customers/concept-native-authentication-challenge-types.md).


### Self-service password reset flow protocol details

The sequence diagram demonstrates the flow for the password reset process.

:::image type="content" source="media/reference-native-auth-api/self-service-password-reset.png" alt-text="Diagram of native auth self-service password reset flow."::: 

This diagram indicates that the app collects username (email) and password from the user at different times (and possibly on separate screens). However, you can design your app to collect the username (email) and new password on the same screen. In this case, the app holds the password, then submits it via the `/submit` endpoint where it's required.

### Step 1: Request to start the self-service password reset flow

The password reset flow starts with the app making a POST request to the `/start` endpoint to start the self-service password reset flow.

Here's an example of the request (we present the example request in multiple lines for readability):

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/resetpassword/v1.0/start
Content-Type: application/x-www-form-urlencoded

client_id=00001111-aaaa-2222-bbbb-3333cccc4444 
&challenge_type=oob redirect 
&username=contoso-consumer@contoso.com 
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
| `client_id`         |   Yes    | The Application (client) ID of the app you registered in the Microsoft Entra admin center.                |
| `username`          |    Yes   |   Email of the customer user such as *contoso-consumer@contoso.com*.  |
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
| `continuation_token`  |  [Continuation token](#continuation-token) that Microsoft Entra returns. |

If an app can't support a required authentication method by Microsoft Entra, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra informs the app by returning a *redirect* challenge type in its response:

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
| `challenge_type`  | Microsoft Entra returns a response that has a challenge type. The value of this challenge type is redirect, which enables the app to use the web-based authentication flow.  |  

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
    "error_description": "AADSTS901007: The challenge_type list parameter does not include the 'redirect' type.\r\nTrace ID: 0000aaaa-11bb-cccc-dd22-eeeeee333333\r\nCorrelation ID: aaaa0000-bb11-2222-33cc-444444dddddd\r\nTimestamp: yyyy-...",
    "error_codes": [ 
        901007 
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "0000aaaa-11bb-cccc-dd22-eeeeee333333", 
    "correlation_id": "aaaa0000-bb11-2222-33cc-444444dddddd"
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as when the `challenge_type` parameter includes an invalid challenge type or the request didn't include `client_id` parameter the client ID value is empty or invalid. Use the `error_description` parameter to learn the exact cause of the error.   |  
|`user_not_found`|The username doesn't exist.|
|`unsupported_challenge_type`|The `challenge_type` parameter value doesn't include the `redirect` challenge type.|
|`invalid_client`| The client ID that the app includes in the request is for an app that lacks native authentication configuration, such as it isn't a public client or isn't enabled for native authentication. Use the `suberror` parameter to learn the exact cause of the error.|
|`unauthorized_client`| The client ID used in the request has a valid client ID format, but doesn't exist in the external tenant or is incorrect. |

If the error parameter has a value of *invalid_client*, Microsoft Entra includes a `suberror` parameter in its response. Here are the possible values of the `suberror` parameter for an *invalid_client* error:

|    Suberror value     | Description        |
|----------------------|------------------------|
|`nativeauthapi_disabled`| The client ID for an app that isn't enable for native authentication.|


### Step 2: Select an authentication method

To continue with the flow, the app uses the continuation token acquired from the previous step to request Microsoft Entra to select one of the supported challenge types for the user to authenticate with. The app makes a POST request to the `/challenge` endpoint. If this request is successful, Microsoft Entra sends a one-time passcode to the user's account email. At the moment, we only support email OTP.

Here's an example (we present the example request in multiple lines for readability):

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/resetpassword/v1.0/challenge
Content-Type: application/x-www-form-urlencoded

client_id=client_id=00001111-aaaa-2222-bbbb-3333cccc4444
&challenge_type=oob redirect
&continuation_token=uY29tL2F1dGhlbnRpY... 
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
| `client_id`         |   Yes    | The Application (client) ID of the app you registered in the Microsoft Entra admin center.                |
| `continuation_token`          |    Yes   |   [Continuation token](#continuation-token) that Microsoft Entra returned in the previous request. |
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
| `continuation_token`  | [Continuation token](#continuation-token) that Microsoft Entra returns. |
|`challenge_type`| Challenge type selected for the user to authenticate with.|
|`binding_method`|The only valid value is *prompt*. This parameter can be used in the future to offer more ways to the user to enter the one-time passcode. Issued if `challenge_type` is *oob*  |
|`challenge_channel`| The type of the channel through which the one-time passcode was sent. At the moment, we support email. |
|`challenge_target_label` |An obfuscated email where the one-time passcode was sent.|
|`code_length`|The length of the one-time passcode that Microsoft Entra generates. |

If an app can't support a required authentication method by Microsoft Entra, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra informs the app by returning a *redirect* challenge type in its response:

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
| `challenge_type`  | Microsoft Entra returns a response that has a challenge type. The value of this challenge type is redirect, which enables the app to use the web-based authentication flow.  |  

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
    "error_description": "AADSTS901007: The challenge_type list parameter does not include the 'redirect' type.\r\nTrace ID: 0000aaaa-11bb-cccc-dd22-eeeeee333333\r\nCorrelation ID: aaaa0000-bb11-2222-33cc-444444dddddd\r\nTimestamp: yyyy-...",
    "error_codes": [ 
        901007 
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "0000aaaa-11bb-cccc-dd22-eeeeee333333", 
    "correlation_id": "aaaa0000-bb11-2222-33cc-444444dddddd"
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as when the `challenge_type` parameter includes an invalid challenge type or *continuation token* validation failed.   |  
|`expired_token`|The continuation token is expired.  |
|`unsupported_challenge_type`|The `challenge_type` parameter value doesn't include the `redirect` challenge type.|

### Step 3: Submit one-time passcode

The app then makes a POST request to the `/continue` endpoint. In the request, the app needs to include the user’s credentials chosen in the previous step and the continuation token issued from the `/challenge` endpoint.

Here's an example of the request (we present the example request in multiple lines for readability):

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/resetpassword/v1.0/continue
Content-Type: application/x-www-form-urlencoded

continuation_token=uY29tL2F1dGhlbnRpY... 
&client_id=00001111-aaaa-2222-bbbb-3333cccc4444 
&grant_type=oob 
&oob={otp_code}
```

|    Parameter     | Required | Description        |
|----------------------|------------------------|------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
| `continuation_token`  | Yes | [Continuation token](#continuation-token) that Microsoft Entra returned in the previous request. |
|`client_id`| Yes | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|
|`grant_type` | Yes | The only valid value is *oob*.  |
|`oob`| Yes |The one-time passcode that the customer user received in their email. Replace `{otp_code}` with the one-time passcode that the customer user received in their email. To **resend a one-time passcode**, the app needs to make a request to the `/challenge` endpoint again. |

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
| `continuation_token`  |  [Continuation token](#continuation-token) that Microsoft Entra returns.  |

#### Error response

Example:

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{ 
    "error": "invalid_request", 
    "error_description": "AADSTS55200: The continuation_token is invalid.\r\nTrace ID: 0000aaaa-11bb-cccc-dd22-eeeeee333333\r\nCorrelation ID: aaaa0000-bb11-2222-33cc-444444dddddd\r\nTimestamp: yyyy-...",
    "error_codes": [ 
        55200 
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "0000aaaa-11bb-cccc-dd22-eeeeee333333", 
    "correlation_id": "aaaa0000-bb11-2222-33cc-444444dddddd"
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |
|`suberror` | An error code string that can be used to further classify types of errors.|

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as a validation of *continuation token* failed or the request didn't include `client_id` parameter the client ID value is empty or invalid or the external tenant administrator hasn't enabled SSPR and email OTP for all tenant users. Use the `error_description` parameter to learn the exact cause of the error. |
|`invalid_grant` |The grant type is unknown or doesn't match the expected grant type value. Use the `suberror` parameter to learn the exact cause of the error.|
|`expired_token`|The continuation token is expired.    |


If the error parameter has a value of *invalid_grant*, Microsoft Entra includes a `suberror` parameter in its response. Here are the possible values of the `suberror` parameter for an *invalid_grant* error:

|    Suberror value     | Description        |
|----------------------|------------------------|
|`invalid_oob_value`|The one-time passcode provided by the user is invalid.|


### Step 4: Submit a new password

The app collects a new password from the user, then uses the *continuation token* issued by the `/continue` endpoint to submit the password by making a POST request to the `/submit` endpoint.

Here's an example (we present the example request in multiple lines for readability):

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/resetpassword/v1.0/submit
Content-Type: application/x-www-form-urlencoded

client_id=00001111-aaaa-2222-bbbb-3333cccc4444
&continuation_token=czZCaGRSa3F0Mzp...
&new_password={new_password}
```

|    Parameter     | Required | Description        |
|----------------------|------------------------|------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
| `continuation_token`  |Yes |[Continuation token](#continuation-token) that Microsoft Entra returned in the previous request.  |
|`client_id`| Yes | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|
|`new_password` | Yes | User’s new password. Replace `{new_password}` with the user's new password. It's your responsibility to confirm that the user is aware of the password they want to use by providing the password confirm field in the app's UI. You must also ensure that the user is aware of what constitutes a strong password per your organization's policy. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md). |

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
| `continuation_token`  |  [Continuation token](#continuation-token) that Microsoft Entra returns.  |
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
    "error_description": "AADSTS901007: The challenge_type list parameter does not include the 'redirect' type.\r\nTrace ID: 0000aaaa-11bb-cccc-dd22-eeeeee333333\r\nCorrelation ID: aaaa0000-bb11-2222-33cc-444444dddddd\r\nTimestamp: yyyy-...",
    "error_codes": [ 
        901007 
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "0000aaaa-11bb-cccc-dd22-eeeeee333333", 
    "correlation_id": "aaaa0000-bb11-2222-33cc-444444dddddd"
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |
|`suberror` | An error code string that can be used to further classify types of errors.|

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as a validation of *continuation token* failed.   |
|`expired_token`|The *continuation token* is expired.    |
|`invalid_grant`| The grant submitted is invalid, such as the password submitted is too short. Use the `suberror` parameter to learn the exact cause of the error.|

If the error parameter has a value of *invalid_grant*, Microsoft Entra includes a `suberror` parameter in its response. Here are the possible values of the `suberror` parameter:

|    Suberror value     | Description        |
|----------------------|------------------------|
|`password_too_weak`|Password is too weak as it doesn't meet complexity requirements. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md).|
|`password_too_short`|New password is fewer than 8 characters. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md).|
|`password_too_long` |New password is longer than 256 characters. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md). |
|`password_recently_used`|The new password must not be the same as one recently used. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md).|
|`password_banned`|New password contains a word, phrase, or pattern that is banned. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md).|
|`password_is_invalid`| Password is invalid, for example because it uses disallowed characters. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md). This response is possible if the app submits a user password.|

### Step 5: Poll for password reset status

Lastly, since updating of the user’s configuration with the new password incurs some delay, the app can use the `/poll_completion` endpoint to poll Microsoft Entra for password reset status. The minimum amount of time in seconds that the app should wait between polling requests is returned from the `/submit` endpoint in the `poll_interval` parameter.  

Here's an example (we present the example request in multiple lines for readability):

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/resetpassword/v1.0/poll_completion
Content-Type: application/x-www-form-urlencoded

client_id=00001111-aaaa-2222-bbbb-3333cccc4444
&continuation_token=czZCaGRSa3F0... 
```

|    Parameter     | Required | Description        |
|----------------------|------------------------|------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
| `continuation_token`  |Yes | [Continuation token](#continuation-token) that Microsoft Entra returned in the previous request. |
|`client_id`| Yes | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|

#### Success response

Example:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{
    "status": "succeeded",
    "continuation_token":"czZCaGRSa3F0..."
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `status`  | The status of the reset password request. If Microsoft Entra returns a status of *failed*, the app can resubmit the new password by making another request to the `/submit` endpoint and include the new continuation token.|
| `continuation_token`  |  [Continuation token](#continuation-token) that Microsoft Entra returns. If the status is *succeeded*, the app can use the continuation token that Microsoft Entra returns to request for security tokens via the `/token` endpoint as explained in [step 5 of sign-up flow](#step-5-request-for-security-tokens). This means that after a user successfully resets their password, you can directly sign them into your app without initiating a new sign-in flow.|

Here are the possible statuses that Microsoft Entra returns (possible values of the `status` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `succeeded` |  Password reset completed successfully. |
| `failed` |Password reset failed. The app can resubmit the new password by making another request to the `/submit` endpoint.|
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
    "error_description": "AADSTS901007: The continuation_token is expired.\r\nTrace ID: 0000aaaa-11bb-cccc-dd22-eeeeee333333\r\nCorrelation ID: aaaa0000-bb11-2222-33cc-444444dddddd\r\nTimestamp: yyyy-...",
    "error_codes": [ 
        552003 
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "0000aaaa-11bb-cccc-dd22-eeeeee333333", 
    "correlation_id": "aaaa0000-bb11-2222-33cc-444444dddddd"
} 
```

|    Parameter     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as validation of *continuation token* failed.   |
|`expired_token`|The *continuation token* is expired.    |

## Related content

- [Configure a custom claims provider](custom-extension-tokenissuancestart-configuration.md?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json).