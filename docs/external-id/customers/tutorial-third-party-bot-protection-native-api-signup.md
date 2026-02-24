---
title: Integrate third-party bot protection with Native API sign-up
description: Learn how to integrate third-party bot protection providers with Native API sign-up flows in Microsoft Entra External ID by using a Web Application Firewall.
ms.topic: tutorial
ms.date: 02/24/2026
ai-usage: ai-assisted

#CustomerIntent: As an IT administrator, I want to integrate third-party bot protection with Native API sign-up flows in Microsoft Entra External ID to protect against automated bot attacks and fake account creation.
---
# Tutorial: Integrate third-party bot protection with Native API sign-up flows

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

This tutorial guides you through integrating third-party bot protection providers with Native API sign-up flows in Microsoft Entra External ID. By using a Web Application Firewall (WAF) to intercept sign-up requests, you can implement risk-based challenge mechanisms during user registration to protect against automated bot attacks and fake account creation.

> [!NOTE]
> This tutorial assumes you manually make raw HTTP requests to execute the sign-up flow. When possible, use a Microsoft-built and supported authentication SDK. See [Tutorial: Prepare your Android mobile app for native authentication](tutorial-native-authentication-prepare-android-app.md) and [Tutorial: Prepare your iOS/macOS mobile app for native authentication](tutorial-native-authentication-prepare-ios-macos-app.md).

## Prerequisites

