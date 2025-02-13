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

[!INCLUDE [applies-to-external-only](./includes/applies-to-external-only.md)]

This article explains how to invite users from a federated organization to sign in to your Microsoft Entra tenant using their own SAML 2.0 or WS-Fed identity provider (IdP). Once federation is set up, new invited users can use their existing IdP-managed accounts to sign in, without needing a separate Microsoft Entra account.

## Prerequisites

- An [external tenant](customers/how-to-create-external-tenant-portal.md).
- A registered application in the tenant.
- A [federated SAML or WS-Fed identity provider](direct-federation.md).

## Invite a user to your external tenant

To invite a user from the federated partner organization to your external tenant, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](/entra/identity/role-based-access-control/permissions-reference#privileged-role-administrator).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu.
1. Browse to **Identity** > **Users** > **All users**.
1. Select **New user** > **Invite external user (Preview)**.
1. On the **Basics** tab, enter information for the user:

   - **Email**. *Required*. The email address of the user you would like to invite.
   - **Display name**. The first and last name of the new user. For example, *Mary Parker*.
   - Under **Invitation message**:
      - Select the **Send invite message** checkbox if you want to send the invitation email to the user. Otherwise, clear the checkbox.
      - In **Message**, add a personal message to include in the invite email.
      - To send a copy of the invitation email to someone, add their email address in the **Cc recipient** text box.
      - The **Invite redirect URL** defaults to MyApplications, which is where the user is redirected when they redeem the invitation. You can change it to a different URL.
   
1. Select the **Assignments** tab, and use the following steps to assign a role to the user. (Adding a group is optional).

   - Select **+ Add role**.
   - From the menu that appears, choose up to 20 roles from the list. You can assign the user to one or more of the [administrator roles](/entra/identity/role-based-access-control/permissions-reference) in Microsoft Entra ID.
   - Select the **Select** button.

1. Select the **Review + invite** button.

An invitation email is sent to the user. The user needs to accept the invitation to be able to sign in.

## Next steps

Learn how to onboard users with  more about the [invitation redemption experience](redemption-experience.md) when external users sign in with various identity providers.
