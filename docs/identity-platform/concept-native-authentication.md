---
title: Embedded native authentication overview
description: Understand how Embedded native authentication gives your application control of the interface while Microsoft Entra External ID controls authentication.
manager: dougeby
ms.service: identity-platform
ms.subservice: external
ms.topic: overview
ms.date: 11/13/2026
ms.custom: msecd-doc-authoring-1030
ai-usage: ai-assisted
#customer intent: As an application developer, I want to understand Embedded native authentication so that I can choose and implement an application-managed authentication experience.
author: adamstoffel
ms.author: adamstoffel
---

# Native authentication overview

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

[!INCLUDE [applies-to-authentication-native](../external-id/includes/applies-to-authentication-native.md)]

Embedded native authentication is an authentication approach that lets your application present sign-up, sign-in, and password reset while Microsoft Entra External ID validates credentials and enforces authentication requirements. Your app controls the interface and handles the actions, available methods, and links returned by the Native Authentication API.

## API version boundaries

[!INCLUDE [native-authentication-public-preview](../external-id/includes/native-authentication-public-preview.md)]

The primary references describe the response-driven Native Authentication API, with native routes such as `/api/v2.0`. Follow service-returned links without rewriting their versions or paths. The `/oauth2/v2.0` OAuth endpoint path is also used by V1 integrations.

