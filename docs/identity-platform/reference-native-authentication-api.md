---
title: Native authentication API reference documentation
description: Find out how to use native authentication APIs to authenticate users into your customer-facing apps with the external tenant. 
author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: identity-platform
ms.subservice: external
ms.topic: reference
ms.date: 02/27/2026
ms.custom: sfi-ropc-nochange, sfi-image-nochange
#Customer intent: As an identity developer, I want to learn how to integrate customer-facing apps with native authentication API so that I can sign in customer users into external tenant.
---

# Native authentication API reference

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

Microsoft Entra's [native authentication](../external-id/customers/concept-native-authentication.md) enables you to host the user interface of your app in the client application instead of delegating authentication to browsers, resulting in a natively integrated authentication experience. As a developer, you have full control over the look and feel of the sign-in interface.

[!INCLUDE [native-auth-api-common-description](./includes/native-auth-api/native-auth-api-common-description.md)]

Microsoft Entra's native authentication API supports sign-up and sign-in for two authentication flows:

- Email with password, which supports sign-up and sign-in with an email and password, and self-service password reset (SSPR).
    - Users who sign in with an email address and password to also [sign in with a username and password](../external-id/customers/how-to-sign-in-alias.md).

- Email one-time passcode, which supports sign-up and sign-in with email one-time passcode.

[!INCLUDE [native-auth-api-cors-note](./includes/native-auth-api/native-auth-api-cors-note.md)]

## Prerequisites

1. A Microsoft Entra external tenant. If you don't already have one, [create an external tenant](../external-id/customers/how-to-create-external-tenant-portal.md).

