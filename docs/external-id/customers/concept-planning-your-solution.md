---
title: Plan a CIAM Deployment
description: Discover the steps for setting up a customer identity and access management (CIAM) solution in an external tenant, including creating a tenant, registering apps, and setting up user flows for sign-in.
ai-usage: ai-assisted
ms.topic: concept-article
ms.date: 05/21/2026

ms.custom: it-pro, seo-july-2024

---

# Planning for customer identity and access management

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Microsoft Entra External ID adds customer identity and access management (CIAM) to your app on the Microsoft Entra platform, so you get consistent app integration, tenant management, and operations across workforce and customer scenarios.

This article is a decision-making guide for the six planning steps. Each section summarizes the key choices and links to the canonical how-tos and reference docs.

:::image type="content" source="media/concept-planning-your-solution/planning-flow-horizontal.png" alt-text="Diagram showing the six setup steps as a horizontal flow: create an external tenant, choose an authentication approach, register your application, integrate a sign-in flow, secure your sign-in, and customize your sign-in.":::

Jump to a step for details, or go straight to the **How-to guides**.

| Step  |  How-to guides |
|---------|---------|
|**[Step 1: Create an external tenant](#step-1-create-an-external-tenant)**   | &#8226; [Create an external tenant](how-to-create-external-tenant-portal.md)</br>&#8226; <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">Or start a free trial</a>  |
|**[Step 2: Choose an authentication approach](#step-2-choose-an-authentication-approach)**   | &#8226; [Choose an authentication approach](concept-choose-authentication-approach.md)  |
|**[Step 3: Register your application](#step-3-register-your-application)**   | &#8226; [Register your application](/entra/identity-platform/quickstart-register-app)  |
|**[Step 4: Integrate a sign-in flow with your app](#step-4-integrate-a-sign-in-flow-with-your-app)**     | &#8226; [Create a user flow](how-to-user-flow-sign-up-sign-in-customers.md) </br>&#8226; [Add your app to the user flow](how-to-user-flow-add-application.md)   |
|**[Step 5: Secure your sign-in](#step-5-secure-your-sign-in)**     | &#8226; [Add multifactor authentication (MFA)](concept-multifactor-authentication-customers.md)</br>&#8226; [Review security and governance](concept-security-customers.md)</br>&#8226; [Integrate third-party bot protection](tutorial-third-party-bot-protection-native-api-sign-up.md) *(native authentication)*</br>&#8226; [Integrate third-party ATO protection](tutorial-third-party-account-take-over-protection-native-api.md) *(native authentication)*    |
|**[Step 6: Customize your sign-in](#step-6-customize-your-sign-in)**     | &#8226; [Customize branding](concept-branding-customers.md) *(browser-delegated)*</br>&#8226; [Use a custom URL domain](concept-custom-url-domain.md)</br>&#8226; [Add custom authentication extensions](concept-custom-extensions.md)    |

## Step 1: Create an external tenant

:::image type="content" source="media/concept-planning-your-solution/planning-flow-horizontal-step-1.png" alt-text="Diagram showing the setup flow with step 1, create an external tenant, highlighted.":::

Your external tenant is the resource where you register apps and manage customer identities, separate from your workforce tenant. When you create it, you choose its geographic location and domain name. If you currently use Azure AD B2C, your existing B2C tenants aren't affected; see [Plan your migration from Azure AD B2C to External ID](plan-your-migration-from-b2c-to-external-id.md).

[!INCLUDE [active-directory-b2c-end-of-sale-notice.md](~/includes/active-directory-b2c-end-of-sale-notice.md)]

The directory contains both [admin accounts](how-to-manage-admin-accounts.md) and customer accounts. Customers usually self-register; you can also [create local accounts](how-to-manage-customer-accounts.md). Customer accounts have a restricted [default permission set](reference-user-permissions.md) and can't see other users, groups, or devices.

### How to create an external tenant

- [Create an external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
- Don't have a tenant yet? [Start a free trial](https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl).
- Using VS Code? Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/quickstarts/marketplace) ([learn more](https://aka.ms/ciamvscode/quickstartguide)).

## Step 2: Choose an authentication approach

:::image type="content" source="media/concept-planning-your-solution/planning-flow-horizontal-step-2.png" alt-text="Diagram showing the setup flow with step 2, choose an authentication approach, highlighted.":::

Decide how to build the sign-in experience before you register your app. This choice drives the rest of your integration.

- **Browser-delegated authentication** — Microsoft hosts the sign-in page; your app redirects users to it. Broad platform support, system-browser SSO, lower maintenance.
- **Native authentication** — your app hosts the sign-in UI and calls MSAL or the native authentication API directly. Full UI control, more development and security responsibility.

### How to choose an authentication approach

- [Choose an authentication approach](concept-choose-authentication-approach.md) — feature comparison and trade-offs.
- [Native authentication overview](/entra/identity-platform/concept-native-authentication) — detail if you're considering native.

## Step 3: Register your application

:::image type="content" source="media/concept-planning-your-solution/planning-flow-horizontal-step-3.png" alt-text="Diagram showing the setup flow with step 3, register your application, highlighted.":::

Register your app in your external tenant to establish a trust relationship with Microsoft Entra ID. The settings you configure depend on the authentication approach you chose in Step 2:

| Setting | Browser-delegated | Native authentication |
|---|---|---|
| Redirect URI | Required (matches your app's sign-in callback) | Required only as a [web fallback](/entra/identity-platform/concept-native-authentication-web-fallback) |
| Public client flows | Not required | Enabled |
| Native authentication | Not required | Enabled |

After you register the app, update your code with the application (client) ID, tenant subdomain, and (if applicable) client secret.

### How to register your application

- Find platform-specific guidance on the [Samples by app type and language page](samples-ciam-all.md).
- If your platform isn't listed, follow the general [register an application](/entra/identity-platform/quickstart-register-app) quickstart.
- For native authentication app settings, see [How to enable native authentication](/entra/identity-platform/concept-native-authentication#how-to-enable-native-authentication).

## Step 4: Integrate a sign-in flow with your app

:::image type="content" source="media/concept-planning-your-solution/planning-flow-horizontal-step-4.png" alt-text="Diagram showing the setup flow with step 4, integrate a sign-in flow with your app, highlighted.":::

Create a sign-up and sign-in user flow that defines the sign-in methods, attributes to collect, and identity providers for your app. You create the user flow the same way for both authentication approaches; the difference is how your app drives it at runtime:

| | Browser-delegated | Native authentication |
|---|---|---|
| Runtime behavior | App redirects to the Microsoft-hosted sign-in page | App calls MSAL native authentication APIs from your own UI |
| Supported app types | Web, SPA, mobile, daemon | Mobile, SPA |
| Federated identity providers (social, external IdPs) | Supported | Not supported — use browser-delegated if needed |
| Company branding | Applies to Microsoft-hosted pages | Managed in your app's UI/localization |
| Attribute collection | Configured in the user flow | Configured in the user flow; submitted via the MSAL [user attribute builder](/entra/identity-platform/concept-native-authentication-user-attribute-builder) |

### Plan your user flow

- **Number of user flows.** Each app uses one user flow. You can share one flow across apps or create up to 10 per tenant for differentiated experiences.
- **Attributes to collect.** Decide which built-in attributes you need and whether you need [custom attributes](how-to-define-custom-attributes.md).
- **Terms and conditions consent.** Use custom attributes to capture consent with links to your terms and privacy policies.
- **Token claims.** [Add required attributes to the token](how-to-add-attributes-to-token.md) if your app depends on them.
- **Sign-in methods.** Local accounts (email OTP, email + password) work with both approaches. Federated providers ([Google](how-to-google-federation-customers.md), [Facebook](how-to-facebook-federation-customers.md), [Apple](how-to-apple-federation-customers.md), [another Microsoft Entra tenant](how-to-entra-id-federation-customers.md), [custom OIDC](how-to-custom-oidc-federation-customers.md)) require browser-delegated authentication.

### How to integrate a user flow with your app

- [Define custom attributes](how-to-define-custom-attributes.md) (if needed).
- [Create the sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md).
- [Add your application to the user flow](how-to-user-flow-add-application.md).
- Wire up your app code:
    - **Browser-delegated:** follow a [sample or quickstart](samples-ciam-all.md) for your app type.
    - **Native authentication:** follow the [native authentication overview and tutorials](/entra/identity-platform/concept-native-authentication).

## Step 5: Secure your sign-in

:::image type="content" source="media/concept-planning-your-solution/planning-flow-horizontal-step-5.png" alt-text="Diagram showing the setup flow with step 5, secure your sign-in, highlighted.":::

Every customer-facing app needs MFA and a baseline security review. Native authentication apps have extra work: because your app is the exposed sign-in surface, you front it with a web application firewall (WAF). Browser-delegated apps inherit Microsoft's platform-level protections on the hosted sign-in pages.

- **Enable MFA.** [Available MFA methods](concept-multifactor-authentication-customers.md).
- **Review security and governance.** Conditional Access, risk-based policies, auditing. See [Security and governance](concept-security-customers.md).
- **Add bot protection** *(native authentication only)*. Requires a [custom URL domain](concept-custom-url-domain.md). See [Integrate third-party bot protection](tutorial-third-party-bot-protection-native-api-sign-up.md).
- **Add account takeover (ATO) protection** *(native authentication only)*. Requires a [custom URL domain](concept-custom-url-domain.md). See [Integrate third-party ATO protection](tutorial-third-party-account-take-over-protection-native-api.md).

## Step 6: Customize your sign-in

:::image type="content" source="media/concept-planning-your-solution/planning-flow-horizontal-step-6.png" alt-text="Diagram showing the setup flow with step 6, customize your sign-in, highlighted.":::

Customize the sign-in look and feel and extend it with your own business logic. With native authentication, your app owns the UI, so the Microsoft Entra company-branding feature doesn't apply — manage visuals and localization in your app code.

- **Customize branding** *(browser-delegated only)*. Apply your logo, colors, and language strings to the Microsoft-hosted sign-in pages. See [Customize the sign-in look and feel](concept-branding-customers.md).
- **Use a custom URL domain.** Replace the default `ciamlogin.com` host with your own domain. Also a prerequisite for native authentication bot/ATO protection in [Step 5](#step-5-secure-your-sign-in). See [Custom URL domain](concept-custom-url-domain.md).
- **Add custom authentication extensions.** Extend the flow with server-side logic. Token-issuance extensions work with both approaches; attribute-collection extensions are browser-delegated only. See [Custom authentication extensions](concept-custom-extensions.md).

## Next steps
- [Start a free trial](https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl) or [create your external tenant](how-to-create-external-tenant-portal.md).
- [Find samples and guidance for integrating your app](samples-ciam-all.md).
- [Learn how to migrate users from your current identity provider](how-to-migrate-users.md).
- See also the [Microsoft Entra External ID Developer Center](https://aka.ms/ciam/dev) for the latest developer content and resources.
- [Microsoft Entra External ID deployment guide for security operations](../../architecture/deployment-external-operations.md)
