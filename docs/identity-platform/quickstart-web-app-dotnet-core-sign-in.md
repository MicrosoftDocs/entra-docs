---
title: "Quickstart: Sign in to a web app & call an API - ASP.NET Core"
description: Learn how an ASP.NET Core web app uses Microsoft.Identity.Web to implement Microsoft sign-in using OpenID Connect and call Microsoft Graph
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: "devx-track-csharp,  scenarios:getting-started, languages:aspnet-core"
ms.date: 01/18/2024
ms.reviewer: jmprieur
ms.service: identity-platform

ms.topic: quickstart
#Customer intent: As an application developer, I want to know how to write an ASP.NET Core web app that can sign in personal Microsoft accounts and work/school accounts from any Microsoft Entra instance,  then access their data in Microsoft Graph on their behalf.
---

# Quickstart: Sign in users and call the Microsoft Graph API from an ASP.NET Core web app

This quickstart uses a sample ASP.NET Core web app to show you how to sign in users by using the [authorization code flow](./v2-oauth2-auth-code-flow.md) and call the Microsoft Graph API. The sample uses [Microsoft Authentication Library for .NET](/entra/msal/dotnet/) and [Microsoft Identity Web](/entra/msal/dotnet/microsoft-identity-web/) to handle authentication.

## Prerequisites

* An Azure account with an active subscription. If you don't already have one, [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* A minimum requirement of [.NET 6.0 SDK](https://dotnet.microsoft.com/download/dotnet)
* [Visual Studio 2022](https://visualstudio.microsoft.com/vs/) or [Visual Studio Code](https://code.visualstudio.com/)

## Register the application and record identifiers

[!INCLUDE [Register a single-page application](./includes/register-app/web-app-common/register-application-web-app-common.md)]

## Add a platform redirect URI

[!INCLUDE [Add a platform redirect URI](./includes/register-app/web-app-common/add-platform-redirect-web-app-port-5001.md)]

## Clone or download the sample application

To obtain the sample application, you can either clone it from GitHub or download it as a *.zip* file.

* To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-docs-code-dotnet.git
    ```

* [Download the .zip file](https://github.com/Azure-Samples/ms-identity-docs-code-dotnet/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.

## Create and upload a self-signed certificate

1. Using your terminal, use the following commands to navigate to create a self-signed certificate in the project directory.

    ```console
    cd ms-identity-docs-code-dotnet\web-app-aspnet\
    dotnet dev-certs https -ep ./certificate.crt --trust
    ```

1. Return to the Microsoft Entra admin center, and under **Manage**, select **Certificates & secrets** > **Upload certificate**.
1. Select the **Certificates (0)** tab, then select **Upload certificate**.
1. An **Upload certificate** pane appears. Use the icon to navigate to the certificate file you created in the previous step, and select **Open**.
1. Enter a description for the certificate, for example *Certificate for aspnet-web-app*, and select **Add**.
1. Record the **Thumbprint** value for use in the next step.

## Configure the project

1. In your IDE, open the project folder, *ms-identity-docs-code-dotnet\web-app-aspnet*, containing the sample.
1. Open *appsettings.json* and replace the file contents with the following snippet;

    :::code language="json" source="~/../ms-identity-docs-code-dotnet/web-app-aspnet/appsettings.json" :::

    * `TenantId` - The identifier of the tenant where the application is registered. Replace the text in quotes with the `Directory (tenant) ID` that was recorded earlier from the overview page of the registered application.
    * `ClientId` - The identifier of the application, also referred to as the client. Replace the text in quotes with the `Application (client) ID` value that was recorded earlier from the overview page of the registered application.
    * `ClientCertificates` - A self-signed certificate is used for authentication in the application. Replace the text of the `CertificateThumbprint` with the thumbprint of the certificate that was previously recorded.

## Run the application and sign in

1. In your project directory, use the terminal to enter the following command;

    ```console
    dotnet run
    ```

1. Copy the `https` URL that appears in the terminal, for example, `https://localhost:5001`, and paste it into a browser. We recommend using a private or incognito browser session.
1. Follow the steps and enter the necessary details to sign in with your Microsoft account. You're requested to provide an email address so a one time passcode can be sent to you. Enter the code when prompted.
1. The application requests permission to maintain access to data you have given it access to, and to sign you in and read your profile. Select **Accept**.
1. The following screenshot appears, indicating that you have signed in to the application and have accessed your profile details from the Microsoft Graph API.

    :::image type="content" source="./media/common-web-app/dotnet-core/display-api-call-results-dotnet-core.png" alt-text="Screenshot depicting the results of the API call." lightbox="./media/common-web-app/dotnet-core/display-api-call-results-dotnet-core.png":::

## Sign-out from the application

1. Find the **Sign out** link in the top right corner of the page, and select it.
1. You're prompted to pick an account to sign out from. Select the account you used to sign in.
1. A message appears indicating that you signed out. You can now close the browser window.

## Related content

* Learn by building this ASP.NET web app with the series [Tutorial: Register an application with the Microsoft identity platform](./tutorial-web-app-dotnet-sign-in-users.md).
* [Quickstart: Protect an ASP.NET Core web API with the Microsoft identity platform](./quickstart-web-api-aspnet-core-protect-api.md).
* [Quickstart: Deploy an ASP.NET web app to Azure App Service](/azure/app-service/quickstart-dotnetcore?tabs=net70&pivots=development-environment-vs)
