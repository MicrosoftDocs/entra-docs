---
title: SAML/WS-Fed federation for self-service sign-up 
description: Set up direct federation with SAML 2.0 or WS-Fed identity providers (IdP) and enable self-service sign-up for external users, who can sign in with their own work accounts.
 
ms.service: entra-external-id
ms.topic: how-to
ms.date: 05/07/2025
ms.author: cmulligan
author: csmulligan
manager: celestedg
ms.custom: it-pro, 
ms.collection: M365-identity-device-management
#customer intent: As an IT admin setting up federation with an external organization's SAML/WS-Fed identity provider, I want to invite users from that organization to sign in to my Microsoft Entra tenant with their work account.
---

# Add the SAML/WS-Fed identity provider to a user flow

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Once you've configured federation with a SAML or WS-Fed identity provider by following the steps in [Add federation with SAML/WS-Fed identity providers](../direct-federation.md), the identity provider is set up in your external tenant, but it's not yet available in any of the sign-in pages. 

## Prerequisites

- An [external tenant](how-to-create-external-tenant-portal.md).
- A registered application in the tenant.
- A [federated SAML or WS-Fed identity provider](../direct-federation.md).
- A sign-up and sign-in user flow.

## Add the identity provider to a user flow

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [External ID User Flow Administrator](~/identity/role-based-access-control/permissions-reference.md#external-id-user-flow-administrator).

1. Switch to your *external* tenant: Select the **Settings** icon in the top menu, and then switch to your external tenant.

1. Browse to **Entra ID** > **External Identities** > **User flows**.

1. Select the user flow where you want to add the identity provider.

   :::image type="content" source="media/saml-ws-federation-self-service-sign-up/select-user-flow.png" alt-text="Screenshot showing where to select the user flow.":::

1. Under **Settings**, select **Identity providers.**

1. Under **Other Identity Providers**, select the identity provider.

   :::image type="content" source="media/saml-ws-federation-self-service-sign-up/select-identity-provider.png" alt-text="Screenshot showing how to select the identity provider on the SAML WS-Fed page.":::

1. Select **Save**.

## Next steps

Follow the steps in [Test your sign-up and sign-in user flow](how-to-test-user-flows.md) to simulate a user’s sign-up or sign-in experience with your app.
