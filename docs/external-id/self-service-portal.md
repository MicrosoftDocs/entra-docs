---
title: Self-service sign-up portal for B2B collaboration
description: Learn how to customize the onboarding workflow for Microsoft Entra B2B users to fit your organization’s needs.
 
ms.service: entra-external-id
ms.topic: concept-article
ms.date: 01/23/2024

ms.author: mimart
author: msmimart
manager: celestedg

ms.collection: M365-identity-device-management
#customer intent: As an organization managing B2B collaborations, I want to customize the onboarding workflow for external users, so that they can sign themselves up with policies that I control. I also want the ability to build my own onboarding experiences using the Microsoft Graph invitation manager API.
---

# Self-service for Microsoft Entra B2B collaboration sign-up

Customers can do a lot with the built-in features that are exposed through the [Azure portal](https://portal.azure.com) and the [Application Access Panel](https://myapps.microsoft.com) for end users. However, you might need to customize the onboarding workflow for B2B users to fit your organization’s needs.

<a name='azure-ad-entitlement-management-for-b2b-guest-user-sign-up'></a>

## Microsoft Entra entitlement management for B2B guest user sign-up

As an inviting organization, you might not know ahead of time who the individual external collaborators are who need access to your resources. You need a way for users from partner companies to sign themselves up with policies that you control. You can use [Microsoft Entra entitlement management](~/id-governance/entitlement-management-overview.md) to configure policies, which [manage access for external users](~/id-governance/entitlement-management-external-users.md#how-access-works-for-external-users). Then users from other organizations can request access, and upon approval be provisioned with guest accounts and assigned to groups, apps and SharePoint Online sites.

<a name='azure-active-directory-b2b-invitation-api'></a>

## Microsoft Entra B2B invitation API

Organizations can use the [Microsoft Graph invitation manager API](/graph/api/resources/invitation) to build their own onboarding experiences for B2B guest users. When you want to offer self-service B2B guest user sign-up, we recommend that you use [Microsoft Entra entitlement management](~/id-governance/entitlement-management-overview.md). But if you want to build your own experience, you can use the [create invitation API](/graph/api/invitation-post?tabs=http) to automatically send your customized invitation email directly to the B2B user, for example. Or your app can use the inviteRedeemUrl returned in the creation response to craft your own invitation (through your communication mechanism of choice) to the invited user.

## Next steps

- [Self-service sign-up user flows](self-service-sign-up-overview.md)
- [What is Microsoft Entra B2B collaboration?](what-is-b2b.md)
- [External ID pricing](external-identities-pricing.md)
