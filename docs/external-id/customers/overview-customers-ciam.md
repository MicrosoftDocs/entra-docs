---
title: Overview - External ID in external tenants
description: Learn about customer identity access management (CIAM), a solution that lets you create secure, customized sign-in experiences for your apps and services.
 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: overview
ms.date: 04/29/2024
ms.author: mimart
ms.custom: it-pro

#Customer intent: As a dev, devops, or it admin, I want to learn about identity solutions for apps for consumers and business customers.
---

# Overview: Secure your apps using External ID in an external tenant

Microsoft Entra External ID includes Microsoft's customer identity and access management (CIAM) solution. For organizations and businesses that want to make their apps available to consumers and business customers, External ID makes it easy to add CIAM features like self-service registration, personalized sign-in experiences, and customer account management. Because these CIAM capabilities are built into Microsoft Entra ID, you also benefit from platform features like enhanced security, compliance, and scalability.

:::image type="content" source="media/overview-customers-ciam/overview-ciam.png" alt-text="Diagram showing an overview customer identity and access management." border="true":::

[!INCLUDE [preview-alert](../customers/includes/preview-alert/preview-alert-ciam.md)] 

## Create a dedicated external tenant

When getting started with External ID for your consumer and business customer apps, you first create a tenant for your apps, resources, and directory of customer accounts.

If you've worked with Microsoft Entra ID, you're already familiar with using a Microsoft Entra tenant that contains your employee directory, internal apps, and other organizational resources. With External ID, you create a distinct tenant that follows the standard Microsoft Entra tenant model but is configured for external scenarios. This external tenant contains:

- **A directory**: The directory stores your customers' credentials and profile data. When a consumer or business customer signs up for your app, a local account is created for them in your external tenant.

- **Application registrations**: Microsoft Entra ID performs identity and access management only for registered applications. Registering your app establishes a trust relationship and allows you to integrate your app with Microsoft Entra ID.

- **User flows**: The external tenant contains the self-service sign-up, sign-in, and password reset experiences you want to enable for your customers.

- **Extensions**: If you need to add user attributes and data from external systems, you can create custom authentication extensions for your user flows.

- **Sign-in methods**: You can enable various options for signing in to your app, including username and password, one-time passcode, and Google or Facebook identities.

- **Encryption keys**: Add and manage encryption keys for signing and validating tokens, client secrets, certificates, and passwords.

Learn more about [password and one-time passcode](how-to-enable-password-reset-customers.md) sign-in, and about [Google](how-to-google-federation-customers.md) and [Facebook](how-to-facebook-federation-customers.md) federation.

There are two types of user accounts you can manage in your external tenant:

- **Customer account**: Accounts that represent the customers who access your applications.

- **Admin account**: Users with work accounts can manage resources in a tenant, and with an administrator role, can also manage tenants. Users with work accounts can create new consumer accounts, reset passwords, block/unblock accounts, and set permissions or assign an account to a security group.

Learn more about managing [customer accounts](how-to-manage-customer-accounts.md) and [admin accounts](how-to-manage-admin-accounts.md) in your external tenant.

## Add customized sign-in

External ID is intended for businesses that want to make applications available to their customers using the Microsoft Entra platform for identity and access.

- **Add sign-up and sign-in pages to your apps.** Quickly add intuitive, user-friendly sign-up and sign-up experiences for your customer apps. With a single identity, a customer can securely access all the applications you want them to use.

- **Add single sign-on (SSO) with social and enterprise identities.** Customers can choose a social, enterprise, or managed identity to sign in with a username and password, email, or one-time passcode.

- **Add your company branding to the sign-up page.** Customize the look and feel of your sign-up and sign-in experiences, including both the default experience and the experience for specific browser languages.

- **Easily customize and extend your sign-up flows.** Tailor your identity user flows to your needs. Choose the attributes you want to collect from a customer during sign-up, or add your own custom attributes. If the information your app needs is contained in an external system, create custom authentication extensions to collect and add data to authentication tokens.

- **Integrate multiple app languages and platforms.** With Microsoft Entra, you can quickly set up and deliver secure, branded authentication flows for multiple app types, platforms, and languages.

