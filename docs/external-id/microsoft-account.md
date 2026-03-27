---

title: Use Microsoft accounts
description: Enable your external business partners and guest users to use their Microsoft account (MSA) to sign in to your apps for B2B collaboration.
ms.topic: how-to
ms.date: 03/27/2026
ai-usage: ai-assisted
ms.collection: M365-identity-device-management
ms.custom: seo-july-2024

#customer intent: As a B2B collaboration administrator, I want to understand the built-in capability for using Microsoft account (MSA) as an identity provider for Microsoft Entra External ID, so that guest users can use their personal Microsoft accounts to sign in without additional configuration.
---

# Use Microsoft accounts for B2B collaboration

[!INCLUDE [applies-to-workforce-only](./includes/applies-to-workforce-only.md)]

Your B2B guest users can use their own personal Microsoft accounts for B2B collaboration without further configuration. Guest users can redeem your B2B collaboration invitations or complete your sign-up user flows using their personal Microsoft account.

Microsoft accounts are set up by a user to get access to consumer-oriented Microsoft products and cloud services, such as Outlook, OneDrive, Xbox, or Microsoft 365. The account is created and stored in the Microsoft consumer identity account system, run by Microsoft.

## Guest sign-in using Microsoft accounts

Microsoft account is available by default in the list of **External Identities** > **All identity providers**. No further configuration is needed to allow guest users to sign in with their Microsoft account by using either the invitation flow or a self-service sign-up user flow.

### Microsoft account in the invitation flow

When you [invite a guest user](add-users-administrator.yml) to B2B collaboration, you can specify their Microsoft account as the email address they'll use to sign in.

:::image type="content" source="media/microsoft-account/microsoft-account-invite.png" alt-text="Invite user pane with a Microsoft account entered as the email address.":::

### Microsoft account in self-service sign-up user flows

Microsoft account is an identity provider option for your self-service sign-up user flows. Users can sign up for your applications using their own Microsoft accounts. First, you'll need to [enable self-service sign-up](self-service-sign-up-user-flow.yml) for your tenant. Then you can set up a user flow for the application, and select Microsoft account as one of the sign-in options.

:::image type="content" source="media/microsoft-account/microsoft-account-user-flow.png" alt-text="Identity provider selection with Microsoft account enabled in a self-service sign-up user flow.":::

## Verify the application's publisher domain

Unverified app registrations can show warning text in consent prompts. For Microsoft Entra External ID user flows, publisher information appears when users sign in with a Microsoft account or another Microsoft Entra tenant as the identity provider.

To reduce consent friction, verify your publisher domain and associate your app registration with your verified partner account:

1. [Verify your company identity in Partner Center](/partner-center/verification-responses).
1. Complete publisher verification to associate your verified partner account with your app registration by using one of these options:
   - If the app registration for the Microsoft account identity provider is in a Microsoft Entra tenant, [verify your app in the App Registration portal](~/identity-platform/mark-app-as-publisher-verified.md).
   - If your app registration for the Microsoft account identity provider is in an Azure AD B2C tenant, [mark your app as publisher verified using Microsoft Graph APIs](~/identity-platform/troubleshoot-publisher-verification.md#making-microsoft-graph-api-calls) (for example, using Graph Explorer).

## Next steps

- [Publisher verification overview](~/identity-platform/publisher-verification-overview.md)
- [Add Microsoft Entra ID as an identity provider for External ID](default-account.md)
