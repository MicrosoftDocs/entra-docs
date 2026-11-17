---
title: Bring Your Own UX API and protocol reference
description: Reference the browser handoff, initialization envelopes, continuation-token transport, and finish contract for Bring Your Own UX.
author: adamstoffel
ms.author: adamstoffel
ms.topic: reference
ms.date: 11/13/2026
ms.custom: msecd-doc-authoring-1030
ai-usage: ai-generated

#customer intent: As an application developer, I want the BYO UX handoff and completion contract so that my self-hosted page can handle authentication and resume the relying application's authorization flow.
---

# Bring Your Own UX API and protocol reference

Bring Your Own UX (BYO UX) connects an OAuth 2.0 or OpenID Connect authorization-code request to a self-hosted authentication page. This reference describes the browser handoff and finish contract, and the boundaries around the page's Native Authentication API calls.

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

[!INCLUDE [bring-your-own-ux-preview](../includes/bring-your-own-ux-preview.md)]

## Protocol boundaries

BYO UX starts with the relying application's browser authorization request and completes through browser form navigation. The self-hosted page calls the Native Authentication API between those boundaries.

| Phase | Transport | Contract |
| --- | --- | --- |
| **Authorization** | Top-level browser navigation to `/{tenant}/oauth2/v2.0/authorize`. | The relying application's OAuth authorization-code request. |
| **Page initialization** | Browser form POST to the configured self-hosted page. | Required `context` and `initialResponse` fields. |
| **Authentication operations** | JSON requests to links returned by the service. | The [shared Native Authentication API contract](~/identity-platform/reference-native-authentication.md). |
| **Completion** | Top-level browser form POST to the returned `_links.continue.href`. | BYO UX finish form containing `continuation_token`. |
| **Authorization response** | The original OAuth response mode at the registered reply URL. | Authorization code and original application state, or an OAuth error. |

BYO UX uses the initialization response from the browser handoff and completes through the returned finish link. Don't call the standalone native authentication `/authorize-challenge` operation within a BYO UX transaction.

## Authorization request

The relying application starts an authorization-code request at its tenant-specific custom-domain authority:

```http
GET https://{custom_domain}/{tenant}/oauth2/v2.0/authorize
```

`{custom_domain}` is the tenant's verified custom-domain service hostname, and `{tenant}` is the external tenant's GUID. Don't use `/common`.

Use a tenant-verified custom domain for every Microsoft Entra service URL in this flow. This includes the OAuth authority, all Native Authentication API URLs, proxy upstream URLs, and the returned finish link. This requirement applies to service URLs, not the relying application's callback or resource URLs. The self-hosted page can use a different domain that meets the same tenant's domain-ownership checks.

The browser-facing proxy URL is a transport route, not the service authority. Resolve returned service links against the configured Microsoft Entra service authority, not a local proxy address.

The OAuth request carries the relying application's `client_id`, registered `redirect_uri`, requested scopes, `response_type=code`, and application state. The `redirect_uri` is the relying application's web-type reply URL, not the self-hosted page URL. Both public and confidential relying applications use a web-type reply URL for BYO UX.

The relying application uses the same OAuth or Microsoft Authentication Library (MSAL) integration as a Microsoft-hosted flow. It validates the OAuth response, including its original state, and redeems the code. Use the maintained [authorization-code protocol reference](~/identity-platform/v2-oauth2-auth-code-flow.md) and [MSAL guidance](~/identity-platform/msal-overview.md). Keep confidential-client credentials on the server, outside the browser page.

## Authorization handoff

For a request that requires the self-hosted page, Microsoft Entra External ID returns `200 OK` with an HTML page that automatically submits a form to the configured page URL. The browser sends that form as `application/x-www-form-urlencoded`.

| Field | Required | Encoding and contents |
| --- | --- | --- |
| **`context`** | Yes. | Base64url-encoded UTF-8 JSON with page initialization identifiers. |
| **`initialResponse`** | Yes. | Base64url-encoded UTF-8 JSON with the initial native authentication HAL response and continuation token. |

