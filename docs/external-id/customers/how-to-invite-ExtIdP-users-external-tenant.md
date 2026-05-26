---
title: Invite users to authenticate with an external identity provider
description: Learn how to invite users to a Microsoft Entra External ID tenant and route them to a specific external identity provider (OIDC, SAML, or social) using the invitation API or admin center with issuer acceleration.
ms.topic: how-to
ms.date: 05/23/2026
ms.custom: it-pro

#Customer intent: As an IT admin or developer, I want to invite users to my External ID tenant and ensure they authenticate with a specific external identity provider, so that only invited users can access my application using their existing credentials.
---

# Invite users to authenticate with an external identity provider

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

This article describes how to invite users to a Microsoft Entra External ID tenant and ensure they authenticate using a specific external identity provider (IdP), such as a social provider, custom OIDC provider, or custom SAML provider.

This approach is useful when:

- Only invited users should be able to access your application (no self-service sign-up).
- Users must authenticate with a specific external identity provider.
- You want full control over the invitation experience and communication.

## Prerequisites

Before you begin, ensure you have the following:

- A [Microsoft Entra External ID tenant](how-to-create-external-tenant-portal.md).
- A configured external identity provider: [Custom OIDC](how-to-custom-oidc-federation-customers.md), [Microsoft Entra ID](how-to-entra-id-federation-customers.md), [SAML/WS-Fed](../direct-federation.md), or a social provider ([Google](how-to-google-federation-customers.md), [Facebook](how-to-facebook-federation-customers.md), [Apple](how-to-apple-federation-customers.md)).
- A [registered application](/entra/identity-platform/quickstart-register-app) in your external tenant.
- A [user flow](how-to-user-flow-sign-up-sign-in-customers.md) associated with your application. Adding the identity provider to the user flow is only required if you want explicit IdP buttons on the sign-in page or you want to allow self-service sign-up with the identity providers. If you always invite users and rely on `domain_hint` for routing, you don't need to add identity providers to the user flow.
- The **Issuer URI** or **domain name** for the identity provider. For more information, see [Issuer acceleration](concept-authentication-methods-customers.md#issuer-acceleration).

## Overview of the invitation flow

This pattern uses:

- The **Invitation API** or **Admin UX** to create users in a pending state.
- A **custom invitation email** with a specialized application link.
- The **`domain_hint` parameter** to route users to the intended identity provider during invitation redemption.

## Step 1: (Optional) Disable self-service sign-up

If you want only explicitly invited users to access your application, disable the sign-up option in your user flow. This prevents new users from self-registering and ensures that access is controlled entirely through [user creation](how-to-manage-customer-accounts.md) and/or invitations.

For detailed steps on finding your user flow ID and disabling sign-up, see [Disable sign-up in a user flow](how-to-disable-sign-up-user-flow.md).

## Step 2: Invite users

You can invite users using either the Microsoft Graph API or the admin center. With either method, set `sendInvitationMessage` to `false` so that Microsoft doesn't send the default invitation email. You send your own custom email in the next step.

Regardless of which option you use, when the invitation is created:

- A user object is created in the external tenant with `externalUserState` set to `PendingAcceptance`.
- No identity provider is yet associated with the user object.

### Option 1: Use the Invitation API

Create a user in the External ID tenant using the [Microsoft Graph Invitation API](/graph/api/invitation-post).

```http
POST https://graph.microsoft.com/v1.0/invitations
Content-Type: application/json

{
    "invitedUserEmailAddress": "user@contoso.com",
    "inviteRedirectUrl": "https://your-app-url.com",
    "sendInvitationMessage": false
}
```

### Option 2: Use the admin center

You can also invite users through the Microsoft Entra admin center using the [Invite external user](~/fundamentals/how-to-create-delete-users.md#invite-an-external-user) option. To use this pattern, disable the default Microsoft invitation email and send your own custom invitation containing the `domain_hint` parameter as described in the next step.

## Step 3: Send a custom invitation email with the domain_hint parameter

After creating the user, send your own email that includes a link to your application. The key element is the `domain_hint` parameter, which triggers [issuer acceleration](concept-authentication-methods-customers.md#issuer-acceleration). This routes the user directly to the specified identity provider during sign-in, bypassing the generic sign-in page.

Construct the application link using the following format:

```
https://<app-url>?domain_hint=<Issuer URI>
```

The `domain_hint` value depends on your identity provider type. For the correct value for each provider, see [Issuer acceleration](concept-authentication-methods-customers.md#issuer-acceleration) and [Domain acceleration](concept-authentication-methods-customers.md#domain-acceleration).

Include this link in your custom invitation email. For example:

> **Subject**: You're invited to access [Your Application Name]
>
> Hello,
>
> You've been invited to access [Your Application Name]. Select the following link to get started:
>
> [Accept invitation and sign in](https://your-app-url.com?domain_hint=contoso.onmicrosoft.com)
>
> You'll be asked to sign in with your existing credentials.

## End-user experience

After you complete the configuration and send the invitation, here's what the invited user experiences.

### First sign-in (invitation redemption)

1. The user receives your custom invitation email and selects the link that includes the `domain_hint` parameter.
1. The application launches the External ID sign-in experience. The `domain_hint` parameter routes the user directly to the specified identity provider.
1. The user authenticates with their existing credentials at the identity provider.
1. The invitation is redeemed. In your external tenant, the user object is updated:
   - A federated identity is added to the `identities` collection.
   - The `externalUserState` changes to `Accepted`.

> [!NOTE]
> The `domain_hint` parameter is only required during this initial invitation redemption step.

### Subsequent sign-ins

After the user completes invitation redemption:

1. The user navigates to your application (no `domain_hint` parameter is needed).
1. The user enters their email address on the sign-in page.
1. External ID identifies the user and redirects them to the same identity provider used during redemption.

## Considerations and limitations

- **Custom email required**: When you set `sendInvitationMessage` to `false` in the invitation API, you must send your own invitation email containing the application link with the `domain_hint` parameter.
- **Special link required for initial redemption**: Users must use the invitation link containing `domain_hint` to redeem their invitation and associate the correct identity provider.
- **No attribute collection during sign-in**: Unlike self-service sign-up users, invited users aren't prompted for additional attributes during sign-in. Their user properties are based on the invitation and claims received from the external identity provider.

## Related content

- [Create invitation (Microsoft Graph)](/graph/api/invitation-post)
- [Add and manage customer accounts](how-to-manage-customer-accounts.md)
- [Identity providers for external tenants](concept-authentication-methods-customers.md)
- [Issuer acceleration](concept-authentication-methods-customers.md#issuer-acceleration)
- [Disable sign-up in a user flow](how-to-disable-sign-up-user-flow.md)
- [Add a Microsoft Entra ID tenant as an OIDC identity provider](how-to-entra-id-federation-customers.md)
- [Configure a custom OIDC identity provider](how-to-custom-oidc-federation-customers.md)
- [Configure SAML/WS-Fed IdP federation](../direct-federation.md)
- [Self-service sign-up for SAML/WS-Fed federated users](how-to-saml-ws-federation-self-service-sign-up.md)
