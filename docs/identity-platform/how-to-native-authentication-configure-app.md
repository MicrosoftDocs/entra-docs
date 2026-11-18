---
title: Configure an app for Embedded native authentication
description: Register an application, enable native authentication, associate a user flow, and prepare permissions and policies for direct API calls.
ms.topic: how-to
ms.custom: msecd-doc-authoring-1030
ms.date: 11/17/2026
ai-usage: ai-generated
#customer intent: As an application developer, I want to configure a direct API application so that I can run native authentication journeys in my external tenant.
---

# Configure an app for embedded native authentication

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

[!INCLUDE [applies-to-authentication-native](../external-id/includes/applies-to-authentication-native.md)]

Configure your application registration and user flow before calling the Native Authentication API. This guide prepares a public client application for Embedded native authentication through direct API calls or an SDK.

[!INCLUDE [native-authentication-public-preview](~/external-id/includes/native-authentication-public-preview.md)]

## Prerequisites

- An [external tenant](../external-id/customers/how-to-create-external-tenant-portal.md).
- An account authorized to create or manage the application registration.
- Access to create or select the user flow and associate the application with it. Coordinate policy changes and consent with the appropriate tenant administrator.
- For browser-based apps, such as SPAs, a [tenant-verified custom URL domain](../external-id/customers/how-to-custom-url-domain.md) configured for the authentication service.

An application owner can manage the registration's authentication settings. For delegated access, use [application-scoped permissions](~/identity/role-based-access-control/delegate-app-roles.md) rather than assigning a tenant-wide administrator role solely for this task.

## Register the application

Create the registration in the external tenant that owns the customer accounts.

