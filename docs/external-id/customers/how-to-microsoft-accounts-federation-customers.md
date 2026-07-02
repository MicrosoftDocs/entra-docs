---
title: Add MSA for customer sign-in
description: Learn how to add MSA as an identity provider for your external tenant.
ms.topic: how-to
ms.date: 04/17/2026
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done
ai-usage: ai-assisted
# Customer intent: As a developer, DevOps engineer, or IT admin, I want to add Microsoft account as an identity provider so customers can sign in with their existing accounts.
---

# Add Microsoft account (live.com) as an OpenID Connect identity provider

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

By setting up federation with Microsoft account (live.com) using OpenID Connect (OIDC) identity provider, you enable users to sign up and sign in to your applications using their existing Microsoft accounts (MSA).
After you add Microsoft account (live.com) as one of your user flow sign-in options, customers can sign up and sign in to your application by using their Microsoft account.

## Prerequisites

- An [external tenant](how-to-create-external-tenant-portal.md).
- A [sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md).
- A Microsoft account (live.com). If you don't already have one, sign up at <https://www.live.com/>.

> [!NOTE]
> This feature is available only for users who sign up with a Microsoft account (MSA). It isn’t available for [B2B guest users](/entra/external-id/user-properties) invited to the tenant.

## Create a Microsoft account application

To enable sign-in for users with a Microsoft account, you need to create an application in a Microsoft Entra ID tenant. The resource tenant for the application can be any Microsoft Entra ID tenant, like your workforce or external tenant.  

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **App registrations** then select **New registration**.
1. Name the application, for example *ContosoApp*.
1. Under **Supported account types**, select *Accounts in any organizational directory (Any Microsoft Entra ID tenant - Multitenant) and personal Microsoft accounts (for example, Skype, Xbox)*.
1. Under **Redirect URI**, select **Web** and enter your populated redirect URI described in [Set up your OpenID Connect identity provider](/entra/external-id/customers/how-to-custom-oidc-federation-customers#set-up-your-openid-connect-identity-provider).
1. Select **Register**.

   When registration finishes, the Microsoft Entra admin center displays the app registration's **Overview** pane. You see the **Application (client) ID**. Record this value, as you need it later.

1. Under **Manage**, browse to **Certificates & secrets**, and then select **New client secret**.
1. Name the secret, for example *Key 1*, and then select **Add**.
1. Record the **Value** of the secret, as you need it later. Make sure you save the secret before leaving the page. Client secret values can't be viewed except immediately after creation.

### Configure optional claims

You can also configure optional claims to be provided for your application such as *family_name* and *given_name*.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 
1. Browse to **Entra ID** > **App registrations**.
1. Select your MSA application that you created earlier.
1. Under **Manage**, select **Token configuration**.
1. Select **Add optional claim**.
1. Select the token type you want to configure, such as *ID*.
1. Select the optional claims to add.
1. Select **Add**.

## Configure Microsoft account (live.com) as an OpenID Connect identity provider

Once you have configured your Microsoft account (live.com) as an application, you can proceed to set it up as an OIDC identity provider in your external tenant.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [External Identity Provider Administrator](~/identity/role-based-access-control/permissions-reference.md#external-identity-provider-administrator).
1. Browse to **Entra ID** > **External identities** > **All identity providers**.
1. Select the **Custom** tab, and then select **Add new** > **Open ID Connect**.

   :::image type="content" source="media/how-to-custom-oidc-federation-customers/add-new.jpg" alt-text="Screenshot of the All identity providers page showing the Custom tab and the Add new menu with Open ID Connect selected.":::

1. Enter the following details for your identity provider on the **Basics** tab:
      - **Display name**: Enter a name for your identity provider, for example *Microsoft account* This name is displayed to your users during the sign-in and sign-up flows. For example, *Sign in with Microsoft account* or *Sign up with your Microsoft account*.
      - **Well-known endpoint**: Enter the endpoint URI as `https://login.microsoftonline.com/consumers/v2.0/.well-known/openid-configuration`, which is the discovery URI of the common authority URL for Microsoft accounts.
      - **OpenID Issuer URI**: Enter the Issuer URI as `https://login.live.com`.
      - **Client ID** and **Client Secret**: Enter the **Application (client) ID** and **Value** of the client secret you created earlier.
      - **Client Authentication**: Select **client_secret** and add `openid profile email` to **Scope**.
      - **Response type**: Select **code**.
1. You can select **Next: Claims mapping** to configure [claims mapping](reference-oidc-claims-mapping-customers.md) or **Review + create** to add your identity provider.

   :::image type="content" source="media/how-to-microsoft-accounts-federation-customers/msa-setup.png" alt-text="Screenshot of the Basics tab for an Open ID Connect identity provider configured for Microsoft account, including endpoint, issuer, client ID, secret, and scope values.":::

## Add OIDC identity provider to a user flow

At this point, the MSA identity provider is set up in your external tenant, but it isn't yet available on sign-in pages. To add the OIDC identity provider to a user flow:

1. In your external tenant, browse to **Entra ID** > **External Identities** > **User flows**.
1. Select the user flow where you want to add the OIDC identity provider.
1. Under **Settings**, select **Identity providers**.
1. Under **Other Identity Providers**, select the identity provider you created, which is **Microsoft Account**.

   :::image type="content" source="media/how-to-microsoft-accounts-federation-customers/msa-idp-list.png" alt-text="Screenshot of the user flow Identity providers page with Microsoft Account selected under Other identity providers.":::

1. Select **Save**.

## Related content

- [Add a Microsoft Entra ID tenant as an OIDC identity provider](how-to-entra-id-federation-customers.md)
- [Add an Azure AD B2C tenant as an OIDC identity provider](how-to-b2c-federation-customers.md)
- [OIDC claims mapping](reference-oidc-claims-mapping-customers.md)
