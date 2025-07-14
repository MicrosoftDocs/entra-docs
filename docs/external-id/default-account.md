---
title: Use Microsoft Entra Accounts
description: Enable your external business partners and guest users to use their Microsoft Entra work or school accounts to sign in to your apps for B2B collaboration.
 

ms.service: entra-external-id
ms.topic: how-to
ms.date: 04/09/2025
ms.author: cmulligan
author: csmulligan
manager: dougeby
ms.collection: M365-identity-device-management
ms.custom: seo-july-2024
#customer intent: As a B2B collaboration administrator, I want to understand the built-in capability for using Microsoft Entra ID as an identity provider for external guests, so that guest users can use their Microsoft Entra work or school account to sign in without additional configuration.
---

# Use Microsoft Entra work and school accounts for B2B collaboration

[!INCLUDE [applies-to-workforce-only](./includes/applies-to-workforce-only.md)]

Microsoft Entra ID is available as an identity provider option for B2B collaboration by default. If an external guest user has a Microsoft Entra account through work or school, they can redeem your B2B collaboration invitations or complete your sign-up user flows using their Microsoft Entra account.

<a name='guest-sign-in-using-azure-active-directory-accounts'></a>

## Guest sign-in using Microsoft Entra accounts

If you want to enable guest users to sign in with their Microsoft Entra account, you can use either the invitation flow or a self-service sign-up user flow. No further configuration is required.

<a name='azure-ad-account-in-the-invitation-flow'></a>

### Microsoft Entra account in the invitation flow

When you [invite a guest user](add-users-administrator.yml) to B2B collaboration, you can specify their Microsoft Entra account as the **Email address** they use to sign in.

:::image type="content" source="media/default-account/default-account-invite.png" alt-text="Screenshot of inviting a guest user using the Microsoft Entra account." lightbox="media/default-account/default-account-invite.png":::

<a name='azure-ad-account-in-self-service-sign-up-user-flows'></a>

### Microsoft Entra account in self-service sign-up user flows

Microsoft Entra account is an identity provider option for your self-service sign-up user flows. Users can sign up for your applications using their own Microsoft Entra accounts. First, [enable self-service sign-up](self-service-sign-up-user-flow.yml) for your tenant, and then set up a user flow for the application.

:::image type="content" source="media/default-account/default-account-user-flow.png" alt-text="Screenshot of Microsoft Entra account in a self-service sign-up user flow." lightbox="media/default-account/default-account-user-flow.png":::

## Verifying the application's publisher domain
As of November 2020, new application registrations show up as unverified in the user consent prompt unless [the application's publisher domain is verified](~/identity-platform/howto-configure-publisher-domain.md), ***and*** the company’s identity has been verified with the Microsoft Partner Network and associated with the application. ([Learn more](~/identity-platform/publisher-verification-overview.md) about this change.) For Microsoft Entra user flows, the publisher’s domain appears only when using a [Microsoft account](microsoft-account.md) or other Microsoft Entra tenant as the identity provider. To meet these new requirements, follow these steps:

1. [Verify your company identity using your Microsoft Partner Network (MPN) account](/partner-center/verification-responses). This process verifies information about your company and your company’s primary contact.
1. Complete the publisher verification process to associate your MPN account with your app registration using one of the following options:
   - If the app registration for the Microsoft account identity provider is in a Microsoft Entra tenant, [verify your app in the App Registration portal](~/identity-platform/mark-app-as-publisher-verified.md).
   - If your app registration for the Microsoft account identity provider is in an Azure AD B2C tenant, [mark your app as publisher verified using Microsoft Graph APIs](~/identity-platform/troubleshoot-publisher-verification.md#making-microsoft-graph-api-calls) (for example, using Graph Explorer).

## Next steps

- [Microsoft account](microsoft-account.md)
- [Add Microsoft Entra B2B collaboration users](add-users-administrator.yml)
- [Add self-service sign-up to an app](self-service-sign-up-user-flow.yml)

