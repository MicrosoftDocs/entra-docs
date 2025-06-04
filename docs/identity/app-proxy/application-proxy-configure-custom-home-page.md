---
title: Custom Home Page for Published Apps Using Microsoft Entra Application Proxy
description: Learn how to set a custom home page for published apps using Microsoft Entra application proxy to ensure users land on the correct page.
author: HULKsmashGithub
manager: 
ms.service: entra-id
ms.subservice: app-proxy
ms.topic: how-to
ms.date: 03/25/2025
ms.author: jayrusso
ms.reviewer: KaTabish
ms.custom: no-azure-ad-ps-ref, sfi-image-nochange
#customer intent: As an IT admin, I want to set a custom home page for published apps using Microsoft Entra application proxy so that users are directed to the correct page when accessing the app.
---
# Set a custom home page for published apps by using Microsoft Entra application proxy

This article discusses how to configure an app to direct a user to a custom home page. When you publish an app with application proxy, you set an internal URL, but sometimes that's not the page a user should see first. Set a custom home page so users get the correct page when accessing the app. Users see the custom home page you set, regardless of whether they access the app from Microsoft Entra My Apps or the Microsoft 365 app launcher.

When a user launches the app, they're directed to the root domain URL for the published app by default. The landing page is typically set as the home page URL. Use the Microsoft Entra PowerShell module to define a custom home page URL when you want an app user to land on a specific page within the app.

Here's one scenario that explains why your company would set a custom home page:

- Inside your corporate network, a user goes to `https://ExpenseApp/login/login.aspx` to sign in and access your app.
- Because you have other assets (such as images) that application proxy needs to access at the top level of the folder structure, you publish the app with `https://ExpenseApp` as the internal URL.
- The default external URL is `https://ExpenseApp-contoso.msappproxy.net`, which doesn't direct an external user to the sign-in page.
- You want to set `https://ExpenseApp-contoso.msappproxy.net/login/login.aspx` as the home page URL instead, so an external user sees the sign-in page first.

> [!NOTE]
> When you give users access to published apps, the apps appear in [My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510) and the [Office 365 app launcher](https://www.microsoft.com/microsoft-365/blog/2016/09/27/introducing-the-new-office-365-app-launcher/).

## Before you start

Before setting the home page URL, keep these requirements in mind:

- The path that you specify must be a subdomain path of the root domain URL.

  For example, if the root domain URL is `https://apps.contoso.com/app1/`, the home page URL you configure must start with `https://apps.contoso.com/app1/`.

- If you make a change to the published app, the change might reset the value of the home page URL. When you update the app in the future, you should recheck and, if necessary, update the home page URL.

You can set the home page URL either through the Microsoft Entra admin center or by using PowerShell.

## Change the home page in the Microsoft Entra admin center

To change the home page URL of your app through the Microsoft Entra admin center, follow these steps:
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator).
1. Select your username in the upper-right corner. Verify you're signed in to a directory that uses application proxy. If you need to change directories, select **Switch directory** and choose a directory that uses application proxy.
1. Browse to **Entra ID** > **App registrations**. The list of registered apps appears.
1. Choose your app from the list. A page showing the details of the registered app appears.
1. Under **Manage**, select **Branding**.
1. Update the **Home page URL**  with your new path.
1. Select **Save**.
:::image type="content" source="media/application-proxy-configure-custom-home-page/application-proxy-branding-properties.png" alt-text="Screenshot of the Branding & properties page for a registered app with the Home Page URL field highlighted." lightbox="media/application-proxy-configure-custom-home-page/application-proxy-branding-properties-expanded.png":::      

## Change the home page with PowerShell

To configure the home page of an app using PowerShell, you need to:

1. Install the  Microsoft Entra PowerShell module.
1. Find the ObjectId value of the app.
1. Update the app's home page URL using PowerShell commands.

### Install the Microsoft Entra PowerShell module

Before you define a custom home page URL by using PowerShell, install the Microsoft Entra PowerShell module. You can download the package from the [PowerShell Gallery](https://www.powershellgallery.com/packages/Microsoft.Graph.Entra), which uses the Graph API endpoint.

To install the package, follow these steps:

1. Open a standard PowerShell window, and then run the following command:

   ```powershell
   Install-Module -Name Microsoft.Graph
   ```

   If you're running the command without administrative rights, use the `-Scope CurrentUser` option.

1. During the installation, select **Y** to install two packages from Nuget.org. Both packages are required.

### Find the ObjectId of the app

You get the ObjectId of the app by searching for the app by its display name or home page.

1. In the same PowerShell window, import the Microsoft Entra module.

   ```powershell
   Import-Module -Name Microsoft.Graph
   ```

1. Sign in to the Microsoft Entra module as the tenant administrator.

   ```powershell
   Connect-Entra -Scopes 'Application.Read.All'
   ```

1. Find the app. This example uses PowerShell to find the ObjectId by searching for the app with a display name of `SharePoint`.

   ```powershell
   Get-EntraApplication | Where-Object { $_.DisplayName -eq "SharePoint" } | Format-List DisplayName, IdentifierUris, ObjectId
   ```

   You should get a result that's similar to the one shown here. Copy the ObjectId GUID to use in the next section.

   ```console
   DisplayName       : SharePoint
   IdentifierUris    : https://sharepoint-iddemo.msappproxy.net/
   ObjectId          : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
   ```

   Alternatively, you could just pull the list of all apps, search the list for the app with a specific display name or home page, and copy the app's ObjectId once the app is found.

   ```powershell
   Get-EntraApplication | Format-List DisplayName, IdentifierUris, ObjectId
   ```

### Update the home page URL

Create the home page URL, and update your app with that value. Continue using the same PowerShell window, or if you're using a new PowerShell window, sign in to the Microsoft Entra module again using `Connect-Entra`. Then follow these steps:

1. Create a variable to hold the `ObjectId` value you copied.

   ```powershell
   $objguid = "<object id>"
   ```

1. Confirm that you have the correct app by running the following command. The output should be identical to the output you saw in the previous section ([Find the ObjectId of the app](#find-the-objectid-of-the-app)).

   ```powershell
   Get-EntraApplication -ObjectId $objguid | Format-List DisplayName, IdentifierUris, ObjectId
   ```

1. Set the home page URL to the value that you want. The value must be a subdomain path of the published app. For example, if you change the home page URL from `https://sharepoint-iddemo.msappproxy.net/` to `https://sharepoint-iddemo.msappproxy.net/hybrid/`, app users go directly to the custom home page.

   Use this command:

   ```powershell
   Set-EntraApplication -ApplicationId $objguid -IdentifierUris 'https://sharepoint-iddemo.msappproxy.net/hybrid/'
   ```

1. To confirm that the change was successful, run the following command from step 2 again.

   ```powershell
   Get-EntraApplication -ObjectId $objguid | Format-List DisplayName, IdentifierUris, ObjectId
   ```

   For our example, the output should now appear as follows:

   ```console
   DisplayName       : SharePoint
   IdentifierUris    : https://sharepoint-iddemo.msappproxy.net/hybrid/
   ObjectId          : bbbbbbbb-1111-2222-3333-cccccccccccc
   ```

1. Restart the app to confirm that the home page appears as the first screen, as expected.

> [!NOTE]
> Any changes that you make to the app might reset the home page URL. If your home page URL resets, repeat the steps in this section to set it back.

## Next steps

- [Enable remote access to SharePoint with Microsoft Entra application proxy](./application-proxy-integrate-with-sharepoint-server.md)
- [Tutorial: Add an on-premises application for remote access through application proxy in Microsoft Entra ID](application-proxy-add-on-premises-application.md)
