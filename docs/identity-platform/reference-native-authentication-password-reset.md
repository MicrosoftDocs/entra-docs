---
title: Native authentication password reset API reference
description: Verify customer recovery credentials, update a password, poll completion, and acquire tokens with the Native Authentication API.
author: adamstoffel
ms.author: adamstoffel
ms.service: identity-platform
ms.subservice: external
ms.topic: reference
ms.custom: msecd-doc-authoring-1030
ms.date: 11/13/2026
ai-usage: ai-generated
#customer intent: As an application developer, I want the password reset operations so that customers can recover access without bypassing authentication policies.
---

# Native authentication password reset API reference

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

[!INCLUDE [applies-to-authentication-native](../external-id/includes/applies-to-authentication-native.md)]

Password reset verifies a customer's recovery method, accepts a replacement password, and polls an asynchronous update. Email and SMS one-time passcode (OTP) methods support recovery. Multifactor authentication (MFA) and Conditional Access requirements can apply after the reset and before authorization completes.

For existing V1 integrations, use the [V1 API reference](reference-native-authentication-api-v1.md).

## Prerequisites

[!INCLUDE [native-authentication-public-preview](../external-id/includes/native-authentication-public-preview.md)]

- An [application configured for native authentication](how-to-native-authentication-configure-app.md).
- Password reset enabled for the tenant and customer, with a usable recovery method. See [Enable self-service password reset](../external-id/customers/how-to-enable-password-reset-customers.md).
- The delegated permissions and consent required for a target API, if you request an API scope.

