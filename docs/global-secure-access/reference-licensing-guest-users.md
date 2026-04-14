---
title: Global Secure Access licensing for guest users
description: Learn how Global Secure Access licensing works for guest users, including MAU billing, billable features, and multitenant organization scenarios.
ms.topic: reference
ms.date: 04/09/2026
ms.reviewer: cagautham
ai-usage: ai-assisted
---
# Global Secure Access licensing for guest users

This article outlines the pricing structure for Microsoft Entra Private Access licensing for guest users. It also describes how to link your tenant to an Azure subscription to ensure correct billing and feature access.

## Monthly active users (MAU) billing model

Global Secure Access uses Monthly Active User (MAU) licensing for guest users. This model is different from licensing for employees. For complete details on licensing for employees, see [Global Secure Access licensing overview](overview-what-is-global-secure-access.md#licensing-overview).

Under the guest billing model, guests are identified by a `userType` of `Guest` regardless of where the user authenticates. A `userType` of `Guest` is the default `userType` for all B2B invitation methods and can also be set by an identity administrator. Monthly active usage for Global Secure Access is measured when a guest user initiates at least one sign-in during a given month to Microsoft Entra Private Access tunnels using the Global Secure Access client solution. Contact your Microsoft account team for pricing details.

## Billable access features

Guest users are only billed when they actively sign in to the Global Secure Access client for Private Access.

You can identify sign-ins that are billed to Microsoft Entra Private Access for guests by looking at your sign-in logs. Under **Entra ID** > **Monitoring & health** > **Sign-in logs**, each billable sign-in has these properties:

- **User type**: Guest
- **Cross tenant access type**: B2B collaboration
- **Application**: Global Secure Access Client
- **Client app**: Mobile Apps and Desktop clients

> [!NOTE]
> These sign-in log filters are provided as guidance for identifying billable guest usage. Contact your Microsoft account team if you need detailed billing validation.

## Link your tenant to a subscription

Your tenants must be linked to an Azure subscription for proper billing and access to features. Contact your Microsoft account team for details.

## Global Secure Access guest user licensing FAQs

**Does guest billing apply to all guest users, including those within the first 50,000 Monthly Active Users (MAU)?**

The 50,000 free Monthly Active Users (MAU) allowance applies exclusively to external users utilizing Microsoft Entra ID P1 and P2. However, this MAU allowance doesn't extend to products like Microsoft Entra ID Governance for guests or Global Secure Access for guests.

**Does guest billing apply to all internal guest users as well?**

Yes, guest billing applies to all users with a `userType` of `Guest`. It applies to internal and external guest users.

## Related content

- [External user access for Global Secure Access](concept-external-user-access.md)
- [Global Secure Access licensing overview](overview-what-is-global-secure-access.md#licensing-overview)
- [Link a workforce tenant to a subscription](~/external-id/external-identities-pricing.md#link-your-azure-ad-tenant-to-a-subscription)