1. Sign in to the Microsoft Entra admin center and switch to your external tenant.
1. Browse to **Entra ID** > **App registrations** > **New registration**.
1. Enter an application **Name** and select the single-tenant supported account type for your external tenant.
1. Select **Register**.
1. On **Overview**, record the **Application (client) ID** and **Directory (tenant) ID**.
1. Record the tenant subdomain if your selected SDK requires it. Configure service API URLs as described in [Configure the API authority](#configure-the-api-authority).

For registration details, see [Register an application](quickstart-register-app.md). The client ID identifies this public client; it isn't a secret. Don't create or embed a client secret for these direct API requests.

## Configure the API authority

The Native Authentication API V2 requires a tenant-verified custom domain for browser-based apps, such as SPAs, to help protect against cross-site request forgery (CSRF). Non-browser clients, such as Android and iOS apps using native HTTP transports, don't require a custom domain. An embedded browser or webview isn't a native HTTP transport.

For a custom-domain integration, the authority has the form `https://{custom_domain}/{tenant}`, where `custom_domain` is the verified authentication domain, such as `login.contoso.com`, and `tenant` is the Directory (tenant) ID, a GUID. Configure it as follows:

1. [Verify and configure the custom URL domain](../external-id/customers/how-to-custom-url-domain.md) in the external tenant.
1. Configure the application or SDK to use that domain for authorization challenges, native interaction operations, authorization continuation, and token exchange.
1. Validate returned links against the configured authority. Keep their paths, versions, and query parameters unchanged.

For SPAs with Embedded native authentication and BYO UX websites, configure a cross-origin resource sharing (CORS) proxy or edge policy for cross-origin browser API calls. A proxy address is a transport setting, not a replacement service authority. Its upstream calls still use the tenant-verified custom domain and tenant GUID. See the [provider-neutral proxy requirements](concept-native-authentication-cors.md#proxy-contract).

Android and iOS apps using native HTTP transports call their configured service authority directly. A custom domain is optional for these clients, and they don't need CORS configuration or a CORS proxy. Use your selected SDK's documented authority configuration. Validate returned links against that authority and preserve their paths, versions, and query parameters.

## Enable public client and native authentication flows

The API requires native authentication to be enabled on this application.

1. In the app registration, under **Manage**, select **Authentication**.
1. On **Redirect URI configuration**, set **Enable the following mobile and desktop flows** to **Yes**.
1. Set **Enable native authentication** to **Yes**.
1. Select **Save**.

These application settings enable the integration. The app then uses returned methods, actions, and links to select allowed operations through user choice or application flow logic.

Configure redirect URIs separately for any platform SDK or browser-delegated integration you use. Browser sign-in needs its registered callback and the platform's URL-scheme or manifest configuration. Direct native authorization-code redemption doesn't establish a browser session and isn't a reason to require a browser redirect URI on every direct HTTP client.

See [Redirect URI configuration](reply-url.md) for browser and platform registration requirements.

<a id="select-the-integration-version"></a>

## Choose an integration

Choose direct API calls or Microsoft Authentication Library (MSAL) entry points for your platform. For direct calls, native routes use `/api/v2.0` and OAuth routes use `/oauth2/v2.0`; follow the [API reference](reference-native-authentication.md).

Use the [SDK compatibility guidance](how-to-migrate-native-authentication-v1-v2.md#sdk-compatibility) for the documented package versions, entry points, and enrollment support. Installing a new package doesn't migrate V1 calls. Keep V1 and V2 continuation states separate.

For direct inline email and SMS method registration, use the [enrollment contract](reference-native-authentication.md#authentication-method-enrollment).

## Create and associate a user flow

The associated user flow determines the email sign-up/sign-in method and requested attributes. Tenant and user-flow policies apply to Microsoft-hosted authentication, Embedded native authentication, and Bring Your Own UX (BYO UX). Use the [shared method and journey matrix](../external-id/customers/concept-supported-features-customers.md#methods-and-journeys-by-approach) to check which interactions each approach supports.

1. Browse to **Entra ID** > **External Identities** > **User flows**.
1. Select **New user flow**, or open the existing user flow you intend to use.
1. For a new flow, enter a **Name**. Under **Identity providers**, select **Email Accounts** and choose **Email with password** or **Email one-time passcode**.
1. Under **User attributes**, choose the attributes your application needs to collect. For a first integration, keep the required profile fields to the minimum your application needs.
1. Select **Create** for the new flow.
1. Open the flow. Under **Use**, select **Applications** > **Add application**.
1. Select the app registration, then choose **Select**.

An application has one user flow; a user flow can serve multiple applications. For an existing flow, verify the selected identity provider and attributes before changing settings used by other applications.

If you select email one-time passcode, enable it at the tenant level as described in [Create a user flow](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md). The sign-up API doesn't have a parameter that overrides the user flow's method selection.

## Configure scopes and consent

Establish permissions before starting authorization.

1. Identify the target resource and delegated scopes your application needs. The authorization request's `scope` parameter establishes the requested access.
1. If the app calls a protected API, configure its delegated permission on the client registration and arrange consent from an administrator authorized for that permission.
1. In **API permissions**, inspect the requested permissions and consent status. Don't add broad Microsoft Graph permissions just to enable native authentication.
1. Request the selected scopes in the initial authorization challenge. Add `offline_access` only if your app needs a refresh token.

The tenant's permissions and consent requirements apply to the target resource. See [Add permissions to access your web API](quickstart-configure-app-access-web-apis.md).

## Prepare MFA and password reset

Configure multifactor authentication (MFA) through the tenant's authentication-method and Conditional Access policies. The service enforces these requirements; the client handles the returned authentication steps.

1. If your application uses password accounts, [enable self-service password reset](../external-id/customers/how-to-enable-password-reset-customers.md) for the intended customers and recovery methods.
1. Configure the [MFA requirements](../external-id/customers/how-to-multifactor-authentication-customers.md) for the application and customers.
1. Prepare a customer account with the methods needed by the policy. Verify its recovery methods before testing password reset.
1. Test a flow with additional authentication required. Continue processing returned actions after sign-up or password reset rather than treating either operation as final authorization.

Inline method registration has a separate contract from profile attribute collection. The [flow concept](concept-native-authentication-flow.md#method-discovery-isnt-method-registration) links to the enrollment and activation contract.

## Verify the configuration

Use the request and response contracts in the [API reference](reference-native-authentication.md) for a direct integration, or run the [SDK quickstart](quickstart-native-authentication.md) with the React Next.js sample. Validate the selected integration with your application and user flow.

1. Start authorization. An unauthenticated request normally returns `401 InsufficientAuthorization` with a continuation token and enabled journey links.
1. Confirm that the intended journey link is present. If it isn't, check the app's user-flow association and policy configuration instead of constructing a missing URL.
1. Complete an advertised method, resume authorization, and exchange the code.

| Symptom | Configuration to check |
| --- | --- |
| **`invalid_client`** | Tenant/client ID match and native authentication enabled for the selected app. |
| **`invalid_scope`** | Scope spelling, resource registration, configured permissions, and consent. |
| **No expected journey link** | User-flow association and enabled authentication/recovery options. |
| **Browser preflight failure** | The proxy's allowed browser origin, `OPTIONS` handling, headers, JSON `POST`, and `PUT`. The service answers `OPTIONS` but doesn't grant browser-origin access. |
| **Browser callback failure** | The redirect URI and platform configuration for that browser integration, separately from direct native code redemption. |

## Next step

> [!div class="nextstepaction"]
> [Review the Native Authentication API contract](reference-native-authentication.md)