The examples use a [tenant-verified custom-domain authority](reference-native-authentication.md#operations-and-authority). `custom_domain` is the authentication domain and `tenant` is the tenant GUID.

Passwordless email-OTP accounts don't have a password to reset.

## Start password reset

The diagram shows a standalone recovery sequence using email one-time passcode verification. Inline recovery instead uses the password method's `recover` link within the active sign-in transaction.

:::image type="complex" source="media/native-authentication-v2/native-password-reset-sequence.svg" alt-text="Sequence diagram of password recovery, passcode verification, password update, optional polling, and authorization-code exchange." lightbox="media/native-authentication-v2/native-password-reset-sequence.svg":::
   The application starts authorization and follows the returned password-reset link with the customer's identifier and current token.

   The application challenges an offered email recovery method, collects the delivered passcode, and verifies it. When requested, the user supplies a replacement password and the application follows the returned update link.

   The application polls only while the current action is `poll` and completes any remaining authentication requirements. It then resumes authorization when allowed and exchanges the authorization code for tokens.
:::image-end:::

[Start authorization](reference-native-authentication.md#start-authorization) and follow the returned reset-password link (`resetPassword` or `reset_password`). Don't call sign-in discovery first:

```http
POST https://{custom_domain}/{tenant}/api/v2.0/resetpassword/start
Content-Type: application/json
Accept: application/hal+json
```

```json
{
  "username": "user@contoso.com",
  "continuationToken": "******"
}
```

Send the customer's identifier in `username` and the current authorization token in `continuationToken`. The example uses an email address. A response can advertise an email recovery method:

```json
{
  "state": "interactionRequired",
  "action": "challenge",
  "continuationToken": "******",
  "_links": {
    "self": {
      "href": "/{tenant}/api/v2.0/resetpassword/start"
    }
  },
  "_embedded": {
    "methods": [
      {
        "id": "{email_method_id}",
        "type": "email",
        "hint": "j****n@c****o",
        "_links": {
          "challenge": {
            "href": "/{tenant}/api/v2.0/auth/methods/email/{email_method_id}/challenge"
          },
          "verify": {
            "href": "/{tenant}/api/v2.0/auth/methods/email/{email_method_id}/verify"
          }
        }
      }
    ]
  }
}
```

Select a returned email or SMS recovery method through user choice or application flow logic. The example shows email; for SMS, follow the returned SMS method's links without rewriting the example URL. Use the masked hint where the interface needs a destination label.

### Inline recovery during sign-in

Offer inline recovery only when a password method in the current sign-in response advertises a `recover` link. Follow that link using the current sign-in continuation token. Don't start another authorization request or resubmit the username or password.

```http
POST https://{custom_domain}/{tenant}/api/v2.0/auth/methods/password/{password_method_id}/recover
Content-Type: application/json
Accept: application/hal+json
```

```json
{
  "continuationToken": "******"
}
```

Both entry points use the recovery method, challenge, verification, password-update, and polling operations returned by the service.

## Challenge and verify the recovery method

Post to the selected method's `challenge` link:

```json
{
  "continuationToken": "******"
}
```

Use JSON and `Accept: application/hal+json`. The [shared challenge operation](reference-native-authentication.md#challenge-or-resend) returns the current method type, masked `hint`, `codeLength`, and `verify` and optional `resend` links.

Post the entered passcode to the returned `verify` link:

```json
{
  "otp": "{one_time_passcode}",
  "continuationToken": "******"
}
```

Use the newest token for each request. For another code, use the current `resend` link and service limits, not an earlier challenge URL/token pair.

A successful verification can return the password method:

```json
{
  "state": "interactionRequired",
  "action": "update",
  "id": "{password_method_id}",
  "type": "password",
  "continuationToken": "******",
  "_links": {
    "update": {
      "href": "/{tenant}/api/v2.0/auth/methods/password/{password_method_id}"
    }
  }
}
```

Use the password method ID from the returned `update` link, not the email or SMS recovery method ID. Inline recovery can retain the password method ID from the parent sign-in.

## Update a password

Submit the replacement password with `PUT`, not `POST`:

```http
PUT https://{custom_domain}/{tenant}/api/v2.0/auth/methods/password/{password_method_id}
Content-Type: application/json
Accept: application/hal+json
```

```json
{
  "newPassword": "{new_password}",
  "continuationToken": "******"
}
```

| Property | Type | Required | Description |
| --- | --- | --- | --- |
| **`continuationToken`** | String. | Yes. | Current token requesting password update. |
| **`newPassword`** | String. | Yes. | Replacement password. Password confirmation is local to your interface, not an additional request field. |

The service can return:

```json
{
  "state": "interactionRequired",
  "action": "poll",
  "pollInterval": "2",
  "id": "{password_method_id}",
  "type": "password",
  "continuationToken": "******",
  "_links": {
    "poll": {
      "href": "/{tenant}/api/v2.0/auth/methods/password/{password_method_id}/pollUpdate"
    }
  }
}
```

This indicates an asynchronous update, not final authorization. Don't submit the password again while waiting or automatically repeat the update after an ambiguous network failure.

## Poll password update

Follow the latest `poll` link:

```http
POST https://{custom_domain}/{tenant}/api/v2.0/auth/methods/password/{password_method_id}/pollUpdate
Content-Type: application/json
Accept: application/hal+json
```

```json
{
  "continuationToken": "******"
}
```

While the update is in progress, the service returns `interactionRequired` with `action: poll`, an updated token, and a `poll` link. Replace the prior response before the next poll.

When included, `pollInterval` is a string containing the interval in seconds. Use the current response's interval for the next request, and honor server retry guidance. The example `"2"` isn't a fixed service interval. Stop polling when the action changes or an error is returned, and handle any later authentication required by policy.

A continuation response is:

```json
{
  "state": "continue",
  "continuationToken": "******",
  "_links": {
    "continue": {
      "href": "/{tenant}/oauth2/v2.0/authorize-challenge"
    }
  }
}
```

## Complete policy requirements and acquire tokens

Password reset doesn't bypass MFA or Conditional Access. If another challenge is returned, complete it using the shared method operations. Token exchange follows completion of the remaining policy steps and authorization continuation.

After `state: continue`, [resume authorization](reference-native-authentication.md#resume-authorization) using the latest token and [exchange the code](reference-native-authentication.md#exchange-the-authorization-code). The requested scopes and claims remain those established at the beginning of the transaction.

## Outcomes and errors

Use the [shared error handling](reference-native-authentication.md#errors). The recovery contract describes these outcomes:

| Condition | Outcome and client handling |
| --- | --- |
| **Unknown username** | Recovery doesn't start. Use a generic customer-facing message. |
| **Incorrect email or SMS passcode** | HTTP `400 invalidGrant` with `innerError.code: invalidOneTimeCode`. Let the user correct the code using the usable current state or an advertised resend. |
| **Missing passcode** | HTTP `400 invalidRequest`. Correct the missing input. |
| **Resend** | A new passcode is sent through the returned `resend` link. |
| **Expired password-update token** | HTTP `400 expiredToken` with `innerError.code: expiredContinuationToken`. Restart authorization. |
| **Weak or common replacement password** | HTTP `400 invalidRequest` with an applicable inner error such as `passwordTooWeak` or `passwordTooCommon`. Collect a compliant password. |
| **Update in progress** | Follow the latest polling response and server retry guidance. |
| **Poll fails password policy** | HTTP `400 invalidRequest` with an inner error such as `passwordTooCommon` or `passwordBannedByPolicy`. Handle the error rather than polling indefinitely. |
| **Account locked or disabled during polling** | HTTP `403 forbidden` with `innerError.code: accountLocked`. Stop the recovery operation. |
| **Password update job fails** | HTTP `500 serverError`. Show a clear failure without automatically repeating the password update. |
| **Completed recovery** | Handle any remaining policy actions, resume authorization, and request tokens. |

This table describes specific outcomes, not an exhaustive error catalog. Password update acceptance, polling completion, and token issuance are separate boundaries.

Don't log recovery passcodes, replacement passwords, or transaction tokens. Record only safe diagnostic IDs, timestamps, and HTTP status. Don't automatically replay verification or password updates.

## Related content

- [Native Authentication API reference](reference-native-authentication.md).
- [Sign-in API reference](reference-native-authentication-sign-in.md).
- [Configure an application](how-to-native-authentication-configure-app.md).
