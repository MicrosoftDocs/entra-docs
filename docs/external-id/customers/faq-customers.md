---
title: Frequently asked questions
description: Find answers to frequently asked questions about Microsoft Entra External ID. Learn about pricing, features, and the future of Azure AD B2C and External Identities. 
 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: faq
ms.date: 10/21/2024
ms.author: mimart
ms.custom: it-pro
---

# Microsoft Entra External ID frequently asked questions

This article answers frequently asked questions about Microsoft Entra External ID. It offers guidance to help customers better understand Microsoft’s current external identities capabilities and the journey for our next generation platform (Microsoft Entra External ID).

This FAQ references customer identity and access management (CIAM). CIAM is an industry recognized category that covers solutions that manage identity, authentication, and authorization for external identity use cases (partners, customers, and citizens). Common functionality includes self-service capabilities, adaptive access, single sign-on (SSO), and bring your own identity (BYOI).

## External ID pricing  

### How is External ID billed?

Microsoft Entra External ID pricing is based on monthly active users (MAU), which is the count of unique users with authentication activity within a calendar month. External ID consists of a core offer and premium add-ons. The Microsoft Entra External ID core offering is free for the first 50,000 MAU. For the latest information about usage billing and pricing, see [Billing model for Microsoft Entra External ID](../external-identities-pricing.md).

> [!NOTE]
> Existing subscriptions to Azure Active Directory B2C (Azure AD B2C) B2C or B2B collaboration under an Azure AD External Identities P1/P2 SKU remain valid and no migration is necessary. We'll communicate upgrade options once they're available.

### Does the 50,000 MAU free tier apply to add-ons?

No, External ID add-ons don't have a free tier. However, the ID Governance premium feature for External ID is in preview, so currently there's no charge for this add-on.

### Does External ID have phone authentication via SMS?

Yes, this feature is now available in workforce and [external](concept-multifactor-authentication-customers.md) configurations.

### I linked my external tenant to a subscription, but the license status still shows "free"

After you link your external tenant to a subscription, you can view it on your external tenant home page (**Home** > **Billing**). However, the license on your external tenant overview page (**Home** > **Tenant overview** > **Overview**) will still show **Microsoft Entra ID Free**. This is a known issue that we’re working to resolve.

## About External ID

### What is Microsoft Entra External ID?

Microsoft Entra External ID is our next generation CIAM platform. It represents an evolutionary step in unifying secure and engaging experiences across all external identities including customers, partners, citizens, and others, within a single, integrated platform.

### Is Microsoft Entra External ID a new name for Azure AD B2C?

No, it's not a new name for Azure AD B2C. Microsoft Entra External ID is our next generation CIAM solution that combines CIAM use cases and B2B collaboration features into one unified platform.

### I notice some name changes, both in the admin center and on the website

Yes, we rebranded some items in the admin center and in our messaging to best match our vision for External ID. The following table summarizes the changes.

|Previous name                | New name                                |
|-----------------------------|-----------------------------------------|
|Azure AD External Identities | Azure AD B2C                            |
|Azure AD B2B                 | Now part of Microsoft Entra External ID |
|Azure AD for customers       | Microsoft Entra External ID             |
|Azure AD B2B collaboration   | External ID B2B collaboration           |
|Azure AD B2B direct connect  | External ID B2B direct connect          |
|Customer tenant              | External tenant                         |

### How can I get started with External ID?

Get started with securing your consumer and business customer apps by [creating an external tenant](quickstart-tenant-setup.md) in the Microsoft Entra admin center.

## Azure AD B2C and Azure AD External Identities  

### What's happening to Azure AD B2C and Azure AD External Identities?

Effective May 1, 2025 Azure AD External Identities P1 and P2 will no longer be available to purchase for new customers, but current Azure AD B2C customers can continue using the product. The product experience, including creating new tenants or user flows, will remain unchanged. The operational commitments, including service level agreements (SLAs), security updates, and compliance, will also remain unchanged. We'll continue supporting Azure AD External Identities until at least May  2030. More information, including migration plans will be made available. Contact your account representative for more information and to learn more about Microsoft Entra External ID.

### What's happening to Azure AD B2B collaboration and B2B direct connect?

