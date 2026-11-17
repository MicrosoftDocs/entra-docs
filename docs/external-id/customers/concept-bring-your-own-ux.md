---
title: Bring Your Own UX authentication overview
description: Understand Bring Your Own UX authentication in Microsoft Entra External ID, including page ownership, policy boundaries, and developer responsibilities.
author: adamstoffel
ms.author: adamstoffel
ms.topic: overview
ms.date: 11/13/2026
ms.custom: msecd-doc-authoring-1030
ai-usage: ai-generated

#customer intent: As an application developer, I want to understand Bring Your Own UX authentication so that I can design a self-hosted authentication page with clear application and service responsibilities.
---

# Bring Your Own UX authentication overview

Bring Your Own UX (BYO UX) is an authentication approach in Microsoft Entra External ID that lets your team host and manage a browser-based authentication page. You control the page's presentation and application logic. Microsoft Entra External ID applies authentication policy and verifies credentials.

BYO UX connects a relying application's OAuth or OpenID Connect (OIDC) authorization request to your self-hosted page. The page uses the Native Authentication API for sign-up, sign-in, or password recovery, then returns control to Microsoft Entra External ID to finish the original authorization request.

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

[!INCLUDE [bring-your-own-ux-preview](../includes/bring-your-own-ux-preview.md)]

<a name='application-and-service-responsibilities'></a>

## Architecture and ownership

The relying application and self-hosted page have separate endpoints and responsibilities.

| Component | Responsibility |
| --- | --- |
| **Relying application** | Starts authorization, validates the response at its registered reply URL, redeems the authorization code, and manages its application session. |
| **Self-hosted authentication page** | Receives the handoff, collects input, and follows the actions and links returned by the Native Authentication API. |
| **Application-controlled server or proxy** | Mediates browser API calls where needed and restricts their destinations. It handles sensitive authentication requests and responses. |
| **Microsoft Entra External ID** | Enforces policy, verifies credentials, protects transaction state, creates the browser session, and completes authorization. |
| **Browser** | Carries the handoff and completion through the same top-level browser flow, with normal cookie handling. |

The self-hosted page URL isn't the relying application's OAuth reply URL. Your team owns the page's hosting, maintenance, monitoring, and integration code.

The relying application uses the same OAuth or Microsoft Authentication Library (MSAL) integration as a Microsoft-hosted flow. Use the maintained [authorization-code flow](~/identity-platform/v2-oauth2-auth-code-flow.md) and [MSAL guidance](~/identity-platform/msal-overview.md) for that application. BYO UX implementation focuses on the authentication website's handoff, API calls, and browser completion.

### BYO UX and the other authentication choices

Unlike Microsoft-hosted company branding or branding themes, BYO UX gives your team responsibility for hosting the authentication page. Embedded native authentication integrates authentication interactions into the application; BYO UX introduces a self-hosted browser page into the relying application's authorization flow.

Sharing the Native Authentication API doesn't make these approaches' initialization, completion, sessions, or supported capabilities interchangeable. An OAuth library used by the relying application doesn't implement the page's BYO UX handoff or native authentication transaction.

For the decision framework, see [Choose an authentication approach](concept-choose-authentication-approach.md).

<a name='supported-journeys-and-integration-scope'></a>

## Common policy boundaries and supported journeys

The authentication approaches use the same Microsoft Entra External ID tenant and user-flow policy foundation. BYO UX changes presentation and integration responsibilities, not who decides whether authentication requirements are satisfied.

Your page can offer returned actions to the user or select an available action through application logic. Required credentials, attributes, and policy checks still apply.

| Journey | Supported behavior |
| --- | --- |
| **Sign-up** | Email with password or passwordless email one-time passcode, as configured by the user flow. |
| **Sign-in** | Email with password, username with password for configured local accounts (preview), or email one-time passcode. |
| **Password recovery** | Email or SMS one-time-passcode verification for accounts that use an email address and password, from an available handoff link or inline during sign-in. |
| **Multifactor authentication (MFA)** | Email or SMS verification and inline method registration when requested by the service. An email one-time-passcode first factor uses SMS, not email, as its second factor. |

