---
title: External Tenant Overview
description: Learn how Microsoft Entra External ID provides to manage your external identities scenarios, including guest user access and customer identity and access management (CIAM) for apps.
 
ms.author: cmulligan
author: csmulligan
manager: dougeby
ms.service: entra-external-id
 
ms.subservice: external
ms.topic: overview
ms.date:  03/12/2025
ms.custom: it-pro, seo-july-2024

#Customer intent: As a dev, devops, or it admin, I want to learn about identity solutions for apps for consumers and business customers.
---

# Overview: Secure your apps using External ID in an external tenant

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Microsoft Entra External ID includes Microsoft's customer identity and access management (CIAM) solution. For organizations and businesses that want to make their apps available to consumers and business customers, External ID makes it easy to add CIAM features like self-service registration, personalized sign-in experiences, and customer account management. Because these CIAM capabilities are built into Microsoft Entra ID, you also benefit from platform features like enhanced security, compliance, and scalability.

:::image type="content" source="media/overview-customers-ciam/overview-ciam.png" alt-text="Diagram showing an overview customer identity and access management." border="true":::

 

## Create a dedicated external tenant

When getting started with External ID for your consumer and business customer apps, you first create a tenant for your apps, resources, and directory of customer accounts.

If you've worked with Microsoft Entra ID, you're already familiar with using a Microsoft Entra tenant that contains your employee directory, internal apps, and other organizational resources. With External ID, you create a distinct tenant that follows the standard Microsoft Entra tenant model but is configured for external scenarios. This external tenant contains:

- **A directory**: The directory stores your customers' credentials and profile data. When a consumer or business customer signs up for your app, a local account is created for them in your external tenant.

- **Application registrations**: Microsoft Entra ID performs identity and access management only for registered applications. Registering your app establishes a trust relationship and allows you to integrate your app with Microsoft Entra ID.

- **User flows**: The external tenant contains the self-service sign-up, sign-in, and password reset experiences you want to enable for your customers.

- **Extensions**: If you need to add user attributes and data from external systems, you can create custom authentication extensions for your user flows.

- **Sign-in methods**: You can enable various options for signing in to your app, including username and password, one-time passcode, and Google, Facebook, Apple or custom OIDC identities.

- **Encryption keys**: Add and manage encryption keys for signing and validating tokens, client secrets, certificates, and passwords.

Learn more about [password and one-time passcode](how-to-enable-password-reset-customers.md) sign-in, and about [Google](how-to-google-federation-customers.md), [Facebook](how-to-facebook-federation-customers.md), [Apple](how-to-apple-federation-customers.md) and [OIDC](how-to-custom-oidc-federation-customers.md) federation.

There are two types of user accounts you can manage in your external tenant:

- **Customer account**: Accounts that represent the customers who access your applications.

- **Admin account**: Users with work accounts can manage resources in a tenant, and with an administrator role, can also manage tenants. Users with work accounts can create new consumer accounts, reset passwords, block/unblock accounts, and set permissions or assign an account to a security group.

Learn more about managing [customer accounts](how-to-manage-customer-accounts.md) and [admin accounts](how-to-manage-admin-accounts.md) in your external tenant.

## Add customized sign-in

External ID is intended for businesses that want to make applications available to their customers using the Microsoft Entra platform for identity and access.

- **Add sign-up and sign-in pages to your apps.** Quickly add intuitive, user-friendly sign-up and sign-in experiences for your customer apps. With a single identity, a customer can securely access all the applications you want them to use.

- **Add single sign-on (SSO) with social and enterprise identities.** Customers can choose a social, enterprise, or managed identity to sign in with a username and password, email, or one-time passcode.

- **Add your company branding to the sign-up page.** Customize the look and feel of your sign-up and sign-in experiences, including both the default experience and the experience for specific browser languages.

- **Easily customize and extend your sign-up flows.** Tailor your identity user flows to your needs. Choose the attributes you want to collect from a customer during sign-up, or add your own custom attributes. If the information your app needs is contained in an external system, create custom authentication extensions to collect and add data to authentication tokens.

- **Integrate multiple app languages and platforms.** With Microsoft Entra, you can quickly set up and deliver secure, branded authentication flows for multiple app types, platforms, and languages.

- **Use native authentication for your apps.** Create seamless authentication experiences for mobile and desktop applications using the Microsoft Authentication Library (MSAL) for iOS and Android. 

- **Provide self-service account management.** Customers can register for your online services by themselves, manage their profile, delete their account, enroll in a multifactor authentication (MFA) method, or reset their password with no admin or help desk assistance.

- **Consent to your terms of use and privacy policies.** You can prompt users to accept your terms and conditions during sign-up. By using customer user attributes, you can add checkboxes to your sign-up form and include links to your terms of use and privacy policies.

Learn more about [adding sign-in and sign-up to your app](concept-planning-your-solution.md) and [customizing the sign-in look and feel](concept-branding-customers.md).

## Design user flows for self-service sign-up