- An external tenant. If you don't already have one, [create an external tenant](how-to-create-external-tenant-portal.md).
- A [registered application](/entra/identity-platform/quickstart-register-app) in the Microsoft Entra admin center with the following configuration:
    - Application (client) ID and Directory (tenant) ID recorded.
    - [Admin consent granted](/entra/identity-platform/quickstart-register-app#grant-admin-consent-external-tenants-only).
    - [Public client and native authentication flows enabled](/entra/identity-platform/concept-native-authentication#how-to-enable-native-authentication).
- A [user flow](how-to-user-flow-sign-up-sign-in-customers.md) created in the Microsoft Entra admin center and [associated with your application](how-to-user-flow-add-application.md).
- A [custom domain](how-to-custom-url-domain.md) associated with your external tenant.
- A third-party bot protection provider account (this tutorial uses HUMAN Security as an example) with the following configuration values:
   - Enforcer API credentials
   - SDK integration details
- A WAF platform account (this tutorial uses Cloudflare) with domain administrator privileges.

## How bot protection works

When a user attempts to sign up using Native Authentication, the sign-up request flows through a Web Application Firewall (WAF) that intercepts the /start endpoint. The WAF evaluates the request with your third-party bot protection provider using their detection APIs. If the request is flagged as suspicious based on device fingerprinting, behavioral analysis, or bot signatures, the WAF can block the request or present a challenge to verify the user is human.

This approach allows you to apply bot protection during the native sign-up flow without requiring browser-based redirects, maintaining the native app user experience while protecting against automated account creation and bot attacks.

## Architecture components

This integration involves several key components working together to provide bot protection:

- **External tenant:** A dedicated Microsoft Entra ID instance for managing external identities and customer access.
- **Native application:** A mobile or desktop application that uses Microsoft Entra External ID (native authentication) to sign users up and sign them in.
- **Native APIs:** Service endpoints that enable mobile and desktop apps to perform sign-up, sign-in, and self-service password reset (SSPR) flows in-app, without a browser redirect.
- **Web Application Firewall (WAF):** A firewall that inspects incoming and outgoing HTTP traffic, intercepts sign-up requests, and coordinates with the third-party provider for bot detection.
- **Third-party bot protection provider:** A third-party provider that delivers bot detection, device fingerprinting, and risk-assessment services to identify automated attacks.

:::image type="content" source="media/tutorial-third-party-bot-protection-native-api-signup/native-app-signup-flow-waf.png" alt-text="Diagram of risk-based authentication flow showing native app, WAF, third-party provider, and OTP-based MFA steps." lightbox="media/tutorial-third-party-bot-protection-native-api-signup/native-app-signup-flow-waf.png":::

## Configuration steps

1. Create a sign-up flow for your external tenant.
1. Create a WAF configuration.
1. Update the WAF layer to intercept specific API requests during sign-up flow.
1. Update the native app sign-up API call flow.

## Create a sign-up flow for your external tenant

Before integrating bot protection, ensure you have a working sign-up flow configured. If you've already completed this setup as part of the prerequisites, you can skip to the next section.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/).
1. If you haven't already done so, [register an application in the Microsoft Entra admin center](/entra/identity-platform/quickstart-register-app). Make sure to:
   - Record the **Application (client) ID** and **Directory (tenant) ID** for later use.
   - [Grant admin consent](/entra/identity-platform/quickstart-register-app#grant-admin-consent-external-tenants-only) to the application.
   - [Enable public client and native authentication flows](/entra/identity-platform/concept-native-authentication#how-to-enable-native-authentication).
1. If you haven't already done so, [create a user flow in the Microsoft Entra admin center](how-to-user-flow-sign-up-sign-in-customers.md#to-add-a-new-user-flow). When you create the user flow, take note of the user attributes you configure as required. These attributes are the ones that Microsoft Entra expects your app to submit.
1. [Associate your app registration with the user flow](how-to-user-flow-add-application.md).
1. Test the sign-up flow by [registering a customer user](how-to-manage-customer-accounts.md#create-a-customer-account). Alternatively, you can test after completing the integration.

## Configure WAF to intercept sign-up requests

Configure a WAF to intercept sign-up requests for bot detection. This tutorial uses Cloudflare as an example, but you can use any WAF that supports request interception and custom logic execution.

> [!IMPORTANT]
> A custom domain must be associated with your external tenant before configuring WAF. Without a custom domain, the WAF can't intercept sign-up requests.

For detailed Cloudflare WAF setup instructions, see [Configure Cloudflare WAF with Microsoft Entra External ID](how-to-configure-waf-integration.md).

## Configure WAF worker for bot detection

This section configures the WAF to intercept sign-up /start requests and perform bot detection with your third-party provider.

### Update the WAF layer to intercept specific API requests during sign-up flow

Use the Cloudflare WAF that you created in the previous section.

1. Sign in to the **Cloudflare account** for the external domain (mentioned in the Create a WAF configuration step) associated with the external tenant with at least **Domain Administrator** privilege.
1. Go to **Workers Routes**, and select **Create application**.

   :::image type="content" source="media/tutorial-third-party-bot-protection-native-api-signup/workers-pages-create-application.png" alt-text="Screenshot showing the Workers Routes page in Cloudflare.":::

   :::image type="content" source="media/tutorial-third-party-bot-protection-native-api-signup/workers-routes-page.png" alt-text="Screenshot of Cloudflare dashboard sidebar with Workers Routes selected, showing Access, Speed, Caching, Rules, and Error Pages menu options.":::

1. Select **Start with Hello World**.

   :::image type="content" source="media/tutorial-third-party-bot-protection-native-api-signup/create-application-template.png" alt-text="Screenshot showing the Start with Hello World template option." lightbox="media/tutorial-third-party-bot-protection-native-api-signup/create-application-template.png":::

1. Name the worker and select **Deploy**.

   :::image type="content" source="media/tutorial-third-party-bot-protection-native-api-signup/deploy-hello-world-worker.png" alt-text="Screenshot of Cloudflare Workers deployment screen showing worker name, code preview, and Deploy button." lightbox="media/tutorial-third-party-bot-protection-native-api-signup/deploy-hello-world-worker.png":::

1. Once the worker is deployed, select the **Settings** tab. Select **+Add** in **Domains & Routes**.

   :::image type="content" source="media/tutorial-third-party-bot-protection-native-api-signup/settings-domains-routes.png" alt-text="Screenshot of the Settings tab with Domains & Routes section and Add button for configuring worker routes." lightbox="media/tutorial-third-party-bot-protection-native-api-signup/settings-domains-routes.png":::

1. Select **Route**.

   :::image type="content" source="media/tutorial-third-party-bot-protection-native-api-signup/domains-routes-settings.png" alt-text="Screenshot showing the Route option." lightbox="media/tutorial-third-party-bot-protection-native-api-signup/domains-routes-settings.png":::

1. Select the domain from **Zone**. Add the following in the **Route** field:

   `*<custom_domain>/<external_tenant_id(guid)>/*signup/v1.0/start*`

   Select **Fail Closed** for failure mode.

   :::image type="content" source="media/tutorial-third-party-bot-protection-native-api-signup/route-configuration-screen.png" alt-text="Screenshot showing the Route configuration with Zone and Route fields." lightbox="media/tutorial-third-party-bot-protection-native-api-signup/route-configuration-screen.png":::

1. Select **Add Route**.

If the WAF setup was configured properly, all requests to the external tenant /start endpoint are intercepted by the worker.

### Configure worker logic for bot detection

The worker logic must be configured to:

1. Extract relevant information from the sign-up request (device fingerprint, IP address, user agent, behavioral data).
1. Send this data to your third-party bot protection provider's detection API.
1. Evaluate the bot detection score returned by the provider.
1. If the request is identified as a bot based on your threshold, block the request or present a challenge.
1. If the request appears legitimate, forward it to the Microsoft Entra /start endpoint.

#### Third-party provider integration

This tutorial uses [HUMAN Security](https://docs.humansecurity.com/home) as the third-party bot protection provider. The Enforcer API provided by HUMAN Security is used for bot detection. Refer to the following HUMAN Security documentation:

- [Enforce an HTTP request | HUMAN Documentation](https://docs.humansecurity.com/applications/reference/request)
- SDK documentation: [Overview | HUMAN Documentation](https://docs.humansecurity.com/applications/mobile-sdk-intro)

> [!NOTE]
> The worker code implementation is specific to your chosen bot protection provider's API and your detection thresholds. Contact Microsoft support for guidance on implementing the worker logic for your specific provider.

## Update the native app sign-up API call flow

The standard sign-up flow using Native API endpoints is described in the [Native authentication API reference documentation](/entra/identity-platform/reference-native-authentication-api?tabs=emailOtp#api-reference-for-sign-up). With bot protection enabled, your native app's sign-up flow interacts with the WAF layer transparently.

### Sign-up flow with bot protection

When the WAF intercepts a /start request and determines it's from a bot, it can either block the request entirely or present a challenge. The flow works as follows:

1. **App initiates sign-up:** The native app calls the /start endpoint to begin the sign-up flow.
1. **WAF intercepts request:** The WAF receives the request and extracts device and behavioral signals.
1. **Bot detection evaluation:** The WAF sends the signals to the bot protection provider for analysis.
1. **Decision point:**
   - If legitimate: Request is forwarded to Microsoft Entra /start endpoint.
   - If suspicious: Request is blocked or challenged based on your configuration.
1. **Sign-up continues:** If allowed, the standard sign-up flow proceeds with /challenge, /continue, and other endpoints.

> [!TIP]
> To enhance bot detection accuracy, integrate your provider's SDK into your native app to collect device fingerprinting and behavioral signals. Pass these signals to the WAF through custom headers or request parameters.

> [!NOTE]
> For Android SDK implementation examples using WAF-based bot protection, contact Microsoft support for code samples and integration guidance.

## Next steps

Now that you've integrated bot protection with Native Authentication sign-up, explore these related resources:

- [Native authentication API reference](/entra/identity-platform/reference-native-authentication-api)
- [Tutorial: Prepare your Android mobile app for native authentication](tutorial-native-authentication-prepare-android-app.md)
- [Tutorial: Prepare your iOS/macOS mobile app for native authentication](tutorial-native-authentication-prepare-ios-macos-app.md)
- [Enable custom URL domains for apps in external tenants](how-to-custom-url-domain.md)
- [Configure Cloudflare WAF with Microsoft Entra External ID](how-to-configure-waf-integration.md)
- [HUMAN Security Enforcer API documentation](https://docs.humansecurity.com/applications/reference/request)
