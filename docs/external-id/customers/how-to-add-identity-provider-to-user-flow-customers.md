---
title: Add an identity provider to a user flow
description: Learn how to add a configured external identity provider (OIDC, SAML/WS-Fed, or social) to a user flow in Microsoft Entra External ID so it appears on the sign-in page for self-service sign-up.
ms.topic: how-to
ms.date: 05/29/2026
ms.custom: it-pro
ai-usage: ai-assisted
#customer intent: As an IT admin, I want to add a configured identity provider to a user flow so that users can self-service sign up and sign in using the identity provider.
---

# Add an identity provider to a user flow

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

After you configure an external identity provider in your external tenant, you need to add it to a user flow to make it available on the sign-in page.

For steps on configuring identity providers, see:

- [Configure a custom OIDC identity provider](how-to-custom-oidc-federation-customers.md)
- [Add a Microsoft Entra ID tenant as an OIDC identity provider](how-to-entra-id-federation-customers.md)
- [Configure SAML/WS-Fed IdP federation](../direct-federation.md)
- [Add Google as an identity provider](how-to-google-federation-customers.md)
- [Add Facebook as an identity provider](how-to-facebook-federation-customers.md)
- [Add Apple as an identity provider](how-to-apple-federation-customers.md)
- [Add Microsoft account as an identity provider](how-to-microsoft-accounts-federation-customers.md)

## Prerequisites

- An [external tenant](how-to-create-external-tenant-portal.md).
- A registered application in the tenant.
- A configured identity provider (see links above).
- A [sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md).

## Add the identity provider to a user flow

To add a configured identity provider to a user flow, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [External ID User Flow Administrator](~/identity/role-based-access-control/permissions-reference.md#external-id-user-flow-administrator).

1. Switch to your external tenant by selecting the **Settings** icon in the top menu and choosing the external tenant.

1. Browse to **Entra ID** > **External Identities** > **User flows**.

1. Select the user flow where you want to add the identity provider.

   :::image type="content" source="media/how-to-add-identity-provider-to-user-flow-customers/select-user-flow.png" alt-text="Screenshot of the External Identities User flows page showing the user flow list.":::

1. Under **Settings**, select **Identity providers**.

1. Under **Other Identity Providers**, select the identity provider you want to add.

   :::image type="content" source="media/how-to-add-identity-provider-to-user-flow-customers/select-identity-provider.png" alt-text="Screenshot of the Identity providers page showing the Other Identity Providers section.":::

1. Select **Save**.

## Next step

> [!div class="nextstepaction"]
> [Test your sign-up and sign-in user flow](how-to-test-user-flows.md)
