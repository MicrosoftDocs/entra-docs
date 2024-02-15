---

title: Add Facebook as an identity provider
description: Federate with Facebook to enable external users (guests) to sign in to your Microsoft Entra apps with their own Facebook accounts.

 
ms.service: entra-external-id
ms.topic: how-to
ms.date: 01/23/2024

ms.author: mimart
author: msmimart
manager: celestedg
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done
ms.collection: M365-identity-device-management
#customer intent: As a B2B collaboration administrator, I want to add Facebook as an identity provider for self-service sign-up user flows, so that users can sign in to applications using their Facebook accounts.
---

# Add Facebook as an identity provider for External Identities

> [!TIP]
> This article describes adding Facebook as an identity provider for B2B collaboration. If your tenant is configured for customer identity and access management, see [Add Facebook as an identity provider](customers/how-to-facebook-federation-customers.md) for customers.

You can add Facebook to your self-service sign-up user flows so that users can sign in to your applications using their own Facebook accounts. To allow users to sign in using Facebook, you first need to [enable self-service sign-up](self-service-sign-up-user-flow.md) for your tenant. After you add Facebook as an identity provider, set up a user flow for the application and select Facebook as one of the sign-in options.

After you add Facebook as one of your application's sign-in options, on the **Sign in** page, a user can enter the email they use to sign in to Facebook, or they can select **Sign-in options** and choose **Sign in with Facebook**. In either case, they're redirected to the Facebook sign in page for authentication.

![Sign in options for facebook users](media/facebook-federation/sign-in-with-facebook-overview.png)

> [!NOTE]
> Users can only use their Facebook accounts to sign up through apps using self-service sign-up and user flows. Users cannot be invited and redeem their invitation using a Facebook account.

## Create an app in the Facebook developers console

To use a Facebook account as an [identity provider](identity-providers.md), you need to create an application in the Facebook developers console. If you don't already have a Facebook account, you can sign up at [https://www.facebook.com/](https://www.facebook.com).

> [!NOTE]  
> Use the following URLs in the steps 9 and 16.
> - For **Site URL** enter the address of your application, such as `https://contoso.com`.
> - For **Valid OAuth redirect URIs**, enter `https://login.microsoftonline.com/te/<tenant-id>/oauth2/authresp`. To find your tenant ID, sign in to the [Microsoft Entra admin center](https://entra.microsoft.com). Under **Identity**, select **Overview** and copy the **Tenant ID**.


1. Sign in to [Facebook for developers](https://developers.facebook.com/) with your Facebook account credentials.
2. If you haven't already done so, you need to register as a Facebook developer. To do this, select **Get Started** on the upper-right corner of the page, accept Facebook's policies, and complete the registration steps.
3. Select **My Apps** and then **Create App**.
1. **Select an app type** and then **Details**
1. **Add an app name** and a valid **App contact email**.
1. Select **Create app**. This might require you to accept Facebook platform policies and complete an online security check.
1. Select **Settings** > **Basic**.
1. Choose a **Category**, for example **Business and pages**. This value is required by Facebook, but not used for Microsoft Entra External ID.
1. At the bottom of the page, select **Add Platform**, and then select **Website**.
1. In **Site URL**, enter the appropriate URL (noted above).
1. In **Privacy Policy URL** at the top of the page, enter the URL for the page where you maintain privacy information for your application, for example `http://www.contoso.com`.
1. Select **Save changes**.
1. At the top of the page, copy the value of **App ID**.
1. At the top of the page, select **Show** and copy the value of **App secret**. You use both of them to configure Facebook as an identity provider in your tenant. **App secret** is an important security credential.
1. In the left menu select **Add Product** next to **Products**, and then select **Set up** under **Facebook Login**.
1. Under **Facebook Login** in the left, select **Settings**.
1. In **Valid OAuth redirect URIs**, enter the appropriate URL (noted above).
1. Select **Save changes** at the bottom of the page.
1. To make your Facebook application available to Microsoft Entra External ID, select the **App Mode** selector at the top of the page and turn it **Live** to make the Application public.
	
## Configure a Facebook account as an identity provider
Now you set the Facebook client ID and client secret, either by entering it in the Microsoft Entra admin center or by using PowerShell. You can test your Facebook configuration by signing up via a user flow on an app enabled for self-service sign-up.

### To configure Facebook federation in the Microsoft Entra admin center

[!INCLUDE [portal updates](~/includes/portal-update.md)]

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [External Identity Provider administrator](~/identity/role-based-access-control/permissions-reference.md#external-identity-provider-administrator).
1. Browse to **Identity** > **External Identities** > **All identity providers**, then select **Facebook**.
1. For the **Client ID**, enter the **App ID** of the Facebook application that you created earlier.
1. For the **Client secret**, enter the **App secret** that you recorded.

   :::image type="content" source="media/facebook-federation/add-social-identity-provider-page.png" alt-text="Screenshot showing the Add social identity provider page.":::

1. Select **Save**.
### To configure Facebook federation by using PowerShell

1. Install the latest version of the [Microsoft Graph PowerShell](/powershell/microsoftgraph/installation).
1. Run the following command:

   ```powershell
   Connect-MgGraph -Scopes "IdentityProvider.ReadWrite.All"
   ```

1. At the sign-in prompt, sign in with the managed Global Administrator account.  
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

   > [!NOTE]
   > Use the client ID and client secret from the app you created in the Facebook developer console. For more information, see the [New-MgIdentityProvider](/powershell/microsoftgraph/authentication-commands) article.

## How do I remove Facebook federation?
You can delete your Facebook federation setup. If you do so, any users who have signed up through user flows with their Facebook accounts will no longer be able to sign in. 

### To delete Facebook federation in the Microsoft Entra admin center: 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [External Identity Provider administrator](~/identity/role-based-access-control/permissions-reference.md#external-identity-provider-administrator).
1. Browse to **Identity** > **External Identities** > **All identity providers**.
1. Select the **Facebook** line, and then select **Delete**. 
1. Select **Yes** to confirm deletion.

### To delete Facebook federation by using PowerShell: 

1. Install the latest version of the [Microsoft Graph PowerShell](/powershell/microsoftgraph/installation).
1. Run the following command:

   ```powershell
   Connect-MgGraph -Scopes "IdentityProvider.ReadWrite.All"
   ```

1. In the sign-in prompt, sign in with the managed Global Administrator account.  
1. Enter the following command:

   ```powershell
   Remove-MgIdentityProvider -IdentityProviderBaseId "Facebook-OAUTH"
   ```

   > [!NOTE]
   > For more information, see [Remove-MgIdentityProvider](/powershell/module/microsoft.graph.identity.signins/remove-mgidentityprovider).

## Next steps

- [Add self-service sign-up to an app](self-service-sign-up-user-flow.md)
- [SAML/WS-Fed IdP federation](direct-federation.md)
- [Google federation](google-federation.md)
