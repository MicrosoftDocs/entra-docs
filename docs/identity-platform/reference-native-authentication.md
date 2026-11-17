---
title: Native Authentication API reference
description: Implement authorization, credential challenges, token acquisition, response handling, and diagnostics with the Native Authentication API.
author: adamstoffel
ms.author: adamstoffel
ms.service: identity-platform
ms.subservice: external
ms.topic: reference
ms.custom: msecd-doc-authoring-1030
ms.date: 11/16/2026
ai-usage: ai-generated
#customer intent: As an application developer, I want the shared API contract so that I can implement customer authentication and acquire tokens.
---

# Native authentication API v2 reference

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

[!INCLUDE [applies-to-authentication-native](../external-id/includes/applies-to-authentication-native.md)]

The Native Authentication API uses a response-driven flow in Microsoft Entra External ID external tenants. Start authorization, complete the returned authentication interactions, resume authorization, and exchange the authorization code for tokens. This reference defines shared operations; journey-specific references define sign-in discovery, sign-up attributes, and password reset.

For an existing V1 integration, use the [V1 API reference](reference-native-authentication-api-v1.md). See [Migrate from V1 to V2](how-to-migrate-native-authentication-v1-v2.md) for package versions, migration requirements, and SDK integration details.

## Prerequisites

[!INCLUDE [native-authentication-public-preview](../external-id/includes/native-authentication-public-preview.md)]