Require both fields and decode each from base64url to UTF-8 JSON. Validate tenant and client IDs against your deployment configuration and reject unexpected authentication destinations. Decoded handoff data, matching IDs, and destination checks don't authenticate the sender or establish user intent.

Microsoft Entra External ID validates protected continuation state when resuming the original OAuth request. The relying application validates its original OAuth state.

Ignore unknown optional form fields, JSON properties, and HAL relations. Missing required fields or unsupported required actions aren't valid initialization.

### Context properties

The `context` envelope identifies the tenant and relying application.

| Property | Type | Meaning |
| --- | --- | --- |
| **`tenantId`** | GUID string. | Canonical tenant identifier. |
| **`clientId`** | GUID string. | Application identifier from the original authorization request. |

These identifiers initialize the page. The envelope doesn't contain credentials, the original OAuth request or state, decrypted continuation state, or an OAuth result. Don't rely on `login_hint`, `domain_hint`, or arbitrary application context being passed to the page.

### Initial authentication response

The decoded `initialResponse` is a native authentication HAL response with the current `continuationToken`, `state`, and the links and metadata for the current action. Use the same [response handling](~/identity-platform/concept-native-authentication-flow.md) for initialization and every later response.

The handoff can already request attributes, verification, enrollment, or completion; it isn't restricted to journey discovery. When it offers journeys, the page can present them or select an available journey through application logic.

### Future account selection

Account selection on the self-hosted page isn't currently supported. The reserved future response-handling case is `state: interactionRequired` with `action: disambiguate`, not a separate transaction state.

