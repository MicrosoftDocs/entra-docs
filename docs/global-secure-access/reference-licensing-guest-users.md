---
title: Global Secure Access licensing for guest users
description: Learn how Global Secure Access licensing works for guest users, including MAU billing, billable features, and multitenant organization scenarios.
ms.topic: reference
ms.date: 04/09/2026
ms.reviewer: cagautham
ai-usage: ai-assisted
---
# Global Secure Access licensing for guest users

This article outlines the pricing structure for Global Secure Access — Microsoft Entra Internet Access and Microsoft Entra Private Access — licensing for guest users. It also describes how to link your tenant to an Azure subscription to ensure correct billing and feature access.

## Monthly active users (MAU) billing model

Global Secure Access uses Monthly Active User (MAU) licensing for guest users. This model is different from licensing for employees. For complete details on licensing for employees, see [Global Secure Access licensing overview](overview-what-is-global-secure-access.md#licensing-overview).

Under the guest billing model, guests are identified by a `userType` of `Guest` regardless of where the user authenticates. A `userType` of `Guest` is the default `userType` for all B2B invitation methods and can also be set by an identity administrator. Monthly active usage for Global Secure Access is measured when a guest user initiates at least one sign-in during a given month to Microsoft Entra Internet Access or Microsoft Entra Private Access tunnels using either the Global Secure Access client or supported clientless solutions. For pricing details, see the [Microsoft Entra pricing page](https://www.microsoft.com/security/business/microsoft-entra-pricing).

## Billable access features

Guest users are only billed when they actively sign in to the Global Secure Access client for Private Access or Internet Access. Microsoft Entra Internet Access for Microsoft services capabilities, which are included with a Microsoft Entra ID P1 or P2 license, aren't billed to the guest add-on.

You can identify sign-ins that are billed to Microsoft Entra Private Access or Internet Access for guests by looking at your sign-in logs. Under **Entra ID** > **Monitoring & health** > **Sign-in logs**, each billable sign-in has these properties:

- **User type**: Guest
- **Cross tenant access type**: B2B collaboration
- **Application**: Global Secure Access Client
- **Client app**: Mobile Apps and Desktop clients

> [!NOTE]
> These sign-in log filters are provided as guidance for identifying billable guest usage. Contact your Microsoft account team if you need detailed billing validation.

## Guest billing in multitenant organizations

Guest billing only applies for users with a `userType` of `Guest`. If licensed member users are brought into other organization tenants with a `userType` of `Member`, they don't accrue to the billing meter. If these users are brought in with a `userType` of `Guest`, they accrue to the meter. However, you can avoid being charged by setting up or joining a multitenant organization. If the guest user is from a participating organizational tenant, the guest doesn't accrue to the billing meter. For more information, see [Set up a multitenant org in Microsoft 365](/microsoft-365/enterprise/set-up-multi-tenant-org).

## Link your tenant to a subscription

Your tenants must be linked to an Azure subscription for proper billing and access to features. For steps to link your tenant to a subscription and troubleshoot subscription issues, see [Link a workforce tenant to a subscription](~/external-id/external-identities-pricing.md#link-your-azure-ad-tenant-to-a-subscription).

## Global Secure Access guest user licensing FAQs

**I've been using Microsoft Entra Internet Access for Microsoft services for my guest users. Will I start getting billed for this usage?**

Microsoft Entra Internet Access for Microsoft services (Microsoft traffic profile) capabilities are included with a Microsoft Entra ID P1 or P2 license, so they aren't billed to the guest add-on.

**Does guest billing apply to all guest users, including those within the first 50,000 Monthly Active Users (MAU)?**

Yes, there's no free tier for guest billing. Guest billing applies to all guest users, including those within the first 50,000 MAU.

**Does guest billing apply to all internal guest users as well?**

Yes, guest billing applies to all users with a `userType` of `Guest`. It applies to internal and external guest users.

## Related content

- [External user access for Global Secure Access](concept-external-user-access.md)
- [Global Secure Access licensing overview](overview-what-is-global-secure-access.md#licensing-overview)
- [Link a workforce tenant to a subscription](~/external-id/external-identities-pricing.md#link-your-azure-ad-tenant-to-a-subscription)
