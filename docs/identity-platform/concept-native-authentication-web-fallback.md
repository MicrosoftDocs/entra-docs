---
title: Embedded native authentication web fallback overview
description: Understand unsupported native interactions, separate browser sign-in, and the boundaries between restarting and resuming authentication.
ms.topic: concept-article
ms.date: 11/13/2026
ms.custom: msecd-doc-authoring-1030
ai-usage: ai-assisted
#customer intent: As an application developer, I want to understand browser fallback so that my app can offer recovery when it can't complete a native interaction.
---

# Embedded native authentication web fallback overview

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

[!INCLUDE [applies-to-authentication-native](../external-id/includes/applies-to-authentication-native.md)]

An Embedded native authentication interaction can require behavior that your app can't complete natively. Browser fallback is a recovery path that starts a separate, configured browser sign-in. It doesn't resume the native transaction.

[!INCLUDE [native-authentication-public-preview](~/external-id/includes/native-authentication-public-preview.md)]

<a name="web-fallback-flow"></a>

## Service-required and client-initiated fallback

The API uses states, actions, and links to describe the next interaction. A client can present available actions or apply application flow logic to select an allowed operation.

The Native Authentication API can return the following response:

```json
{
    "state": "redirect"
}
```

This response can contain only `state`. It doesn't supply a continuation token or a browser handoff URL. Stop the native transaction instead of requiring `action`, `continuationToken`, or `_links` on this response.

At the OAuth boundary, browser-required handling can instead use `invalid_grant` with `web_redirect_required`. Handle that OAuth error separately from native JSON states.

A client can also reach a response it can't safely process: an unknown required action, a missing required field, an unsupported credential interaction, or malformed data. Offer a separately configured browser sign-in if your app has one, or show a clear failure without marking the user signed in.

Unknown optional properties or links are different. Ignore those additions while processing the required fields; their presence alone doesn't require a switch to the browser.

## Transaction and user-experience boundaries

A separate browser sign-in restarts authentication; it doesn't preserve native progress.

Native continuation tokens belong to the active transaction and current operation. They aren't general-purpose browser sign-in tokens. Don't add passwords, one-time passcodes (OTPs), native continuation tokens, or security tokens to browser URLs. Let the configured authorization flow handle its registered redirect. Keep authorization codes and other credentials out of logs and telemetry. Use the configured interactive authorization flow, not an arbitrary URL supplied by untrusted content.

The browser flow can have different interactions from the native flow. Don't mark the app signed in until its configured authentication integration reports success. If the user cancels or the browser flow fails, retain a clear signed-out or incomplete state.

<a name="example-scenario"></a>
<a name="support-web-fallback"></a>
<a id="sdk-and-api-boundaries"></a>

## Browser integration

Use a supported browser-delegated integration to open the browser and handle its registered redirect. The [mobile quickstart](quickstart-mobile-app-sign-in.md?pivots=external) and [single-page app quickstart](quickstart-single-page-app-sign-in.md?pivots=external) describe those integration paths. Keep browser completion, cancellation, and error handling separate from native transaction processing.

For an application configured with Bring Your Own UX (BYO UX), normal browser authorization uses the configured self-hosted page. A native `redirect` response isn't a URL or parameter for bypassing that configuration to Microsoft-hosted pages. Use the configured browser authorization flow rather than a constructed bypass URL.

If your app doesn't have a supported browser path, explain that the interaction can't be completed. Don't automatically replay credentials or switch the active transaction to V1.

## V1 fallback

V1 clients need to support web fallback. The client declares its supported interactions through challenge types. For example, an email-with-password user flow requires both `oob` and `password`; omitting either can cause the service to require browser authentication. See [V1 challenge types](reference-native-authentication-api-v1.md#v1-challenge-types-and-capabilities).

For existing SDK integrations, use the [SDK library references](reference-native-authentication-api-v1.md#sdk-references) for fallback interfaces. V1 fallback starts a separate browser sign-in, not a resumable native-to-browser continuation.

## Related content

- [Embedded native authentication flow](concept-native-authentication-flow.md).
- [The Native Authentication API reference](reference-native-authentication.md).
- [Migrate from Native Authentication API V1 to V2](how-to-migrate-native-authentication-v1-v2.md).
