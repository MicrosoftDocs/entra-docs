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

This article describes how to invite users to a Microsoft Entra External ID tenant and ensure they authenticate using a specific external identity provider (IdP), such as:

- **Social identity providers** (for example, Google or Facebook)
- **Custom OpenID Connect (OIDC) providers** (for example, a Microsoft Entra ID workforce tenant)
- **Custom SAML identity providers**

This approach is useful when:

- Only invited users should be able to access your application (no self-service sign-up).
- Users must authenticate with a specific external identity provider.
- You want full control over the invitation experience and communication.

## Prerequisites

Before you begin, ensure you have the following:

- A [Microsoft Entra External ID tenant](how-to-create-external-tenant-portal.md).
- An external identity provider configured in your tenant. Depending on your scenario, set up one of the following:
  - [Custom OIDC identity provider](how-to-custom-oidc-federation-customers.md) (including [Microsoft Entra ID federation](how-to-entra-id-federation-customers.md))
  - [SAML/WS-Fed identity provider](../direct-federation.md)
  - A social identity provider ([Google](how-to-google-federation-customers.md), [Facebook](how-to-facebook-federation-customers.md), or [Apple](how-to-apple-federation-customers.md))
- A [registered application](/entra/identity-platform/quickstart-register-app) in your external tenant.
- A [sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md) with the identity provider added and the user flow associated with your application.
- The **Issuer URI** or **domain name** for the identity provider (used for routing during sign-in). For more information, see [Issuer acceleration](concept-authentication-methods-customers.md#issuer-acceleration).

## Overview of the invitation flow

This pattern uses:

- The **Invitation API** or **Admin UX** to create users in a pending state.
- A **custom invitation email** with a specialized application link.
- The **`domain_hint` parameter** to route users to the intended identity provider during invitation redemption.

You can create invitations using either method:

- **Microsoft Graph Invitation API**: See [Create invitation](/graph/api/invitation-post?view=graph-rest-1.0&tabs=http).
- **Microsoft Entra admin center**: See [Add and manage customer accounts](how-to-manage-customer-accounts.md). Browse to **Users** > **New user** > **Invite external user**.

## Step 1: (Optional) Disable self-service sign-up

If you want only explicitly invited users to access your application, disable the sign-up option in your user flow. This prevents new users from self-registering and ensures that access is controlled entirely through [user creation](how-to-manage-customer-accounts.md) and/or invitations.

For detailed steps on finding your user flow ID and disabling sign-up, see [Disable sign-up in a user flow](how-to-disable-sign-up-user-flow.md).

To disable sign-up, update the **onInteractiveAuthFlowStart** property of your user flow:

```http
PATCH https://graph.microsoft.com/beta/identity/authenticationEventsFlows/{user-flow-id}
Content-Type: application/json

{
    "@odata.type": "#microsoft.graph.externalUsersSelfServiceSignUpEventsFlow",
    "onInteractiveAuthFlowStart": {
        "@odata.type": "#microsoft.graph.onInteractiveAuthFlowStartExternalUsersSelfServiceSignUp",
        "isSignUpAllowed": false
    }
}
```

## Step 2: Invite users

You can invite users using either the Microsoft Graph API or the admin center.

### Option 1: Use the Invitation API

Create a user in the External ID tenant using the [Microsoft Graph Invitation API](/graph/api/invitation-post?view=graph-rest-1.0&tabs=http). Set `sendInvitationMessage` to `false` so that Microsoft doesn't send the default invitation email. You send your own custom email in the next step.

```http
POST https://graph.microsoft.com/v1.0/invitations
Content-Type: application/json

{
    "invitedUserEmailAddress": "user@contoso.com",
    "inviteRedirectUrl": "https://your-app-url.com",
    "sendInvitationMessage": false
}
```

Key configuration details:

- **`invitedUserEmailAddress`**: The email address of the user you're inviting.
- **`inviteRedirectUrl`**: The URL of the application you want the user to access after they redeem the invitation.
- **`sendInvitationMessage`**: Set to `false` to suppress the default Microsoft invitation email. This ensures you can send a custom email with your own application link that includes the `domain_hint` parameter.

When the invitation is created:

- A user object is created in the external tenant with `externalUserState` set to `PendingAcceptance`.
- No identity provider is yet associated with the user object.

### Option 2: Use the admin center

You can also invite users through the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **Users** > **All users**.
1. Select **New user** > **Invite external user**.
1. Provide the user's email address and any optional attributes.
1. Choose whether to send the Microsoft invitation email or send your own.

To use this pattern, disable the default email and send your own custom invitation containing the `domain_hint` parameter as described in the next step.

For step-by-step instructions, see [Invite external user](~/fundamentals/how-to-create-delete-users.yml#invite-an-external-user).

## Step 3: Send a custom invitation email with the domain_hint parameter

After creating the user, send your own email that includes a link to your application. The key element is the `domain_hint` parameter, which triggers [issuer acceleration](concept-authentication-methods-customers.md#issuer-acceleration). This routes the user directly to the specified identity provider during sign-in, bypassing the generic sign-in page.

Construct the application link using the following format:

```
https://<app-url>?domain_hint=<Issuer URI>
```

The `domain_hint` value depends on the type of identity provider:

| Identity provider type | `domain_hint` value | Example |
|------------------------|---------------------|---------|
| **Custom OIDC (Entra ID)** | Domain name of the Entra ID tenant | `domain_hint=contoso.onmicrosoft.com` |
| **Custom OIDC (other)** | Domain part of the Issuer URI | `domain_hint=www.linkedin.com` |
| **Google** | `google` | `domain_hint=google` |
| **Facebook** | `facebook` | `domain_hint=facebook` |
| **Apple** | `apple` | `domain_hint=apple` |
| **Custom SAML** | Domain name of the federating IdP | `domain_hint=adfs.contoso.com` |

For more information about `domain_hint` values, see [Issuer acceleration](concept-authentication-methods-customers.md#issuer-acceleration) and [Domain acceleration](concept-authentication-methods-customers.md#domain-acceleration).

> [!TIP]
> Only the initial invitation redemption step requires the user to select a link with the `domain_hint` parameter. For all subsequent sign-ins, the user can enter their email address on the sign-in page and is automatically redirected to the identity provider they used during invitation redemption.

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
1. The application launches the External ID sign-in experience. The `domain_hint` parameter routes the user directly to the specified identity provider, bypassing the generic sign-in page.
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

## Resulting behavior

After the flow is complete:

| Outcome | Description |
|---------|-------------|
| **Invited-only access** | Only users you've explicitly invited can sign in. Self-service sign-up is disabled (if you completed [Step 1](#step-1-optional-disable-self-service-sign-up)). |
| **External IdP sign-in** | Users authenticate using their external identity provider. No local account or separate password is required. |
| **Automatic sign-in routing** | After the first sign-in, users are automatically redirected to the correct identity provider based on their email address. |

## Considerations and limitations

- **Custom email required**: When you set `sendInvitationMessage` to `false` in the invitation API, you must send your own invitation email containing the application link with the `domain_hint` parameter.
- **Special link required for initial redemption**: Users must use the invitation link containing `domain_hint` to redeem their invitation and associate the correct identity provider.

## Related content

- [Create invitation (Microsoft Graph)](/graph/api/invitation-post?view=graph-rest-1.0&tabs=http)
- [Add and manage customer accounts](how-to-manage-customer-accounts.md)
- [Identity providers for external tenants](concept-authentication-methods-customers.md)
- [Issuer acceleration](concept-authentication-methods-customers.md#issuer-acceleration)
- [Disable sign-up in a user flow](how-to-disable-sign-up-user-flow.md)
- [Add a Microsoft Entra ID tenant as an OIDC identity provider](how-to-entra-id-federation-customers.md)
- [Configure a custom OIDC identity provider](how-to-custom-oidc-federation-customers.md)
- [Configure SAML/WS-Fed IdP federation](../direct-federation.md)
- [Self-service sign-up for SAML/WS-Fed federated users](how-to-saml-ws-federation-self-service-sign-up.md)
