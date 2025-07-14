---
title: "Tutorial: Prepare a web application for authentication"
description: Learn how to create and prepare an ASP.NET Core application for authentication with the Microsoft identity platform, and secure it with a self-signed certificate.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.date: 04/15/2025
ms.service: identity-platform
ms.topic: tutorial
ms.custom: sfi-image-nochange
#Customer intent: As an application developer, I want to use an IDE to set up an ASP.NET Core project, set up and upload a self signed certificate to the Microsoft Entra admin center and configure the application for authentication.
---

# Tutorial: Set up an ASP.NET Core web app that authenticates users

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

In this tutorial, you create an ASP.NET Core web app and configure it for authentication. This is part 1 of a series that demonstrates how to build an ASP.NET Core web application and prepare it for authentication using the Microsoft Entra admin center. This application can be used for employees in a workforce tenant or for customers using an external tenant

In this tutorial, you:

> [!div class="checklist"]
> * Create an ASP.NET Core web app
> * Create a self-signed certificate
> * Configure the settings for the application
> * Define platform settings and URLs

## Prerequisites

* An Azure account with an active subscription. [Create an account for free](https://azure.microsoft.com/free/). This account must have permissions to manage applications. Use any of the following roles needed to register the application:
  * Application Administrator
  * Application Developer
* Although any integrated development environment (IDE) that supports ASP.NET Core applications can be used, this tutorial uses **Visual Studio Code**. You can download it [here](https://visualstudio.microsoft.com/downloads/).
* A minimum requirement of [.NET 8.0 SDK](https://dotnet.microsoft.com/download/dotnet).
* An ASP.NET Core developer certificate. Install one using [dotnet dev-certs](/dotnet/core/additional-tools/self-signed-certificates-guide#with-dotnet-dev-certs)

### [Workforce tenant](#tab/workforce-tenant)

* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* Add the following redirect URIs using the **Web** platform configuration. Refer to [How to add a redirect URI in your application](./how-to-add-redirect-uri.md) for more details.
  * **Redirect URI**: `https://localhost:5001/signin-oidc`
  * **Front channel logout URL**: `https://localhost:5001/signout-oidc`
* For development purposes, [create a self signed certificate](./howto-create-self-signed-certificate.md). Refer to [add credentials](./how-to-add-credentials.md) to upload the certificate and record the certificate **Thumbprint**. **Do not use a self signed certificate** for production apps. Use a trusted certificate authority.

### [External tenant](#tab/external-tenant)

* An external tenant. If you don't have one, [create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* Add the following redirect URIs using the **Web** platform configuration. Refer to [How to add a redirect URI in your application](./how-to-add-redirect-uri.md) for more details.
  * **Redirect URI**: `https://localhost:5001/signin-oidc`
  * **Front channel logout URL**: `https://localhost:5001/signout-oidc`
* For development purposes, [create a self signed certificate](./howto-create-self-signed-certificate.md). Refer to [add credentials](./how-to-add-credentials.md) to upload the certificate and record the certificate **Thumbprint**. **Do not use a self signed certificate** for production apps. Use a trusted certificate authority.
* Associate your app with a user flow in the Microsoft Entra admin center. This user flow can be used across multiple applications. For more information, see [Create self-service sign-up user flows for apps in external tenants](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md) and [Add your application to the user flow](../external-id/customers/how-to-user-flow-add-application.md).

---

## Create an ASP.NET Core project

In this section, you create an ASP.NET Core project in Visual Studio Code.

1. Open Visual Studio Code and select **File > Open Folder...**. Navigate to and select the location in which to create your project.
1. Open a new terminal by selecting **Terminal > New Terminal**.
1. Enter the following command to make a Model View Controller (MVC) ASP.NET Core project.

    ```console
    dotnet new mvc -n identity-client-web-app
    ```

## Install identity packages

This application uses [Microsoft.Identity.Web](/entra/msal/dotnet/microsoft-identity-web/) and the related NuGet package must be installed.

Use the following snippet to change into the new *identity-client-web-app* folder and install the relevant NuGet package:

```console
cd identity-client-web-app
dotnet add package Microsoft.Identity.Web.UI
```

## Configure the application for authentication

The values recorded in your application setup are used to configure the application for authentication. The configuration file, *appsettings.json*, is used to store application settings used during run-time.

### Update the configuration file

In your IDE, open *appsettings.json* and replace the file contents with the following snippet. Replace the text in quotes with the values that were recorded earlier.
  
### [Workforce tenant](#tab/workforce-tenant)

```json
{
  "AzureAd": {
    "Instance": "https://login.microsoftonline.com/",
    "TenantId": "Enter_the_Tenant_Id_Here",
    "ClientId": "Enter_the_Application_Id_Here",
    "ClientCertificates": [
      {
        "SourceType": "StoreWithThumbprint",
        "CertificateStorePath": "CurrentUser/My",
        "CertificateThumbprint": "Enter the certificate thumbprint obtained the Microsoft Entra admin center"
      }   
    ],
    "CallbackPath": "/signin-oidc"
  },
    "DownstreamApi": {
      "BaseUrl": "https://graph.microsoft.com/v1.0/",
      "RelativePath": "me",
      "Scopes": [ 
        "user.read" 
      ]
    },
    "Logging": {
      "LogLevel": {
        "Default": "Information",
        "Microsoft.AspNetCore": "Warning"
      }
    },
    "AllowedHosts": "*"
  }
```

### [External tenant](#tab/external-tenant)

```json
{
  "AzureAd": {
    "Authority": "https://Enter_the_Tenant_Subdomain_Here.ciamlogin.com/",
    "ClientId": "Enter_the_Application_Id_Here",
    "ClientCertificates": [
      {
        "SourceType": "StoreWithThumbprint",
        "CertificateStorePath": "CurrentUser/My",
        "CertificateThumbprint": "Enter the certificate thumbprint obtained the Microsoft Entra admin center"
      }   
    ],
    "CallbackPath": "/signin-oidc",
    "SignedOutCallbackPath": "/signout-callback-oidc"
  },
  "DownstreamApi": {
    "BaseUrl": "https://graph.microsoft.com/v1.0/",
    "RelativePath": "me",
    "Scopes": [ 
      "user.read" 
    ]
  },
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  },
  "AllowedHosts": "*"
}
```
---

* `Instance` - The authentication endpoint. Check with the different available endpoints in [National clouds](authentication-national-cloud.md#azure-ad-authentication-endpoints).
* `TenantId` - The identifier of the tenant where the application is registered. Replace the text in quotes with the **Directory (tenant) ID** value that was recorded earlier from the overview page of the registered application.
* `ClientId` - The identifier of the application, also referred to as the client. Replace the text in quotes with the **Application (client) ID** value that was recorded earlier from the overview page of the registered application.
* `ClientCertificates` - A self-signed certificate is used for authentication in the application. Replace the text of the `CertificateThumbprint` with the thumbprint of the certificate that was previously recorded. Do not use a self signed certificate for production apps. 
* `CallbackPath` - Is an identifier to help the server redirect a response to the appropriate application.
* `DownstreamApi` - Is an identifier that defines an endpoint for accessing Microsoft Graph. The application URI is combined with the specified scope. To define the configuration for an application owned by the organization, the value of the `Scopes` attribute is slightly different.

### Update the redirect URI

From the [prerequisites](#prerequisites), the redirect URI is set to `https://localhost:5001/signin-oidc`. This needs to be updated in the application launch settings. You can use the redirect URI that is created during the local application setup, or any other available port number, provided it matches the redirect URI in the application registration.

1. In the **Properties** folder, open the *launchSettings.json* file.
1. Find the `https` object, and update the value of `applicationURI` with the correct port number, in this case, `5001`. The line should look similar to the following snippet:

    ```json
    "applicationUrl": "https://localhost:5001;http://localhost:{port}",
    ```

## Next step

### [Workforce tenant](#tab/workforce-tenant)

> [!div class="nextstepaction"]
> [Configure an ASP.NET Core web app for authorization and authentication](./tutorial-web-app-dotnet-sign-in-users.md)

### [External tenant](#tab/external-tenant)

> [!div class="nextstepaction"]
> [Configure an ASP.NET Core web app for authorization and authentication](./tutorial-web-app-dotnet-sign-in-users.md?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&tabs=external-tenant)

---
