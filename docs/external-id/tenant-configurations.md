---
title: Tenant Configurations
description: Learn about tenant configurations in Microsoft Entra External ID, including the differences between workforce and external tenants.
ms.author: cmulligan
author: csmulligan
manager: dougeby
ms.service: entra-external-id
ms.subservice: external
ms.topic: concept-article
ms.date: 05/20/2025
ms.custom: it-pro

#customer intent: As a dev, DevOps, or IT admin, I want to learn about features supported in a CIAM tenant so that I can configure tenants according to my organization's needs. 
---
# Workforce and external tenant configurations in Microsoft Entra External ID

A *tenant* is a dedicated and trusted instance of Microsoft Entra ID. It contains an organization's resources, including registered apps and a directory of users. There are two ways to configure a tenant, depending on how your organization intends to use the tenant and the resources that you want to manage:

- A *workforce* tenant configuration is for your employees, internal business apps, and other organizational resources. You can invite external business partners and guests to your workforce tenant.
- An *external* tenant configuration is used exclusively for Microsoft Entra External ID scenarios where you want to publish apps to consumers or business customers. [Learn more about External ID in external tenants](~/external-id/customers/overview-customers-ciam.md).

Each tenant configuration represents a different scenario for working with users outside your organization.

:::image type="content" source="media/tenant-configurations/tenant-configurations.png" alt-text="Diagram that shows External ID tenant configurations." lightbox="media/tenant-configurations/tenant-configurations.png":::

## Workforce tenant

A workforce tenant represents a single organization. You use it to manage your employees, business apps, and other internal resources. If you've worked with Microsoft Entra ID, you're already familiar with a workforce tenant. It's the standard tenant that's automatically created when your organization signs up for a Microsoft cloud service subscription, such as Microsoft Azure, Microsoft Intune, or Microsoft 365.

In a workforce tenant, the External ID feature [B2B collaboration](what-is-b2b.md) lets your employees collaborate with external business partners and guests.

You can create additional workforce tenants in either the Microsoft Entra admin center or the Azure portal.

## External tenant

When you want to use External ID to add customer identity and access management (CIAM) to your apps, you create a new tenant in an external configuration. This tenant is distinct and separate from your workforce tenant. It follows the standard Microsoft Entra tenant model, but it's configured for your consumer and business customer scenarios.

The external tenant is where you register your apps, create sign-up and sign-in user flows, and manage the users of your apps. The consumers and business customers who sign up for your apps are added to the tenant directory, but with [limited default permissions](customers/reference-user-permissions.md).

### Creation of an external tenant

If you plan to use External ID for apps for consumers or business customers, the first resource that you need to create is a new tenant with an external tenant configuration.

You can create an external tenant in a couple of ways:

- If you already have an Azure subscription, you can [create a tenant](customers/how-to-create-customer-tenant-portal.md) in the Microsoft Entra admin center. When you create a new tenant, choose the external configuration.

  You can't create external tenants via the Azure portal. The portal supports creation of workforce tenants only.

- If you don't already have a Microsoft Entra tenant and you want to try out External ID features in an external tenant, we recommend using the get-started experience to start a free trial.

When you create a tenant, you can set your correct geographic location and domain name. If you currently use Azure Active Directory B2C (Azure AD B2C), the new workforce and customer tenant model doesn't affect your existing Azure AD B2C tenants.

[!INCLUDE [active-directory-b2c-end-of-sale-notice.md](./includes/active-directory-b2c-end-of-sale-notice.md)]

## Comparison of workforce and external tenants

Although workforce tenants and external tenants are built on the same underlying Microsoft Entra platform, there are some feature differences. For a detailed comparison of tenant features and capabilities, see [Supported features in workforce and external tenants](customers/concept-supported-features-customers.md).
