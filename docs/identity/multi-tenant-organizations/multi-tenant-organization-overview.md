---
title: What is a multitenant organization in Microsoft Entra ID?
description: Learn about multitenant organizations in Microsoft Entra ID and Microsoft 365.
author: rolyon
manager: amycolannino
ms.service: entra-id
ms.subservice: multitenant-organizations
ms.topic: overview
ms.date: 04/30/2024
ms.author: rolyon
ms.custom: it-pro
#Customer intent: As a dev, devops, or it admin, I want to
---

# What is a multitenant organization in Microsoft Entra ID?

Multitenant organization is a feature in Microsoft Entra ID and Microsoft 365 that enables you to define a boundary around the Microsoft Entra tenants that your organization owns. In the directory, it takes the form of a tenant group representing your organization. Each pair of tenants in the group is governed by cross-tenant access settings that you can use to configure B2B collaboration.

## Why use multitenant organization?

Here are the primary goals of multitenant organization:

- Define a boundary around the tenants belonging to your organization
- Collaborate across your tenants in new Microsoft Teams
- Collaborate across your tenants in Microsoft Viva Engage

## Who should use it?

Organizations that own multiple Microsoft Entra tenants and want to streamline intra-organization cross-tenant collaboration in Microsoft 365.

The multitenant organization capability in Microsoft Teams is built on the assumption of reciprocal provisioning of [B2B collaboration member users](../../external-id/user-properties.md) across multitenant organization tenants.

The multitenant organization capability in Viva Engage is built on the assumption of centralized provisioning of B2B collaboration member users into a hub tenant.

As such, the multitenant organization capability is best deployed with the use of a bulk provisioning engine for B2B collaboration users, for example with [cross-tenant synchronization](./cross-tenant-synchronization-overview.md).

## Benefits

Here are the primary benefits of a multitenant organization:

- Differentiate in-organization and out-of-organization external users

    In Microsoft Entra ID, external users originating from within a multitenant organization can be differentiated from external users originating from outside the multitenant organization. This differentiation facilitates the application of different policies for in-organization and out-of-organization external users.

