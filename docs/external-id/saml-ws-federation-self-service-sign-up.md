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

- # Add the SAML/WS-Fed identity provider to a user flow

[!INCLUDE [applies-to-external-only](./includes/applies-to-external-only.md)]

If you've followed the steps in [Configure federation with a SAML/WS-Fed identity provider](1-prereq-configure-saml-wsfed.md), the identity provider is set up in your external tenant, but it's not yet available in any of the sign-in pages. 

## Prerequisites

- An [external tenant](how-to-create-external-tenant-portal.md).
- A registered application in the tenant.
- A [federated SAML or WS-Fed identity provider](direct-federation.md).
- A sign-up and sign-in user flow.

## Add the identity provider to a user flow

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [External ID User Flow Administrator](https://learn.microsoft.com/entra/identity/role-based-access-control/permissions-reference#external-id-user-flow-administrator).

1. Switch to your *external* tenant: Select the **Settings** icon in the top menu, and then switch to your external tenant.

1. Browse to **Identity** > **External Identities** > **User flows**.

1. Select the user flow where you want to add the identity provider.

   ![Picture of selecting the user flow.](media/saml-ws-federation-self-service-sign-up/select-user-flow.png)

1. In a workforce tenant, options appear for selecting the **Preview** or **Recommended** versions of sign-up and sign-in user flows. Select **Preview**.

1. Under **Settings**, select **Identity providers.**

1. Under **Other Identity Providers**, select the identity provider.

   ![Picture of the New SAML WS-Fed page.](media/saml-ws-federation-self-service-sign-up/select-identity-provider.png)

1. Select **Save**.

## Test the user flow

Follow the steps in [Test your sign-up and sign-in user flow](https://learn.microsoft.com/en-us/entra/external-id/customers/how-to-test-user-flows) to simulate a user’s sign-up or sign-in experience with your app.