- An external tenant and an application configured for public client and native authentication flows. See [Configure an application](how-to-native-authentication-configure-app.md).
- A user flow associated with the application.
- A tenant-verified custom URL domain configured for all service API calls.
- The delegated permissions and consent required by your target resource, if you request access to an API.
- For SPAs with Embedded native authentication and BYO UX websites, a proxy or edge policy that implements the [browser proxy requirements](#browser-proxy-requirements).

## Operations and authority

The examples use `https://{custom_domain}/{tenant}`, where `custom_domain` is a tenant-verified authentication domain, such as `login.contoso.com`, and `tenant` is its Directory (tenant) ID, a GUID. `client_id` is the Application (client) ID. All service API call URLs use this custom domain, including authorization challenges and token exchange. See [Configure the API authority](how-to-native-authentication-configure-app.md#configure-the-api-authority).

Except for the initial authorization request and token exchange, use the URL advertised by the current response. Method IDs are opaque. Resolve relative links against the configured authority origin, validate the destination, and retain the returned path and query unchanged.

The authorization start, resume, and code exchange below describe Embedded native authentication. A BYO UX page instead uses its browser handoff and returned finish link around the shared native interaction operations. Don't start or resume `/authorize-challenge` inside that BYO UX transaction.

| Operation | Method | Path or link |
| --- | --- | --- |
| **Start authorization** | `POST` | `/{tenant}/oauth2/v2.0/authorize-challenge` |
| **Resume authorization** | `POST` | Returned `continue` link. |
| **[Start sign-in](reference-native-authentication-sign-in.md)** | `POST` | Returned `sign_in` link; examples use `/{tenant}/api/v2.0/signin/start`. |
| **[Start sign-up](reference-native-authentication-sign-up.md)** | `POST` | Returned `sign_up` link; examples use `/{tenant}/api/v2.0/signup/start`. |
| **Submit sign-up attributes** | `POST` | Returned `submitAttributes` link. |
| **[Start password reset](reference-native-authentication-password-reset.md)** | `POST` | Returned reset-password link; examples use `/{tenant}/api/v2.0/resetpassword/start`. |
| **Start inline password reset** | `POST` | Password method's returned `recover` link. |
| **Enroll an authentication method** | `POST` | Selected method's returned `enroll` link. |
| **Activate an authentication method** | `POST` | Returned `activate` link. |
| **Challenge or resend** | `POST` | Returned `challenge` or `resend` link. |
| **Verify a credential** | `POST` | Returned `verify` link. |
| **Update a password** | `PUT` | Returned `update` link. |
| **Poll password update** | `POST` | Returned `poll` link. |
| **Exchange an authorization code** | `POST` | `/{tenant}/oauth2/v2.0/token` |

Native examples use `/api/v2.0`; OAuth operations use `/oauth2/v2.0`. Use the tenant GUID in these authority examples. Follow returned links without rewriting their paths, versions, or query parameters.

### Headers

OAuth and native authentication operations use different body encodings.

| Header | Use |
| --- | --- |
| **`Content-Type: application/x-www-form-urlencoded`** | Required for authorization challenge and token requests. |
| **`Content-Type: application/json`** | Required for native authentication request bodies. |
| **`Accept: application/hal+json`** | Recommended for native authentication requests. |
| **`client-request-id: {guid}`** | Recommended. Generate a new value for each flow and retain it for diagnostics. |

### Browser proxy requirements

These requirements apply to browser API calls from SPAs with Embedded native authentication and BYO UX websites. Android and iOS apps using native HTTP transports don't need CORS configuration or a CORS proxy.

Native authentication routes handle `OPTIONS`, but don't grant a browser origin access through `Access-Control-Allow-Origin`. Cross-origin browser integrations therefore need a proxy or edge configuration that:

- Forwards the service's successful preflight response and applies the configured browser-origin policy.
- Returns `Access-Control-Allow-Origin` for that exact allowed origin, not `*`.
- Allows the operation's required `POST` or `PUT` method and the request headers used by the integration.
- Preserves request bodies, response status codes, content types, and transaction links without caching authentication responses.
- Handles origin and routing consistently across authorization, native operations, and token exchange.
- Preserves retry guidance, including `Retry-After`, and exposes it to browser code when needed.

See [Native authentication CORS concepts](concept-native-authentication-cors.md) for the browser boundary and [local proxy configuration](how-to-native-authentication-cors-local.md) for development.

## Continuation tokens

A continuation token represents the authentication transaction at its current stage. It is bound to the tenant, client, scenario, and action.

| Message format | Field |
| --- | --- |
| **OAuth** | `continuation_token` |
| **Native authentication API** | `continuationToken` |

Use only the current token with the operation identified by the same response. Don't parse, modify, log, or persist it beyond the active transaction. When a response supplies a replacement, stop using the earlier token. Don't move a token to another user or journey. Restart authorization after expiration.

The documented default validity is 10 minutes for an individual continuation token. Handle expiration according to the service response; a newer token isn't a guarantee of extending the whole journey. The token and a one-time passcode have separate lifetimes. Authorization codes are short-lived and single-use; don't interpret a token response's `expires_in` as the authorization-code lifetime.

## Response model

Successful native interaction operations return HAL JSON. The next action can differ even for successive calls to the same endpoint. Fields are specific to the response: for example, a redirect can contain only `state`.

| Member | Purpose |
| --- | --- |
| **`continuationToken`** | Token for the next allowed request, when included. |
| **`state`** | Current transaction state. |
| **`action`** | Required interaction for an `interactionRequired` response. |
| **`_links`** | URLs for allowed operations. |
| **`_embedded`** | Related resources, including available methods. |

The [flow concept](concept-native-authentication-flow.md#the-current-response-is-the-control-model) explains the states and actions. For `interactionRequired`, handle the returned action using an allowed operation. For `continue`, resume authorization through the returned link. An individual operation's `completed` state doesn't confirm that tokens have been issued.

A native transaction that can't continue can return:

```json
{
  "state": "redirect"
}
```

This response doesn't supply a continuation token, links, or a browser handoff URL. Stop native requests and offer a separately configured browser sign-in or a clear failure. Browser sign-in restarts authentication; it doesn't resume native progress.

<a id="account-selection-action-reserved"></a>

### Account-selection action

> [!NOTE]
> Account selection is not relevant in embedded native authentication and is not yet supported for BYO UX self-hosted pages. 

`disambiguate` identifies account selection under `state: interactionRequired`.

### Link relations

Use links from the latest response and validate their authority before forwarding secrets.

| Relation | Purpose |
| --- | --- |
| **`self`** | Current resource or operation. |
| **`discover`** | Submit a sign-in identifier. |
| **`challenge`** | Start the selected method's challenge. |
| **`verify`** | Verify a password or one-time passcode. |
| **`resend`** | Request another one-time passcode. |
| **`submitAttributes`** | Submit requested sign-up values. |
| **`recover`** | Start password recovery within the active sign-in transaction. |
| **`enroll`** | Start registration of an advertised authentication method. |
| **`activate`** | Verify the code for an enrolled method. |
| **`update`** | Submit a replacement password. |
| **`poll`** | Check an asynchronous update. |
| **`continue`** | Resume OAuth authorization. |

This action is relevant for Bring Your Own UX (BYO UX) account selection. Embedded native authentication integrations don't use it, and account selection on the self-hosted BYO UX page isn't currently supported.

If your BYO UX integration follows the recommended workaround by sending `login_hint` or `prompt=login` in the authorization request, introducing account selection won't interrupt or break your existing UX.

The action payload is part of the existing BYO UX browser handoff's `initialResponse` and includes:

- `state: interactionRequired`, `action: disambiguate`, and a `continuationToken` for the pending selection.
- An `_embedded.user` array with information about each offered account and supported links. An active account has an account-specific `_links.resume` URL.
- A response-level `_links.discover` URL for an inactive account or **Use another account**.

### Authentication method resources

Existing-credential method selection uses `_embedded.methods`. The service can also select a single method. An existing credential has an opaque `id`, a `type` such as `password`, `email`, or `sms`, and links for allowed operations. A masked `hint` identifies a destination without disclosing it in full; `isPreferred` is optional preference metadata. Enrollment choices have a separate representation and don't need an existing credential ID.

```json
{
  "_embedded": {
    "methods": [
      {
        "id": "{id}",
        "type": "email",
        "hint": "u***@contoso.com",
        "isPreferred": true,
        "_links": {
          "challenge": {
            "href": "/{tenant}/api/v2.0/auth/methods/email/{id}/challenge"
          },
          "verify": {
            "href": "/{tenant}/api/v2.0/auth/methods/email/{id}/verify"
          }
        }
      }
    ]
  }
}
```

This fragment illustrates method metadata. Method availability is determined for each transaction. Your app can present available methods or select one through application flow logic. Challenge and verification operate on the selected method; method registration has a separate contract.

Don't require optional presentation metadata such as `pages` or `scenario`. The examples describe basic password and email/SMS interactions, not every additional method-specific requirement.

## Start authorization

Send the application, scopes, and optional claims on the initial request. Form-encode values; the line breaks below are for readability.

```http
POST https://{custom_domain}/{tenant}/oauth2/v2.0/authorize-challenge
Content-Type: application/x-www-form-urlencoded
```

```text
client_id={client_id}&
scope=openid%20profile%20offline_access&
response_type=code
```

| Parameter | Use |
| --- | --- |
| **`client_id`** | Required application (client) ID. |
| **`scope`** | Scopes your application requests. Include the OpenID Connect (OIDC) and resource scopes needed for the resulting tokens. |
| **`response_type`** | `code` in this example. The endpoint returns an authorization code after authentication. |
| **`claims`** | Optional JSON-encoded OpenID Connect claims request. |

When authentication is required, the response is `401 Unauthorized`, with `Content-Type: application/json`:

```json
{
  "error": "InsufficientAuthorization",
  "error_description": "AADSTS500127: No authenticated credentials found in request.",
  "error_codes": [
    500127
  ],
  "timestamp": "2026-08-28T17:30:00Z",
  "trace_id": "0000aaaa-11bb-cccc-dd22-eeeeee333333",
  "correlation_id": "aaaa0000-bb11-2222-33cc-444444dddddd",
  "continuation_token": "******",
  "reset_password": "/{tenant}/api/v2.0/resetpassword/start",
  "sign_in": "/{tenant}/api/v2.0/signin/start",
  "sign_up": "/{tenant}/api/v2.0/signup/start"
}
```

Sign-in and sign-up URLs are conditional. Journey links are top-level OAuth response properties, not `_links` entries. Select an advertised journey and send its token as `continuationToken` in the JSON request. Handle any policy or account-specific rejection.

## Resume authorization

When the current response returns `state: continue`, post the latest token to `_links.continue.href`. Don't resend the initial `client_id`, `scope`, or `claims` in this request.

```http
POST https://{custom_domain}/{tenant}/oauth2/v2.0/authorize-challenge
Content-Type: application/x-www-form-urlencoded
```

```text
continuation_token={continuation_token}
```

The successful response is `200 OK` and JSON:

```json
{
  "code": "{authorization_code}"
}
```

Authorization codes are short-lived and single-use. Exchange the code rather than treating it as an access token.

## Exchange the authorization code

Post the code with the same application ID:

```http
POST https://{custom_domain}/{tenant}/oauth2/v2.0/token
Content-Type: application/x-www-form-urlencoded
```

```text
client_id={client_id}&
grant_type=authorization_code&
code={authorization_code}
```

All three parameters are required. `grant_type` is `authorization_code`. This public-client request doesn't contain a client secret.

The successful response is `200 OK` and JSON:

```json
{
  "token_type": "Bearer",
  "expires_in": 3600,
  "access_token": "******",
  "id_token": "******",
  "refresh_token": "******"
}
```

Token fields depend on the scopes and claims established initially. A refresh token is returned only when the initial request includes `offline_access`. The example expiration value isn't a fixed lifetime guarantee. Don't request `offline_access` if your application doesn't need a refresh token.

## Challenge or resend

Follow the selected method's `challenge` link, or a current `resend` link when the customer requests another passcode:

```http
POST https://{custom_domain}/{tenant}/api/v2.0/auth/methods/{methodType}/{id}/challenge
Content-Type: application/json
Accept: application/hal+json
```

```json
{
  "continuationToken": "******"
}
```

An email challenge can return:

```json
{
  "continuationToken": "******",
  "state": "interactionRequired",
  "action": "verify",
  "id": "{email_method_id}",
  "type": "email",
  "hint": "u***@contoso.com",
  "codeLength": 8,
  "_links": {
    "verify": {
      "href": "/{tenant}/api/v2.0/auth/methods/email/{email_method_id}/verify"
    },
    "resend": {
      "href": "/{tenant}/api/v2.0/auth/methods/email/{email_method_id}/challenge"
    }
  }
}
```

SMS uses the same credential-challenge shape with `type: sms`, a masked phone hint, and its returned method links. Password challenges send no passcode and return a password `verify` action. Use the returned `codeLength`, not the example length. Follow service-controlled attempt and resend limits.

## Verify a credential

Post to the current `verify` link. For a password method:

```http
POST https://{custom_domain}/{tenant}/api/v2.0/auth/methods/password/{id}/verify
Content-Type: application/json
Accept: application/hal+json
```

```json
{
  "continuationToken": "******",
  "password": "******"
}
```

For an email or SMS method:

```http
POST https://{custom_domain}/{tenant}/api/v2.0/auth/methods/{methodType}/{id}/verify
Content-Type: application/json
Accept: application/hal+json
```

```json
{
  "continuationToken": "******",
  "otp": "{one_time_passcode}"
}
```

Verification can return another challenge, attribute collection, a password update, or continuation. Handle the returned action. Verification isn't idempotent; don't retry automatically after an ambiguous network failure.

## Authentication-method enrollment

Sign-up or sign-in can require inline registration through `action: enroll`, followed by `action: activate`. Enrollment is separate from collecting profile attributes or verifying an existing credential.

> [!IMPORTANT]
> Enrollment is separate from authentication with a registered method. Use only enrollment methods advertised for the current transaction; don't infer an enrollment operation from a credential challenge.

### Select and enroll a method

Select a supported method from `_embedded.methods` and follow its `_links.enroll` URL.

| Method | Advertisement | Required JSON fields |
| --- | --- | --- |
| **Phone SMS** | `type: phone`, with `sms` in `channels`. | `continuationToken`, `phoneNumber` including country code, and `channel: sms`. |
| **Email** | `type: email`. | `continuationToken` and `email`. Don't send a `channel`. |

Phone enrollment uses `type: phone`, not the `sms` type used by existing SMS challenge methods. The example phone enrollment URL is `/{tenant}/api/v2.0/auth/methods/phone`; the email URL is `/{tenant}/api/v2.0/auth/methods/email`. Use `POST` with JSON and follow the advertised URL rather than constructing one.

For phone SMS enrollment, the body is:

```json
{
  "continuationToken": "******",
  "phoneNumber": "+1 2025550123",
  "channel": "sms"
}
```

For email enrollment, the body is:

```json
{
  "continuationToken": "******",
  "email": "user@contoso.com"
}
```

The service sends a passcode and returns `action: activate`, a new continuation token, and an `activate` link. Display the returned masked `hint` and `codeLength` when present. Email and SMS can use different code lengths.

A phone activation response can be:

```json
{
  "continuationToken": "******",
  "state": "interactionRequired",
  "action": "activate",
  "id": "{phone_method_id}",
  "type": "phone",
  "channel": "sms",
  "hint": "***0123",
  "codeLength": 6,
  "_links": {
    "activate": {
      "href": "/{tenant}/api/v2.0/auth/methods/phone/{phone_method_id}/activate"
    },
    "resend": {
      "href": "/{tenant}/api/v2.0/auth/methods/phone"
    }
  }
}
```

Use the fields and links from the actual response; email uses its own method type, code length, and links.

### Activate or resend

Send a JSON `POST` to the current `activate` link with the latest `continuationToken` and the user's code in `otp`. Phone examples use `/{tenant}/api/v2.0/auth/methods/phone/{phone_method_id}/activate`; email uses its own advertised link. Don't submit activation codes to a credential's `verify` link.

```json
{
  "continuationToken": "******",
  "otp": "{one_time_passcode}"
}
```

If the activation response advertises `resend`, send a JSON `POST` containing only the latest `continuationToken` to that link. The link can point back to enrollment. Don't retain or resend the contact details; the token carries the enrollment context.

```json
{
  "continuationToken": "******"
}
```

Replace the active token, links, hint, and code length after each response. Continue handling returned actions after activation; only `state: continue` permits resuming authorization. Registration can itself satisfy MFA, so a separate credential challenge isn't always required.

For `invalidGrant` with `innerError.code: invalidOneTimeCode`, keep the current activation token and advertised links. Let the user correct the code or request a resend. Don't automatically replay enrollment or activation after an ambiguous connection failure.

## Errors

OAuth errors use fields such as `error`, `error_description`, `trace_id`, and `correlation_id`. Native authentication failures use a nested envelope. For example, an incorrect email verification code can return HTTP `400` with:

```json
{
  "error": {
    "code": "invalidGrant",
    "message": "AADSTS50181: Unable to validate the otp.",
    "timestamp": "2026-08-28T17:30:00Z",
    "traceId": "0000aaaa-11bb-cccc-dd22-eeeeee333333",
    "correlationId": "aaaa0000-bb11-2222-33cc-444444dddddd",
    "innerError": {
      "code": "invalidOneTimeCode"
    }
  }
}
```

Use stable codes for handling rather than localized messages. Attribute validation can return `error.innerError.code: attributeValidationError` with `details` entries containing `code`, `message`, and `attributeIds`, plus optional `suggestions` or `recovery`. Check HTTP status and content type before parsing; don't render an unexpected HTML error body in the app.

| Condition | Status or error | Handling |
| --- | --- | --- |
| **Invalid OAuth parameter** | `400 invalid_request` | Correct the request; don't retry unchanged. |
| **Invalid or expired code** | `400 invalid_grant` | Restart authorization. |
| **Invalid application** | `400 invalid_client` | Correct app configuration. |
| **Invalid or ungranted scope** | `400 invalid_scope` | Check requested scopes and consent. |
| **Authentication required** | `401 InsufficientAuthorization` | Follow an enabled journey link. |
| **Invalid continuation token/state** | `400 invalidRequest` | Restart the applicable flow. |
| **Expired password-update token** | `400 expiredToken` with `innerError.code: expiredContinuationToken` | Restart authorization. |
| **Missing verification code** | `400 invalidRequest` | Correct the missing input. |
| **Incorrect email or SMS verification code** | `400 invalidGrant` with `innerError.code: invalidOneTimeCode` | Let the user correct the code using the usable current verification state or follow an advertised resend link. Don't resubmit automatically. |
| **Incorrect activation code** | `400 invalidGrant` with `innerError.code: invalidOneTimeCode` | Keep the current activation token and advertised links. Let the user correct the code or use an advertised resend action. Don't resubmit automatically. |
| **Browser interaction required** | `invalid_grant` with `web_redirect_required` | Stop native requests and use the configured interactive recovery path. Don't forward the continuation token to an arbitrary URL. |
| **Native transaction can't continue** | Native body `{"state":"redirect"}` | Stop native requests. A separate browser sign-in doesn't preserve native progress. |
| **Throttling** | `429` | Honor `Retry-After` and server guidance. |

Network and service failures can use other response formats. Treat an unexpected content type as an explicit failure. The table describes specific common cases, not an exhaustive error catalog for every operation.

## Security and diagnostics

Use HTTPS for every upstream request. Keep passwords, passcodes, continuation tokens, codes, and issued tokens out of URLs, logs, telemetry, exceptions, screenshots, and support attachments. Don't cache authentication responses or share transaction state across users.

Reject unexpected authorities and redirects rather than forwarding secrets. Don't automatically retry credential verification, account-creation submissions, or password updates after an ambiguous failure.

Display only masked hints supplied by the service. Use generic discovery failures so messages and method presentation don't unnecessarily disclose account existence.

Retain safe diagnostics: HTTP status, operation category, `client-request-id`, service trace/correlation IDs, and timestamp. OAuth names use underscores; Native authentication error names use camel case. Extract these diagnostic fields without retaining full request or response bodies.

## Custom authentication extensions

Event configuration and contracts are specific to each extension and journey. Your app continues to select allowed operations from service responses when an extension participates in the flow.

Native event coverage includes `OnOtpSend` for email and `OnTokenIssuanceStart`. `OnAttributeCollectionStart` and `OnAttributeCollectionSubmit` aren't supported for Embedded native authentication or Bring Your Own UX. See [Custom authentication extensions](../external-id/customers/concept-custom-extensions.md) for event-specific behavior. This event set doesn't establish password-migration hooks, password-update synchronization, or arbitrary context propagation.

## Related content

- [SDK sign-in quickstart](quickstart-native-authentication.md).
- [Sign-up API reference](reference-native-authentication-sign-up.md).
- [Password reset API reference](reference-native-authentication-password-reset.md).