- Improved collaborative experience in Microsoft Teams

    In new Microsoft Teams, multitenant organization users can expect an improved collaborative experience across tenants with chat, calling, and meeting start notifications from all connected tenants across the multitenant organization. Tenant switching is more seamless and faster. For more information, see:

    - [Announcing more seamless collaboration in Microsoft Teams for multitenant organizations](https://techcommunity.microsoft.com/t5/microsoft-teams-blog/announcing-more-seamless-collaboration-in-microsoft-teams-for/ba-p/3901092)
    - [Microsoft Teams: Advantages of the new architecture](https://techcommunity.microsoft.com/t5/microsoft-teams-blog/microsoft-teams-advantages-of-the-new-architecture/ba-p/3775704)
    - [Multitenant organization capabilities now available](https://techcommunity.microsoft.com/t5/microsoft-365-blog/multi-tenant-organization-capabilities-now-available-in/ba-p/4122812)

- Improved collaborative experience in Viva Engage

    Viva Engage for multitenant organizations allows complex and distributed organizations to communicate as a unified network. From multitenant organization communities, campaigns, and events to analytics, Viva Engage unlocks new ways for employees and leaders to connect, share, and measure participation across their multitenant organization. For more information, see:

    - [What's new for Viva Engage](https://techcommunity.microsoft.com/t5/viva-engage-blog/what-s-new-for-viva-engage-ignite-edition/ba-p/3981897)
    - [Set up Viva Engage for a multitenant organization](/Viva/engage/mto-setup)
    - [Multitenant organization capabilities now available](https://techcommunity.microsoft.com/t5/microsoft-365-blog/multi-tenant-organization-capabilities-now-available-in/ba-p/4122812)

## How does a multitenant organization work?

The multitenant organization capability enables you to define a boundary around the Microsoft Entra tenants that your organization owns, facilitated by an invite-and-accept flow between tenant administrators. The following list describes the basic lifecycle of a multitenant organization.

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

    For more information, see [Configure cross-tenant access settings for B2B collaboration](~/external-id/cross-tenant-access-settings-b2b-collaboration.yml) and [crossTenantAccessPolicyConfigurationPartner resource type](/graph/api/resources/crosstenantaccesspolicyconfigurationpartner?view=graph-rest-beta&preserve-view=true).

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

## Limits

| Resource | Limit | Notes |
| --- | :---: | --- |
| Maximum number of active tenants, including the owner tenant | 100 | The owner tenant can add more than 100 pending tenants, but they won't be able to join the multitenant organization if the limit is exceeded. This limit is applied at the time a pending tenant joins a multitenant organization. This limit is specific to the number of tenants in a multitenant organization. It doesn't apply to cross-tenant synchronization by itself. To increase this limit, submit a support request in the Microsoft Entra or Microsoft 365 admin center. |

## External user segmentation

By defining a multitenant organization, as well as pivoting on the Microsoft Entra user property of userType, [external users](~/external-id/user-properties.md) (B2B collaboration users) are segmented as follows:

- External members originating from within a multitenant organization
- External guests originating from within a multitenant organization
- External members originating from outside of your organization
- External guests originating from outside of your organization

This segmentation of external users, due to the definition of a multitenant organization, enables administrators to better differentiate in-organization from out-of-organization external users.

External members originating from within a multitenant organization are called multitenant organization members.

Multitenant collaboration capabilities in Microsoft 365 aim to provide a seamless collaboration experience across tenant boundaries when collaborating with multitenant organization member users.

## Choosing between Microsoft 365 admin center and cross-tenant synchronization

- If you haven't previously used Microsoft Entra cross-tenant synchronization, and you intend to establish a [collaborating user set](multi-tenant-organization-microsoft-365.md#collaborating-user-set) topology where the same set of users is shared to all multitenant organization tenants, you might want to use the Microsoft 365 admin center share users functionality.
- If you're already using Microsoft Entra cross-tenant synchronization, for various [multi-hub multi-spoke topologies](cross-tenant-synchronization-topology.md), you don't need to use the Microsoft 365 admin center share users functionality. Instead, you might want to continue using your existing Microsoft Entra cross-tenant synchronization jobs.
- If you already have your own at-scale user provisioning engine, you can utilize the new multitenant organization benefits while continuing to use your own engine to manage the lifecycle of your employees.

## Get started

Here are the basic steps to get started using multitenant organization.

### Step 1: Plan your deployment

For more information, see [Plan for multitenant organizations in Microsoft 365](/microsoft-365/enterprise/plan-multi-tenant-org-overview).

### Step 2: Create your multitenant organization

Create your multitenant organization using [Microsoft 365 admin center](/microsoft-365/enterprise/set-up-multi-tenant-org), [Microsoft Graph PowerShell](multi-tenant-organization-configure-graph.md?tabs=ms-powershell), or [Microsoft Graph API](multi-tenant-organization-configure-graph.md?tabs=ms-graph):

- First tenant, soon-to-be owner tenant, creates a multitenant organization.
- Owner tenant adds one or more joiner tenants.

### Step 3: Join a multitenant organization

Join a multitenant organization using [Microsoft 365 admin center](/microsoft-365/enterprise/join-leave-multi-tenant-org) or [Microsoft Graph PowerShell](multi-tenant-organization-configure-graph.md?tabs=ms-powershell), or [Microsoft Graph API](multi-tenant-organization-configure-graph.md?tabs=ms-graph):

- Joiner tenants submit a join request to join the multitenant organization of owner tenant.
- To allow for asynchronous processing, wait **up to 2 hours**.

Your multitenant organization is formed.

### Step 4: Synchronize users

Depending on your use case, you may want to synchronize users using one of the following methods:

- [Synchronize users in multitenant organizations in Microsoft 365](/microsoft-365/enterprise/sync-users-multi-tenant-orgs)
- [Configure cross-tenant synchronization in the Microsoft Entra admin center](cross-tenant-synchronization-configure.md)
- [Configure cross-tenant synchronization using PowerShell or Microsoft Graph API](cross-tenant-synchronization-configure-graph.md)
- Your alternative bulk provisioning engine

## License requirements

The multitenant organization capability requires Microsoft Entra ID P1 licenses. Only one Microsoft Entra ID P1 license is required per employee per multitenant organization. Also, you must have at least one Microsoft Entra ID P1 license per tenant. To find the right license for your requirements, see [Compare generally available features of Microsoft Entra ID](https://www.microsoft.com/security/business/microsoft-entra-pricing).

## Next steps

- [Plan for multitenant organizations in Microsoft 365](/microsoft-365/enterprise/plan-multi-tenant-org-overview)
- [What is cross-tenant synchronization?](cross-tenant-synchronization-overview.md)
