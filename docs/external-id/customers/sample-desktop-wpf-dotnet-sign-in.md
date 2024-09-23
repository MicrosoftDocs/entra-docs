---
title: Sign in users in a sample WPF desktop application 
description: Learn how to configure a sample WPF desktop to sign in and sign out users.

author: SHERMANOUKO
manager: mwongerapk

ms.author: shermanouko
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: sample
ms.date: 07/26/2023
ms.custom: developer, devx-track-dotnet
#Customer intent: As a dev, devops, I want to learn about how to configure a sample WPF desktop app to sign in and sign out users with my external tenant.
---

# Sign in users in a sample WPF desktop application 

This guide uses a sample Windows Presentation Foundation (WPF) application to show you how to add authentication to a WPF desktop application. The sample application enables users to sign in and sign out. The sample desktop application uses [Microsoft Authentication Library for .NET](https://github.com/AzureAD/microsoft-authentication-library-for-dotnet) for .NET to handle authentication.

## Prerequisites

* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.
* [.NET 7.0](https://dotnet.microsoft.com/download/dotnet/7.0) or later. 
- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.

## Register the desktop app

[!INCLUDE [active-directory-b2c-register-app](./includes/register-app/register-client-app-common.md)]

## Specify your app platform

[!INCLUDE [active-directory-b2c-wpf-app-platform](./includes/register-app/add-platform-redirect-url-wpf.md)]  

## Grant admin consent

[!INCLUDE [active-directory-b2c-grant-delegated-permissions](./includes/register-app/grant-api-permission-sign-in.md)] 

## Create a user flow 

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)] 

## Associate the WPF application with the user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/add-app-user-flow.md)]

## Clone or download sample WPF application

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-dotnet-tutorial.git
    ```

- [Download the .zip file](https://github.com/Azure-Samples/ms-identity-ciam-dotnet-tutorial/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.

## Configure the sample WPF app

1. Open the project in your IDE (like Visual Studio or Visual Studio Code) to configure the code.

1. In your code editor, open the *appsettings.json* file in the **ms-identity-ciam-dotnet-tutorial** > **1-Authentication** > **5-sign-in-dotnet-wpf** folder.

1. Replace `Enter_the_Application_Id_Here` with the Application (client) ID of the app you registered earlier.
 
1. Replace `Enter_the_Tenant_Subdomain_Here` with the Directory (tenant) subdomain. For example, if your primary domain is *contoso.onmicrosoft.com*, replace `Enter_the_Tenant_Subdomain_Here` with *contoso*. If you don't have your primary domain, learn how to [read tenant details](how-to-create-external-tenant-portal.md#get-the-external-tenant-details).

## Run and test sample WPF desktop app 

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
1. Once you sign in, you'll see a screen displaying successful sign-in and basic information about your user account stored in the retrieved token.

    :::image type="content" source="./media/sample-wpf-dotnet-sign-in/wpf-successful-sign-in.png" alt-text="Screenshot of successful sign-in for desktop WPF app.":::

### How it works

The main configuration for the public client application is handled within the *App.xaml.cs* file. A `PublicClientApplication` is initialized along with a cache for storing access tokens. The application will first check whether there's a cached token that can be used to sign the user in. If there's no cached token, the user will be prompted to provide credentials and sign-in. Upon signing-out, the cache is cleared of all accounts and all corresponding access tokens.

## Related content

- [Use our multi-part tutorial series to build this WPF desktop app from scratch](tutorial-desktop-wpf-dotnet-sign-in-prepare-tenant.md)
- [Enable password reset](how-to-enable-password-reset-customers.md).
- [Customize the default branding](how-to-customize-branding-customers.md).
- [Configure sign-in with Google](how-to-google-federation-customers.md).

