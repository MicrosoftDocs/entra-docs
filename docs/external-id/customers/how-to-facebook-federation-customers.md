---
title: Add Facebook for customer sign-in
description: Learn how to add Facebook as an identity provider for your external tenant, enabling customers to sign in to your applications using their Facebook accounts.
ms.author: cmulligan
author: csmulligan
manager: dougeby
ms.service: entra-external-id
ms.subservice: external
ms.topic: how-to
ms.date: 05/22/2025
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done, sfi-ga-nochange
#Customer intent: As a developer or IT admin, I want to add Facebook as an identity provider for my external tenant so that customers can sign in to my applications using their Facebook accounts.
---

# Add Facebook as an identity provider

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

By setting up federation with Facebook, you can allow customers to sign in to your applications with their own Facebook accounts. After you've added Facebook as one of your application's sign-in options, on the sign-in page, customers can sign-in to Microsoft Entra External ID with a Facebook account. (Learn more about [authentication methods and identity providers for customers](/entra/external-id/customers/concept-authentication-methods-customers).)

> [!TIP]
> [![Try it now](./media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=Social)
> 
> To try out this feature, go to the Woodgrove Groceries demo and start the “Sign-in with a social account” use case.

## Create a Facebook application

To enable sign-in for customers with a Facebook account, you need to create an application in [Facebook App Dashboard](https://developers.facebook.com/). For more information, see [App Development](https://developers.facebook.com/docs/development).

If you don't already have a Facebook account, sign up at [https://www.facebook.com](https://www.facebook.com). After you sign-up or sign-in with your Facebook account, start the [Facebook developer account registration process](https://developers.facebook.com/async/registration). For more information, see [Register as a Facebook Developer](https://developers.facebook.com/docs/development/register).

> [!NOTE]
> This document was created using the state of the provider’s developer page at the time of creation, and changes may occur.

1. Sign in to [Facebook for developers](https://developers.facebook.com/apps) with your Facebook developer account credentials.
1. If you haven't already done so, register as a Facebook developer: Select **Get Started** in the upper-right corner of the page, accept Facebook's policies, and complete the registration steps.
1. Select **Create App**. This step may require you to accept Facebook platform policies and complete an online security check.
1. Select **Authenticate and request data from users with Facebook Login** > **Next**.
1. Under **Are you building a game?** select **No, I'm not building a game** and then **Next**.
1. Add an app name and a valid app contact email. You can also add a business account if you have one.
1. Select **Create app**.
1. Once your app is created, go to the Dashboard.
1. Select **App settings** > **Basic**.
    1. Copy the value of **App ID**. Then select **Show** and copy the value of **App Secret**. You use both of these values to configure Facebook as an identity provider in your tenant. **App Secret** is an important security credential.
    1. Enter a URL for the **Privacy Policy URL**, for example `https://www.contoso.com/privacy`. The policy URL is a page you maintain to provide privacy information for your application.
    1. Enter a URL for the **Terms of Service URL**, for example `https://www.contoso.com/tos`. The policy URL is a page you maintain to provide terms and conditions for your application.
    1. Enter a URL for the **User Data Deletion**, for example `https://www.contoso.com/delete_my_data`. The User Data Deletion URL is a page you maintain to provide away for users to request that their data be deleted.
    1. Choose a **Category**, for example **Business and pages**. Facebook requires this value, but it's not used by Microsoft Entra ID.
1. At the bottom of the page, select **Add platform**, select **Website**, and then select **Next**.
1. In **Site URL**, enter the address of your website, for example `https://contoso.com`. 
1. Select **Save changes**. 
1. Select **Use cases** on the left and select **Customize** next to **Authentication and account creation**.
1. Select **Go to settings** under **Facebook Login**.
1.  In **Valid OAuth Redirect URIs**, enter the following URIs, replacing `<tenant-ID>` with your **external tenant ID** and `<tenant-name>` with your **external tenant name**:

- `https://login.microsoftonline.com/te/<tenant-ID>/oauth2/authresp`
- `https://login.microsoftonline.com/te/<tenant-name>.onmicrosoft.com/oauth2/authresp`
- `https://<tenant-name>.ciamlogin.com/<tenant-ID>/federation/oidc/www.facebook.com`
- `https://<tenant-name>.ciamlogin.com/<tenant-name>.onmicrosoft.com/federation/oidc/www.facebook.com`
- `https://<tenant-name>.ciamlogin.com/<tenant-ID>/federation/oauth2`
- `https://<tenant-name>.ciamlogin.com/<tenant-name>.onmicrosoft.com/federation/oauth2`

16. Select **Save changes** and select **Apps** at the top of the page and select the app you've just created.
17. Select **Use cases** on the left hand side of the page and select **Customize** next to **Authentication and account creation**.
18. Add email permissions by selecting **Add** under **Permissions**.
19. Select **Go back** at the top of the page.
20. At this point, only Facebook application owners can sign in. Because you registered the app, you can sign in with your Facebook account. To make your Facebook application available to your users, from the menu, select **Go live**. Follow all of the steps listed to complete all requirements. You'll likely need to complete data handling questions and the business verification to verify your identity as a business entity or organization. For more information, see [Meta App Development](https://developers.facebook.com/docs/development/release).

## Configure Facebook federation in Microsoft Entra External ID

After you create the Facebook application, in this step you set the Facebook client ID and client secret in Microsoft Entra ID. You can use the Microsoft Entra admin center or PowerShell to do so. To configure Facebook federation in the Microsoft Entra admin center, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **External Identities** > **All identity providers**.
2. On the **Built-in** tab, next to **Facebook**, select **Configure**.

   <!-- ![Screenshot that shows how to add Facebook identity provider in Microsoft Entra ID.](./media/sign-in-with-facebook/configure-facebook-idp.png)-->

1. Enter a **Name**. For example, *Facebook*.
1. For the **Client ID**, enter the App ID of the Facebook application that you created earlier.
1. For the **Client secret**, enter the App Secret that you recorded.
1. Select **Save**.

To configure Facebook federation by using PowerShell, follow these steps:

1. Install the latest version of the [Microsoft Graph PowerShell](/powershell/microsoftgraph/installation).
1. Run the following command:

   ```powershell
   Connect-MgGraph -Scopes "IdentityProvider.ReadWrite.All"
   ```

1. At the sign-in prompt, sign in as at least an [External Identity Provider Administrator](~/identity/role-based-access-control/permissions-reference.md#external-identity-provider-administrator). 
1. Run the following commands:

   ```powershell
   $params = @{
      "@odata.type" = "microsoft.graph.socialIdentityProvider"
      displayName = "Facebook"
      identityProviderType = "Facebook"
      clientId = "[Client ID]"
      clientSecret = "[Client secret]"
   }

   New-MgIdentityProvider -BodyParameter $params
   ```
    
Use the client ID and client secret from the app you created in [Create a Facebook application](#create-a-facebook-application) step.

## Add Facebook identity provider to a user flow

At this point, the Facebook identity provider has been set up in your external tenant, but it's not yet available in any of the sign-in pages. To add the Facebook identity provider to a user flow:

1. Browse to **Entra ID** > **External Identities** > **User flows**.
1. Select the user flow where you want to add the Facebook identity provider.
1. Under Settings, select **Identity providers**
1. Under **Other Identity Providers**, select **Facebook**.

   <!-- ![Screenshot that shows how to add Facebook identity provider a user flow.](./media/sign-in-with-facebook/add-facebook-to-user-flow.png)-->

1. At the top of the pane, select **Save**.

## Related content

- [Add Google as an identity provider](how-to-google-federation-customers.md)
- [Add Apple as an identity provider](how-to-apple-federation-customers.md)
- [Add OpenID Connect as an external identity provider](how-to-custom-oidc-federation-customers.md)