Azure AD B2B collaboration and B2B direct connect are now part of Microsoft Entra External ID as External ID B2B collaboration and B2B direct connect. They remain in the same location in the Microsoft Entra admin center within the workforce tenant.  

### I have a substantial investment in custom policies, including code artifacts and CI/CD pipelines. How should I view the upcoming converged platform?

We recognize the large investments in building and managing custom policies. We listened to customers who told us custom policies are too hard to build and manage. With the new External ID platform, we're simplifying experiences so that custom policies are no longer needed. We'll provide a migration path for existing custom policies in B2C when it becomes available.

## Product Features

### What's the difference between external and workforce tenants?

Both are Microsoft Entra tenants, but with different default configurations. [Learn more about the tenant configurations](../tenant-configurations.md).  

### Are there custom policies in External ID?

Our next-generation CIAM platform is designed to accommodate equivalent capabilities without the need for complex custom policies.  

### What identity providers does External ID support?

 External ID supports various identity providers, including Microsoft Entra accounts (via invite), Facebook, Google, and SAML/WS-Fed identity provider federation. Identity providers are based on the tenant configuration and whether the external user is invited or uses self-service sign-up. [Learn more about identity providers](../identity-providers.md) in External ID, and refer to our [supported feature comparison](concept-supported-features-customers.md).

### Where can I find a list of External ID features?

For a detailed list of the External ID features and capabilities, see [Supported features in workforce and external tenants](concept-supported-features-customers.md).

<!--
### Will External ID be available in all regions worldwide?
-->
### Will External ID support Microsoft Entra US Government Cloud?

Currently, External ID supports public clouds only.

## Developer Experiences

### I'm a developer, where can I get started with External ID?

You can find the latest resources and information for developers in our [Developer Center](https://aka.ms/ciam/dev).

- [Create an external tenant](quickstart-tenant-setup.md) and follow a guide to set up your tenant and run your first sample.
- Use our tutorials to learn how to build and integrate your consumer and business customer apps with External ID.
- Sign up for [Identity blog](https://devblogs.microsoft.com/identity/tag/external-id/) email updates to keep up with the latest news and insights.
- Follow us on [YouTube](https://www.youtube.com/playlist?list=PL3ZTgFEc7Lythpts59O9KOVuEDLWJLLmA) for video overviews, tutorials, and deep dives.

In addition to those resources, we have some developer-focused features in public preview:

- Use Microsoft Entra External ID as an identity provider for [Azure App Service’s built-in authentication](https://devblogs.microsoft.com/identity/app-service-external-id/).

- Use the [Microsoft Entra External ID extension for Visual Studio Code](https://aka.ms/ciam/vscode/marketplace). This extension offers a seamless, guided experience that enables you to create and configure a sample External ID application entirely from within VS Code. Read our [blog](https://devblogs.microsoft.com/identity/external-id-extension/) and [documentation](visual-studio-code-extension.md) to learn more.

### How do I add authentication with External ID to my app code?

We have a single, unified [Microsoft Authentication Library (MSAL)](~/identity-platform/msal-overview.md) where the same application code works for workforce and customer scenarios. In three steps, you can sign up or sign in a user:

1. Configure MSAL to use to your tenant and application
1. Create a sign-in function that calls MSAL to start the web-based sign in flow
1. Create a response handler which can extract customer information from the returned token

You can see example code for each of these steps in our [sample applications](samples-ciam-all.md).

### Can I build a fully custom authentication sign-in experience?

[Native authentication](concept-native-authentication.md) empowers you to take complete control over the design of the sign-in experience of your mobile applications. It allows you to craft stunning, pixel-perfect authentication screens that are seamlessly integrated into your apps, rather than relying on browser-based solutions. Read more in our [blog](https://devblogs.microsoft.com/identity/native-auth-for-external-id/).

### What integrations does External ID support for developers?

External ID supports server-side integrations with external systems via [custom authentication extensions](~/identity-platform/custom-extension-overview.md). This capability allows developers to implement their own logic and invoke it via real-time API calls during sign-in/up flows.

## Next steps

[Learn more about Microsoft Entra External ID](../index.yml).
