---
title: What is a multitenant organization in Microsoft Entra ID? (Preview)
description: Learn about multitenant organizations in Microsoft Entra ID and Microsoft 365.
services: active-directory
author: rolyon
manager: amycolannino
ms.service: active-directory
ms.workload: identity
ms.subservice: multi-tenant-organizations
ms.topic: overview
ms.date: 11/01/2023
ms.author: rolyon
ms.custom: it-pro

#Customer intent: As a dev, devops, or it admin, I want to
---

# What is a multitenant organization in Microsoft Entra ID? (Preview)

> [!IMPORTANT]
> Multitenant organization is currently in PREVIEW.
> See the [Product Terms](https://aka.ms/EntraPreviewsTermsOfUse) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

Multitenant organization is a feature in Microsoft Entra ID and Microsoft 365 that enables you to form a tenant group within your organization. Each pair of tenants in the group is governed by cross-tenant access settings that you can use to configure B2B or cross-tenant synchronization.

## Why use multitenant organization?

Here are the primary goals of multitenant organization:

- Define a group of tenants belonging to your organization
- Collaborate across your tenants in new Microsoft Teams
- Enable search and discovery of user profiles across your tenants through Microsoft 365 people search

## Who should use it?

Organizations that own multiple Microsoft Entra tenants and want to streamline intra-organization cross-tenant collaboration in Microsoft 365.

The multitenant organization capability is built on the assumption of reciprocal provisioning of B2B member users across multitenant organization tenants.

As such, the multitenant organization capability assumes the simultaneous use of Microsoft Entra cross-tenant synchronization or an alternative bulk provisioning engine for [external identities](~/external-id/user-properties.md).

## Benefits

Here are the primary benefits of a multitenant organization:

- Differentiate in-organization and out-of-organization external users

    In Microsoft Entra ID, external users originating from within a multitenant organization can be differentiated from external users originating from outside the multitenant organization. This differentiation facilitates the application of different policies for in-organization and out-of-organization external users.
- Improved collaborative experience in Microsoft Teams

    In new Microsoft Teams, multitenant organization users can expect an improved collaborative experience across tenants with chat, calling, and meeting start notifications from all connected tenants across the multitenant organization. Tenant switching is more seamless and faster. For more information, see [Announcing more seamless collaboration in Microsoft Teams for multitenant organizations](https://techcommunity.microsoft.com/t5/microsoft-teams-blog/announcing-more-seamless-collaboration-in-microsoft-teams-for/ba-p/3901092) and [Microsoft Teams: Advantages of the new architecture](https://techcommunity.microsoft.com/t5/microsoft-teams-blog/microsoft-teams-advantages-of-the-new-architecture/ba-p/3775704).

- Improved people search experience across tenants

    Across Microsoft 365 services, the multitenant organization people search experience is a collaboration feature that enables search and discovery of people across multiple tenants. Once enabled, users are able to search and discover synced user profiles in a tenant's global address list and view their corresponding people cards. For more information, see [Microsoft 365 multitenant organization people search (public preview)](/microsoft-365/enterprise/multi-tenant-people-search).

## How does a multitenant organization work?

The multitenant organization capability enables you to form a tenant group within your organization. The following list describes the basic lifecycle of a multitenant organization.

- Define a multitenant organization

    One tenant administrator defines a multitenant organization as a grouping of tenants. The grouping of tenants isn't reciprocal until each listed tenant takes action to join the multitenant organization. The objective is a reciprocal agreement between all listed tenants.

- Join a multitenant organization

    Tenant administrators of listed tenants take action to join the multitenant organization. After joining, the multitenant organization relationship is reciprocal between each and every tenant that joined the multitenant organization.

- Leave a multitenant organization

    Tenant administrators of listed tenants can leave a multitenant organization at any time. While a tenant administrator who defined the multitenant organization can add and remove listed tenants they don't control the other tenants.

A multitenant organization is established as a collaboration of equals. Each tenant administrator stays in control of their tenant and their membership in the multitenant organization.

## Cross-tenant access settings

Administrators staying in control of their resources is a guiding principle for multitenant organization collaboration. Cross-tenant access settings are required for each tenant-to-tenant relationship. Tenant administrators explicitly configure, as needed, the following policies:

- Cross-tenant access partner configurations

    For more information, see [Configure cross-tenant access settings for B2B collaboration](~/external-id/cross-tenant-access-settings-b2b-collaboration.md) and [crossTenantAccessPolicyConfigurationPartner resource type](/graph/api/resources/crosstenantaccesspolicyconfigurationpartner?view=graph-rest-beta&preserve-view=true).

- Cross-tenant access identity synchronization

    For more information, see [Configure cross-tenant synchronization](cross-tenant-synchronization-configure.md) and [crossTenantIdentitySyncPolicyPartner resource type](/graph/api/resources/crosstenantidentitysyncpolicypartner).

## Multitenant organization example

The following diagram shows three tenants A, B, and C that form a multitenant organization.

:::image type="content" source="./media/common/multi-tenant-organization-topology.png" alt-text="Diagram that shows a multitenant organization topology and cross-tenant access settings." lightbox="./media/common/multi-tenant-organization-topology.png":::

| Tenant | Description |
| :---: | --- |
| A | Administrators see a multitenant organization consisting of A, B, C.<br/>They also see cross-tenant access settings for B and C. |
| B | Administrators see a multitenant organization consisting of A, B, C.<br/>They also see cross-tenant access settings for A and C. |
| C | Administrators see a multitenant organization consisting of A, B, C.<br/>They also see cross-tenant access settings for A and B. |

## Templates for cross-tenant access settings

To ease the setup of homogenous cross-tenant access settings applied to partner tenants in the multitenant organization, the administrator of each multitenant organization tenant can configure optional cross-tenant access settings templates dedicated to the multitenant organization. These templates can be used to preconfigure cross-tenant access settings that are applied to any partner tenant newly joining the multitenant organization.

## Tenant role and state

To facilitate the management of a multitenant organization, any given multitenant organization tenant has an associated role and state.

| Tenant role | Description |
| --- | --- |
| Owner | One tenant creates the multitenant organization. The multitenant organization creating tenant receives the role of owner. The privilege of the owner tenant is to add tenants into a pending state as well as to remove tenants from the multitenant organization. Also, an owner tenant can change the role of other multitenant organization tenants. |
| Member | Following the addition of pending tenants to the multitenant organization, pending tenants need to join the multitenant organization to turn their state from pending to active. Joined tenants typically start in the member role. Any member tenant has the privilege to leave the multitenant organization. |

| Tenant state | Description |
| --- | --- |
| Pending | A pending tenant has yet to join a multitenant organization. While listed in an administrator’s view of the multitenant organization, a pending tenant isn't yet part of the multitenant organization, and as such is hidden from an end user’s view of a multitenant organization. |
| Active | Following the addition of pending tenants to the multitenant organization, pending tenants need to join the multitenant organization to turn their state from pending to active. Joined tenants typically start in the member role. Any member tenant has the privilege to leave the multitenant organization. |

## Constraints

The multitenant organization capability has been designed with the following constraints:

- Any given tenant can only create or join a single multitenant organization.
- Any multitenant organization must have at least one active owner tenant.
- Each active tenant must have cross-tenant access settings for all active tenants.
- Any active tenant may leave a multitenant organization by removing themselves from it.
- A multitenant organization is deleted when the only remaining active (owner) tenant leaves.

## External user segmentation

By defining a multitenant organization, as well as pivoting on the Microsoft Entra user property of userType, [external identities](~/external-id/user-properties.md) are segmented as follows:

- External members originating from within a multitenant organization
- External guests originating from within a multitenant organization
- External members originating from outside of your organization
- External guests originating from outside of your organization

This segmentation of external users, due to the definition of a multitenant organization, enables administrators to better differentiate in-organization from out-of-organization external users.

External members originating from within a multitenant organization are called multitenant organization members.

Multitenant collaboration capabilities in Microsoft 365 aim to provide a seamless collaboration experience across tenant boundaries when collaborating with multitenant organization member users.

## Get started

Here are the basic steps to get started using multitenant organization.

### Step 1: Plan your deployment

For more information, see [Plan for multitenant organizations in Microsoft 365 (Preview)](/microsoft-365/enterprise/plan-multi-tenant-org-overview).

### Step 2: Create your multitenant organization

Create your multitenant organization using [Microsoft 365 admin center](/microsoft-365/enterprise/set-up-multi-tenant-org) or [Microsoft Graph API](multi-tenant-organization-configure-graph.md):

- First tenant, soon-to-be owner tenant, creates a multitenant organization.
- Owner tenant adds one or more joiner tenants.
- To allow for asynchronous processing, wait a **minimum of 2 hours**.

### Step 3: Join a multitenant organization

Join a multitenant organization using [Microsoft 365 admin center](/microsoft-365/enterprise/join-leave-multi-tenant-org) or [Microsoft Graph API](multi-tenant-organization-configure-graph.md):

- Joiner tenants submit a join request to join the multitenant organization of owner tenant.
- To allow for asynchronous processing, wait **up to 4 hours**.

Your multitenant organization is formed.

### Step 4: Synchronize users

Depending on your use case, you may want to synchronize users using one of the following methods:

- [Synchronize users in multitenant organizations in Microsoft 365 (Preview)](/microsoft-365/enterprise/sync-users-multi-tenant-orgs)
- [Configure cross-tenant synchronization](cross-tenant-synchronization-configure.md)
- [Configure cross-tenant synchronization using PowerShell or Microsoft Graph API](cross-tenant-synchronization-configure-graph.md)
- Your alternative bulk provisioning engine

## Limits

Multitenant organizations have the following limits:

- A maximum of five active tenants per multitenant organization
  - This limit is specific to the number of tenants in a multitenant organization. It does not apply to cross-tenant synchronization by itself. 
- A maximum of 100,000 internal users per active tenant at the time of joining

If you want to add more than five tenants or 100,000 internal users per tenant, contact Microsoft support.

## License requirements

The multitenant organization capability is in preview, and you can start using it if you have Microsoft Entra ID P1 licenses or above in all multitenant organization tenants. Licensing terms will be released at general availability. To find the right license for your requirements, see [Compare generally available features of Microsoft Entra ID](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing).

## Next steps

- [Plan for multitenant organizations in Microsoft 365 (Preview)](/microsoft-365/enterprise/plan-multi-tenant-org-overview)
- [What is cross-tenant synchronization?](cross-tenant-synchronization-overview.md)
