---
title: Use Microsoft Entra accounts
description: Enable your external business partners and guest users to use their Microsoft Entra work or school accounts to sign in to your apps for B2B collaboration.
ms.topic: how-to
ms.date: 03/27/2026
ai-usage: ai-assisted
ms.collection: M365-identity-device-management
ms.custom: seo-july-2024
#customer intent: As a B2B collaboration administrator, I want to understand the built-in capability for using Microsoft Entra ID as an identity provider for external guests, so that guest users can use their Microsoft Entra work or school account to sign in without additional configuration.
---

# Use Microsoft Entra work or school accounts for B2B collaboration

[!INCLUDE [applies-to-workforce-only](./includes/applies-to-workforce-only.md)]

Microsoft Entra ID is available as an identity provider option for B2B collaboration by default. If an external guest user has a Microsoft Entra account through work or school, they can redeem your B2B collaboration invitations or complete your sign-up user flows using their Microsoft Entra account.

<a name='guest-sign-in-using-azure-active-directory-accounts'></a>

## Guest sign-in using Microsoft Entra accounts

If you want to enable guest users to sign in with their Microsoft Entra account, you can use either the invitation flow or a self-service sign-up user flow. No further configuration is required.

<a name='azure-ad-account-in-the-invitation-flow'></a>

### Microsoft Entra account in the invitation flow

When you [invite a guest user](add-users-administrator.yml) to B2B collaboration, you can specify their Microsoft Entra account as the **Email address** they use to sign in.

:::image type="content" source="media/default-account/default-account-invite.png" alt-text="Invite user pane showing a Microsoft Entra work or school account as the sign-in email." lightbox="media/default-account/default-account-invite.png":::

<a name='azure-ad-account-in-self-service-sign-up-user-flows'></a>

### Microsoft Entra account in self-service sign-up user flows

Microsoft Entra account is an identity provider option for your self-service sign-up user flows. Users can sign up for your applications using their own Microsoft Entra accounts. First, [enable self-service sign-up](self-service-sign-up-user-flow.yml) for your tenant, and then set up a user flow for the application.

:::image type="content" source="media/default-account/default-account-user-flow.png" alt-text="Identity provider selection with Microsoft Entra account enabled in a self-service sign-up user flow." lightbox="media/default-account/default-account-user-flow.png":::

## Verify the application's publisher domain

Unverified app registrations can show warning text in consent prompts unless [the application's publisher domain is verified](~/identity-platform/howto-configure-publisher-domain.md) and the company identity is verified in Partner Center. For Microsoft Entra user flows, publisher information appears when users sign in with a [Microsoft account](microsoft-account.md) or another Microsoft Entra tenant as the identity provider.

To reduce consent friction, follow these steps:

1. [Verify your company identity in Partner Center](/partner-center/verification-responses).
1. Complete publisher verification to associate your verified partner account with your app registration by using one of these options:
   - If the app registration for the Microsoft account identity provider is in a Microsoft Entra tenant, [verify your app in the App Registration portal](~/identity-platform/mark-app-as-publisher-verified.md).
   - If your app registration for the Microsoft account identity provider is in an Azure AD B2C tenant, [mark your app as publisher verified using Microsoft Graph APIs](~/identity-platform/troubleshoot-publisher-verification.md#making-microsoft-graph-api-calls) (for example, using Graph Explorer).

## Next steps

- [Microsoft account](microsoft-account.md)
- [Add Microsoft Entra B2B collaboration users](add-users-administrator.yml)
- [Add self-service sign-up to an app](self-service-sign-up-user-flow.yml)

