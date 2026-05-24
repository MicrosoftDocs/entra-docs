---
title: Invite Microsoft Entra ID (workforce) users to an external tenant
description: Learn how to invite users from a Microsoft Entra ID workforce tenant to sign in to apps in your external tenant, using the invitation API with issuer acceleration for seamless identity provider redirection.
ms.topic: how-to
ms.date: 05/23/2026
ms.custom: it-pro

#Customer intent: As an IT admin or developer, I want to invite users from a Microsoft Entra ID workforce tenant to access apps in my external tenant so that they can sign in using their existing organizational credentials without self-service sign-up.
---

# Invite Microsoft Entra ID workforce users to an external tenant

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

If you've set up federation with a Microsoft Entra ID workforce tenant as an [OpenID Connect (OIDC) identity provider](how-to-entra-id-federation-customers.md), you can invite specific users from that tenant to access your applications. By using the invitation API, you can control exactly which users have access and skip the default invitation email in favor of a custom one that includes an issuer acceleration link. This approach is useful when you want to restrict access to invited users only, without allowing self-service sign-up.

This article walks you through the admin configuration steps, the invitation process, and the end-user experience for inviting workforce users to your external tenant.

## Prerequisites

- An [external tenant](how-to-create-external-tenant-portal.md).
- A Microsoft Entra ID workforce tenant configured as an [OIDC identity provider](how-to-entra-id-federation-customers.md) in your external tenant.
- A [registered application](/entra/identity-platform/quickstart-register-app) in your external tenant.
- A [sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md) associated with your application.

## Step 1: (Optional) Disable self-service sign-up

If you want only explicitly invited users to access your application, disable the sign-up option in your user flow. This prevents new users from self-registering and ensures that access is controlled entirely through invitations.

To disable sign-up, update the **onInteractiveAuthFlowStart** property of your user flow using the [Update authenticationEventsFlow API](/graph/api/authenticationeventsflow-update):

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

For detailed steps on finding your user flow ID and disabling sign-up, see [Disable sign-up in a user flow](how-to-disable-sign-up-user-flow.md).

## Step 2: Invite users using the invitation API

Invite users from the workforce tenant by calling the [invitation API](/graph/api/invitation-post). Set `sendInvitationMessage` to `false` so that Microsoft Entra ID doesn't send the default invitation email. You'll send your own custom email in the next step.

```http
POST https://graph.microsoft.com/v1.0/invitations
Content-Type: application/json

{
    "invitedUserEmailAddress": "user@contoso.com",
    "inviteRedirectUrl": "https://your-app-url.com",
    "sendInvitationMessage": false
}
```

Key details about this API call:

- **`invitedUserEmailAddress`**: The email address of the user you're inviting from the workforce tenant.
- **`inviteRedirectUrl`**: The URL of the application you want the user to access after they redeem the invitation.
- **`sendInvitationMessage`**: Set to `false` to suppress the default Microsoft invitation email.

After this call succeeds, a user object is created in your external tenant with `externalUserState` set to `PendingAcceptance`.

> [!NOTE]
> You can also invite users through the Microsoft Entra admin center. Browse to **Identity** > **Users** > **All users** > **New user** > **Invite external user**. If you use the admin center, make sure you still send a custom invitation email with the issuer acceleration link as described in the next step.

## Step 3: Send a custom invitation email with the issuer acceleration link

Because you suppressed the default invitation email, you need to send your own email to the invited user. The key element of this email is a link to your application URL that includes a `domain_hint` parameter. The `domain_hint` parameter triggers [issuer acceleration](concept-authentication-methods-customers.md#issuer-acceleration), which redirects the user directly to their workforce identity provider to authenticate, bypassing the generic sign-in page.

Construct the link using the following format:

```
https://your-app-url.com?domain_hint=<workforce-tenant-domain>
```

For a Microsoft Entra ID workforce tenant configured as a custom OIDC identity provider, use the workforce tenant's domain name as the `domain_hint` value. For example:

```
https://your-app-url.com?domain_hint=contoso.onmicrosoft.com
```

> [!TIP]
> Only the initial invitation redemption step requires the user to select a link with the `domain_hint` parameter. For all subsequent sign-ins, the user can enter their email address on the sign-in page and will be automatically redirected to the identity provider they used during invitation redemption.

Include this link in your custom invitation email. For example:

> **Subject**: You're invited to access [Your Application Name]
>
> Hello,
>
> You've been invited to access [Your Application Name]. Select the following link to get started:
>
> [Accept invitation and sign in](https://your-app-url.com?domain_hint=contoso.onmicrosoft.com)
>
> You'll be asked to sign in with your organizational account (for example, user@contoso.com).

## End-user experience

After you complete the configuration and send the invitation, here's what the invited user experiences:

### First sign-in (invitation redemption)

1. The user receives your custom invitation email and selects the link that includes the `domain_hint` parameter.
1. The user is redirected directly to their workforce tenant's sign-in page (the Microsoft Entra ID identity provider), bypassing the generic External ID sign-in page.
1. The user signs in with their workforce credentials (for example, `user@contoso.com`).
1. After successful authentication, the user's invitation is redeemed. In your external tenant, the user object is updated:
   - The `identities` collection includes a new entry for the federated identity.
   - The `externalUserState` changes to `Accepted`.

### Subsequent sign-ins

1. The user navigates to your application's sign-in page (no `domain_hint` parameter is needed).
1. The user enters their email address on the sign-in page.
1. Microsoft Entra External ID recognizes the user's identity provider from their previous redemption and automatically redirects them to the correct workforce tenant for authentication.

## End state summary

After you complete this configuration:

| Outcome | Description |
|---------|-------------|
| **Invited-only access** | Only users you've explicitly invited can sign in. Self-service sign-up is disabled (if you completed [Step 1](#step-1-optional-disable-self-service-sign-up)). |
| **Workforce identity sign-in** | Invited users sign in using their existing Microsoft Entra ID (workforce) credentials. No separate passwords or accounts are needed. |
| **Initial invitation link** | Until OIDC domain support is available, invited users need to select a link with the `domain_hint` parameter to redeem their invitation. After initial redemption, the `domain_hint` is no longer required. |
| **Future improvement** | When OIDC domain support becomes available, users won't need the special invitation link. They'll be automatically redirected to redeem their invitation with the correct external identity provider when they sign in. |

## Related content

- [Add a Microsoft Entra ID tenant as an OIDC identity provider](how-to-entra-id-federation-customers.md)
- [Identity providers for external tenants](concept-authentication-methods-customers.md)
- [Disable sign-up in a user flow](how-to-disable-sign-up-user-flow.md)
- [Microsoft Entra B2B collaboration API and customization](../customize-invitation-api.md)
- [Issuer acceleration](concept-authentication-methods-customers.md#issuer-acceleration)