Existing V1 integrations can continue to use the [V1 API reference](reference-native-authentication-api-v1.md) and its [SDK library references](reference-native-authentication-api-v1.md#sdk-references). The legacy V1 guides and tutorials have been removed from this documentation. This documentation change doesn't announce retirement of V1 or its SDKs. See [SDK compatibility and migration](how-to-migrate-native-authentication-v1-v2.md#sdk-compatibility) for platform and package requirements.

<a name="when-to-use-native-authentication"></a>

## Application-owned experience, service-controlled authentication

With Embedded native authentication, a mobile, desktop, or single-page application (SPA) can present authentication within its own interface. Your application controls layout, interaction, and validation feedback. Microsoft Entra External ID validates credentials, enforces authentication requirements, and issues tokens.

Tenant and Conditional Access policies and the application's user flow apply to Microsoft-hosted authentication, Embedded native authentication, and Bring Your Own UX (BYO UX). Presentation and integration responsibilities differ. With Embedded native authentication, your app handles the required interactions, such as a second-factor challenge after password verification or more attribute collection after email verification.

Microsoft-hosted authentication presents pages on behalf of your app. Choose Embedded native authentication when your team needs control of the interface and can implement response handling and security responsibilities. See [Choose an authentication approach](../external-id/customers/concept-choose-authentication-approach.md) for the broader comparison.

## Customer journeys

The same authorization transaction surrounds each journey. Your app starts authorization, completes the returned authentication interactions, resumes authorization, and exchanges the authorization code for tokens.

| Journey | Behavior |
| --- | --- |
| **Sign-up** | Create an email-with-password or passwordless email one-time passcode (OTP) account. Collect the attributes and complete the verification steps requested by the user flow. |
| **Sign-in** | Submit the customer's identifier and complete password or email one-time-passcode verification using an offered method. Username-with-password sign-in is also available for configured local accounts. |
| **Password reset** | Verify an offered email or SMS one-time passcode, submit a replacement password, and follow the password-update polling responses. Recovery can start before sign-in discovery or through a password method's `recover` link. |
| **Multifactor authentication (MFA) and inline registration** | Complete email or SMS verification when policy requires MFA. If registration is required, handle the returned `enroll` and `activate` operations. Email OTP first-factor accounts use a different second factor, such as SMS. |
| **Policy requirements after sign-up or password reset** | Continue handling required authentication, including MFA and Conditional Access, before requesting tokens. Completing account creation or a password update doesn't bypass policy. |

Select journeys and methods from those available in the current transaction. Your application can present a choice or apply its flow logic within those options.

The Native Authentication API doesn't support federation, phone numbers as a first factor, time-based one-time passwords (TOTP), passkeys, push authentication, or external MFA methods. Later-operation step-up and using native-issued tokens with profile or credential-management APIs aren't supported. See the [method and integration matrices](../external-id/customers/concept-supported-features-customers.md#methods-and-journeys-by-approach) for the comparison with Microsoft-hosted authentication and BYO UX.

For supported custom authentication extension events, see the [approach comparison](../external-id/customers/concept-supported-features-customers.md#custom-authentication-extension-applicability). For configuration, see [Custom authentication extensions](../external-id/customers/concept-custom-extensions.md).

<a name="how-to-use-native-authentication"></a>

## Integration responsibilities

Use the configuration guide and API references for a direct integration, or use a documented JavaScript, Android, or Apple SDK. The [SDK quickstart](quickstart-native-authentication.md) configures a React Next.js sample. SDK entry points and supported continuation interfaces are specific to the package and platform.

| Responsibility | What your application implements |
| --- | --- |
| **Response handling** | Use the latest `state`, `action`, and links to select an allowed operation through user choice or application flow logic. |
| **Method selection** | Select from the returned methods, use masked hints where needed, and follow the selected method's links. |
| **Attribute collection** | Collect values according to the returned field requirements and validation metadata. Don't require page-grouping metadata. |
| **Transaction continuity** | Keep the latest continuation token in memory and use it only with links from the same response. |
| **Authorization** | Request the needed scopes initially and exchange the final authorization code for tokens. |
| **Recovery** | Handle validation failures, throttling, expiration, unsupported interactions, and cancellation without replaying credentials automatically. A separately configured browser sign-in starts a new authentication attempt; it doesn't resume native progress. |

SPAs with Embedded native authentication and BYO UX websites need a proxy or edge cross-origin resource sharing (CORS) policy for cross-origin browser API calls. Android and iOS apps using native HTTP transports don't need CORS or a CORS proxy. See [Native authentication CORS concepts](concept-native-authentication-cors.md).

All service API calls in the current native authentication integration use a tenant-verified custom domain and the tenant GUID. Configure that authority before starting a journey; see [Configure the API authority](how-to-native-authentication-configure-app.md#configure-the-api-authority).

<a name="security-considerations-for-native-authentication"></a>

## Security boundaries

Your application handles credentials, so protect passwords, one-time passcodes, continuation tokens, authorization codes, and issued tokens. Use HTTPS, don't log authentication bodies, and don't cache credential responses. Validate returned URL authorities before sending transaction data.

Use client-side validation to help customers correct their input. The service validates authentication requests.

<a name="single-sign-on-sso"></a>

## Session boundaries

Embedded native authentication supports single sign-on (SSO) for embedded webviews. A signed-in native app requests an access token for the web resource and includes it in the webview request's `Authorization` header. The resource validates the token and establishes a session, allowing access without another sign-in prompt. See [Authenticate an embedded webview from a native app](how-to-native-authentication-webview-sso.md).

Signing out of your native app doesn't terminate other application or browser sessions. Clear each application's session separately when your sign-out experience requires it.

<a name="how-to-enable-native-authentication"></a>
<a name="update-your-configuration-code"></a>

## Existing V1 application configuration

For existing V1 applications, [enable public client and native authentication flows](reference-native-authentication-api-v1.md#enable-public-client-and-native-authentication-flows), then update your platform configuration. The [V1 API reference](reference-native-authentication-api-v1.md#v1-challenge-types-and-capabilities) describes challenge types and capabilities. For a response-driven integration, follow [Configure an application](how-to-native-authentication-configure-app.md) to select and configure the V2 entry points.

## Conditional Access and sign-in frequency

Microsoft Entra External ID supports the Conditional Access [sign-in frequency (SIF)](../identity/conditional-access/concept-session-lifetime.md#user-sign-in-frequency) session control for both Microsoft-hosted and native authentication.

For native authentication, when reauthentication is required by the policy, Microsoft Entra External ID prevents token issuance during refresh token grants (`grant_type=refresh_token`). Your app must handle the failed token refresh and prompt the user to sign in again before it can acquire new tokens. The policy doesn't display the sign-in UI for your app.

<a id="next-step"></a>

## Next steps

- [Run the SDK sign-in quickstart](quickstart-native-authentication.md).
- [Configure an application for native authentication](how-to-native-authentication-configure-app.md).
- [Implement the Native Authentication API](reference-native-authentication.md).
- [Review SDK compatibility and migration](how-to-migrate-native-authentication-v1-v2.md).

## Related content

- [Native authentication flow](concept-native-authentication-flow.md).
- [Native authentication user attributes](concept-native-authentication-user-attributes.md).
- [Choose an authentication approach](../external-id/customers/concept-choose-authentication-approach.md).