Passwordless accounts have no password to reset. Sign-up, password recovery, or successful first-factor verification can lead to more MFA or policy interactions rather than immediate authorization completion.

BYO UX supports custom authentication extensions for email one-time passcode sending (`OnOtpSend`) and token issuance (`OnTokenIssuanceStart`). Attribute collection start and submit extension events aren't supported for BYO UX. See [Custom authentication extensions](concept-custom-extensions.md) for event-specific configuration and behavior.

Availability can differ by approach, journey, and user flow. See [Supported features](concept-supported-features-customers.md) for the capabilities available with each approach.

<a name='browser-handoff-and-completion'></a>

## Browser handoff and protocol lifecycle

BYO UX keeps the relying application's authorization request active while your page handles authentication:

- **Authorization:** The relying application starts an authorization-code request in the top-level browser.
- **Handoff:** Microsoft Entra External ID sends a form POST to the configured self-hosted page, with initialization information and the initial authentication response.
- **Authentication:** Your page follows the Native Authentication API's returned actions and links with the latest continuation token.
- **Completion:** At `state: continue`, your page submits the final token to the returned BYO UX finish link through a top-level browser form POST.
- **Authorization response:** Microsoft Entra External ID resumes authorization and returns the response to the relying application's registered reply URL.

The sequence shows an interactive authorization-code flow. A browser session that already satisfies the request can skip the self-hosted page.

:::image type="complex" source="media/bring-your-own-ux/bring-your-own-ux-sequence.svg" alt-text="Sequence diagram of the BYO UX browser handoff, Native Authentication API interactions, finish form POST, and authorization-code exchange." lightbox="media/bring-your-own-ux/bring-your-own-ux-sequence.svg":::
   The relying application starts authorization in the top-level browser. Microsoft Entra External ID returns an HTML handoff form, and the browser posts `context` and `initialResponse` to the configured self-hosted page.

   The page decodes the envelopes and checks the expected configuration and authentication destinations. It follows native authentication links through its configured browser/proxy integration, using the current input and continuation token and replacing its response model after every reply.

   At `state: continue`, the page submits the returned finish link through a top-level browser form with `continuation_token`. The browser handles Microsoft Entra cookies automatically; the page doesn't read or manually forward HTTP-only cookies.

   Microsoft Entra External ID completes the original authorization request. The browser delivers the code and original OAuth state to the relying application, which validates the response and redeems the code for tokens.
:::image-end:::

<a name='response-driven-orchestration'></a>

Use the same response handling for initialization and every later response. The initial response can already request attributes, verification, enrollment, or completion; it isn't limited to journey selection. Some actions, such as polling, don't require a new input form.

The page's API requests and its browser finish operation are different transports. Finish isn't a background API request. The browser handles Microsoft Entra cookies automatically; the page doesn't read or manually forward HTTP-only cookies.

For the envelopes and transport, see the [BYO UX API and protocol reference](reference-bring-your-own-ux.md). For shared response handling, see [Native authentication flow concepts](~/identity-platform/concept-native-authentication-flow.md).

<a name='sessions-and-navigation'></a>

## Sessions, navigation, and fallback

An existing single sign-on (SSO) browser session that satisfies the authorization request skips the self-hosted page. Successful interactive BYO UX completion creates a Microsoft Entra browser session. Manage the relying application's session separately.

BYO UX doesn't currently support customizing the account/session picker, application consent page, logout page, or user opt-in for **Stay signed in?**. When a required interaction isn't supported by BYO UX, the current implementation falls back to Microsoft-hosted UX.

The following scenarios can display Microsoft-hosted UX. Configure the relying application and tenant to avoid these interactions:

