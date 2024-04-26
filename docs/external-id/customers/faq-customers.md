---
title: Frequently asked questions
description: Find answers to some of the most frequently asked questions about Microsoft Entra External ID. 
 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: faq
ms.date: 05/15/2024
ms.author: mimart
ms.custom: it-pro
---

# Microsoft Entra External ID frequently asked questions

This article answers frequently asked questions about Microsoft Entra External ID. This document offers guidance to help customers better understand Microsoft’s current external identities capabilities and the journey for our next generation platform (Microsoft Entra External ID).

This FAQ references customer identity and access management (CIAM). CIAM is an industry recognized category that covers solutions that manage identity, authentication, and authorization for external identity use cases (partners, customers, and citizens). Common functionality includes self-service capabilities, adaptive access, single sign-on (SSO), and bring your own identity (BYOI).

## External ID pricing  

### How is External ID licensed?

Microsoft Entra External ID pricing is based on monthly active users (MAU), which is the count of unique users with authentication activity within a calendar month. External ID consists of a core offer and premium add-ons. We're currently offering an extended free trial for all features in the core offer. We won't start enforcing External ID core offer pricing until July 1, 2024.*  

After July 1, you can still get started for free and only pay for what you use as your business grows. The Microsoft Entra External ID core offer is free for the first 50,000 MAU, and additional active users are priced at $0.03 USD per MAU (with a launch discounted price of $0.01625 USD per MAU until May 2025).

|MAU  | Core offer pricing        |
|------------|---------|
|1-50K MAU   |Free        |
|50K+ MAU    |$0.03 USD per MAU (discounted to $0.01625 USD per MAU until May 2025) |
| | |

External ID premium features are available as add-ons. These premium features do not have a free tier.

|Premium feature  | Add-on pricing          |
|---------------------|------------------|
|ID Governance        |$0.75 USD per MAU |
| | |

 While the ID Governance feature for External ID is in preview, we won't charge for the add-on.

> [!NOTE]
> Existing subscriptions to Azure AD B2C or B2B collaboration under an Azure AD External Identities P1/P2 SKU remain valid and no migration is necessary. We'll communicate upgrade options once they're available. For multitenant organizations, identities whose UserType is external member aren't counted as part of the External ID MAU. Only internal and external guests count as External ID MAU.

### Does the 50,000 MAU free tier apply to add-ons?

No, External ID add-ons don't have a free tier. However, while the ID Governance premium feature for External ID is in preview, we won't charge for the add-on.

## Azure AD B2C and Azure AD External Identities  

### What's happening to Azure AD B2C and Azure AD External Identities?

Effective May 1, 2025 Azure AD External Identities P1 and P2 will no longer be available to purchase for new customers. Current Azure AD B2C customers can continue using the product. The product experience (including creating new tenants or user flows) and operational commitments (including SLA, security updates, and compliance) remain unchanged. We continue supporting Azure AD External Identities until at least May  2030. More information, including migration plans will be shared at a later date. Contact your account representative for more information and to learn more about Microsoft Entra External ID.

### What's happening to Azure AD B2B collaboration and B2B direct connect?

Azure AD B2B collaboration and B2B direct connect are now part of Microsoft Entra External ID as External ID B2B collaboration and B2B direct connect. They remain in the same location in the Microsoft Entra admin center within the workforce tenant.  

### I have a substantial investment in custom policies, including code artifacts and CI/CD pipelines. How should I view the upcoming converged platform?

We recognize the large investments in building and managing custom policies. We listened to customers who told us custom policies are too hard to build and manage. The new platform resolves the need for intricate custom policies. We're simplifying experiences in External ID so that we don’t need custom policies. We'll provide a migration path for existing custom policies in B2C when it becomes available.

## Product Features

### What's the difference between external and workforce tenants?

While both are Microsoft Entra tenants, they have different default configurations. [Learn more about the tenant configurations](concept-tenant-configurations.md).  

### Are there custom policies in External ID?

Our next-generation CIAM platform is designed to accommodate equivalent capabilities, without the need for complex custom policies.  

### What methods of MFA does External ID support?  

External ID currently supports email MFA and Phone SMS MFA for high trust scenarios in which an identity is invited. Support for low trust scenarios where users sign up will be released later this year. [Learn more](concept-authentication-methods-customers.md).

### What IDPs does External ID support?

We currently support Microsoft Entra accounts (via invite), Facebook, Google, and SAML/WS-Fed identity provider federation. [Learn more](identity-providers.md)

### Does External ID offer verifiable credentials as an authentication method?

Yes, our [Microsoft Entra Verified ID documentation](~/verified-id/index.yml) covers how to add verifiable credentials as an authentication method.  

### Is passwordless authentication supported?

Passwordless authentication is currently supported in workforce configurations and only email-based in external configurations. [Learn more](~/identity/authentication/concept-authentication-passwordless.md#supported-scenarios-1)

<!--
### Will External ID be available in all regions worldwide?
-->
### Will External ID support GovCloud?

External ID currently supports public clouds only, but we'll communicate any changes.

## Developer Experiences

### I'm a developer, where can I get started with External ID?

You can find all the latest resources and information for developers at our [Developer Center](https://aka.ms/ciam/dev). From that page, you can create a 30-day free trial and follow a guide to set up your tenant and run your first sample in three easy steps. Sign up for email updates on the Identity blog for more insights and to keep up with the latest on all things Identity. Also, follow us on [YouTube}(https://www.youtube.com/playlist?list=PL3ZTgFEc7Lythpts59O9KOVuEDLWJLLmA) for video overviews, tutorials, and deep dives.

In addition to those resources, we have some developer-focused features in public preview:

- Use Microsoft Entra External ID as an identity provider for [Azure App Service’s built-in authentication](https://devblogs.microsoft.com/identity/app-service-external-id/).

- Use the [Microsoft Entra External ID extension for Visual Studio Code](https://aka.ms/ciam/vscode/marketplace), which offers a seamless, guided experience that enables you to create and configure a sample External ID application entirely from within VS Code (blog).

### How do I add authentication with External ID to my app code?

We have a single, unified [Microsoft Authentication Library](https://learn.microsoft.com/azure/active-directory/develop/msal-overview) (MSAL) where the same application code works for workforce and customer scenarios. In three steps, you can sign up or sign in a user:

1. Configure MSAL to use to your tenant and application
1. Create a sign-in function that calls MSAL to start the web-based sign in flow
1. Create a response handler which can extract customer information from the returned token

You can see example code for each of these steps in our sample applications.

### Can I build a fully custom authentication sign-in experience?

[Native authentication](concept-native-authentication.md) empowers you to take complete control over the design of the sign-in experience of your mobile applications. It allows you to craft stunning, pixel-perfect authentication screens that are seamlessly integrated into your apps, rather than relying on browser-based solutions. Read more in our [blog](https://devblogs.microsoft.com/identity/native-auth-for-external-id/).

### What integrations does External ID support for developers?

External ID supports server-side integrations with external systems via custom authentication extensions. This capability allows developers to implement their own logic and invoke it via real-time API calls during sign-in/up flows.

## Next steps

[Learn more about Microsoft Entra External ID](index.yml).
