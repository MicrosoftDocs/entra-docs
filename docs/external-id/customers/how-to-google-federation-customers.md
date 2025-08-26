---
title: Add Google as an identity provider
description: Learn how to add Google as an identity provider for your external tenant.
ms.author: cmulligan
author: csmulligan
manager: dougeby
ms.service: entra-external-id
ms.subservice: external
ms.topic: how-to
ms.date: 03/06/2025
ms.custom: it-pro, has-azure-ad-ps-ref, sfi-ga-nochange
#Customer intent: As a dev, devops, or it admin, I want to
---

# Add Google as an identity provider

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

By setting up federation with Google, you allow customers to sign in to your applications with their own Google accounts. After you add Google as one of your user flow's sign-in options, customers can sign up and sign in to your application with a Google account. (Learn more about [authentication methods and identity providers for customers](concept-authentication-methods-customers.md).)

> [!TIP]
> [![Try it now](./media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=Social)
> 
> To try out this feature, go to the Woodgrove Groceries demo and start the “Sign-in with a social account” use case.

## Prerequisites

- An [external tenant](how-to-create-external-tenant-portal.md).
- A [sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md).

## Create a Google application

To enable sign-in for customers with a Google account, you need to create an application in [Google Developers Console](https://console.developers.google.com/). For more information, see [Setting up OAuth 2.0](https://support.google.com/googleapi/answer/6158849). If you don't already have a Google account, you can sign up at [`https://accounts.google.com/signup`](https://accounts.google.com/signup).

1. Sign in to the [Google Developers Console](https://console.developers.google.com/) with your Google account credentials.
1. Accept the terms of service if you're prompted to do so.
1. In the upper-left corner of the page, select the project list, and then select **New Project**.
1. Enter a **Project Name**, select **Create**.
1. Make sure you're using the new project by selecting the project drop-down in the top-left of the screen. Select your project by name, then select **Open**.
1. Under the **Quick access**, or in the left menu, select **APIs & services** and then **OAuth consent screen**.
1. For the **User Type**, select **External** and then select **Create**.
1. On the **OAuth consent screen**, under **App information**
   1. Enter a **Name** for your application.
   1. Select a **User support email** address.
1. Under the **Authorized domains** section, select **Add domain**, and then add `ciamlogin.com` and `microsoftonline.com`.
1. In the **Developer contact information** section, enter comma separated emails for Google to notify you about any changes to your project.
1. Select **Save and Continue**.
1. From the left menu, select **Credentials**
1. Select **Create credentials**, and then **OAuth client ID**.
1. Under **Application type**, select **Web application**.
   1. Enter a suitable **Name** for your application, such as "Microsoft Entra External ID."
   1. In **Valid OAuth redirect URIs**, enter the following URIs. Replace `<tenant-ID>` with your customer Directory (tenant) ID and `<tenant-subdomain>` with your customer Directory (tenant) subdomain. If you don't have your tenant name, [learn how to read your tenant details](how-to-create-external-tenant-portal.md#get-the-external-tenant-details).  
    - `https://login.microsoftonline.com`
    - `https://login.microsoftonline.com/te/<tenant-ID>/oauth2/authresp`
    - `https://login.microsoftonline.com/te/<tenant-subdomain>.onmicrosoft.com/oauth2/authresp`
    - `https://<tenant-ID>.ciamlogin.com/<tenant-ID>/federation/oidc/accounts.google.com`
    - `https://<tenant-ID>.ciamlogin.com/<tenant-subdomain>.onmicrosoft.com/federation/oidc/accounts.google.com`
    - `https://<tenant-subdomain>.ciamlogin.com/<tenant-ID>/federation/oauth2`
    - `https://<tenant-subdomain>.ciamlogin.com/<tenant-subdomain>.onmicrosoft.com/federation/oauth2`

1. Select **Create**.
1. Record the values of **Client ID** and **Client secret**. You need both values to configure Google as an identity provider in your tenant.

> [!NOTE]
> In some cases, your app might require verification by Google (for example, if you update the application logo). For more information, check out the [Google's verification status guid](https://support.google.com/cloud/answer/10311615#verification-status).

<a name='configure-google-federation-in-azure-ad-for-customers'></a>

## Configure Google federation in Microsoft Entra External ID

After you create the Google application, in this step you set the Google client ID and client secret in Microsoft Entra ID. You can use the Microsoft Entra admin center or PowerShell to do so. To configure Google federation in the Microsoft Entra admin center, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com). 
1. Browse to **Entra ID** > **External Identities** > **All identity providers**.
1. On the **Built-in** tab, next to **Google**, select **Configure**.

   <!-- ![Screenshot that shows how to add Google identity provider in Microsoft Entra ID.](./media/sign-in-with-google/configure-google-idp.png)-->

1. Enter a **Name**. For example, *Google*.
1. For the **Client ID**, enter the Client ID of the Google application that you created earlier.
1. For the **Client secret**, enter the Client Secret that you recorded.
1. Select **Save**.

To configure Google federation by using PowerShell, follow these steps:

1. Install the latest version of the [Microsoft Graph PowerShell for Graph module](/powershell/microsoftgraph/installation).
1. Run the following command: `Connect-MgGraph`
1. At the sign-in prompt, sign in as at least an [External Identity Provider Administrator](~/identity/role-based-access-control/permissions-reference.md#external-identity-provider-administrator).
1. Run the following command:

   ```powershell
   Import-Module Microsoft.Graph.Identity.SignIns
   $params = @{
   "@odata.type" = "microsoft.graph.socialIdentityProvider"
   displayName = "Login with Google"
   identityProviderType = "Google"
   clientId = "00001111-aaaa-2222-bbbb-3333cccc4444"
   clientSecret = "000000000000"
   }
   New-MgIdentityProvider -BodyParameter $params
   ```

Use the client ID and client secret from the app you created in [Create a Google application](#create-a-google-application) step.


## Add Google identity provider to a user flow

At this point, the Google identity provider has been set up in your Microsoft Entra ID, but it's not yet available in any of the sign-in pages. To add the Google identity provider to a user flow:

1. In your external tenant, browse to **Entra ID** > **External Identities** > **User flows**.
1. Select the user flow where you want to add the Google identity provider.

1. Under Settings, select **Identity providers.**

1. Under **Other Identity Providers**, select **Google**.

   <!-- ![Screenshot that shows how to add Google identity provider a user flow.](./media/sign-in-with-google/add-google-idp-to-user-flow.png)-->

1. Select **Save**.

## Related content

- [Add Facebook as an identity provider](how-to-facebook-federation-customers.md)
- [Add Apple as an identity provider](how-to-apple-federation-customers.md)
- [Add OpenID Connect as an external identity provider](how-to-custom-oidc-federation-customers.md)