| Scenario | Microsoft-hosted experience | Workaround |
| --- | --- | --- |
| **Sign-out without an account hint** | Account selection during sign-out. | Include `logout_hint` in the relying application's logout request to identify the account to sign out. See [Send a sign-out request](~/identity-platform/v2-protocols-oidc.md#send-a-sign-out-request). |
| **Multiple browser sessions** | Account selection when the authorization request doesn't identify the intended account. | Include `login_hint` in the relying application's authorization request to identify the intended account, or use `prompt=login` to require fresh authentication. `prompt=login` disables SSO for that request. See [Authorization request parameters](~/identity-platform/v2-oauth2-auth-code-flow.md#request-an-authorization-code). |
| **Stay signed in?** | A prompt asking the user whether to persist the browser session. | Configure the Conditional Access **Persistent browser session** control as **Always persistent** or **Never persistent**, according to your requirements. Either setting suppresses the prompt. See [Configure the tenant-level session policy](how-to-configure-bring-your-own-ux.md#configure-session-persistence). |
| **Application consent** | A consent interaction for the relying application's requested API permissions. | Have an administrator review and grant admin consent for the required API permissions on the **relying application registration** before users sign in. See [Grant admin consent in App registrations](~/identity/enterprise-apps/grant-admin-consent.md#grant-admin-consent-in-app-registrations-pane). |

The authorization and logout parameters belong to the relying application's OAuth integration, not the self-hosted page's Native Authentication API requests. These workarounds address the listed interactions; they don't guarantee that every request avoids Microsoft-hosted UX.

> [!TIP]
> Even when you use BYO UX, configure [custom branding](how-to-customize-branding-customers.md) or custom HTML for Microsoft-hosted flows to match your self-hosted page. This helps minimize disruption to the user experience when Microsoft-hosted fallback occurs.

Support for managing account selection on the self-hosted page is planned. See [Future account selection](reference-bring-your-own-ux.md#future-account-selection) for the reserved `disambiguate` action and current handling requirements.

Keep the latest continuation token and its links together for the active transaction. Browser Back/Forward navigation or a restored page can contain stale transaction state. If the current token expires or the service requires a restart, start a new authorization request from the relying application instead of replaying that state.

<a name='transaction-security'></a>

## Security responsibilities

Treat continuation tokens as opaque, sensitive transaction state. Use each token only with the links from its response, and keep transactions separate.

Use a tenant-verified custom domain for the OAuth service authority, every Native Authentication API call, and the finish link. The self-hosted page and service can use different domains, but both must meet the same tenant's domain-ownership checks.

Resolve relative authentication links against the Microsoft Entra authority that handled authorization, not the self-hosted page's origin. Validate destinations before sending authentication data. Keep credentials, passcodes, and tokens out of URLs, diagnostic logs, analytics, and support attachments.

Decoded handoff data and matching tenant/client IDs don't authenticate the sender or establish user intent. Microsoft Entra External ID validates protected continuation state; the relying application remains responsible for validating its original OAuth state.

The page handles credential input, so its hosting, proxy, and diagnostics are part of your authentication security boundary. Use HTTPS and service-provided masked hints, and avoid messages that reveal whether an account exists. Keep confidential-client credentials on the server.

<a id="limitations-and-review-boundaries"></a>

## Integration boundaries

Use these boundaries when designing the page and relying application:

- Use OAuth 2.0 or OIDC authorization-code flow. SAML and WS-Federation aren't yet supported.
- Register a web-type reply URL for both public and confidential relying applications.
- Use the Native Authentication API inside the page. The BYO UX transaction doesn't provide direct Microsoft Graph or Credential API access.
- Finish with the current, unexpired continuation token. Start a new authorization request if that token expires or the service requires a restart.

<a id="next-step"></a>

<a id="next-steps"></a>

## Implement BYO UX

- [Configure Bring Your Own UX authentication](how-to-configure-bring-your-own-ux.md).
- [Implement the BYO UX handoff and finish protocol](reference-bring-your-own-ux.md).
- [Handle native authentication flow responses](~/identity-platform/concept-native-authentication-flow.md).

## Related content

- [Choose an authentication approach](concept-choose-authentication-approach.md).
- [Native authentication user attributes](~/identity-platform/concept-native-authentication-user-attributes.md).
