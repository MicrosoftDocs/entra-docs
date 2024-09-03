---
title: Sign in users to a sample ASP.NET Core web application
description: Learn how to configure a sample ASP.NET Core web app to sign in and sign out users by using an external tenant.
 
author: cilwerner
manager: celestedg

ms.author: cwerner
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: sample
ms.date: 04/23/2024
ms.custom: developer, devx-track-dotnet
#Customer intent: As a dev, devops, I want to learn about how to configure a sample ASP.NET Core web app to sign in and sign out users with my external tenant
---

# Sign in users for a sample ASP.NET Core web app in an external tenant

This how-to guide uses a sample ASP.NET Core web application to show the fundamentals of modern authentication using the [Microsoft Authentication Library for .NET](https://github.com/AzureAD/microsoft-authentication-library-for-dotnet) and [Microsoft Identity Web](https://github.com/AzureAD/microsoft-identity-web/) for ASP.NET Core to handle authentication.

In this article, you'll register a web application in the Microsoft Entra admin center and create a sign in and sign out user flow. You'll associate your web application with the user flow, download and update a sample ASP.NET Core web application using your own external tenant details. Finally, you'll run and test the sample web application.

## Prerequisites

- Although any IDE that supports ASP.NET Core applications can be used, Visual Studio Code is used for this guide. It can be downloaded from the [Downloads](https://visualstudio.microsoft.com/downloads/) page.
- [.NET 7.0 SDK](https://dotnet.microsoft.com/download/dotnet).
- An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>.

## Register the web app

[!INCLUDE [active-directory-b2c-register-app](./includes/register-app/register-client-app-common.md)]

## Define the platform and URLs

[!INCLUDE [ciam-redirect-url-dotnet](./includes/register-app/add-platform-redirect-url-dotnet.md)]

## Enable implicit and hybrid flows

[!INCLUDE [ciam-enable-implicit-flow](./includes/register-app/enable-implicit-hybrid-flows.md)]

## Add app client secret

[!INCLUDE [ciam-add-client-secret](./includes/register-app/add-app-client-secret.md)]

## Grant admin consent

[!INCLUDE [ciam-grant-delegated-permissions](./includes/register-app/grant-api-permission-sign-in.md)]

## Create a user flow

[!INCLUDE [ciam-app-integration-add-user-flow](./includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)]

## Associate the web application with the user flow

[!INCLUDE [ciam-integration-add-user-flow](./includes/configure-user-flow/add-app-user-flow.md)]

## Clone or download sample web application

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-dotnet-tutorial.git
    ```

- [Download the .zip file](https://github.com/Azure-Samples/ms-identity-ciam-dotnet-tutorial/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters. 

## Configure the application

1. Navigate to the root folder of the sample you have downloaded and directory that contains the ASP.NET Core sample app:

    ```console
    cd 1-Authentication\1-sign-in-aspnet-core-mvc
    ```

1. Open the *appsettings.json* file.
1. In **Authority**, find `Enter_the_Tenant_Subdomain_Here` and replace it with the subdomain of your tenant. For example, if your tenant primary domain is *caseyjensen@onmicrosoft.com*, the value you should enter is *casyjensen*.
1. Find the `Enter_the_Application_Id_Here` value and replace it with the application ID (clientId) of the app you registered in the Microsoft Entra admin center.
1. Replace `Enter_the_Client_Secret_Here` with the client secret value you set up in [Add app client secret](#add-app-client-secret).

## Run the code sample

1. From your shell or command line, execute the following commands:

    ```console
    dotnet run
    ```

1. Open your web browser and navigate to `https://localhost:7274`.

1. Sign-in with an account registered to the external tenant.

1. Once signed in the display name is shown next to the **Sign out** button as shown in the following screenshot.

    :::image type="content" source="media/tutorial-web-app-dotnet-sign-in-sign-in-out/display-aspnet-welcome.png" alt-text="Screenshot of sign in into a ASP.NET Core web app.":::

1. To sign out from the application, select the **Sign out** button.

## See also

- [Use our multi-part tutorial series to build this ASP.NET web application from scratch](tutorial-web-app-dotnet-sign-in-prepare-app.md)
- [Enable password reset](how-to-enable-password-reset-customers.md)
- [Customize the default branding](how-to-customize-branding-customers.md)
- [Configure sign-in with Google](how-to-google-federation-customers.md)
- [Sign in users in your own ASP.NET Core web application by using an external tenant](tutorial-web-app-dotnet-sign-in-prepare-app.md)