You can create a simple sign-up and sign-in experience for your customers by adding a user flow to your application. The user flow defines the series of sign-up steps customers follow and the sign-in methods they can use (such as email and password, one-time passcodes, social accounts from [Google](how-to-google-federation-customers.md), [Facebook](how-to-facebook-federation-customers.md) or [Apple](how-to-apple-federation-customers.md), as well as [custom OIDC](how-to-custom-oidc-federation-customers.md) identity providers). You can also collect information from customers during sign-up by selecting from a series of user built-in attributes or adding your own custom attributes.

Several user flow settings let you control how the customer signs up for the application, including:

- Sign-in methods and external identity providers
- Attributes to be collected from the customer signing up, such as first name, postal code, or country/region of residency
- Company branding and language customization

For details about configuring a user flow, see [Create a sign-up and sign-in user flow for customers](how-to-user-flow-sign-up-sign-in-customers.md).

## Add your own business logic

External ID is designed for flexibility by allowing you to define actions at certain points within the authentication flow. Using a custom authentication extension, you can add claims from external systems to the token just before it's issued to your application.

Learn more about [adding your own business logic](concept-custom-extensions.md)  with custom authentication extensions.

## Microsoft Entra security and reliability

External ID represents the convergence of business-to-consumer (B2C) features into the Microsoft Entra platform. You benefit from platform features like enhanced security, compliance with regulations, and the ability to scale your identity and access management processes.

### Conditional Access

Microsoft Entra Conditional Access brings signals together, to make decisions, and enforce security policies. Conditional Access policies at their simplest are if-then statements; **if** a user wants to access your application, **then** they must complete an action.

Conditional Access policies are enforced after the user has completed first-factor authentication. For example, if a user's sign-in risk level is high, they must perform MFA to gain access. Alternatively, the most restrictive approach is to block access to the application.

> [!TIP]
> [![Try it now](./media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=CA)
> 
> To try out this feature, go to the Woodgrove Groceries demo and start the “Conditional Access and multifactor authentication” use case.

### Multifactor authentication (MFA)

Microsoft Entra MFA helps safeguard access to data and applications while maintaining simplicity for your users. Microsoft Entra External ID integrates directly with Microsoft Entra MFA so you can add security to your sign-up and sign-in experiences by requiring a second form of authentication. You can fine-tune MFA depending on the extent of security you want to apply to your apps. Consider the following scenarios:

- You offer a single app to customers and you want to enable MFA for an extra layer of security. You can enable MFA in a Conditional Access policy that's targeted to all users and your app.

- You offer multiple apps to your customers, but you don't require MFA for every application. For example, the customer can sign into an auto insurance application with a social or local account, but must verify the phone number before accessing the home insurance application registered in the same directory. In your Conditional Access policy, you can target all users but just those apps for which you want to enforce MFA.

Learn more about [MFA in external tenants](concept-multifactor-authentication-customers.md) or see [how to enable multifactor authentication](how-to-multifactor-authentication-customers.md).

### Identity protection

Microsoft Entra [Identity Protection](~/id-protection/overview-identity-protection.md) provides ongoing risk detection for your external tenant. It allows you to discover, investigate, and remediate identity-based risks. Identity Protection allows organizations to accomplish three key tasks:

- Automate the detection and remediation of identity-based risks.

- Investigate risks using data in the portal.

- Export risk detection data to other tools.

Identity Protection comes with risk reports that can be used to investigate identity risks in external tenants. For details, see [Investigate risk with Identity Protection in Microsoft Entra External ID](how-to-identity-protection-customers.md).

### Microsoft Entra reliability and scalability

Create highly customized sign-in experiences and manage customer accounts at a large scale. Ensure a good customer experience by taking advantage of Microsoft Entra performance, resiliency, business continuity, low-latency, and high throughput.

## Analyze user activity and engagement

The Application user activity  feature under Usage & insights provides data analytics on user activity and engagement for registered applications in your tenant. You can use this feature to view, query, and analyze user activity data in the Microsoft Entra admin center. This can help you uncover valuable insights that can aid strategic decisions and drive business growth.

Learn more about the [application user activity dashboards](how-to-user-insights.md) that are available in an external tenant.

## About Azure AD B2C

If you're a new customer, you might be wondering which solution is a better fit, [Azure AD B2C](/azure/active-directory-b2c/) or Microsoft Entra External ID. Effective May 1, 2025, Azure AD B2C will no longer be available to purchase for new customers (learn more in our [FAQ](faq-customers.md#azure-ad-b2c-and-azure-ad-external-identities)). Microsoft Entra External ID represents the future of CIAM for Microsoft, and new features and capabilities will be focused on this platform. By choosing the next generation platform from the start, you will receive the benefits of rapid innovation and a future-proof architecture.

## Next steps

- See our [training, live demos, and videos](reference-training-videos.md).
- Learn more about [planning for Microsoft Entra External ID](concept-planning-your-solution.md).
- See also the [Microsoft Entra External ID Developer Center](https://aka.ms/ciam/dev) for the latest developer content and resources.
