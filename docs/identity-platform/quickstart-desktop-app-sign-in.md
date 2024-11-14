---
title: Quickstart - Sign in users in a sample Desktop app
description: Quickstart for configuring a sample Desktop app to sign in employees or customers with Microsoft identity platform.
services: identity-platform
author: henrymbuguakiarie
manager: mwongerapk
ms.service: identity-platform
ms.topic: quickstart
ms.date: 10/30/2024
ms.author: henrymbugua
zone_pivot_groups: entra-tenants

#Customer intent: As a developer, I want to configure a sample Deesktop app so that I can sign in my employees or customers by using Microsoft identity platform.
---

# Quickstart: Sign in users in a sample Desktop app

[!INCLUDE [select-tenant-type-statement](./includes/select-tenant-type-statement.md)]

::: zone pivot="workforce"

In this quickstart, you'll download and run a code sample that demonstrates how an application can sign in users and acquire an access token to call the Microsoft Graph API.

## Prerequisites

#### [Node.js Electron](#tab/node-js-workforce)

* [Node.js](https://nodejs.org/en/download/)
* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor

#### [Windows Presentation Foundation (WPF)](#tab/wpf-workforce)

* [Visual Studio](https://visualstudio.microsoft.com/vs/) with the [Universal Windows Platform development](/windows/apps/windows-app-sdk/set-up-your-development-environment) workload installed

---

## Register the web app

To register your application and add the app's registration information to your solution manually, follow these steps:

#### [Node.js Electron](#tab/node-js-workforce)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="./media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the tenant in which you want to register the application from the **Directories + subscriptions** menu.
1. Browse to **Identity** > **Applications** > **App registrations** and select **New registration**.
1. Enter a **Name** for your application, for example `msal-node-desktop`. Users of your app might see this name, and you can change it later.
1. Select **Register** to create the application.
1. Under **Manage**, select **Authentication**.
1. Select **Add a platform** > **Mobile and desktop applications**.
1. In the **Redirect URIs** section, enter `http://localhost`.
1. Select **Configure**.

#### [Windows Presentation Foundation (WPF)](#tab/wpf-workforce)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the tenant in which you want to register the application from the **Directories + subscriptions** menu.
1. Browse to **Identity** > **Applications** > **App registrations**, select **New registration**.
1. Enter a **Name** for your application, for example `Win-App-calling-MsGraph`. Users of your app might see this name, and you can change it later.
1. In the **Supported account types** section, select **Accounts in any organizational directory and personal Microsoft accounts (for example, Skype, Xbox, Outlook.com)**.
1. Select **Register** to create the application.
1. Under **Manage**, select **Authentication**.
1. Select **Add a platform** > **Mobile and desktop applications**.
1. In the **Redirect URIs** section, select `https://login.microsoftonline.com/common/oauth2/nativeclient` and in **Custom redirect URIs** add `ms-appx-web://microsoft.aad.brokerplugin/{client_id}` where `{client_id}` is the application (client) ID of your application (the same GUID that appears in the `msal{client_id}://auth` checkbox).
1. Select **Configure**.

---

## Download the sample project

#### [Node.js Electron](#tab/node-js-workforce)

[Download the code sample](https://github.com/azure-samples/ms-identity-javascript-nodejs-desktop/archive/main.zip)

#### [Windows Presentation Foundation (WPF)](#tab/wpf-workforce)

[Download the WPF sample application](https://github.com/Azure-Samples/active-directory-dotnet-desktop-msgraph-v2/archive/msal3x.zip)

[!INCLUDE [active-directory-develop-path-length-tip](includes/error-handling-and-tips/path-length-tip.md)]

---


## Configure the project

#### [Node.js Electron](#tab/node-js-workforce)

*Extract the project, open the *ms-identity-JavaScript-nodejs-desktop-main* folder, and then open *.authConfig.js* file. Replace the value as follows:

| Variable  |  Description | Example(s) |
|-----------|--------------|------------|
| `Enter_the_Cloud_Instance_Id_Here` | The Azure cloud instance in which your application is registered | `https://login.microsoftonline.com/` (include the trailing forward-slash)|
| `Enter_the_Tenant_Id_Here` | Tenant ID or Primary domain | `contoso.microsoft.com` or `aaaabbbb-0000-cccc-1111-dddd2222eeee` |
| `Enter_the_Application_Id_Here` | Client ID of the application you registered | `00001111-aaaa-2222-bbbb-3333cccc4444` |
| `Enter_the_Redirect_Uri_Here` | Redirect Uri of the application you registered | `msal00001111-aaaa-2222-bbbb-3333cccc4444://auth` |
| `Enter_the_Graph_Endpoint_Here` | The Microsoft Graph API cloud instance that your app will call | `https://graph.microsoft.com/`  (include the trailing forward-slash)|

Your file should look similar to below:

   ```javascript   
   const AAD_ENDPOINT_HOST = "https://login.microsoftonline.com/"; // include the trailing slash

   const msalConfig = {
       auth: {
           clientId: "00001111-aaaa-2222-bbbb-3333cccc4444",
           authority: `${AAD_ENDPOINT_HOST}/aaaabbbb-0000-cccc-1111-dddd2222eeee`,
       },
       system: {
           loggerOptions: {
               loggerCallback(loglevel, message, containsPii) {
                    console.log(message);
                },
                piiLoggingEnabled: false,
                logLevel: LogLevel.Verbose,
           }
       }
   }

   const GRAPH_ENDPOINT_HOST = "https://graph.microsoft.com/"; // include the trailing slash

   const protectedResources = {
        graphMe: {
            endpoint: `${GRAPH_ENDPOINT_HOST}v1.0/me`,
            scopes: ["User.Read"],
        }
   };

   module.exports = {
        msalConfig: msalConfig,
        protectedResources: protectedResources,
    };

   ```

#### [Windows Presentation Foundation (WPF)](#tab/wpf-workforce)

1. Extract the zip file to a local folder close to the root of the disk, for example, **C:\Azure-Samples**.
1. Open the project in Visual Studio.
1. Edit **App.Xaml.cs** and replace the values of the fields `ClientId` and `Tenant` with the following code:

   ```csharp
   private static string ClientId = "Enter_the_Application_Id_here";
   private static string Tenant = "Enter_the_Tenant_Info_Here";
   ```

Where:
- `Enter_the_Application_Id_here` - is the **Application (client) ID** for the application you registered.
   
    To find the value of **Application (client) ID**, go to the app's **Overview** page in the Microsoft Entra admin center.
- `Enter_the_Tenant_Info_Here` - is set to one of the following options:
  - If your application supports **Accounts in this organizational directory**, replace this value with the **Tenant Id** or **Tenant name** (for example, contoso.microsoft.com)
  - If your application supports **Accounts in any organizational directory**, replace this value with `organizations`
  - If your application supports **Accounts in any organizational directory and personal Microsoft accounts**, replace this value with `common`.

    To find the values of **Directory (tenant) ID** and **Supported account types**, go to the app's **Overview** page in the Microsoft Entra admin center.

---

## Run the application

#### [Node.js Electron](#tab/node-js-workforce)

1. You'll need to install the dependencies of this sample once:

    ```console
    cd ms-identity-javascript-nodejs-desktop-main
    npm install
    ```

1. Then, run the application via command prompt or console:

    ```console
    npm start
    ```

1. Select **Sign in** to start the sign-in process.

    The first time you sign in, you're prompted to provide your consent to allow the application to sign you in and access your profile. After you're signed in successfully, you'll be redirected back to the application.

#### [Windows Presentation Foundation (WPF)](#tab/wpf-workforce)

To build and run the sample application in Visual Studio, select the **Debug menu** > **Start Debugging**, or press the F5 key. Your application's MainWindow is displayed.

When the app's main window appears, select the Call Microsoft Graph API button. You'll be prompted to sign in using your Microsoft Entra account (work or school account) or Microsoft account (live.com, outlook.com) credentials.

If you're running the application for the first time, you'll be prompted to provide consent to allow the application to access your user profile and sign you in. After consenting to the requested permissions, the application displays that you've successfully logged in. You should see some basic token information and user data obtained from the call to the Microsoft Graph API.

---

## Next steps

#### [Node.js Electron](#tab/node-js-workforce)

To learn more about Electron desktop app development with MSAL Node, see the tutorial:

> [!div class="nextstepaction"]
> [Tutorial: Sign in users and call the Microsoft Graph API in an Electron desktop app](tutorial-v2-nodejs-desktop.md)

#### [Windows Presentation Foundation (WPF)](#tab/wpf-workforce)

Try out the Windows desktop tutorial for a complete step-by-step guide on building applications and new features, including a full explanation of this quickstart.

> [!div class="nextstepaction"]
> [Call Graph API tutorial](tutorial-v2-windows-desktop.md)

---


::: zone-end 

::: zone pivot="external"

#### [Node.js Electron](#tab/node-js-external)


#### [.NET MAUI)](#tab/wpfdotnet-maui-external)


#### [.NET MAUI) WPF](#tab/wpfdotnet-wpf-external)

---

::: zone-end 
