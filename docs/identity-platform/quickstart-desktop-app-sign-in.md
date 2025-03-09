---
title: Quickstart - Sign in users in a sample Desktop app
description: Quickstart for configuring a sample Desktop app to sign in employees or customers with Microsoft identity platform.
author: henrymbuguakiarie
manager: mwongerapk
ms.service: identity-platform
ms.topic: quickstart
ms.date: 11/19/2024
ms.author: henrymbugua
zone_pivot_groups: entra-tenants

#Customer intent: As a developer, I want to configure a sample Deesktop app so that I can sign in my employees or customers by using Microsoft identity platform.
---

# Quickstart: Sign in users in a sample Desktop app

In this quickstart, you’ll use a sample application to learn how to add authentication to a desktop application. The sample application enables users to sign in and sign out and uses the Microsoft Authentication Library (MSAL) to handle authentication.

[!INCLUDE [select-tenant-type-statement](./includes/select-tenant-type-statement.md)]

::: zone pivot="workforce"

## Prerequisites

#### [Node.js Electron](#tab/node-js-workforce)

* [Node.js](https://nodejs.org/en/download/package-manager)
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

To build and run the sample application in Visual Studio, follow these steps:

1. Select the **Debug menu** > **Start Debugging**, or press the F5 key. Your application's **MainWindow** is displayed.
1. Select the **Call Microsoft Graph API** button.
1. Sign in using your Microsoft Entra account (work or school account) or Microsoft account (live.com, outlook.com) credentials.
1. If you're running the application for the first time, you'll be prompted to provide consent to allow the application to access your user profile and sign you in. After consenting to the requested permissions, the application displays that you've successfully logged in.

You should see some basic token information and user data obtained from the call to the Microsoft Graph API.

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

## Prerequisites

#### [Node.js Electron](#tab/node-js-external)

- [Node.js](https://nodejs.org)
- [Visual Studio Code](https://code.visualstudio.com/download) or another code editor
- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code
  - [Create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center

#### [.NET (MAUI)](#tab/wpfdotnet-maui-external)

- [.NET 7.0 SDK](https://dotnet.microsoft.com/download/dotnet/7.0)
- [Visual Studio 2022](https://aka.ms/vsdownloads) with the MAUI workload installed:
  - [Instructions for Windows](/dotnet/maui/get-started/installation?tabs=vswin)
  - [Instructions for macOS](/dotnet/maui/get-started/installation?tabs=vsmac)
- An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>

#### [.NET (MAUI) WPF](#tab/wpfdotnet-wpf-external)

* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor
* [.NET 7.0](https://dotnet.microsoft.com/download/dotnet/7.0) or later
- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code
  - [Create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center

---

## Register the desktop app

[!INCLUDE [active-directory-b2c-register-app](../external-id/customers/includes/register-app/register-client-app-common.md)]


## Specify your app platform

#### [Node.js Electron](#tab/node-js-external)

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](../external-id/customers/includes/register-app/add-platform-redirect-url-electron.md)]

#### [.NET (MAUI)](#tab/wpfdotnet-maui-external)

[!INCLUDE [active-directory-b2c-app-integration-add-platform](../external-id/customers/includes/register-app/add-platform-redirect-url-dotnet-maui.md)]

#### [.NET (MAUI) WPF](#tab/wpfdotnet-wpf-external)

[!INCLUDE [active-directory-b2c-wpf-app-platform](../external-id/customers/includes/register-app/add-platform-redirect-url-wpf.md)]  

---

## Grant admin consent

[!INCLUDE [active-directory-b2c-grant-delegated-permissions](../external-id/customers/includes/register-app/grant-api-permission-sign-in.md)]

## Create a user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](../external-id/customers/includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)] 


## Associate the desktop application with the user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](../external-id/customers/includes/configure-user-flow/add-app-user-flow.md)]

## Download the sample project

#### [Node.js Electron](#tab/node-js-external)

To get the desktop app sample code, [download the .zip file](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial/archive/refs/heads/main.zip) or clone the sample web application from GitHub by running the following command:

```powershell
git clone https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial.git
```

If you choose to download the `.zip` file, extract the sample app file to a folder where the total length of the path is 260 or fewer characters.

### Install project dependencies

1. Open a console window, and change to the directory that contains the Electron sample app:

    ```powershell
    cd 1-Authentication\3-sign-in-electron\App
    ```
 
1. Run the following commands to install app dependencies:

    ```powershell
    npm install && npm update
    ```

#### [.NET (MAUI)](#tab/wpfdotnet-maui-external)

To get the .NET MAUI desktop application sample code, [download the .zip file](https://github.com/Azure-Samples/ms-identity-ciam-dotnet-tutorial/archive/refs/heads/main.zip) or clone the sample .NET MAUI desktop application from GitHub by running the following command:

```bash
git clone https://github.com/Azure-Samples/ms-identity-ciam-dotnet-tutorial.git
```

#### [.NET (MAUI) WPF](#tab/wpfdotnet-wpf-external)

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-dotnet-tutorial.git
    ```

- [Download the .zip file](https://github.com/Azure-Samples/ms-identity-ciam-dotnet-tutorial/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.

---

## Configure the sample web app

#### [Node.js Electron](#tab/node-js-external)

1. In your code editor, open `App\authConfig.js` file.

1. Find the placeholder:
 
    1. `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the app you registered earlier.

    1. `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).

#### [.NET (MAUI)](#tab/wpfdotnet-maui-external)

1. In Visual Studio, open *ms-identity-ciam-dotnet-tutorial-main/1-Authentication/2-sign-in-maui/appsettings.json* file.
1. Find the placeholder:
    1. `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).
   1. `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the app you registered earlier.

#### [.NET (MAUI) WPF](#tab/wpfdotnet-wpf-external)

1. Open the project in your IDE (like Visual Studio or Visual Studio Code) to configure the code.

1. In your code editor, open the *appsettings.json* file in the **ms-identity-ciam-dotnet-tutorial** > **1-Authentication** > **5-sign-in-dotnet-wpf** folder.

1. Replace `Enter_the_Application_Id_Here` with the Application (client) ID of the app you registered earlier.
 
1. Replace `Enter_the_Tenant_Subdomain_Here` with the Directory (tenant) subdomain. For example, if your primary domain is *contoso.onmicrosoft.com*, replace `Enter_the_Tenant_Subdomain_Here` with *contoso*. If you don't have your primary domain, learn how to [read tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).

---

## Run and test the sample web app

#### [Node.js Electron](#tab/node-js-external)

You can now test the sample Electron desktop app. After you run the app, the desktop app window appears automatically:

1. In your terminal, run the following command:

    ```powershell
    npm start
    ```

    :::image type="content" source="media/how-to-desktop-app-electron-sample-sign-in/desktop-app-electron-sign-in.png" alt-text="Screenshot of sign in into an electron desktop app.":::

1. On the desktop window that appears, select the **Sign In** or **Sign up** button. A browser window opens, and you're prompted to sign in.

1. On the browser sign-in page, type your **Email address**, select **Next**, type your **Password**, then select **Sign in**. If you don't have an account, select **No account? Create one** link, which starts the sign-up flow.

1. If you choose the sign-up option, after filling in your email, one-time passcode, new password and more account details, you complete the whole sign-up flow. You see a page similar to the following screenshot. You see a similar page if you choose the sign-in option. The page displays token ID claims.

    :::image type="content" source="media/how-to-desktop-app-electron-sample-sign-in/desktop-app-electron-view-claims.png" alt-text="Screenshot of view token claims in an electron desktop app.":::

#### [.NET (MAUI)](#tab/wpfdotnet-maui-external)

.NET MAUI apps are designed to run on multiple operating systems and devices. You'll need to select which target you want to test and debug your app with.

Set the **Debug Target** in the Visual Studio toolbar to the device you want to debug and test with. The following steps demonstrate setting the **Debug Target** to *Windows*:

1. Select **Debug Target** drop-down.
1. Select **Framework** 
1. Select **net7.0-windows...**

Run the app by pressing *F5* or select the *play button* at the top of Visual Studio.

1. You can now test the sample .NET MAUI desktop application. After you run the application, the desktop application window appears automatically:

   :::image type="content" source="media/how-to-desktop-app-maui-sample-sign-in/maui-desktop-sign-in-page.jpg" alt-text="Screenshot of the sign-in button in the desktop application":::

1. On the desktop window that appears, select the **Sign In** button. A browser window opens, and you're prompted to sign in.

   :::image type="content" source="media/how-to-desktop-app-maui-sample-sign-in/maui-desktop-sign-in-prompt.jpg" alt-text="Screenshot of user prompt to enter credential in desktop application.":::

   During the sign in process, you're prompted to grant various permissions (to allow the application to access your data). Upon successful sign in and consent, the application screen displays the main page.

   :::image type="content" source="media/how-to-desktop-app-maui-sample-sign-in/maui-desktop-after-sign-in.png" alt-text="Screenshot of the main page in the desktop application after signing in.":::


#### [.NET (MAUI) WPF](#tab/wpfdotnet-wpf-external)

1. Open a console window, and change to the directory that contains the WPF desktop sample app:

    ```console
    cd 1-Authentication\5-sign-in-dotnet-wpf
    ```

1. In your terminal, run the app by running the following command:

    ```console
    dotnet run
    ```

1. After you launch the sample, you should see a window with a **Sign-In** button. Select the **Sign-In** button.

    :::image type="content" source="./media/sample-wpf-dotnet-sign-in/wpf-sign-in-screen.png" alt-text="Screenshot of sign-in screen for a WPF desktop application.":::

1. On the sign-in page, enter your account email address. If you don't have an account, select **No account? Create one**, which starts the sign-up flow. Follow through this flow to create a new account and sign in.
1. Once you sign in, you'll see a screen displaying successful sign-in and basic information about your user account stored in the retrieved token. The basic information is displayed in the *Token Info* section of the sign-in screen

---

## Related content

#### [Node.js Electron](#tab/node-js-external)

- [Enable password reset](../external-id/customers/how-to-enable-password-reset-customers.md).
- [Customize the default branding](../external-id/customers/how-to-customize-branding-customers.md).
- [Explore the Electron desktop app sample code](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial/tree/main/1-Authentication/3-sign-in-electron#about-the-code).

#### [.NET (MAUI)](#tab/wpfdotnet-maui-external)

- [Tutorial: Create a .NET MAUI app](../external-id/customers/tutorial-desktop-app-maui-sign-in-prepare-app.md).
- [Enable password reset](../external-id/customers/how-to-enable-password-reset-customers.md).
- [Customize the default branding](../external-id/customers/how-to-customize-branding-customers.md).

#### [.NET (MAUI) WPF](#tab/wpfdotnet-wpf-external)

- [Tutorial: Authenticate users to your WPF desktop application](../external-id/customers/tutorial-desktop-wpf-dotnet-sign-in-build-app.md)
- [Enable password reset](../external-id/customers/how-to-enable-password-reset-customers.md).
- [Customize the default branding](../external-id/customers/how-to-customize-branding-customers.md).

---

::: zone-end 
