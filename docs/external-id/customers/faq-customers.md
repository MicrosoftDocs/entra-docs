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

## General

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

We're currently offering a free 30 day trial to start securing your external-facing applications at [https://aka.ms/ExternalIDConsumerApps](https://aka.ms/ExternalIDConsumerApps).

## Azure AD External Identities  

### What's happening to Azure AD External Identities?

Effective May 1, 2025 Azure AD External Identities P1 and P2 will no longer be available to purchase for new customers. Current Azure AD B2C customers can continue using the product. The product experience (including creating new tenants or user flows) and operational commitments (including SLA, security updates, and compliance) remain unchanged. We continue supporting Azure AD External Identities until at least May  2030. More information, including migration plans will be shared at a later date. Contact your account representative for more information and to learn more about Microsoft Entra External ID.

### What's happening to Azure AD B2B collaboration and B2B direct connect?

Azure AD B2B collaboration and B2B direct connect are now part of Microsoft Entra External ID as External ID B2B collaboration and B2B direct connect. They remain in the same location in the Microsoft Entra admin center within the workforce tenant.  

### I have a substantial investment in Custom policies, including code artifacts and CI/CD pipelines. Do I need to plan for migration?

We recognize the large investments in building and managing custom policies. We listened to customers who told us custom policies are too hard to build and manage. The new platform resolves the need for intricate custom policies. We're simplifying experiences in External ID so that we don’t need custom policies. We'll provide a migration path for existing custom policies in B2C when it becomes available.

## External ID Pricing  

### How is External ID licensed?

External ID consists of a core offer and premium add-ons. We're currently offering an extended free trial for all features in the core offer and won't start enforcing External ID Core offer pricing until July 1, 2024.*  

After July 1, you can still get started for free and only pay for what you use as your business grows. Microsoft Entra External ID’s Core offer is free for the first 50,000 Monthly Active Users (MAU) with additional active users at $0.03 USD per MAU (with a launch discounted price of $0.01625 USD per MAU until May 2025).

While ID Governance for External ID is in public preview, we won't charge for the add-on.

*Existing subscriptions to Azure AD B2C or B2B collaboration under an Azure AD External Identities P1/P2 SKU remain valid and no migration is necessary. We'll communicate upgrade options once they're available. For multitenant organizations, identities whose UserType is external member aren't counted as part of the External ID MAU. Only internal and external guests count as External ID MAU.

### Does the 50,000 MAU free tier apply to add-ons?

No, External ID add-ons don't have a free tier.  

## Product Features

### What's the difference between external and workforce tenants?

While both are Microsoft Entra ID tenants, they have different default configurations. [Learn more about the tenant configurations](concept-tenant-configurations.md).  

### Are there custom policies in External ID?

Our next-generation CIAM platform is designed to accommodate equivalent capabilities, without the need for complex custom policies.  

### What methods of MFA does External ID support?  

External ID currently supports email MFA and Phone SMS MFA for high trust scenarios in which an identity is invited. Support for low trust scenarios where users sign up will be released later this year. Learn more.

### What IDPs does External ID support?

We currently support Microsoft Entra accounts (via invite), Facebook, Google, and SAML/WS-Fed identity provider federation. [Learn more](identity-providers.md)

### Does External ID offer verifiable credentials as an auth method?

Yes, our documentation covers how to add verified credentials as an auth method.  

### Is passwordless authentication supported?

