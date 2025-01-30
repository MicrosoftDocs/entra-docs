---
title: SAML/WS-Fed federation for invitations 
description: Set up direct federation with SAML 2.0 or WS-Fed identity providers (IdP) and invite guests, who can sign in with their own work accounts.
 
ms.service: entra-external-id
ms.topic: how-to
ms.date: 01/29/2025
ms.author: mimart
author: msmimart
manager: celestedg
ms.custom: it-pro, 
ms.collection: M365-identity-device-management
#customer intent: As an IT admin setting up federation with an external organizaton's SAML/WS-Fed identity provider, I want to invite users from that organization to sign in to my Microsoft Entra tenant with their work account.
---

# Invite users to sign in using a federated SAML/WS-Fed identity provider

[!INCLUDE [applies-to-workforce-external](./includes/applies-to-workforce-external.md)]

> [!NOTE]
> *Direct federation* in Microsoft Entra External ID is now referred to as *SAML/WS-Fed identity provider (IdP) federation*.

This article explains how to invite users from a federated organization to sign in to your Microsoft Entra tenant using their own SAML 2.0 or WS-Fed identity provider (IdP). Once federation is set up, new invited users can use their existing IdP-managed accounts to sign in, without needing a separate Microsoft Entra account.

## Configure the redemption order for Microsoft Entra ID verified domains

If the domain is Microsoft Entra ID verified, [configure the **Redemption order** settings](cross-tenant-access-settings-b2b-collaboration.yml) in your cross-tenant access settings for inbound B2B collaboration. Move **SAML/WS-Fed identity providers** to the top of the **Primary identity providers** list to prioritize redemption with the federated IdP.

> [!NOTE]
> The Microsoft Entra admin center settings for the configurable redemption feature are currently rolling out to customers. Until the settings are available in the admin center, you can configure the invitation redemption order using the Microsoft Graph REST API (beta version). See [Example 2: Update default invitation redemption configuration](/graph/api/crosstenantaccesspolicyconfigurationdefault-update?view=graph-rest-beta&tabs=http#example-2-update-default-invitation-redemption-configuration&preserve-view=true) in the Microsoft Graph reference documentation.

## Test SAML/WS-Fed IdP federation in Microsoft Entra ID

Now test your federation setup by inviting a new B2B guest user. For details, see [Add Microsoft Entra B2B collaboration users in the Microsoft Entra admin center](add-users-administrator.yml).
 
## Next steps

Learn more about the [invitation redemption experience](redemption-experience.md) when external users sign in with various identity providers.
