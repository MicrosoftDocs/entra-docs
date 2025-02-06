---
title: "Tutorial: Prepare a web application for authentication"
description: Learn how to create and prepare an ASP.NET Core application for authentication with the Microsoft identity platform, and secure it with a self-signed certificate.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.date: 01/18/2024
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an application developer, I want to use an IDE to set up an ASP.NET Core project, set up and upload a self signed certificate to the Microsoft Entra admin center and configure the application for authentication.
---

# Tutorial: Set up an ASP.NET Core web app that authenticates users

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

In this tutorial, you create an ASP.NET Core web app and configure it for authentication. This is part 1 of a series that demonstrates how to build an ASP.NET Core web application and prepare it for authentication using the Microsoft Entra admin center. This application can be used for employees in a workforce tenant or for customers using an external tenant

In this tutorial:

> [!div class="checklist"]
> * Create an ASP.NET Core web app
> * Create a self-signed certificate
> * Configure the settings for the application
> * Define platform settings and URLs

## Prerequisites

### [Workforce tenant](#tab/workforce-tenant)

* An Azure account with an active subscription. [Create an account for free](https://azure.microsoft.com/free/). This account must have permissions to manage applications. Use any of the following roles needed to register the application:
  * Application Administrator
  * Application Developer
  * Cloud Application Administrator
* A workforce tenant. Use your **Default Directory** or [set up a new tenant](./quickstart-create-new-tenant.md)
* An application registered in the Microsoft Entra admin center with the following setup.
  * **Name**: *NewWebAppLocal*
  * **Supported account types**: *Accounts in this organizational directory only*
  * **Redirect URI**: `https://localhost:7274/signin-oidc`
  * **Front channel logout URL**: `https://localhost:7274/signout-oidc`
* For development purposes, [add a client secret](./quickstart-register-app.md#add-credentials), and ensure you record the secret's **Value**. For security reasons, **do not use client secrets in a production setting**. Use a certificate or federated credentials instead.
* Although any integrated development environment (IDE) that supports ASP.NET Core applications can be used, this tutorial uses **Visual Studio Code**. You can download it [here](https://visualstudio.microsoft.com/downloads/).
* A minimum requirement of [.NET 8.0 SDK](https://dotnet.microsoft.com/download/dotnet).

### [External tenant](#tab/external-tenant)

* An Azure account with an active subscription. [Create an account for free](https://azure.microsoft.com/free/). This account must have permissions to manage applications. Use any of the following roles needed to register the application:
  * Application Administrator
  * Application Developer
  * Cloud Application Administrator
* An external tenant. If you don't have one, [create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
* A [self-service sign-up user flow](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md). You can use the same user flow for multiple applications.
* An application registered in the Microsoft Entra admin center,  Use the following setup for your app.
  * **Name**: *NewWebAppLocal*
  * **Supported account types**: *Accounts in this organizational directory only*
  * **Redirect URI**: `https://localhost:7274/signin-oidc`
  * **Front channel logout URL**: `https://localhost:7274/signout-oidc`
* For development purposes, [add a client secret](./quickstart-register-app.md#add-credentials), and ensure you record the secret's **Value**. For security reasons, **do not use client secrets in a production setting**. Use a certificate or federated credentials instead.
* To use your application in your external tenant; 
  * [Add your application to the user flow](../external-id/customers/how-to-user-flow-add-application.md).
  * [Grant admin consent for your tenant](./quickstart-register-app.md#grant-admin-consent-external-tenants-only).
* Although any integrated development environment (IDE) that supports ASP.NET Core applications can be used, this tutorial uses **Visual Studio Code**. You can download it [here](https://visualstudio.microsoft.com/downloads/).
* A minimum requirement of [.NET 8.0 SDK](https://dotnet.microsoft.com/download/dotnet).

---

## Create an ASP.NET Core project

In this section, you'll create an ASP.NET Core project in Visual Studio Code.

1. Open Visual Studio Code, select **File > Open Folder...**. Navigate to and select the location in which to create your project.
1. Create a new folder using the **New Folder...** icon in the **Explorer** pane. Provide a name similar to the one registered previously, for example, *NewWebAppLocal*.
1. Open a new terminal by selecting **Terminal > New Terminal**.
1. To create an ASP.NET Core web app template, run the following commands in the terminal to change into the directory and create the project:

    ```powershell
    cd NewWebAppLocal
    dotnet new webapp
    ```

## Install identity packages

Identity related NuGet packages must be installed in the project to authenticate users.

1. Enter the following commands to change into the *dotnetcore_webapp* folder and install the relevant NuGet package:

    ```powershell
    cd dotnetcore_webapp
    dotnet add package Microsoft.Identity.Web.UI
    ```

## Configure the application for authentication

The values recorded in your application setup are used to configure the application for authentication. The configuration file, *appsettings.json*, is used to store application settings used during run-time. As the application will also call into a web API, it must also contain a reference to it. 

1. In your IDE, open *appsettings.json* and replace the file contents with the following snippet. Replace the text in quotes with the values that were recorded earlier.
  
   :::code language="json" source="~/../ms-identity-docs-code-dotnet/web-app-aspnet/appsettings.json":::

    * `Instance` - The authentication endpoint. Check with the different available endpoints in [National clouds](authentication-national-cloud.md#azure-ad-authentication-endpoints).
    * `TenantId` - The identifier of the tenant where the application is registered. Replace the text in quotes with the **Directory (tenant) ID** value that was recorded earlier from the overview page of the registered application.
    * `ClientId` - The identifier of the application, also referred to as the client. Replace the text in quotes with the **Application (client) ID** value that was recorded earlier from the overview page of the registered application.
    * `ClientCertificates` - A self-signed certificate is used for authentication in the application. Replace the text of the `CertificateThumbprint` with the thumbprint of the certificate that was previously recorded.
    * `CallbackPath` - Is an identifier to help the server redirect a response to the appropriate application.
    * `DownstreamApi` - Is an identifier that defines an endpoint for accessing Microsoft Graph. The application URI is combined with the specified scope. To define the configuration for an application owned by the organization, the value of the `Scopes` attribute is slightly different.
1. Save changes to the file.
1. In the **Properties** folder, open the *launchSettings.json* file.
1. Find and record the `https` value `applicationURI` within *launchSettings.json*, for example `https://localhost:{port}`. This URL will be used when defining the **Redirect URI**. Do not use the `http` value. 


## Next step

> [!div class="nextstepaction"]
> [Configure an ASP.NET Core web app for authorization and authentication](./tutorial-web-app-dotnet-sign-in-users.md)
