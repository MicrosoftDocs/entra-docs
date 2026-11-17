---
title: Plan a Deployment
description: Plan a Microsoft Entra External ID deployment, from creating an external tenant and choosing an authentication approach to integrating and securing sign-in.
ai-usage: ai-assisted
ms.topic: concept-article
ms.date: 11/12/2026

ms.custom: it-pro, seo-july-2024, msecd-doc-authoring-1030
#customer intent: As an application developer or IT administrator, I want to plan a customer identity deployment so that I can configure and secure sign-in for my applications.
---

# Plan a Microsoft Entra External ID deployment

Microsoft Entra External ID adds customer identity and access management (CIAM) to your app on the Microsoft Entra platform, so you get consistent app integration, tenant management, and operations across workforce and customer scenarios.

[!INCLUDE [authentication-approaches](../includes/applies-to-authentication-approaches.md)]

Use this guide to plan your deployment in six steps. Each section summarizes the key choices and links to setup instructions and reference documentation.

:::image type="content" source="media/concept-planning-your-solution/planning-flow-horizontal.png" alt-text="Diagram of six setup steps: create a tenant, choose authentication, register an app, integrate a user flow, secure sign-in, and customize sign-in.":::

Jump to a step for details, or go straight to the **How-to guides**.

| Step | How-to guides |
| --------- | --------- |
| **[Step 1: Create an external tenant](#step-1-create-an-external-tenant)** | &#8226; [Create an external tenant](how-to-create-external-tenant-portal.md)</br>&#8226; <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">Or start a free trial</a> |
| **[Step 2: Choose an authentication approach](#step-2-choose-an-authentication-approach)** | &#8226; [Choose an authentication approach](concept-choose-authentication-approach.md) |
| **[Step 3: Register your application](#step-3-register-your-application)** | &#8226; [Register your application](/entra/identity-platform/quickstart-register-app) |
| **[Step 4: Integrate a sign-in flow with your app](#step-4-integrate-a-sign-in-flow-with-your-app)** | &#8226; [Create a user flow](how-to-user-flow-sign-up-sign-in-customers.md) </br>&#8226; [Add your app to the user flow](how-to-user-flow-add-application.md) |
| **[Step 5: Secure your sign-in](#step-5-secure-your-sign-in)** | &#8226; [Add multifactor authentication (MFA)](concept-multifactor-authentication-customers.md)</br>&#8226; [Review security and governance](concept-security-customers.md) |
| **[Step 6: Customize your sign-in](#step-6-customize-your-sign-in)** | &#8226; [Customize branding](concept-branding-customers.md) *(Microsoft-hosted pages)*</br>&#8226; [Use a custom URL domain](concept-custom-url-domain.md)</br>&#8226; [Add custom authentication extensions](concept-custom-extensions.md) |

## Step 1: Create an external tenant

:::image type="content" source="media/concept-planning-your-solution/planning-flow-horizontal-step-1.png" alt-text="Diagram showing the setup flow with step 1, create an external tenant, highlighted.":::

Your external tenant is the resource where you register apps and manage customer identities, separate from your workforce tenant. When you create it, you choose its geographic location and domain name. If you're migrating from Azure AD B2C, review the [Azure AD B2C migration planning guidance](plan-your-migration-from-b2c-to-external-id.md). For other identity deployments, review [user migration guidance](how-to-migrate-users.md).

The directory contains both [admin accounts](how-to-manage-admin-accounts.md) and customer accounts. Customers usually self-register; you can also [create local accounts](how-to-manage-customer-accounts.md). Customer accounts have a restricted [default permission set](reference-user-permissions.md) and can't see other users, groups, or devices.

### How to create an external tenant

- [Create an external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
- Don't have a tenant yet? [Start a free trial](https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl).
- Using Visual Studio Code? Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/quickstarts/marketplace) and its [quickstart guide](https://aka.ms/ciamvscode/quickstartguide).

## Step 2: Choose an authentication approach

:::image type="content" source="media/concept-planning-your-solution/planning-flow-horizontal-step-2.png" alt-text="Diagram showing the setup flow with step 2, choose an authentication approach, highlighted.":::

Decide how to build the sign-in experience before you register your app. This choice drives the rest of your integration.

- **Microsoft-hosted authentication** — Microsoft hosts the sign-in page, and your app redirects users to it. You can apply company branding or application-specific branding themes.
- **Embedded native authentication** — Your app presents the sign-in interface and calls an SDK or the Native Authentication API. Your team manages the interface and integration.
- **Bring Your Own UX (BYO UX)** — Your team hosts a separate authentication website within a browser-based authorization flow. Microsoft Entra External ID applies authentication policies and verifies credentials.

### How to choose an authentication approach

- [Choose an authentication approach](concept-choose-authentication-approach.md) — feature comparison and trade-offs.
- [Embedded native authentication overview](~/identity-platform/concept-native-authentication.md) — integration guidance for an interface in your app.

## Step 3: Register your application

:::image type="content" source="media/concept-planning-your-solution/planning-flow-horizontal-step-3.png" alt-text="Diagram showing the setup flow with step 3, register your application, highlighted.":::

Register your app in your external tenant to establish its application identity. Follow the registration guide for your platform and authentication approach.

| Setting | Microsoft-hosted | Embedded native authentication | BYO UX |
| --- | --- | --- | --- |
| Redirect URI | Register a callback URI for your app. | Configure the redirect required by your platform or browser integration, separately from direct native code redemption. | Register a web-type redirect URI, including for public clients. |
| Client type | Choose the registration for your app's platform. | Public client; enable public client flows. | Public or confidential client. |
| Service API authority | Default tenant domain or a custom URL domain. | Tenant-verified custom domain for the current API. | Tenant-verified custom domain for API calls. |
| Integration setup | Configure hosted sign-in. | Enable native authentication for the app. | Use Microsoft Graph beta to configure your self-hosted authentication page. |

After registration, configure your application and tenant identifiers. Keep confidential-client credentials on the server; don't place client secrets in mobile apps or browser code.

### How to register your application

- Find platform-specific guidance on the [Samples by app type and language page](samples-ciam-all.md).
- If your platform isn't listed, follow the general [register an application](~/identity-platform/quickstart-register-app.md) quickstart.
- For Embedded native authentication app settings, see [Configure an app for Embedded native authentication](~/identity-platform/how-to-native-authentication-configure-app.md).

## Step 4: Integrate a sign-in flow with your app

:::image type="content" source="media/concept-planning-your-solution/planning-flow-horizontal-step-4.png" alt-text="Diagram showing the setup flow with step 4, integrate a sign-in flow with your app, highlighted.":::

Create a sign-up and sign-in user flow that defines the sign-in methods, attributes to collect, and identity providers for your app. Use the [authentication support matrix](concept-supported-features-customers.md#authentication-approach-supportability) to check which configured features are available through your integration.

For the Native Authentication API integrations, follow the [attribute collection contract](~/identity-platform/concept-native-authentication-user-attributes.md).

### Plan your user flow

- **Number of user flows.** Each app uses one user flow. You can share one flow across apps or create up to 10 per tenant for differentiated experiences.
- **Attributes to collect.** Decide which built-in attributes you need and whether you need [custom attributes](how-to-define-custom-attributes.md).
- **Terms and conditions consent.** Use custom attributes to capture consent with links to your terms and privacy policies.
- **Token claims.** [Add required attributes to the token](how-to-add-attributes-to-token.md) if your app depends on them.
- **Sign-in methods.** Configure local account methods and identity providers for each user flow. With Microsoft-hosted authentication, configured federated providers can include [Google](how-to-google-federation-customers.md), [Facebook](how-to-facebook-federation-customers.md), [Apple](how-to-apple-federation-customers.md), [another Microsoft Entra tenant](how-to-entra-id-federation-customers.md), or [custom OpenID Connect (OIDC)](how-to-custom-oidc-federation-customers.md). Federation isn't supported through the Native Authentication API. Confirm method and journey availability in the [methods and journeys comparison](concept-supported-features-customers.md#methods-and-journeys-by-approach).

### How to integrate a user flow with your app

- [Define custom attributes](how-to-define-custom-attributes.md) (if needed).
- [Create the sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md).
- [Add your application to the user flow](how-to-user-flow-add-application.md).
- Integrate your app code:
    - **Microsoft-hosted:** Follow a [sample or quickstart](samples-ciam-all.md) for your app type.
    - **Embedded native authentication:** Start with the [application configuration guide](~/identity-platform/how-to-native-authentication-configure-app.md), [SDK quickstart](~/identity-platform/quickstart-native-authentication.md), or [Native Authentication API reference](~/identity-platform/reference-native-authentication.md). Confirm platform and SDK coverage in the [native authentication overview](~/identity-platform/concept-native-authentication.md#how-to-use-native-authentication). For an existing V1 integration, use the [V1 API reference](~/identity-platform/reference-native-authentication-api-v1.md) and [migration guide](~/identity-platform/how-to-migrate-native-authentication-v1-v2.md).
    - **Bring Your Own UX:** Review the [Bring Your Own UX overview](concept-bring-your-own-ux.md) for architecture, requirements, and implementation guidance.

## Step 5: Secure your sign-in

:::image type="content" source="media/concept-planning-your-solution/planning-flow-horizontal-step-5.png" alt-text="Diagram showing the setup flow with step 5, secure your sign-in, highlighted.":::

Plan MFA and review security for your customer-facing apps. Configure tenant policies and protect application sessions, tokens, and any credentials or state your integration handles. Assign ownership for the interface, integration, and hosting components your team operates. For responsibility boundaries, see [authentication integration responsibilities](concept-choose-authentication-approach.md#security-considerations).

- **Enable MFA.** Review [available MFA methods](concept-multifactor-authentication-customers.md).
- **Review security and governance.** Plan for Conditional Access, risk-based policies, and auditing. See [Security and governance](concept-security-customers.md).

## Step 6: Customize your sign-in

:::image type="content" source="media/concept-planning-your-solution/planning-flow-horizontal-step-6.png" alt-text="Diagram showing the setup flow with step 6, customize your sign-in, highlighted.":::

Customize the sign-in look and feel and extend it with your own business logic. You can configure Microsoft-hosted pages, manage the interface in your app with Embedded native authentication, or host your own page with BYO UX.

- **Customize branding** *(Microsoft-hosted pages)*. Apply your logo, colors, and language strings to the sign-in pages. See [Customize the sign-in look and feel](concept-branding-customers.md).
- **Use a custom URL domain.** All service API calls for the current Native Authentication API and BYO UX use a tenant-verified custom domain. See [Custom URL domain](concept-custom-url-domain.md).
- **Add custom authentication extensions.** Extend the flow with server-side logic. Event availability can differ by approach and API or SDK version. See [Custom authentication extensions](concept-custom-extensions.md).

## Next steps
- [Start a free trial](https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl) or [create your external tenant](how-to-create-external-tenant-portal.md).
- [Find samples and guidance for integrating your app](samples-ciam-all.md).
- [Learn how to migrate users from your current identity provider](how-to-migrate-users.md).
- See also the [Microsoft Entra External ID Developer Center](https://aka.ms/ciam/dev) for the latest developer content and resources.
- [Microsoft Entra External ID deployment guide for security operations](../../architecture/deployment-external-operations.md).