Passwordless authentication is currently supported in workforce configurations and only email based in external configurations. [Learn more](~/identity/authentication/concept-authentication-passwordless.md#supported-scenarios-1)

### Will External ID be available in all regions worldwide?

### Will External ID support GovCloud?

External ID currently only supports public clouds. We'll communicate any changes.

## Developer Experiences

### I'm a developer, where can I get started with External ID?

You can find all the latest resources and information for developers at our Developer Center. From that page, you can create a 30-day free trial and follow a guide to set up your tenant and run your first sample in three easy steps. Sign up for email updates on the Identity blog for more insights and to keep up with the latest on all things Identity. Also, follow us on YouTube for video overviews, tutorials, and deep dives.

In addition to those resources, we have some developer-focused features in public preview:

- Use Microsoft Entra External ID as an identity provider for Azure App Service’s built-in authentication (blog)

- The [Microsoft Entra External ID extension for Visual Studio Code](https://aka.ms/ciam/vscode/marketplace) offers a seamless, guided experience that enables you to create and configure a sample External ID application entirely from within VS Code (blog).

### How do I add authentication with External ID to my app code?

We have a single, unified [Microsoft Authentication Library](https://learn.microsoft.com/azure/active-directory/develop/msal-overview) (MSAL) where the same application code works for workforce and customer scenarios. In three steps, you can sign up or sign in a user:

1. Configure MSAL to use to your tenant and application
1. Create a sign-in function that calls MSAL to start the web-based sign in flow
1. Create a response handler which can extract customer information from the returned token

You can see example code for each of these steps in our sample applications.

### Can I build a fully custom authentication sign-in experience?

Native authentication empowers you to take complete control over the design of the sign-in experience of your mobile applications. It allows you to craft stunning, pixel-perfect authentication screens that are seamlessly integrated into your apps, rather than relying on browser-based solutions. Read more in our blog.

### What integrations does External ID support for developers?

External ID supports server-side integrations with external systems via custom authentication extensions. This capability allows developers to implement their own logic and invoke it via real-time API calls during sign-in/up flows.

## OLD FAQ questions

### What is the release date for Microsoft Entra External ID?  

Microsoft Entra External ID for external-facing apps entered preview at Microsoft Build 2023. The existing B2B collaboration feature remains unchanged.

### What is the pricing for Microsoft Entra External ID?

Microsoft Entra External ID for external-facing apps is in preview, so no pricing details are available at this time. The pricing for existing B2B collaboration features is unchanged.

### How does Microsoft Entra External ID affect B2B collaboration?

There are no changes to the existing B2B collaboration features or related pricing. Upon general availability, Microsoft Entra External ID will address use cases across all external user identities, including partners, customers, citizens, and others.

### How long will you support the current Azure AD B2C platform?

We remain fully committed to support of the current Azure AD B2C product. The SLA remains unchanged, and we continue investments in the product to ensure security, availability, and reliability. For existing Azure AD B2C customers that have an interest in moving to the next generation platform, more details will be made available after general availability.

### I have many investments tied up in Azure AD B2C, both in code artifacts and CI/CD pipelines. Do I need to plan for a migration or some other effort?

We recognize the large investments in building and managing custom policies. We listened to many customers who, like you, shared that custom policies are too hard to build and manage. Our next generation platform will resolve the need for intricate custom policies. In addition to many other platform and feature improvements, you’ll have equivalent functionality in the new platform, but a much easier way to build and manage it. We expect to share migration options closer to general availability of the next generation platform.  

### I heard I can preview the Microsoft Entra External ID platform. Where can I learn more?

You can learn more about the preview and the features we're delivering on the new platform by visiting the Microsoft Entra External ID [developer center](https://aka.ms/ciam/dev).

### As a new customer, which solution is a better fit, Azure AD B2C or Microsoft Entra External ID (preview)?

Opt for the current Azure AD B2C product if:

- You have an immediate need to deploy a production ready build for customer-facing apps.
  
   > [!NOTE]
   > Keep in mind that the next generation Microsoft Entra External ID platform represents the future of CIAM for Microsoft, and rapid innovation, new features and capabilities will be focused on this platform. By choosing the next generation platform from the start, you will receive the benefits of rapid innovation and a future-proof architecture.

Opt for the next generation Microsoft Entra External ID platform if:

- You’re starting fresh building identities into apps or you're in the early stages of product discovery.
- The benefits of rapid innovation, new features, and new capabilities are a priority.

<a name='why-is-azure-ad-b2c-not-part-of-entra-idexternal-id'></a>

### Why is Azure AD B2C not part of Microsoft Entra External ID?

Microsoft Entra External ID and Azure AD B2C are two separate platforms powered by ESTS and IEF respectively. Microsoft Entra External ID is our new converged platform that's future proof and developer friendly to meet all your B2E, B2B, and B2C identity needs. We continue to support Azure AD B2C as a separate product offering with no change in SLA, and we continue investments in the product to ensure security, availability, and reliability.

## Next steps

[Learn more about Microsoft Entra External ID](index.yml).
