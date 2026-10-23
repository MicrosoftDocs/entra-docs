---
title: Route Invited Users to an External Identity Provider
description: Learn how to invite users to a Microsoft Entra external tenant and route them to a configured OpenID Connect, SAML/WS-Federation, or social identity provider.
author: nanguil
ms.author: nguilanians
ms.topic: how-to
ms.date: 10/12/2026
ms.custom: it-pro, msecd-doc-authoring-1026
ai-usage: ai-assisted

#customer intent: As an IT admin or developer, I want to route invited users to a specific external identity provider so that they can access my application by using their existing credentials.
---

# Route invited users to an external identity provider

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

You can invite consumers, business customers, and admins to a Microsoft Entra external tenant. By default, the [invitation redemption flow](../redemption-experience.md#invitation-redemption-flow) determines how an invited user authenticates. This article describes how to explicitly route an invited user to a configured external identity provider (IdP), such as a social provider, custom OpenID Connect (OIDC) provider, or Security Assertion Markup Language (SAML)/WS-Federation provider.

Explicit identity provider routing is useful when:

- Only invited users should be able to access your application (no self-service sign-up).
- Users must authenticate with a specific external identity provider.
- You want full control over the invitation experience and communication.

Before you begin, ensure you have an external tenant, registered application, associated user flow, configured identity provider, and the provider's `domain_hint` value.

## Prerequisites

- A [Microsoft Entra External ID tenant](how-to-create-external-tenant-portal.md).
- A configured external identity provider: [Custom OIDC](how-to-custom-oidc-federation-customers.md), [Microsoft Entra ID](how-to-entra-id-federation-customers.md), [SAML/WS-Fed](../direct-federation.md), or a social provider ([Google](how-to-google-federation-customers.md), [Facebook](how-to-facebook-federation-customers.md), [Apple](how-to-apple-federation-customers.md)).
- A [registered application](/entra/identity-platform/quickstart-register-app) in your external tenant.
- A [user flow](how-to-user-flow-sign-up-sign-in-customers.md) associated with your application. The user flow is required even if sign-up is disabled. You don't need to add the identity provider to the user flow when you route invited users by using `domain_hint`.
- The `domain_hint` value for the identity provider, as described in [Issuer acceleration](concept-authentication-methods-customers.md#issuer-acceleration).

> [!IMPORTANT]
> The `domain_hint` parameter changes authentication routing during invitation redemption. It isn't required to invite a user, doesn't determine who is eligible for an invitation, and doesn't grant access to an application. When you use `domain_hint` to route a user from another Microsoft Entra tenant to custom OIDC federation, the sign-in doesn't use the native Microsoft Entra business-to-business (B2B) federation path or its home-tenant multifactor authentication (MFA) trust.

## Disable self-service sign-up (optional)

If you want only explicitly invited users to access your application, disable sign-up in your user flow. This prevents users who aren't invited from creating accounts through self-service registration. Your application still controls authorization for invited users.

For detailed steps on finding your user flow ID and disabling sign-up, see [Disable sign-up in a user flow](how-to-disable-sign-up-user-flow.md).

## Invite users

You can invite users by using either the Microsoft Graph API or the admin center. Configure the invitation not to send the default email. Instead, send a custom email with an application link after you create the invitation (next step).

Regardless of which option you use, when the invitation is created:

- A user object is created in the external tenant with `externalUserState` set to `PendingAcceptance`.
- No identity provider is yet associated with the user object.

> [!NOTE]
> Unlike self-service sign-up users, invited users aren't prompted for additional attributes during sign-in. Their user properties are based on the invitation and claims received from the external identity provider.

<a name='option-1-use-the-invitation-api'></a>

### Option 1: Use the Microsoft Graph invitation API

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

## Send a custom invitation email with the `domain_hint` parameter

After creating the user, send your own email with a link to an application route that starts the External ID authorization request. Configure the application route to pass the `domain_hint` parameter in the authorization request so that External ID routes the user to the specified identity provider.

The application route depends on your application. For example:

```text
https://<app-url>/<sign-in-route>?domain_hint=<identity-provider-domain>
```

Use the `domain_hint` value specified for your provider in [Issuer acceleration](concept-authentication-methods-customers.md#issuer-acceleration). For example, for custom OIDC, use the domain part of the issuer URI. For a Microsoft Entra ID tenant configured as a custom OIDC provider, use the tenant domain, such as `contoso.onmicrosoft.com`.

Include this link in your custom invitation email. For example:

> **Subject**: You're invited to access [Your Application Name]
>
> Hello,
>
> You've been invited to access [Your Application Name]. Select the following link to get started:
>
> [Accept invitation and sign in](https://your-app-url.com/signin?domain_hint=contoso.onmicrosoft.com)
>
> You'll be asked to sign in with your existing credentials.

> [!NOTE]
> If you use the default Microsoft invitation email, the [invitation redemption flow](../redemption-experience.md#invitation-redemption-flow) determines how the user authenticates and might not route the user to your intended identity provider.

## End-user experience

After you complete the configuration and send the invitation, here's what the invited user experiences.

### First sign-in (invitation redemption)

1. The user receives your custom invitation email and selects the link that includes the `domain_hint` parameter.
1. The application starts the External ID authorization request with the `domain_hint` parameter, and the user is routed to the specified identity provider.
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
1. The user is recognized as an existing user and is redirected to the identity provider used during invitation redemption.

## Related content

- [Create invitation (Microsoft Graph)](/graph/api/invitation-post)
- [Add and manage customer accounts](how-to-manage-customer-accounts.md)
- [Issuer acceleration](concept-authentication-methods-customers.md#issuer-acceleration)
