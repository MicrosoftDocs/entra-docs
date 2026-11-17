---
title: Authenticate an embedded webview from a native app
description: Use a resource access token to open an authenticated embedded webview and establish a web resource's own session with Microsoft Entra External ID.
ms.topic: how-to
ms.custom: msecd-doc-authoring-1030
ms.date: 11/13/2026
ai-usage: ai-assisted
#customer intent: As a mobile developer, I want to implement single sign-on between my native app and an embedded webview so that users can access my web resource without a second sign-in prompt.
---

# Authenticate an embedded webview from a native app

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

[!INCLUDE [applies-to-authentication-native](../external-id/includes/applies-to-authentication-native.md)]

Use a resource access token to open an authenticated web page inside your native app. This guide connects a user signed in through Microsoft Entra External ID to an HTTPS web resource your team controls, such as your app's rewards page, without a second sign-in prompt.

You need a native app with a working sign-in flow and a web resource that can validate bearer tokens. This resource-token flow provides single sign-on (SSO) to that resource in the embedded webview.

[!INCLUDE [native-authentication-public-preview](~/external-id/includes/native-authentication-public-preview.md)]

The resource-token pattern for embedded webviews is generally available. It establishes a session for your web resource, independently of the Native Authentication API's support contract.

<a id="implement-single-sign-on-from-native-apps-to-embedded-web-views"></a>
<a id="implement-single-sign-on-from-native-apps-to-embedded-webviews"></a>

## Prerequisites

- An app configured for Embedded native authentication in an external tenant. See [Configure an application](how-to-native-authentication-configure-app.md).
- A native app with a working sign-in flow. See the [sign-in reference](reference-native-authentication-sign-in.md).
- An HTTPS web resource with exposed delegated scopes and server-side token validation. See [Expose a web API](quickstart-configure-app-expose-web-apis.md#add-a-scope).
- Permission for the native app to request those scopes. See [Configure access to your web API](quickstart-configure-app-access-web-apis.md#add-permissions-to-access-your-web-api).
- An embedded webview that can send an `Authorization` header with its initial request.

## Sign in with native authentication

Request access for the resource you intend to open, rather than reusing a token issued for a different API.

1. Start authorization with the web resource's required scopes in the initial `scope` parameter. Request only the permissions needed for the page's operations.
1. Complete the sign-in actions returned by the service. Follow the returned links and use the latest continuation token for the active transaction.
1. When the service returns `state: continue`, follow `_links.continue` to resume authorization.
1. Exchange the returned authorization code for tokens. Use the response's `access_token` for the web resource, not the `id_token` or a continuation token.

For the authorization and token request contracts, see the [Native Authentication API reference](reference-native-authentication.md).

For existing V1 integrations, see the [V1 API reference](reference-native-authentication-api-v1.md) and its [SDK library references](reference-native-authentication-api-v1.md#sdk-references) for your platform.

The following diagram illustrates the resource-token flow with a V1 SDK:

:::image type="content" source="./media/native-authentication/common/native-application-sign-in-with-web-view-authentication.png" alt-text="Sequence diagram showing an app signing in through an SDK and sending an access token in the embedded webview request.":::

## Retrieve the access token

Before opening the webview, get a valid, unexpired access token for the resource.

1. Check the token response's expiration metadata rather than parsing the access token in the client.
1. If the app doesn't have a usable token for the required resource and scopes, complete authorization to obtain one before loading the page.
1. Keep the token in the native app's protected authentication state until you construct the request. Don't expose it in page scripts, diagnostics, or a URL.

Access tokens are validated by the receiving resource, not by the native client. See [Access tokens](access-tokens.md).

For V1 SDK token acquisition, use the platform's [SDK library reference](reference-native-authentication-api-v1.md#sdk-references). Request the scopes described in [Limitations and configuration requirements](#limitations-and-configuration-requirements).

## Load the web view with authentication

Send the token in the initial request to the intended web resource. This procedure establishes the web resource's session.

<a id="option-a-use-a-bearer-token-via-http-header-recommended"></a>

1. Construct the HTTPS URL for your web resource without including the token in its path, query, or fragment.
1. Create the initial webview request with `Authorization: Bearer <access-token>`, replacing `<access-token>` with the access token for the web resource.
1. Load that request in the embedded webview.
1. Restrict bearer-token delivery to the intended resource. Don't forward the header to unrelated origins when handling navigation or redirects.

<a id="option-b-use-cookies-fallback-only"></a>

Use bearer authentication for the initial request and let the server issue the application session cookie after validation. Keep the raw access token in the native app's protected authentication state.

## Validate and persist the token on the backend

The web resource validates the access token and authorizes the requested operation before creating a session.

### Validate the token

Use the resource's token-validation middleware before returning protected content.

1. Validate the token's signature, issuer, and lifetime against the resource's trusted Microsoft Entra configuration.
1. Verify that the `aud` claim identifies the receiving resource.
1. Verify the delegated scopes required for the requested operation and the user's authorization to access the data.
1. Reject the request if validation or authorization fails. Don't create a session from an invalid token.

For the audience and permission checks, see [Validate access-token claims](claims-validation.md).

### Persist the session

Establish a server-managed session for subsequent webview navigation.

1. After successful token validation, issue the web resource's session cookie through `Set-Cookie`.
1. Set `HttpOnly`, `Secure`, and the `SameSite` policy appropriate for the application's navigation. Apply server-side protection against cross-site request forgery for cookie-authenticated operations.
1. Use the session cookie for subsequent requests to that web resource. Don't store the raw access token in the cookie.

## Verify access and sign-out

Signing out of the native app doesn't terminate the web resource's session or other application and browser sessions. Clear each session through its own sign-out mechanism.

Test both resource authorization and the session that the webview retains.

1. Sign in to the native app and open the web resource. Confirm that the expected user's page opens without another sign-in prompt.
1. Navigate to another protected page in the same web resource. Confirm that its server-issued session cookie maintains the session.
1. Test an expired token, a token issued for a different resource, and a token without the required scope. Confirm that none establishes an authorized session.
1. Sign out and clear authentication state in both the native app and the web resource. Reopen the protected page and confirm that the old web session no longer grants access.
1. Check that application and server diagnostics exclude tokens, cookies, credentials, and personal data.

## Limitations and configuration requirements

The token's audience and permissions identify the web resource and authorized operations. The native client and resource can have separate app registrations.

This integration requires control over the web resource's bearer-token validation and session creation.

The resulting cookie belongs to your web resource. It doesn't create a browser-wide Microsoft Entra session or enable profile or credential-management APIs.

## Related content

- [Embedded native authentication overview](concept-native-authentication.md).
- [Embedded native authentication web fallback](concept-native-authentication-web-fallback.md).
- [The Native Authentication API reference](reference-native-authentication.md).