- **Use native authentication for your apps.** Create seamless authentication experiences for mobile and desktop applications using the preview Microsoft Authentication Library (MSAL) for iOS and Android. 

- **Provide self-service account management.** Customers can register for your online services by themselves, manage their profile, delete their account, enroll in a multifactor authentication (MFA) method, or reset their password with no admin or help desk assistance.

- **Consent to your terms of use and privacy policies.** You can prompt users to accept your terms and conditions during sign-up. By using customer user attributes, you can add checkboxes to your sign-up form and include links to your terms of use and privacy policies.

Learn more about [adding sign-in and sign-up to your app](concept-planning-your-solution.md) and [customizing the sign-in look and feel](concept-branding-customers.md).

## Design user flows for self-service sign-up

You can create a simple sign-up and sign-in experience for your customers by adding a user flow to your application. The user flow defines the series of sign-up steps customers follow and the sign-in methods they can use (such as email and password, one-time passcodes, or social accounts from [Google](how-to-google-federation-customers.md) or [Facebook](how-to-facebook-federation-customers.md)). You can also collect information from customers during sign-up by selecting from a series of user built-in attributes or adding your own custom attributes.

Several user flow settings let you control how the customer signs up for the application, including:

- Sign-in methods and social identity providers (Google or Facebook)
- Attributes to be collected from the customer signing up, such as first name, postal code, or country/region of residency
- Company branding and language customization

For details about configuring a user flow, see [Create a sign-up and sign-in user flow for customers](how-to-user-flow-sign-up-sign-in-customers.md).

## Add your own business logic

External ID is designed for flexibility by allowing you to define actions at certain points within the authentication flow. Using a custom authentication extension, you can add claims from external systems to the token just before it's issued to your application.

Learn more about [adding your own business logic](concept-custom-extensions.md)  with custom authentication extensions.

## Microsoft Entra security and reliability

External ID represents the convergence of business-to-consumer (B2C) features into the Microsoft Entra platform. You benefit from platform features like enhanced security, compliance with regulations, and the ability to scale your identity and access management processes.

- **Microsoft Entra security.** Get all the security and data privacy benefits of Microsoft Entra, including Conditional Access, multifactor authentication, and governance. Protect access to your apps using strong authentication and risk-based adaptive access policies. Because customers are managed in a separate tenant, you can tailor your access policies to users who typically use personal and shared devices instead of managed ones.

- **Microsoft Entra reliability and scalability**. Create highly customized sign-in experiences and manage customer accounts at a large scale. Ensure a good customer experience by taking advantage of Microsoft Entra performance, resiliency, business continuity, low-latency, and high throughput.

Learn more about the [security and governance](concept-security-customers.md) features that are available in an external tenant.

## Analyze user activity and engagement

The Application user activity (Preview) feature under Usage & insights provides data analytics on user activity and engagement for registered applications in your tenant. You can use this feature to view, query, and analyze user activity data in the Microsoft Entra admin center. This can help you uncover valuable insights that can aid strategic decisions and drive business growth.

Learn more about the [application user activity dashboards](how-to-user-insights.md) that are available in an external tenant.

## About Azure AD B2C

If you're a new customer, you might be wondering which solution is a better fit, [Azure AD B2C](/azure/active-directory-b2c/) or Microsoft Entra External ID (preview). Opt for the current Azure AD B2C product if:

- You have an immediate need to deploy a production ready build.
  
   > [!NOTE]
   > Keep in mind that the next generation Microsoft Entra External ID platform represents the future of CIAM for Microsoft, and rapid innovation, new features and capabilities will be focused on this platform. By choosing the next generation platform from the start, you will receive the benefits of rapid innovation and a future-proof architecture.

Opt for the next generation Microsoft Entra External ID platform if:

- You’re starting fresh building identities into apps or you're in the early stages of product discovery.
- The benefits of rapid innovation, new features, and added capabilities are a priority.

## Next steps

- Learn more about [planning for Microsoft Entra External ID](concept-planning-your-solution.md).
- See also the [Microsoft Entra External ID Developer Center](https://aka.ms/ciam/dev) for the latest developer content and resources.