Prepare a distinct handling case without implementing an account-selection payload or endpoint yet. Until support is documented, stop this unsupported required interaction explicitly rather than continuing authentication or treating it as ordinary credential verification. See the [reserved account-selection action](~/identity-platform/reference-native-authentication.md#account-selection-action-reserved).

## Native authentication operations

Use the [shared API reference](~/identity-platform/reference-native-authentication.md) for JSON request bodies, response metadata, and errors. The page calls the Native Authentication API through its configured browser/proxy integration. The relying application's OAuth library doesn't implement the page's handoff-to-finish sequence.

Resolve relative links against the tenant-verified custom-domain authority origin that handled `/authorize`, not the self-hosted page. Validate the destination against that expected HTTPS authority and reject unexpected cross-origin destinations before sending authentication data. Preserve returned paths, including the tenant GUID, versions, and query parameters rather than rebuilding the URLs.

<a id="actions-and-input"></a>

<a id="method-enrollment-and-activation"></a>

For actions, method selection, enrollment, and activation, follow the shared [flow concepts](~/identity-platform/concept-native-authentication-flow.md). For requested fields and validation metadata, see [Native authentication user attributes](~/identity-platform/concept-native-authentication-user-attributes.md).

### Shared journey references

Within BYO UX, the browser handoff replaces the shared references' authorization-start operation, and BYO UX finish replaces their authorization-resume operation.

| Journey | Shared operations |
| --- | --- |
| **[Sign-in](~/identity-platform/reference-native-authentication-sign-in.md)** | Identifier discovery, credential verification, and additional factors. |
| **[Sign-up](~/identity-platform/reference-native-authentication-sign-up.md)** | Attribute collection and credential verification. |
| **[Password recovery](~/identity-platform/reference-native-authentication-password-reset.md)** | Recovery from an available handoff link or inline during sign-in, password update, and polling. |

Use the [BYO UX journey scope](concept-bring-your-own-ux.md#common-policy-boundaries-and-supported-journeys) and current links to identify the capabilities available for this transaction. Continue handling returned actions after sign-up, password updates, or method activation.

## Continuation-token handling

Use the latest continuation token together with the links from the same response and transaction. Replace the stored response and token when the service returns a new one.

| Location | Token field | Transport |
| --- | --- | --- |
| **Decoded `initialResponse`** | `continuationToken` | Inside the initialization JSON envelope. |
| **Native Authentication API request or response** | `continuationToken` | JSON property. |
| **BYO UX finish request** | `continuation_token` | URL-encoded field in the form body. |

Treat continuation tokens as opaque. Parse neither their contents nor a token-derived destination. Keep them only for the active transaction, and exclude them from URLs, logs, telemetry, analytics, exceptions, and support attachments. A token from an earlier response or another transaction isn't a substitute for the latest token.

Finish with the current, unexpired token. If that token expires or the service requires a restart, stop the transaction and start a new authorization request from the relying application. For response and continuation-token handling, see [Native authentication flow concepts](~/identity-platform/concept-native-authentication-flow.md).

## Complete the BYO UX flow

When the Native Authentication API returns `state: continue`, its `_links.continue.href` identifies the BYO UX finish endpoint. Submit the latest token through a top-level browser form POST:

```http
POST https://{custom_domain}/{tenant}/v2.0/customAuthUx/finish
Content-Type: application/x-www-form-urlencoded

continuation_token={url_encoded_final_token}
```

The path above identifies the finish operation on the tenant's verified custom domain, with the tenant GUID in the path. Use the returned link for the active transaction without rebuilding it. API JSON uses `continuationToken`, while this form uses `continuation_token`.

Finish through the same top-level browser flow that initiated authorization. `fetch`, XHR, iframe navigation, and server-to-server calls aren't supported completion transports. The browser returns Microsoft Entra cookies automatically; the self-hosted page doesn't read or manually forward HTTP-only cookies.

Serve the self-hosted page with `Referrer-Policy: strict-origin`. Use the browser-generated `Origin` header for the finish POST.

The finish request domain and the hostname in the page's origin must be DNS-verified custom domains, or their subdomains, owned by the same tenant. They don't have to be equal. `Origin` must contain one HTTPS origin without a path, query, fragment, or user information. Missing, repeated, opaque (`null`), non-HTTPS, and unowned origins are rejected.

Domain ownership and `Origin` checks aren't proof of user intent.

<a name='success-response'></a>

### Success response and sessions

The finish operation resumes the original OAuth request and creates the Microsoft Entra browser session. It doesn't return a native authentication JSON success body.

For authorization-code flow, the browser delivers the authorization code and original application state to the registered `redirect_uri`. The original `response_mode` determines whether that response uses a redirect or form POST. Code redemption remains the relying application's responsibility.

Session persistence is controlled separately through tenant policy. For existing-session bypass, account pickers, consent, and sign-out, see [Sessions, navigation, and fallback](concept-bring-your-own-ux.md#sessions-navigation-and-fallback).

## Errors and diagnostics

API operations use the [shared native authentication error contract](~/identity-platform/reference-native-authentication.md#errors). The browser handoff and finish operation have different failure surfaces:

| Condition | Handling |
| --- | --- |
| **Malformed handoff or unexpected tenant/client IDs** | Stop initialization and return to the relying application to start again. |
| **Unexpected authentication destination** | Reject the destination before sending credentials or transaction state. |
| **Invalid or expired current continuation token, or service-directed restart** | Stop the transaction and start a new relying-app authorization request. |
| **Finish failure** | Handle the OAuth error response or Microsoft Entra error page delivered through browser navigation, not native authentication JSON. |

Stop explicitly on unsupported required actions or missing essential links. Unknown optional metadata alone isn't a failure. Don't treat an unhandled enrollment action as successful authentication.

Retain request IDs, correlation IDs, trace IDs, and timestamps for diagnostics. Exclude credentials, tokens, passcodes, and personal data, and don't display raw internal error details. Avoid automatically replaying credential verification or password updates after an ambiguous network failure.

<a name='hosted-fallback'></a>

## Microsoft-hosted fallback

BYO UX doesn't support leaving a transaction for a Microsoft-hosted authentication step and resuming the same transaction. Starting a new relying-app authorization request is a separate authentication attempt, not a resumable continuation. Don't construct a fallback URL or reuse a standalone native authentication fallback recipe.

Microsoft-hosted consent or account-selection pages can still appear during normal OAuth processing. Their appearance doesn't provide a page-controlled fallback mechanism.

## Related content

- [Bring Your Own UX authentication overview](concept-bring-your-own-ux.md).
- [Configure Bring Your Own UX authentication](how-to-configure-bring-your-own-ux.md).
- [Native authentication flow concepts](~/identity-platform/concept-native-authentication-flow.md).