1.  If you haven't already done so, [Register an application in the Microsoft Entra admin center](quickstart-register-app.md). Make sure to:

    * Record the **Application (client) ID** and **Directory (tenant) ID** for later use.
    * [Grant admin consent](quickstart-register-app.md#grant-admin-consent-external-tenants-only) to the application.
    * [Enable public client and native authentication flows](quickstart-native-authentication-android-sign-in.md#enable-public-client-and-native-authentication-flows). 

1. If you haven't already done so, [Create a user flow in the Microsoft Entra admin center](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md#to-add-a-new-user-flow). When you create the user flow, take note of the user attributes you configure as required as these attributes are the ones that Microsoft Entra expects your app to submit.

1. [Associate your app registration with the user flow](../external-id/customers/how-to-user-flow-add-application.md).

1. For sign-in flow, [register a customer user](../external-id/customers/how-to-manage-customer-accounts.md#create-a-customer-account), which you use to test the flow. Alternatively, you can get this test user after you run the sign-up flow.

1. For SSPR flow, [enable self-service password reset](../external-id/customers/how-to-enable-password-reset-customers.md) for customer users in the external tenant. SSPR is available for customer users who use email with password authentication method. 

1. If you want to allow users who sign in with an email address and password to also sign in with a username and password, use the steps in [Sign in with an alias or username](../external-id/customers/how-to-sign-in-alias.md) article:
    1. [Enable username in sign-in](../external-id/customers/how-to-sign-in-alias.md#enable-username-in-sign-in-identifier-policy).
    1. [Create users with username in the admin center](../external-id/customers/how-to-sign-in-alias.md#create-users-with-username-in-the-admin-center) or [update existing users to by adding a username](../external-id/customers/how-to-sign-in-alias.md#update-existing-users-to-add-a-username-in-the-admin-center). Alternatively, you can also [automate user creation and updating in your app by using the Microsoft Graph API](../external-id/customers/how-to-sign-in-alias.md#add-a-username-to-existing-users-with-the-microsoft-graph-api). 

1. To enforce multifactor authentication (MFA) for your customers, use the steps in [Add multifactor authentication (MFA) to an app](../external-id/customers/how-to-multifactor-authentication-customers.md) to add MFA to your sign-in flow. Native authentication supports email one-time passcode and SMS as a second factor for MFA.

## Continuation token

[!INCLUDE [entra-external-id-continuation-token](./includes/native-auth-api/continuation-token.md)]

## API reference for sign-up

To complete a user sign-up flow for either authentication method, your app interacts with four endpoints, `/signup/v1.0/start`, `/signup/v1.0/challenge`,  `/signup/v1.0/continue`, and `/token`.

### API endpoints for sign-up

|    Endpoint           | Description                                |
|-----------------------|--------------------------------------------|
| `/signup/v1.0/start`  | This endpoint starts the sign-up flow. You pass valid application ID, new username, and [challenge type](#sign-up-challenge-types), then you get back a new continuation token. The endpoint can return a response to indicate to the application to use a web authentication flow if the application’s chosen authentication methods aren't supported by Microsoft Entra.|
|   `/signup/v1.0/challenge`   | Your app calls this endpoint with a list of [challenge types](#sign-up-challenge-types) supported by Microsoft Entra. Microsoft Entra then selects one of the supported authentication methods for the user to authenticate with. |
|  `/signup/v1.0/continue`  | This endpoint helps to continue the flow to create the user account or interrupt the flow due to missing requirements such as password policy requirements or wrong attribute formats. This endpoint generates a continuation token, then returns it to the app. The endpoint can return a response to indicate to the application to use a web-based authentication flow if the application doesn't an authentication method chosen by  Microsoft Entra.|
|`oauth/v2.0/token`| The application calls this endpoint to finally request for security tokens. The app needs to use the continuation token it acquires from the last successful call to the `/signup/v1.0/continue` endpoint.|

### Sign-up challenge types

The API allows the client app to advertise the authentication methods it supports, when it makes a call to Microsoft Entra. To do so, the app uses the `challenge_type` parameter in the app's request. This parameter holds predefined values, which represent different authentication methods.

Learn more about challenge types in the [native authentication challenge types](../external-id/customers/concept-native-authentication-challenge-types.md). This article explains the challenge type values you should use for an authentication method.

### Sign-up flow protocol details

The sequence diagram demonstrates the flow of the sign-up process.

:::image type="content" source="media/reference-native-auth-api/sign-up-email-with-password.png" alt-text="Diagram of native authentication a sign-up flow."::: 

This diagram indicates that the app collects username (email), password (for email with password authentication flow), and attributes from the user at different times (and possibly on separate screens). However, you can design your app to collect the username (email), password and all the required, and optional attribute values in the same screen, then submit all of them to the `/signup/v1.0/start` endpoint. If the app submits all the required information to the `/signup/v1.0/start` endpoint, the app doesn't need to make calls and handle responses in the optional steps.

In step 21, the user is already signed up. However, if the app requires to automatically sign in a user after sign-up, the app calls the `oauth/v2.0/token` endpoint to request for security tokens.

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
|`capabilities`| No | Space-separated flags that describe the client app's capabilities. While `challenge_type` defines what methods can be challenged, `capabilities` tell the native authentication API which extra flows the client app can handle and which UIs it can show to the user. For example, `mfa_required` means another `/challenge` and `/token` loop; `registration_required` means the client app calls registration APIs and show registration UI. If a required capability isn’t advertised by the client app, the API returns redirect. Supported values are `mfa_required` and `registration_required`. [Learn more about capabilities](concept-native-authentication-challenge-types.md).|

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

|    Property     | Description        |
|----------------------|------------------------|
|`continuation_token`| [Continuation token](#continuation-token) that Microsoft Entra returns.|


#### Redirect response

If the client app doesn't support the authentication method or capabilities that Microsoft Entra requires, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra informs the app by returning a *redirect* challenge type in the response:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{     
   "challenge_type": "redirect" 
} 
```

|    Property     | Description        |
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

|    Property     | Description        |
|----------------------|------------------------|
|`error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |
|`invalid_attributes`   |  A list (array of objects) of attributes that failed validation. This response is possible if the app submits user attributes, and the `suberror` property's value is *attribute_validation_failed*.    |
|`suberror` | An error code string that can be used to further classify types of errors.|

Here are the possible errors you can encounter (possible values of the `error` property):

|    Error value     | Description        |
|----------------------|------------------------|
|`invalid_request`  |Request parameter validation failed such as when the challenge_type parameter value contains an unsupported authentication method or the request didn't include `client_id` parameter the client ID value is empty or invalid. Use the `error_description` parameter to learn the exact cause of the error.|
|`invalid_client`| The client ID that the app includes in the request is for an app that lacks native authentication configuration, such as it isn't a public client or isn't enabled for native authentication. Use the `suberror` property to learn the exact cause of the error.|
|`unauthorized_client`| The client ID used in the request has a valid client ID format, but doesn't exist in the external tenant or is incorrect. |
|`unsupported_challenge_type`|The `challenge_type` parameter value doesn't include the `redirect` challenge type.| 
|`user_already_exists` |  User already exists.  |
|`invalid_grant`| The password that the app submits doesn't meet all the complexity requirements, such as the password is too short. Use the `suberror` property to learn the exact cause of the error. <br> **This parameter is only applicable for email with password authentication method**.|

If the error parameter has a value of *invalid_grant*, Microsoft Entra includes a `suberror` property in its response. Here are the possible values of the `suberror` property for an *invalid_grant* error:

|    Suberror value     | Description        |
|----------------------|------------------------|
|`password_too_weak`|Password is too weak as it doesn't meet complexity requirements. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md). This response is possible if the app submits a user password.|
|`password_too_short`|New password is fewer than 8 characters. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md). This response is possible if the app submits a user password.|
|`password_too_long` |New password is longer than 256 characters. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md). This response is possible if the app submits a user password.|
|`password_recently_used`|The new password must not be the same as one recently used. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md). This response is possible if the app submits a user password.|
|`password_banned`|New password contains a word, phrase, or pattern that is banned. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md). This response is possible if the app submits a user password.|
|`password_is_invalid`| Password is invalid, for example because it uses disallowed characters. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md). This response is possible if the app submits a user password.|


If the error parameter has a value of *invalid_client*, Microsoft Entra includes a `suberror` property in its response. Here are the possible values of the `suberror` property for an *invalid_client* error:

|    Suberror value     | Description        |
|----------------------|------------------------|
|`nativeauthapi_disabled`| The client ID for an app that isn't enable for native authentication.|

> [!NOTE]
> If you submit all the required attributes via `/signup/v1.0/start` endpoint, but not all optional attributes, you won't be able to submit any additional optional attributes later via the  `/signup/v1.0/continue` endpoint. Microsoft Entra doesn't explicitly request for optional attributes as they aren't mandatory for the sign-up flow to complete. See the table in the [Submitting user attributes to endpoints](#submitting-user-attributes-to-endpoints) section to learn the user attributes you can submit to the `/signup/v1.0/start` and `/signup/v1.0/continue` endpoints. 

### Step 2: Select an authentication method

The app requests Microsoft Entra to select one of the supported challenge types for the user to authenticate with. To do so, the app makes a call to the `/signup/v1.0/challenge` endpoint. The app needs to include the continuation token that it acquires from the `/signup/v1.0/start` endpoint in the request.

Here's an example of the request (we present the example request in multiple lines for readability):

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

|    Property     | Description        |
|----------------------|------------------------|
|`interval`| The length of time in seconds the app needs to wait before it attempts to resend OTP. |
| `continuation_token`  | [Continuation token](#continuation-token) that Microsoft Entra returns. |
|`challenge_type`| Challenge type selected for the user to authenticate with.|
|`binding_method`|The only valid value is *prompt*. This parameter can be used in the future to offer more ways to the user to enter the one-time passcode. Issued if `challenge_type` is *oob*  |
|`challenge_channel`| The type of the channel through which the one-time passcode was sent. At the moment, only email channel is supported. |
|`challenge_target_label` |An obfuscated email where the one-time passcode was sent.|
|`code_length`|The length of the one-time passcode that Microsoft Entra generates. |

#### Redirect response

If the client app doesn't support the authentication method or capabilities that Microsoft Entra requires, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra informs the app by returning a *redirect* challenge type in the response:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{
   "challenge_type": "redirect"
}
```

|    Property     | Description        |
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

|    Property     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` property):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as client ID is empty or invalid.   |
|`expired_token`|The continuation token is expired. |
|`unsupported_challenge_type`|The `challenge_type` parameter value doesn't include the `redirect` challenge type.|
|`invalid_grant` | The continuation token is invalid. |

### Step 3: Submit one-time passcode

The app submits the  one-time passcode sent to the user's email. Since we're submitting one-time passcode, an `oob` parameter is required, and the `grant_type` parameter must have a value *oob*.

Here's an example of the request (we present the example request in multiple lines for readability):

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
|The app successfully submits the user's password (for email with password authentication method) via the `/signup/v1.0/start` endpoint, and no attributes are configured in Microsoft Entra admin center or all the required user attributes are submitted via the `/signup/v1.0/start` endpoint. |Microsoft Entra issues a continuation token. The app can use the continuation token to request for security tokens as shown in [Request for security tokens](#step-3-request-for-security-tokens).|
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
    
|    Property     | Description        |
|----------------------|------------------------|
| `error`  |  An error code string that can be used to classify types of errors, and to react to errors.   |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |
|`continuation_token`| [Continuation token](#continuation-token) that Microsoft Entra returns. |
|`suberror` | An error code string that can be used to further classify types of errors.|

Here are the possible errors you can encounter (possible values of the `error` property):

|    Error value     | Description        |
|----------------------|------------------------|
|`credential_required`|Authentication is required for account creation, so you have to make a call to the `/signup/v1.0/challenge` endpoint to determine the credential the user is required to provide.|
|`invalid_request`  | Request parameter validation failed such as a validation of *continuation token* failed or the request didn't include `client_id` parameter the client ID value is empty or invalid or the external tenant administrator hasn't enabled email OTP for all tenant users.   |  
|`invalid_grant`|The grant type included in the request isn't valid or supported, or OTP value is incorrect.|
|`expired_token`|The continuation token included in the request is expired. |

If the error parameter has a value of *invalid_grant*, Microsoft Entra includes a `suberror` property in its response. Here are the possible values of the `suberror` property for an *invalid_grant* error:

|    Suberror value     | Description        |
|----------------------|------------------------|
|`invalid_oob_value`| The value of one-time passcode is invalid.|

For the password credential to be collected from the user, the app needs to make a call to the `/signup/v1.0/challenge` endpoint to determine the credential the user is required to provide.

Here's an example of the request (we present the example request in multiple lines for readability):

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

|    Property     | Description        |
|----------------------|------------------------|
| `challenge_type`  |  *password* is returned in the response for the required credential.   |
|`continuation_token`| [Continuation token](#continuation-token) that Microsoft Entra returns.   |

#### Redirect response

If the client app doesn't support the authentication method or capabilities that Microsoft Entra requires, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra informs the app by returning a *redirect* challenge type in the response:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{     
    "challenge_type": "redirect" 
} 
```

|    Property     | Description        |
|----------------------|------------------------|
| `challenge_type`  | Microsoft Entra returns a response that has a challenge type. The value of this challenge type is redirect, which enables the app to use the web-based authentication flow.  |  

This response is considered successful, but the app is required to switch to a web-based authentication flow. In this case, we recommend that you use a [Microsoft-built and supported authentication library](reference-v2-libraries.md).

### Step 4: Authenticate and get token to sign up

The app needs to submit the user's credential, in this case password, that Microsoft Entra requested in the previous step. The app needs to submit a password credential if it didn't do so via the `/signup/v1.0/start` endpoint. The app makes a request to the `/signup/v1.0/continue` endpoint to submit the password. Since we're submitting a password, a `password` parameter is required, and the `grant_type` parameter must have a value *password*.

Here's an example of the request (we present the example request in multiple lines for readability):

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

If the request is successful, but no attributes were configured in Microsoft Entra admin center or all the required attributes were submitted via the `/signup/v1.0/start` endpoint, the app gets a continuation token without submitting any attributes. The app can use the continuation token to request for security tokens as shown in [Request for security tokens](#step-3-request-for-security-tokens). Otherwise, Microsoft Entra's response indicates that the app needs to submit required attributes. These attributes, built in or custom, were configured in the Microsoft Entra admin center by the tenant administrator.

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


|    Property     | Description        |
|----------------------|------------------------|
| `error`  | This attribute is set if Microsoft Entra can't create the user account because an attribute needs to be verified or submitted.  |  
|`error_description` | A specific error message that can help you to identify the cause of the error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |
|`continuation_token`| [Continuation token](#continuation-token) that Microsoft Entra returns.  |
|`required_attributes`|A list (array of objects) of attributes that the app needs to submit next call to continue. These attributes are the extra attributes that app needs to submit apart from the username. Microsoft Entra includes this parameter is the response if the value of `error` parameter is *attributes_required*.|

Here are the possible errors you can encounter (possible values of the `error` property):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  | Request parameter validation failed such as a validation of *continuation token* failed or the request didn't include `client_id` parameter the client ID value is empty or invalid.|  
|`invalid_grant`| The grant type included in the request isn't valid or supported. The possible values for the `grant_type` are *oob*, *password*, *attributes* |
|`expired_token`| The continuation token included in the request is expired. |
|`attributes_required`  |  One or more of user attributes is required.   |

#### Redirect response 

If the client app doesn't support the authentication method or capabilities that Microsoft Entra requires, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra informs the app by returning a *redirect* challenge type in the response:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{     
   "challenge_type": "redirect" 
} 
```

|    Property     | Description        |
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

|    Property     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |
|`suberror` | An error code string that can be used to further classify types of errors.|

Here are the possible errors you can encounter (possible values of the `error` property):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as when the `challenge_type` parameter includes an invalid challenge type.   |  
|`invalid_grant`| The grant submitted is invalid, such as the password submitted is too short. Use the `suberror` property to learn the exact cause of the error.|
|`expired_token`|The continuation token is expired. |
|`attributes_required`  |  One or more of user attributes is required.   |


If the error parameter has a value of *invalid_grant*, Microsoft Entra includes a `suberror` property in its response. Here are the possible values of the `suberror` property:

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

Here's an example of the request (we present the example request in multiple lines for readability):

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

If the request is successful, Microsoft Entra signs up the user, then issues a continuation token. The app can use the continuation token to request for security tokens from the `oauth/v2.0/token` endpoint.

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{  
    "continuation_token": "AQABAAEAAAYn..."
} 
```

|    Property   |   Description        |
|----------------------|------------------------|
| `continuation_token`  | [Continuation token](#continuation-token) that Microsoft Entra returns.|  

#### Redirect response

If the client app doesn't support the authentication method or capabilities that Microsoft Entra requires, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra informs the app by returning a *redirect* challenge type in the response:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{     
   "challenge_type": "redirect" 
} 
```

|    Property     | Description        |
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

|    Property     | Description        |
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
| `invalid_attributes`   |  A list (array of objects) of attributes that failed validation. This parameter is included in the response when the `suberror` property's value is *attribute_validation_failed*.    |
|`suberror` | An error code string that can be used to further classify types of errors.|

Here are the possible errors you can encounter (possible values of the `error` property):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |Request parameter validation failed such as a validation of *continuation token* failed or the request didn't include `client_id` parameter the client ID value is empty or invalid.|
|`invalid_grant`|The grant type provided isn't valid or supported or failed validation, such as attributes validation failed. Use the `suberror` property to learn the exact cause of the error.| 
|`expired_token`|The continuation token included in the request is expired.|
|`attributes_required`  |  One or more of user attributes is required.   |


If the error parameter has a value of *invalid_grant*, Microsoft Entra includes a `suberror` property in its response. Here are the possible values of the `suberror` property for an *invalid_grant* error:

|    Suberror value     | Description        |
|----------------------|------------------------|
|`attribute_validation_failed`| User attribute validation failed. `invalid_attributes` parameter contains the list (array of objects) of attributes that failed validation.|


### Step 5: Automatically sign in after sign-up


If the user must automatically sign in after sign-up, the app makes a POST request to the `oauth/v2.0/token` endpoint and provides the continuation token obtained from the previous step to acquire security tokens. Learn [how to call the token endpoint](#step-3-request-for-security-tokens).


## Submitting user attributes to endpoints

[!INCLUDE [submit-user-attributes-to-endpoints](./includes/native-auth-api/submit-user-attributes-to-endpoints.md)]

## Format of user attributes values

[!INCLUDE [native-auth-api-cors-note](./includes/native-auth-api/user-attribute-format.md)]

## API reference for sign-in flow

Users need to sign in with the authentication method that they use to sign up. For example, users who sign up using email with password authentication method must sign in email and password.

To request for security tokens, your app interacts with three endpoints, `oauth/v2.0/initiate`, `oauth/v2.0/challenge`,  `oauth/v2.0/token`, and optionally `oauth/v2.0/introspect`.

### API endpoints for sign-in

|    Endpoint           | Description                                |
|-----------------------|--------------------------------------------|
| `oauth/v2.0/initiate`  | This endpoint initiates the sign-in flow. If your app calls it with a username of a user account that already exists, it returns a success response with a continuation token. If your app requests to use authentication methods that aren't supported by Microsoft Entra, this endpoint response can indicate to your app that it needs to use a browser-based authentication flow.|
|   `oauth/v2.0/challenge`   | Your app calls this endpoint to request Microsoft Entra to select one of the supported [sign-in challenge types](#sign-in-challenge-types) for the user to authenticate with. Where the tenant administrator enforces MFA for customer users, your app calls this endpoint to challenge the user for second factor authentication method.|
|  `oauth/v2.0/token`  | This endpoint verifies user’s credentials it receives from your app, then it issues security tokens to your app. A response from this endpoint can also indicate whether the user needs to complete an MFA challenge or register a strong authentication method.|
| `oauth/v2.0/introspect` | Your app calls it to request for a list of registered strong authentication methods for multifactor authentication (MFA). Learn [how to use the introspect endpoint](#get-user-registered-strong-authentication-methods)|

### Sign-in challenge types

The API allows the app to advertise the authentication methods it supports, when it makes a call to Microsoft Entra. To do so, the app uses the `challenge_type` parameter in its requests. This parameter holds predefined values, which represent different authentication methods.

For a given authentication method, the challenge type values an app sends to Microsoft Entra during sign-up flow are same to when the app signs in. For example, the email with password authentication method uses *oob*, *password* and *redirect* challenge type values for both sign-up and sign-in flows.  

Learn more about challenge types in the [native authentication challenge types](../external-id/customers/concept-native-authentication-challenge-types.md) article.

### Sign-in flow protocol details

The sequence diagram demonstrates the flow of the sign in process. The sign-in flow depends on the user's authentication method.

# [Email one-time passcode](#tab/emailOtp)

:::image type="content" source="media/reference-native-auth-api/sign-in-email-otp.png" alt-text="Diagram of native authentication sign-in with email one-time passcode."::: 

After the app verifies the user's email with OTP, it receives security tokens. If the delivery of the one-time passcode delays or is never delivered to the user's email, the user can request to be sent another one-time passcode. Microsoft Entra resends another one-time passcode if the previous one hasn't been verified. When Microsoft Entra resends a one-time passcode, it invalidates the previously sent code.

# [Email with password](#tab/emailPassword)

:::image type="content" source="media/reference-native-auth-api/sign-in-email-with-password.png" alt-text="Diagram of native auth sign in with email and password option."::: 

- This diagram indicates that the app collects username (email) and password from the user at different times (and possibly on separate screens). However, you can design your app to collect the two values in the same screen. 
- If you collect the username (email) and password in the same screen, steps **two** and **three** gets merged with steps **eight** and **nine**. In this case, the app holds the password, then submits it in step **ten** where it's required.

If a tenant administrator enables MFA for the tenant users, the response from the `/oauth2/v2.0/token` endpoint  depends on whether the user already has a registered strong authentication method:

- If the user has a registered strong authentication method, then they complete an MFA challenge flow. 
- If the user has no registered strong authentication method, then they complete a [register for a strong authentication method](#register-a-strong-authentication-method-api-reference) flow. 

This sequence diagram shows the MFA path. It covers both cases: (1) the user already has a registered strong authentication method, or (2) the user has none and must register one just‑in‑time. The flow begins after the app has collected a correct password from the user and calls /oauth2/v2.0/token, which then responds indicating whether the user needs to complete MFA or register a strong authentication method.

:::image type="content" source="media/reference-native-auth-api/call-token-endpoint-register-authentication-method-complete-mfa.png" alt-text="Diagram of native auth call token endpoint register authentication method or complete MFA."::: 

<!--
The following are more flows you can expect when you enforce MFA for your users:

- The app calls the `/challenge` endpoint to invoke default MFA, but after the app prompts the user for the code, the user selects to complete MFA challenge using a different method. See the following sequence diagram.

:::image type="content" source="media/reference-native-auth-api/sign-in-email-with-password-otp-default-mfa-select-another-MFA.png" alt-text="Diagram of native auth sign in with email and password option where user selects another MFA method."::: 

- The app calls the `/challenge` endpoint, but the endpoint can't determine the default MFA method. In this case, the client app needs to call the `/introspect` endpoint to, so the user selects a specific MFA method. See the following sequence diagram.

:::image type="content" source="media/reference-native-auth-api/sign-in-email-with-password-otp-no-default-MFA.png" alt-text="Diagram of native auth sign in with email and password option with no default MFA method."::: 

-->

---

In the sections that follow, we summarize the sign-in flow into three basic steps.

### Step 1: Request to start the sign-in flow

The authentication flow begins with the application making a POST request to the `/initiate` endpoint to start the sign-in flow.

Here's an example of the request (we present the example request in multiple lines for readability):

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/oauth2/v2.0/initiate
Content-Type: application/x-www-form-urlencoded
client_id=00001111-aaaa-2222-bbbb-3333cccc4444
&challenge_type=password redirect
&username=contoso-consumer@contoso.com
&capabilities=registration_required mfa_required
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
| `client_id`         |   Yes    | The Application (client) ID of the app you registered in the Microsoft Entra admin center.                |
| `username`          |    Yes   |   Email of the customer user such as *contoso-consumer@contoso.com*.  |
| `challenge_type`    |   Yes  | A space-separated list of authorization [challenge type](#sign-in-challenge-types) strings that the app supports such as `oob password redirect`. The list must always include the `redirect` challenge type. The value is expected to `oob redirect` for email one-time passcode and `password redirect` for email with password.|
|`capabilities`| No | Space-separated flags that describe the client app’s "how" readiness. While `challenge_type` defines what methods can be challenged, `capabilities` tell the native authentication API which extra flows the client app can handle and which UIs it can show. For example, `mfa_required` means `/introspect`, `/challenge`, and `/token` loop; `registration_required` means the client app calls registration APIs and show registration UI. If the needed capability isn't included by the client app, the API returns redirect. Supported values are `mfa_required` and `registration_required`. [Learn more about capabilities](concept-native-authentication-challenge-types.md).|

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

|    Property     | Description        |
|----------------------|------------------------|
| `continuation_token`  | [Continuation token](#continuation-token) that Microsoft Entra returns. |  

#### Redirect response

If the client app doesn't support the authentication method or capabilities that Microsoft Entra requires, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra informs the app by returning a *redirect* challenge type in the response:

```http
HTTP/1.1 200 OK
Content-Type: application/json

```

```json
{     
   "challenge_type": "redirect" 
} 
```

|    Property     | Description        |
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

|    Property     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` property):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as when the `challenge_type` parameter includes an invalid challenge type. or the request didn't include `client_id` parameter the client ID value is empty or invalid. Use the `error_description` parameter to learn the exact cause of the error.|  
|`unauthorized_client`| The client ID used in the request has a valid client ID format, but doesn't exist in the external tenant or is incorrect. |
|`invalid_client`| The client ID that the app includes in the request is for an app that lacks native authentication configuration, such as it isn't a public client or isn't enabled for native authentication. Use the `suberror` property to learn the exact cause of the error.|
|`user_not_found`|The username doesn't exist.|
|`unsupported_challenge_type`|The `challenge_type` parameter value doesn't include the `redirect` challenge type.|

If the error parameter has a value of *invalid_client*, Microsoft Entra includes a `suberror` property in its response. Here are the possible values of the `suberror` property for an *invalid_client* error:

|    Suberror value     | Description        |
|----------------------|------------------------|
|`nativeauthapi_disabled`| The client ID for an app that isn't enable for native authentication.|

### Step 2: Select an authentication method

To continue with the flow, the app uses the continuation token it acquires from the previous step to request Microsoft Entra to select one of the supported challenge types for the user to authenticate or complete an MFA challenge. The app makes a POST request to the `/oauth2/v2.0/challenge` endpoint.

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
| `continuation_token` |    Yes   | [Continuation token](#continuation-token) that Microsoft Entra returned in the previous request. The previous request calls the `/oauth2/v2.0/initiate` endpoint, or the `/oauth2/v2.0/introspect` endpoint if the user completes an MFA challenge.|
| `challenge_type`    |   No  | A space-separated list of authorization [challenge type](#sign-in-challenge-types) strings that the app supports such as `oob password redirect`. The list must always include the `redirect` challenge type. The value is expected to `oob redirect` for email one-time passcode and `password redirect` for email with password.|
|`id`| No | The string identifier of the strong authentication method that's returned from the `/oauth2/v2.0/introspect` endpoint. This parameter is required when the client app challenges the user for a second factor authentication. Learn [how to use the introspect endpoint](#get-user-registered-strong-authentication-methods). |
<!--| `challenge_channel` | No | The string identifier of the strong authentication that's returned from the `/oauth2/v2.0/introspect` endpoint. This parameter is required when the client app changes the user for a second factor authentication. Learn [how to interact with the introspect endpoint](#get-user-registered-strong-authentication-methods).|-->

#### Success response

The success response depends on the user's authentication method.

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

|    Property     | Description        |
|----------------------|------------------------|
| `continuation_token`  | [Continuation token](#continuation-token) that Microsoft Entra returns. |
|`challenge_type`| Challenge type selected for the user to authenticate with.|
|`binding_method`|The only valid value is *prompt*. This parameter can be used in the future to offer more ways for the user to enter the one-time passcode. Issued if `challenge_type` is *oob*  |
|`challenge_channel`| The type of the channel through which the one-time passcode was sent. At the moment, we support email. |
|`challenge_target_label` |An obfuscated email where the one-time passcode was sent.|
|`code_length`|The length of the one-time passcode that Microsoft Entra generates. |

# [Email with password](#tab/emailPassword)
If the tenant administrator configured email with password in the Microsoft Entra admin center as the user’s authentication method, the response depends on whether the request to the `/oauth2/v2.0/challenge` endpoint is to select a method for the user to authenticate with or to complete an MFA challenge.

**Response if request is to select an authentication method**

If the request to the `/oauth2/v2.0/challenge` endpoint is to select a method for the user to authenticate with (first factor authentication), Microsoft Entra returns a success response, which includes a challenge type of *password*.

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

|    Property     | Description        |
|----------------------|------------------------|
| `continuation_token`  |  [Continuation token](#continuation-token) that Microsoft Entra returns. |  
|`challenge_type`|Microsoft Entra returns the supported challenge type configured for the user in the Microsoft Entra admin center. In this case the values is expected to be *password*.|


**Response if request is to complete an MFA challenge**

If the request to the `/oauth2/v2.0/challenge` endpoint is to complete an MFA challenge (second factor authentication), Microsoft Entra sends a one-time passcode to the user’s selected MFA challenge channel and provides more information about the one-time passcode.

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

|    Property     | Description        |
|----------------------|------------------------|
| `continuation_token`  | [Continuation token](#continuation-token) that Microsoft Entra returns. |
|`challenge_type`| Challenge type selected for the user to complete MFA.|
|`binding_method`|The only valid value is *prompt*. This parameter can be used in the future to offer more ways for the user to enter the one-time passcode. Issued if `challenge_type` is *oob*  |
|`challenge_channel`| The type of the MFA challenge channel through which the one-time passcode was sent. Surported values: *email, sms*. |
|`challenge_target_label` |An obfuscated email where the one-time passcode was sent.|
|`code_length`|The length of the one-time passcode that Microsoft Entra generates. | 

---

#### Redirect response

A fallback to a web-based authentication flow may be needed in the following scenarios:

- The client app doesn't support the authentication method or capabilities that Microsoft Entra requires.
- The user attempts to use SMS as a strong auth method, but fraud protection blocks the request if it deems it as high risk (only in email with password authentication).

In these scenarios, Microsoft Entra informs the app by returning a *redirect* challenge type in the response:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{     
   "challenge_type": "redirect" 
} 
```

|    Property     | Description        |
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

|    Property     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` property):

|    Error value     | Description        |
|--------------------|--------------------|
|`invalid_request`  |  Request parameter validation failed such as when the `challenge_type` parameter includes an invalid challenge type. |  
|`invalid_grant`|The continuation token included in the request isn't valid.  |
|`expired_token`|The continuation token included in the request is expired. |
|`unsupported_challenge_type`|The `challenge_type` parameter value doesn't include the `redirect` challenge type. |

<!--If the request to the `/challenge` endpoint is to complete an MFA challenge, but the user doesn't have a default MFA method, the error response includes a `suberror` property for an *invalid_request* error:  

|    Suberror value     | Description        |
|----------------------|------------------------|
|`introspect_required`| The user doesn't have a default MFA method. In this case, the client app needs to call the `oauth2/v2.0/introspect` endpoint. Learn [how to interact with the introspect endpoint](#request-for-user-registered-strong-authentication-methods-optional).|-->

### Step 3: Request for security tokens

The app makes a POST request to the `oauth2/v2.0/token` endpoint and provides the user’s credentials chosen in the previous step to acquire security tokens.  

[!INCLUDE [request-security-tokens](./includes/native-auth-api/native-authentication-common-token-endpoint.md)]

### Get user registered strong authentication methods

Use the `oauth2/v2.0/introspect` endpoint to request the user's list of registered strong authentication methods.

Here's an example of the request (we present the example request in multiple lines for readability):

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/oauth2/v2.0/introspect
Content-Type: application/x-www-form-urlencoded
continuation_token=uY29tL2F1dGhlbnRpY...
&client_id=00001111-aaaa-2222-bbbb-3333cccc4444
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
| `client_id`       |   Yes   | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|
| `continuation_token`  |    Yes   |  [Continuation token](#continuation-token) that Microsoft Entra returned in the previous request. |

#### Success response

Example:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{
    "continuation_token": "uY29tL2F1dGhlbnRpY...",
    "methods":[
        {
            "id":"0a0a0a0a-1111-bbbb-2222-3c3c3c3c3c3c",
            "challenge_type":"oob",
            "challenge_channel":"email",
            "login_hint":"c***r@co**o**o.com"
        },
        {   
          "id": "1b1b1b1b-2222-cccc-3333-4d4d4d4d4d4d",   
          "challenge_type": "oob",   
          "challenge_channel": "sms",   
          "login_hint": "+1********6   
        }
    ]
}
```

|    Property     | Description        |
|----------------------|------------------------|
| `continuation_token`  |  [Continuation token](#continuation-token) that Microsoft Entra returns. |
| `methods` | A list (of objects) of user registered strong authentication methods.|

The MFA method object has the following properties:

|    Property     | Description        |
|----------------------|------------------------|
| `id`  |   An autogenerated unique string identifier for the MFA method. The app uses this string as `id` when it calls the `/oauth2/v2.0/challenge` endpoint.  |
| `challenge_type` | Challenge type selected for the user to use as the MFA method. Current supported challenge type is *oob*.  |
| `challenge_channel` | The type of the channel to which the the MFA method is sent. Current supported challenge channel is *email*. |
| `login_hint` | The hint for the strong authentication method such as an obfuscated email.  |


#### Redirect response

If the client app doesn't support the authentication method or capabilities that Microsoft Entra requires, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra informs the app by returning a *redirect* challenge type in the response:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{     
   "challenge_type": "redirect" 
} 
```

#### Error response

Example:

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{ 
    "error": "invalid_request", 
    "error_description": "AADSTS901007: The continuation_token provided is not valid for this endpoint.\r\nTrace ID: 0000aaaa-11bb-cccc-dd22-eeeeee333333\r\nCorrelation ID: aaaa0000-bb11-2222-33cc-444444dddddd\r\nTimestamp: yyyy-...",
    "error_codes": [ 
        50126 
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "0000aaaa-11bb-cccc-dd22-eeeeee333333", 
    "correlation_id": "aaaa0000-bb11-2222-33cc-444444dddddd"
} 
```

|    Property     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` property):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed. To understand what happened, use the message in the error description.   |  
|`invalid_client`| The client ID included in the request isn't for a public client. |
|`expired_token`| The continuation token included in the request is expired. |
| `server_error` | Something went wrong with the request. |

After the client app successfully retrieves a list of strong authentication methods registered for the user, the user selects a method they wish to use to complete the MFA challenge. The flow then proceed as follows:

1. The client app calls the `/oauth2/v2.0/challenge` and includes the continuation token obtained from the `/oauth2/v2.0/introspect` and the `id` of the MFA method of choice:
    
    ```http
    POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/oauth2/v2.0/challenge
    Content-Type: application/x-www-form-urlencoded    
    client_id=00001111-aaaa-2222-bbbb-3333cccc4444
    &id=0a0a0a0a-1111-bbbb-2222-3c3c3c3c3c3c 
    &continuation_token=uY29tL2F1dGhlbnRpY... 
    ```

1. Microsoft Entra sends a challenge code to the user's challenge channel, such as email, and then responds back to the client app with a continuation token and the MFA challenge details:
    
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

1. The app can now make a POST request to the `/oauth2/v2.0/token` endpoint and includes a continuation token, correct grant type, and corresponding grant type values to get security tokens. See expected response in [Request for security tokens](#step-3-request-for-security-tokens):

    ```http
    POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/oauth2/v2.0/token
    Content-Type: application/x-www-form-urlencoded    
    client_id=00001111-aaaa-2222-bbbb-3333cccc4444 
    &continuation_token=uY29tL2F1dGhlbnRpY...   
    &grant_type=mfa_oob  
    &oob={otp_code}
    &scope=openid offline_access
    ```


<!--### Determine the default MFA method

Microsoft Entra determines the default MFA method for the user by priority as follows:

1. Use [a system-preferred MFA](../identity/authentication/concept-system-preferred-multifactor-authentication.md).
1. Use an MFA set as default on the user by the tenant administrator.
1. User has only one registered MFA method. -->


## Register a strong authentication method API reference

Native authentication supports registration of strong authentication method. When the app calls the [/oauth2/v2.0/token](#step-3-request-for-security-tokens) endpoint and MFA is required but the user has no registered strong method, the response, *registeration_required*, tells the app to have the user register one before tokens can be issued.

After the client app completes the flow to register a strong authentication method, it calls the `/oauth2/v2.0/token` endpoint to request for security tokens.

### Strong authentication method registration endpoints

To use the strong authentication method registration  API, the app uses the endpoint shown in the following table:

|    Endpoint     | Description        |
|----------------------|------------------------|
|`/register/v1.0/introspect`| Call this endpoint to fetch a list of strong authentication methods that the user can register.   |
|`/register/v1.0/challenge`| Call this endpoint to send the challenge to the user, such as email one-time passcode.|
|`/register/v1.0/continue`| Call this endpoint to submit the challenge the app collects from the user, such as one-time passcode, to complete a flow to register a strong authentication method. After the call succeeds and you obtain a continuation token, call the `/oauth2/v2.0/token` endpoint endpoint to request security tokens. [Learn how to call the token endpoint](#step-3-request-for-security-tokens).|


### Step 1: Get the list of strong authentication methods

The registration flow begins when the app requests the list of strong authentication methods the user is permitted to enroll.

Here's an example of the request (we present the example request in multiple lines for readability):

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/register/v1.0/introspect
Content-Type: application/x-www-form-urlencoded
?continuation_token=uY29tL2F1dGhlbnRpY... 
&client_id=00001111-aaaa-2222-bbbb-3333cccc4444  
```

|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
| `client_id`         |   Yes    | The Application (client) ID of the app you registered in the Microsoft Entra admin center.                |

#### Success response

Here's an example of a successful response:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{
    "continuation_token": "uY29tL2F1dGhlbnRpY...",
    "methods":[
        {
            "id":"email",
            "challenge_type":"oob",
            "challenge_channel":"email",
            "login_hint":"caseyjensen@contoso.com"
        },
        {   
          "id": "sms",   
          "challenge_type": "oob",   
          "challenge_channel": "sms"
        }
    ]
}
```

|    Property     | Description        |
|----------------------|------------------------|
| `continuation_token`  |  [Continuation token](#continuation-token) that Microsoft Entra returns. |
| `methods` | A list (of objects) of strong authentication methods available to the user to enroll.|

The strong authentication methods object has the following properties:

|    Property     | Description        |
|----------------------|------------------------|
| `id`  |  String key of the method. Supported values *email, sms*.  |
| `challenge_type` | Challenge type selected for the user to use as the MFA method. Current supported challenge type is *oob*.  |
| `challenge_channel` | The type of the channel to which the the MFA method is sent. Supported values *email, sms*. |
| `login_hint` | The hint for the strong authentication method such as an email. This value is used by the client app to prepopulate the email textbox.|


#### Error response

Example:

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json
```

```json
{ 
    "error": "invalid_request", 
    "error_description": "AADSTS901007: The continuation_token provided is not valid for this endpoint.\r\nTrace ID: 0000aaaa-11bb-cccc-dd22-eeeeee333333\r\nCorrelation ID: aaaa0000-bb11-2222-33cc-444444dddddd\r\nTimestamp: yyyy-...",
    "error_codes": [ 
        50126 
    ], 
    "timestamp": "yyyy-mm-dd 10:15:00Z",
    "trace_id": "0000aaaa-11bb-cccc-dd22-eeeeee333333", 
    "correlation_id": "aaaa0000-bb11-2222-33cc-444444dddddd"
} 
```

|    Property     | Description        |
|----------------------|------------------------|
|`error`  |  An error code string that can be used to classify types of errors, and to react to errors.   |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` property):

|    Error value     | Description        |
|----------------------|------------------------|
|`invalid_request`  | Request parameter validation failed such as a validation of *continuation token* failed or the request didn't include `client_id` parameter the client ID value is empty or invalid or the external tenant administrator hasn't enabled email OTP for all tenant users.   |  
|`expired_token`|The continuation token included in the request is expired. |

### Step 2: Select strong authentication method

In this step, submit the strong authentication method that the user wishes to register. Microsoft Entra then sends a challenge, such as email one-time passcode, to the user.

Here's an example of the request (we present the example request in multiple lines for readability):

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/register/v1.0/challenge 

?continuation_token=uY29tL2F1dGhlbnRpY... 
&client_id=00001111-aaaa-2222-bbbb-3333cccc4444  
&challenge_type=oob  
&challenge_channel=email 
&challenge_target=contoso-consumer@contoso.com 
```


|    Parameter     | Required                     |           Description        |
|-----------------------|-------------------------|------------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
| `client_id`         |   Yes    | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|
|`continuation_token` | Yes |  The [Continuation token](#continuation-token) that Microsoft Entra returns from the `/register/v1.0/introspect ` endpoint |
| `challenge_type` | Yes | The challenge type of the authentication method. Current type is *oob*. |
|`challenge_target` | Yes | The email or phone number that the user wants to register.  |
|`challenge_channel` | No | The channel to send the challenge on. Supported challenge channel values: *email, sms*. |


#### Success response

Here's an example of a successful response.

Example 1:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{ 
  "continuation_token": "uY29tL2F1dGhlbnRpY...", 
  "challenge_type": "oob", 
  "binding_method": "prompt", 
  "challenge_target": "contoso-consumer@contoso.com", 
  "challenge_channel": "email", 
  "code_length": 8 
} 
```

Example 2:

If the sign-up flow precedes the strong authentication method registration flow and the email submitted to the `/register/v1.0/challenge` endpoint matches the one verified in the sign-up flow, the native authentication API registers the method without sending a challenge to the user. In this case, the response will look similar to the following snippet:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{ 
  "continuation_token": "uY29tL2F1dGhlbnRpY...",
  "challenge_type": "preverified" 
}
```

|    Property     | Description        |
|----------------------|------------------------|
| `continuation_token`  | [Continuation token](#continuation-token) that Microsoft Entra returns. |
|`challenge_type`| Challenge type selected for the user to authenticate with, such as *oob*, or *preverified* if the strong authentication method gets preverified.|
|`binding_method`|The only valid value is *prompt*. This parameter can be used in the future to offer more ways to the user to enter the one-time passcode. Issued if `challenge_type` is *oob* and the strong authentication method is not preverified.  |
|`challenge_channel`| The type of the channel through which the one-time passcode was sent. Supported values *email, sms*. Returned if strong authentication method is not preverified.|
|`code_length`|The length of the one-time passcode if `binding_method` is prompt. Returned if strong authentication method is not preverified.|
|`challenge_target` |The target the challenge was sent to. This is the same as the input provided in the request. Returned if strong authentication method is not preverified.|
|`interval` |The interval (in seconds) the client should wait between polling of /register/continue. Only Returned if `prompt=none` and the strong authentication method is not preverified. Clients should double the interval every time they receive a `HTTP 429` from the native authentication API. |


#### Error response

The errors here are similar to those you can experience when you call the `/register/v1.0/introspect` endpoint. However, when enrolling phone number, if the phone number is considered high risk, the request may be blocked.

Here are the possible errors you can encounter if the request is blocked:

|    Error value     | Description        |
|----------------------|------------------------|
|`access_denied`  | SMS has been blocked. |


If the error parameter has a value of *access_denied*, Microsoft Entra includes a suberror property in its response. Here are the possible values of the suberror property for an invalid_grant error:

|    Suberror value     | Description        |
|----------------------|------------------------|
|`provider_blocked_by_admin`  | The tenant administrator has blocked the phone region.  |
|`provider_blocked_by_rep` | The multifactor authentication method is blocked (phone number was blocked by RepMap).  |


### Step 3: Submit challenge

In this step, make a call to the `/register/v1.0/continue` endpoint to complete registration of the strong authentication method.


Here's an example of the request (we present the example request in multiple lines for readability):

```http
POST https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/register/v1.0/continue 

?continuation_token=uY29tL2F1dGhlbnRpY... 
&client_id=00001111-aaaa-2222-bbbb-3333cccc4444  
&grant_type=oob  
&oob={otp_code}
```

|    Parameter     | Required | Description        |
|----------------------|------------------------|------------------|
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
| `continuation_token`  | Yes |[Continuation token](#continuation-token) that Microsoft Entra returned in the previous request.|
|`client_id`| Yes | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|
|`grant_type` | Yes |The grant type. Current supported value is *oob*, or *continuation_token* if the strong authentication method gets preverified in the `/register/v1.0/challenge` endpoint.|
|`oob`| No | The one-time passcode that the customer user received in their email. Replace `{otp_code}` with the one-time passcode values that the customer user received in their email. To **resend a one-time passcode**, the app needs to make a request to the `/register/v1.0/challenge` endpoint again. Required if strong authentication method is not preverified in the `/register/v1.0/challenge` endpoint.|

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

|    Property     | Description        |
|----------------------|------------------------|
| `continuation_token`  | The [continuation token](#continuation-token) that Microsoft Entra returns. Use this continuation token to call the `/oauth2/v2.0/token` endpoint to request for security tokens. Learn [how to call the token endpoint](#step-3-request-for-security-tokens).|


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
   
|    Property     | Description        |
|----------------------|------------------------|
|`error`  |  An error code string that can be used to classify types of errors, and to react to errors.   |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` property):

|    Error value     | Description        |
|----------------------|------------------------|
|`invalid_request`  | Request parameter validation failed such as a validation of *continuation token* failed or the request didn't include `client_id` parameter the client ID value is empty or invalid or the external tenant administrator hasn't enabled email OTP for all tenant users.   |  
|`invalid_grant`|The grant type included in the request isn't valid or supported, or OTP value is incorrect.|
|`expired_token`|The continuation token included in the request is expired. |

If the error parameter has a value of *invalid_grant*, Microsoft Entra includes a `suberror` property in its response. Here are the possible values of the `suberror` property for an *invalid_grant* error:

|    Suberror value     | Description        |
|----------------------|------------------------|
|`invalid_oob_value`| The value of one-time passcode is invalid.|


## Self-service password reset (SSPR)

**For users whose primary authentication method is email with password**, use the self-service password reset (SSPR) API to enable customer users to reset their password. You can use this API for forgot password or change password scenarios.

### API endpoints for self-service password reset 

To use this API, the app uses the endpoint shown in the following table:

|    Endpoint     | Description        |
|----------------------|------------------------|
| `/resetpassword/v1.0/start`  | Your app calls this endpoint when the customer user selects **Forgot password** or **Change password** link or button in the app. This endpoint validates the user's username (email), then returns a *continuation token* to use in the password reset flow. If your app requests to use authentication methods that aren't supported by Microsoft Entra, this endpoint response can indicate to your app that it needs to use a browser-based authentication flow. |
|`/resetpassword/v1.0/challenge`| Accepts a list of challenge types supported by the client and the *continuation token*. A challenge is issued to one of the preferred recovery credentials. For example, oob challenge issues an out-of-band one-time passcode to the email associated with the customer user account. If your app requests to use authentication methods that aren't supported by Microsoft Entra, this endpoint response can indicate to your app that it needs to use a browser-based authentication flow.    |
|`/resetpassword/v1.0/continue`| Validates the challenge issued by the `/resetpassword/v1.0/challenge` endpoint, then either returns a *continuation token* for the `/resetpassword/v1.0/submit` endpoint, or issues another challenge to the user.  |
|`/resetpassword/v1.0/submit`| Accepts a new password input by the user along with the *continuation token* to complete the password reset flow. This endpoint issues another *continuation token*. |
|`/resetpassword/v1.0/poll_completion`|  The app can use the *continuation token* issued by the `/resetpassword/v1.0/submit` endpoint to check the status of the password reset request. |
|`oauth2/v2.0/token`| If password reset is successfull, the app can use the continuation token it obtains from the `/resetpassword/v1.0/poll_completion` endpoint to obtain security tokens from the `oauth2/v2.0/token` endpoint. |

### Self-service password reset challenge types

The API allows the app to advertise the authentication methods it supports, when it makes a call to Microsoft Entra. To do so, the app uses the `challenge_type` parameter in its requests. This parameter holds predefined values, which represent different authentication methods.

For the SSPR flow, the challenge type values are *oob*, and *redirect*.  

Learn more about challenge types in the [native authentication challenge types](../external-id/customers/concept-native-authentication-challenge-types.md).


### Self-service password reset flow protocol details

The sequence diagram demonstrates the flow for the password reset process.

:::image type="content" source="media/reference-native-auth-api/self-service-password-reset.png" alt-text="Diagram of native auth self-service password reset flow."::: 

This diagram indicates that the app collects username (email) and password from the user at different times (and possibly on separate screens). However, you can design your app to collect the username (email) and new password on the same screen. In this case, the app holds the password, then submits it via the `/resetpassword/v1.0/submit` endpoint where it's required.

### Step 1: Request to start the self-service password reset flow

The password reset flow starts with the app making a POST request to the `/resetpassword/v1.0/start` endpoint to start the self-service password reset flow.

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
| `client_id`         |   Yes    | The Application (client) ID of the app you registered in the Microsoft Entra admin center.               |
| `username`          |    Yes   |   Email of the customer user such as *contoso-consumer@contoso.com*.  |
| `challenge_type`    |   Yes  | A space-separated list of authorization [challenge type](#self-service-password-reset-challenge-types) strings that the app supports such as `oob password redirect`. The list must always include the `redirect` challenge type. For this request, the value is expected to contain `oob redirect`.|
|`capabilities`| No | Space-separated flags that describe the client app’s “how” readiness. While `challenge_type` defines what methods can be challenged, `capabilities` tell the native authentication API which extra flows the client app can handle and which UIs it can show. For example, `mfa_required` means another `/challenge` and `/token` loop; `registration_required` means the client app calls registration APIs and show registration UI. If a required capability isn’t advertised by the client app, the API returns redirect. Supported values are `mfa_required` and `registration_required`. [Learn more about capabilities](concept-native-authentication-challenge-types.md).|

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

|    Property     | Description        |
|----------------------|------------------------|
| `continuation_token`  |  [Continuation token](#continuation-token) that Microsoft Entra returns. |

#### Redirect response 

If the client app doesn't support the authentication method or capabilities that Microsoft Entra requires, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra informs the app by returning a *redirect* challenge type in the response:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{     
   "challenge_type": "redirect" 
} 
```

|    Property     | Description        |
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

|    Property     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` property):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as when the `challenge_type` parameter includes an invalid challenge type or the request didn't include `client_id` parameter the client ID value is empty or invalid. Use the `error_description` parameter to learn the exact cause of the error.   |  
|`user_not_found`|The username doesn't exist.|
|`unsupported_challenge_type`|The `challenge_type` parameter value doesn't include the `redirect` challenge type.|
|`invalid_client`| The client ID that the app includes in the request is for an app that lacks native authentication configuration, such as it isn't a public client or isn't enabled for native authentication. Use the `suberror` property to learn the exact cause of the error.|
|`unauthorized_client`| The client ID used in the request has a valid client ID format, but doesn't exist in the external tenant or is incorrect. |

If the error parameter has a value of *invalid_client*, Microsoft Entra includes a `suberror` property in its response. Here are the possible values of the `suberror` property for an *invalid_client* error:

|    Suberror value     | Description        |
|----------------------|------------------------|
|`nativeauthapi_disabled`| The client ID for an app that isn't enabled for native authentication.|


### Step 2: Select an authentication method

To continue with the flow, the app uses the continuation token acquired from the previous step to request Microsoft Entra to select one of the supported challenge types for the user to authenticate with. The app makes a POST request to the `/resetpassword/v1.0/challenge` endpoint. If this request is successful, Microsoft Entra sends a one-time passcode to the user's account email. At the moment, we only support email OTP.

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

|    Property     | Description        |
|----------------------|------------------------|
| `continuation_token`  | [Continuation token](#continuation-token) that Microsoft Entra returns. |
|`challenge_type`| Challenge type selected for the user to authenticate with.|
|`binding_method`|The only valid value is *prompt*. This parameter can be used in the future to offer more ways to the user to enter the one-time passcode. Issued if `challenge_type` is *oob*  |
|`challenge_channel`| The type of the channel through which the one-time passcode was sent. At the moment, we support email. |
|`challenge_target_label` |An obfuscated email where the one-time passcode was sent. If MFA is enabled for the user, the email containing the one-time passcode is sent to the: <br> - email address used as the strong authentication method when the email address is different from the account email address. <br> - account email address when the strong authentication method is SMS.|
|`code_length`|The length of the one-time passcode that Microsoft Entra generates. |

#### Redirect response

If the client app doesn't support the authentication method or capabilities that Microsoft Entra requires, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra informs the app by returning a *redirect* challenge type in the response:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{     
   "challenge_type": "redirect" 
} 
```

|    Property     | Description        |
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

|    Property     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` property):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as when the `challenge_type` parameter includes an invalid challenge type or *continuation token* validation failed.   |  
|`expired_token`|The continuation token is expired.  |
|`unsupported_challenge_type`|The `challenge_type` parameter value doesn't include the `redirect` challenge type.|

### Step 3: Submit one-time passcode

The app then makes a POST request to the `/resetpassword/v1.0/continue` endpoint. In the request, the app needs to include the user’s credentials chosen in the previous step and the continuation token issued from the `/resetpassword/v1.0/challenge` endpoint.

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
|`oob`| Yes |The one-time passcode that the customer user received in their email. Replace `{otp_code}` with the one-time passcode that the customer user received in their email. To **resend a one-time passcode**, the app needs to make a request to the `/resetpassword/v1.0/challenge` endpoint again. |

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

|    Property     | Description        |
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

|    Property     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |
|`suberror` | An error code string that can be used to further classify types of errors.|

Here are the possible errors you can encounter (possible values of the `error` property):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as a validation of *continuation token* failed or the request didn't include `client_id` parameter the client ID value is empty or invalid or the external tenant administrator hasn't enabled SSPR and email OTP for all tenant users. Use the `error_description` parameter to learn the exact cause of the error. |
|`invalid_grant` |The grant type is unknown or doesn't match the expected grant type value. Use the `suberror` property to learn the exact cause of the error.|
|`expired_token`|The continuation token is expired.    |


If the error parameter has a value of *invalid_grant*, Microsoft Entra includes a `suberror` property in its response. Here are the possible values of the `suberror` property for an *invalid_grant* error:

|    Suberror value     | Description        |
|----------------------|------------------------|
|`invalid_oob_value`|The value of one-time passcode is invalid.|


### Step 4: Submit a new password

The app collects a new password from the user, then uses the *continuation token* issued by the `/resetpassword/v1.0/continue` endpoint to submit the password by making a POST request to the `/resetpassword/v1.0/submit` endpoint.

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

|    Property     | Description        |
|----------------------|------------------------|
| `continuation_token`  |  [Continuation token](#continuation-token) that Microsoft Entra returns.  |
|`poll_interval`|The minimum amount of time in seconds that the app should wait between polling requests to check the status of the password reset request via the `/resetpassword/v1.0/poll_completion` endpoint, see [step 5](#step-5-poll-for-password-reset-status)  |

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

|    Property     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |
|`suberror` | An error code string that can be used to further classify types of errors.|

Here are the possible errors you can encounter (possible values of the `error` property):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as a validation of *continuation token* failed.   |
|`expired_token`|The *continuation token* is expired.    |
|`invalid_grant`| The grant submitted is invalid, such as the password submitted is too short. Use the `suberror` property to learn the exact cause of the error.|

If the error parameter has a value of *invalid_grant*, Microsoft Entra includes a `suberror` property in its response. Here are the possible values of the `suberror` property:

|    Suberror value     | Description        |
|----------------------|------------------------|
|`password_too_weak`|Password is too weak as it doesn't meet complexity requirements. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md).|
|`password_too_short`|New password is fewer than 8 characters. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md).|
|`password_too_long` |New password is longer than 256 characters. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md). |
|`password_recently_used`|The new password must not be the same as one recently used. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md).|
|`password_banned`|New password contains a word, phrase, or pattern that is banned. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md).|
|`password_is_invalid`| Password is invalid, for example because it uses disallowed characters. [Learn more about Microsoft Entra's password policies](../identity/authentication/concept-password-ban-bad-combined-policy.md). This response is possible if the app submits a user password.|

### Step 5: Poll for password reset status

Lastly, since updating of the user’s configuration with the new password incurs some delay, the app can use the `/resetpassword/v1.0/poll_completion` endpoint to poll Microsoft Entra for password reset status. The minimum amount of time in seconds that the app should wait between polling requests is returned from the `/resetpassword/v1.0/submit` endpoint in the `poll_interval` parameter.  

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

|    Property     | Description        |
|----------------------|------------------------|
| `status`  | The status of the reset password request. If Microsoft Entra returns a status of *failed*, the app can resubmit the new password by making another request to the `/resetpassword/v1.0/submit` endpoint and include the new continuation token.|
| `continuation_token`  |  [Continuation token](#continuation-token) that Microsoft Entra returns. If the status is *succeeded*, the app can use the continuation token that Microsoft Entra returns to request for security tokens via the `oauth2/v2.0/token` endpoint as explained in [Request for security tokens](#step-3-request-for-security-tokens). This means that after a user successfully resets their password, you can directly sign them into your app without initiating a new sign-in flow.|

Here are the possible statuses that Microsoft Entra returns (possible values of the `status` parameter):

|    Error value     | Description        |
|----------------------|------------------------|
| `succeeded` |  Password reset completed successfully. |
| `failed` |Password reset failed. The app can resubmit the new password by making another request to the `/resetpassword/v1.0/submit` endpoint.|
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

|    Property     | Description        |
|----------------------|------------------------|
| `error`  |   An error code string that can be used to classify types of errors, and to react to errors.  |  
|`error_description` | A specific error message that can help you to identify the cause of an authentication error. |
|`error_codes`| A list of Microsoft Entra-specific error codes that can help you to diagnose errors.  |
|`timestamp`|The time when the error occurred.|
|`trace_id` |A  unique identifier for the request that can help you to diagnose errors.|
|`correlation_id`|A  unique identifier for the request that can help in diagnostics across components. |

Here are the possible errors you can encounter (possible values of the `error` property):

|    Error value     | Description        |
|----------------------|------------------------|
| `invalid_request`  |  Request parameter validation failed such as validation of *continuation token* failed.   |
|`expired_token`|The *continuation token* is expired.    |

### Automatically sign in after password reset

If the user needs to sign in after a successful password reset. The app needs to call the `/oauth2/v2.0/token` endpoint. Learn [how to call the token endpoint](#step-3-request-for-security-tokens).

## Related content

- [Configure a custom claims provider](custom-extension-tokenissuancestart-configuration.md?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json).