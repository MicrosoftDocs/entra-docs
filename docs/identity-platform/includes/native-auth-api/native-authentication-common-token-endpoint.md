---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 02/27/2026
ms.author: kengaderdus
---

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
| `tenant_subdomain`  |   Yes |  The subdomain of the external tenant that you created. In the URL, replace `{tenant_subdomain}` with the Directory (tenant) subdomain. For example, if your tenant's primary domain is *contoso.onmicrosoft.com*, use *contoso*. If you don't have your tenant subdomain, [learn how to read your tenant details](../../../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).|
| `client_id`       |   Yes   | The Application (client) ID of the app you registered in the Microsoft Entra admin center.|
| `continuation_token`          |    Yes   |  [Continuation token](../../reference-native-authentication-api.md#continuation-token) that Microsoft Entra returned in the previous request. |
|`grant_type`| Yes |The grant type. When you call the token endpoint, this value must be: </br> - *password* for email with password authentication method in a sign-in flow to verify the user's first factor authentication. </br> - *oob* for email one-time passcode authentication method in a sign-in flow. </br>  - *continuation_token* for automatic sign-in after a sign-up flow. </br> - *continuation_token* for automatic sign-in after self-service password reset flow. </br> - *continuation_token* after a [strong authentication method registration flow](../../reference-native-authentication-api.md#register-a-strong-authentication-method-api-reference). </br> - *mfa_oob* when verifying the user's second factor authentication.|
|`scope`| Yes | A space-separated list of scopes. All the scopes must be from a single resource, along with OpenID Connect (OIDC) scopes, such as *profile*, *openid, and *email*. The app needs to include *openid* scope for Microsoft Entra to issue an ID token. The app needs to include *offline_access* scope for Microsoft Entra to issue a refresh token. Learn more about [Permissions and consent in the Microsoft identity platform](../../permissions-consent-overview.md). |
|   `password`    | No | The password value that the app collects from the user. Replace `{secure_password}` with the password value that the app collects from the user. This parameter is **required** if the authentication method is email with password.|
| `oob` | No | The one-time passcode the user receives by email. Required if: </br> - The primary authentication method is email one-time passcode. </br> - The app is submitting the email one-time passcode to satisfy an MFA challenge when the primary authentication method is email with password. </br> To resend a one-time passcode, call the `/challenge` endpoint again. |
| `username` | No | Email of the user that they want to sign up with, such as contoso-consumer@contoso.com. This parameter is **required** in a sign-up flow. |

> [!NOTE]  
> For SMS OTP MFA, when verifying the one-time passcode for strong authentication method, use `https://{tenant_subdomain}.ciamlogin.com/{tenant_ID}/oauth2/v2.0/token` token endpoint instead of `https://{tenant_subdomain}.ciamlogin.com/{tenant_subdomain}.onmicrosoft.com/oauth2/v2.0/token`.

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

|    Property     | Description        |
|----------------------|------------------------|
|`token_type` |  Indicates the token type value. The only type that Microsoft Entra supports is *Bearer*.|
|`scopes`|  A space-separated list of scopes that the access token is valid for.|
|`expires_in`|   The length of time in seconds the access token remains valid.|
| `access_token`  |    The access token that the app requested from the `/token` endpoint. The app can use this access token to request access to secured resources such as web APIs.| 
|`refresh_token` |  An OAuth 2.0 refresh token. The app can use this token to acquire other access tokens after the current access token expires. Refresh tokens are long-lived. They can maintain access to resources for extended periods. For more detail on refreshing an access token, refer to [Refresh the access token](../../v2-oauth2-auth-code-flow.md#refresh-the-access-token) article. <br> **Note**: Only issued if you request *offline_access* scope.   |
|`id_token`|  A JSON Web Token (Jwt) used to identify the user. The app can decode the token to request information about the user who signed in. The app can cache the values and display them, and confidential clients can use this token for authorization. For more information about ID tokens, see [ID tokens](../../id-tokens.md).<br> **Note**: Only issued if you request *openid* scope. |

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
| `invalid_request` |  Request parameter validation failed. To understand what happened, use the message in the error description. |  
|`invalid_grant`|The continuation token included in the request isn't valid or user sign in credentials included in the request are invalid or further interaction required from the user or the grant type included in the request is unknown. |
|`invalid_client`| The client ID included in the request isn't for a public client. |
|`expired_token`|The continuation token included in the request is expired. |
|`invalid_scope`| One or more of the scoped included in the request are invalid. |
|`unauthorized_client`| The client ID included in the request is invalid or doesn't exist. |
|`unsupported_grant_type`| The grant type included in the request isn't supported or is incorrect. |

If the error parameter has a value of *invalid_grant*, Microsoft Entra includes a `suberror` property in its response. Here are the possible values of the `suberror` property for an *invalid_grant* error:


|    Suberror value     | Description        |
|----------------------|------------------------|
|`invalid_oob_value`| The value of one-time passcode that the app submits is invalid. |
| `mfa_required` | MFA is required. The response includes a [continuation token](../../reference-native-authentication-api.md#continuation-token). Call the `oauth2/v2.0/introspect` endpoint to get the user's registered strong authentication methods. **This suberror only occurs when the user's primary authentication method is email with password.** See how to [get a user's registered strong authentication methods](../../reference-native-authentication-api.md#get-user-registered-strong-authentication-methods). <br><br>**Note**: In some cases MFA is required but native authentication doesn't return `mfa_required`. For example, if a [strong authentication method registration](../../reference-native-authentication-api.md#register-a-strong-authentication-method-api-reference) flow precedes a call to the `/oauth2/v2.0/token` and the only available method (email) was already verified during that flow.|
| `registration_required` | The user must complete an MFA challenge but has no registered strong authentication method. Prompt the user to register one. **This error occurs when the user's primary authentication method is email with password.** Learn how to [register a strong authentication method](../../reference-native-authentication-api.md#register-a-strong-authentication-method-api-reference). |

<!--| `basic_action` | This error occurs where the user is required to complete an MFA challenge, but the user has no MFA method registered. This scenario can happen if the tenant administrator changes MFA configuration, or if the user moves to a new location rendering the initially registered MFA method invalid.| -->

#### Redirect response

If the client app doesn't support the authentication method or capability that Microsoft Entra requires, a fallback to the web-based authentication flow is needed. In this scenario, Microsoft Entra informs the app by returning a *redirect* challenge type in its response:

```http
HTTP/1.1 200 OK
Content-Type: application/json
```

```json
{     
    "challenge_type": "redirect",
    "redirect_reason": "Client is missing registration_required capability"
} 
```

|    Property     | Description        |
|----------------------|------------------------|
| `challenge_type`  | Microsoft Entra returns a response that has a challenge type. The value of this challenge type is redirect, which enables the app to use the web-based authentication flow.  |  
|`redirect_reason`| A reason for which a redirect is required. For example, Microsoft Entra detects that MFA or a registrationg for a strong authentication method is required, but the app didn't include these capabilities in its request.  |

This response is considered successful, but the app is required to switch to a web-based authentication flow. In this case, we recommend that you use a [Microsoft-built and supported authentication library](../../reference-v2-libraries.md).