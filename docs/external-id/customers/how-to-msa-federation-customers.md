---
title: Add MSA for customer sign-in
description: Learn how to add MSA as an identity provider for your external tenant.
author: csmulligan
manager: celestedg
ms.service: entra-external-id
ms.subservice: external
ms.topic: how-to
ms.date: 02/27/2025
ms.author: cmulligan
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done
#Customer intent: As a dev, devops, or it admin, I want to
---

# Add Microsoft account (live.com) as an OpenID Connect identity provider (preview)

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

<!--Update this section! START-->
By setting up federation with Microsoft account (live.com) using OpenID Connect (OIDC) identity provider, you enable users to sign up and sign in to your applications using their existing Microsoft accounts (MSA).
When you add live.com identity provider to your user flow's sign-in options, users can sign up and sign in to the registered applications defined in that user flow using their Microsoft accounts.

> [!TIP]
> [![Try it now](./media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=MSA)
>
> To try out this feature, go to the Woodgrove Groceries demo and start the “Microsoft personal account (live.com)” use case.

## Create a Microsoft account application

To enable sign-in for users with a Microsoft account in Microsoft Entra External ID, you need to create an application in a Microsoft Entra ID tenant. The resource tenant for the application can be any Microsoft Entra ID tenant, like your workforce or external tenant. For more information, see [Register an application with the Microsoft identity platform](/entra/identity-platform/quickstart-register-app). If you don't already have a Microsoft account, sign up at https://www.live.com/.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **App registrations** then select **New registration**.
1. Name the application, for example *ContosoApp*.
1. Under **Supported account types**, select _Personal Microsoft accounts only_.
1. Under **Redirect URI**, select **Web** and enter your populated redirect URI explained [here](/entra/external-id/customers/how-to-custom-oidc-federation-customers#set-up-your-openid-connect-identity-provider)
1. Select **Register**.

When registration finishes, the Microsoft Entra admin center displays the app registration's **Overview** pane. You see the **Application (client) ID**. Record this value, as you need it later.

1. Under **Manage** browse to **Certificate & secrets** then select **New client secret**.
1. Name the secret, for example *Key 1* and select **Add**.
1. Record the **Value** of the secret, as you need it later. Make sure to save the secret when created before leaving the page. Client secret values cannot be viewed, except for immediately after creation.

### Configure optional claims

You can also configure optional claims to be provided for your application

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 
1. Browse to **Identity** > **Applications** > **App registrations**.
1. Under **Manage**, select **Token configuration**.
1. Select your MSA application that you created earlier.
1. Select **Add optional claim**.
1. Select the token type you want to configure, such as *ID*.
1. Select the optional claims to add.
1. Select **Add**.

## Configure the Microsoft account (live.com) as an OpenID connect identity provider

After you configured Microsoft account (live.com) as an application, you can now configure it as an OpenID Connect identity provider in your Microsoft Entra External ID tenant.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [External Identity Provider Administrator](~/identity/role-based-access-control/permissions-reference.md#external-identity-provider-administrator).
1. Browse to **Identity** > **External Identities** > **All identity providers**.
1. Select the **Custom** tab, and then select **Add new** > **Open ID Connect**.

   :::image type="content" source="media/how-to-custom-oidc-federation-customers/add-new.jpg" alt-text="Screenshot of adding a new custom identity provider.":::

1.  Enter the following details for your identity provider on the **Basics** tab:

   - **Display name**: Enter a name for your identity provider, for example *Microsoft account* This name is displayed to your users during the sign-in and sign-up flows. For example, *Sign in with Microsoft account* or *Sign up with your Microsoft account*.
   - **Well-known endpoint**: Enter the endpoint URI as `https://login.microsoftonline.com/consumers/v2.0/.well-known/openid-configuration`, which is the discovery URI of the common authority URL for Microsoft accounts.
   - **OpenID Issuer URI**: Enter the Issuer URI as `https://login.live.com`.
   - **Client ID** and **Client Secret**: Enter the **Application (client) ID** and **Value** of the client secret you created earlier.
   - **Client Authentication**:  Select **client_secret** and add	`openid profile email` to **Scope**.
   - **Response type**: Select **code**.

   :::image type="content" source="how-to-msa-federation-customers\MSA setup.png" alt-text="Screenshot of the MSA provider setup.":::

1. You can select **Next: Claims mapping** to configure [claims mapping](reference-oidc-claims-mapping-customers.md) or **Review + create** to add your identity provider.

> [!NOTE]
> Microsoft recommends you do *not* use the [implicit grant flow](/entra/identity-platform/v2-oauth2-implicit-grant-flow#security-concerns-with-implicit-grant-flow) or the [ROPC flow](/entra/identity-platform/v2-oauth-ropc). Therefore, OpenID connect external identity provider configuration does not support these flows. The recommended way of supporting SPAs is [OAuth 2.0 Authorization code flow (with PKCE)](/entra/identity-platform/v2-oauth2-auth-code-flow#applications-that-support-the-auth-code-flow) which is supported by OIDC federation configuration.

## Add OIDC identity provider to a user flow

At this point, the Microsoft account identity provider has been set up in your Microsoft Entra ID, but it's not yet available in any of the sign-in pages. To add the OIDC identity provider to a user flow:

1. In your external tenant, browse to **Identity** > **External Identities** > **User flows**.
1. Select the user flow where you want to add the OIDC identity provider.
1. Under Settings, select **Identity providers.**
1. Under **Other Identity Providers**, select **Microsoft account identity provider**.

   :::image type="content" source="media/how-to-msa-federation-customers/MSA in the IdP list.png" alt-text="Screenshot of the MSA provider in the IdP list.":::

1. Select **Save**.

## Related content

- [Add an Azure AD B2C tenant as an OIDC identity provider (preview)](how-to-b2c-federation-customers.md)
- [OIDC claims mapping (preview)](reference-oidc-claims-mapping-customers.md)
