---
title: "Quickstart: .NET console app that accesses a protected web API"
description: In this quickstart, you learn how a .NET console application can get an access token to call the Microsoft Graph API and display a list of users in the directory. The application is a daemon application, which is a confidential client application.
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.custom: devx-track-csharp,  'scenarios:getting-started', 'languages:aspnet-core', mode-other, devx-track-dotnet
ms.date: 03/28/2024
ms.reviewer: jmprieur
ms.service: identity-platform

ms.topic: quickstart
#Customer intent: As an application developer, I want to learn how to get access tokens and refresh tokens by using the Microsoft identity platform so that my .NET console application can call the Microsoft Graph API.
---

# Quickstart: .NET console app that accesses a protected web API

This quickstart uses a sample .NET console application to accesses a protected web API as its own identity by using the [Microsoft Authentication Library (MSAL) for .NET](https://learn.microsoft.com/en-us/entra/msal/dotnet/). The application is a daemon application, which is a confidential client application and uses the [client credentials OAuth flow](v2-oauth2-client-creds-grant-flow.md) to get an access token to call the Microsoft Graph API.

## Prerequisites

* An Azure account with an active subscription. If you don't already have one, [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* A minimum requirement of [.NET 6.0 SDK](https://dotnet.microsoft.com/download/dotnet)
* [Visual Studio 2022](https://visualstudio.microsoft.com/vs/) or [Visual Studio Code](https://code.visualstudio.com/)

## Register and download the app

The application can be built using either an automatic or manual configuration.

## Register the application and record identifiers

## Create a client secret

## Clone or download the sample application

To obtain the sample application, you can either clone it from GitHub or download it as a *.zip* file.

* To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-docs-code-dotnet.git
    ```

* [Download the .zip file](https://github.com/Azure-Samples/ms-identity-docs-code-dotnet/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.


## Configure the project

1. Extract the *.zip* file to a local folder that's close to the root of the disk to avoid errors caused by path length limitations on Windows. For example, extract to *C:\Azure-Samples*.

1. In your IDE, open the project folder, *ms-identity-docs-code-dotnet/console-daemon*, containing the sample.
1. Open *Program.cs* and replace the file contents with the following snippet;

   ```csharp
    // Full directory URL, in the form of https://login.microsoftonline.com/<tenant_id>
    Authority = " https://login.microsoftonline.com/Enter_the_tenant_ID_obtained_from_the_Microsoft_Entra_admin_center",
    // 'Enter the client ID obtained from the Microsoft Entra Admin Center
    ClientId = "Enter the client ID obtained from the Microsoft Entra admin center",
    // Client secret 'Value' (not its ID) from 'Client secrets' in the Microsoft Entra Admin Center
    ClientSecret = "Enter the client secret value obtained from the Microsoft Entra admin center",
    // Client 'Object ID' of app registration in Microsoft Entra Admin Center - this value is a GUID
    ClientObjectId = "Enter the client Object ID obtained from the Microsoft Entra admin center"
   ```

    * `Authority` - The identifier of the tenant where the application is registered. Replace the text in quotes with the `Directory (tenant) ID` that was recorded earlier from the overview page of the registered application.
    * `ClientId` - The identifier of the application, also referred to as the client. Replace the text in quotes with the `Application (client) ID` value that was recorded earlier from the overview page of the registered application.
    * `ClientSecret` - The client secret created for the application in the Microsoft Entra admin center. Enter the **value** of the client secret.
    * `ClientObjectId` - The object ID of the client application. Replace the text in quotes with the `Object ID` value that was recorded earlier from the overview page of the registered application.

## Run the application

1. In a terminal, navigate to the project directory, *ms-identity-docs-code-dotnet/console-daemon*.
1. Run the following command to build and run the application:

    ```console
    dotnet run
    ```
1. The application runs and displays a respone similar to the following:

    ```console
    {
      "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications/$entity",
      "id": "6ed9c555-6dfd-4f35-b832-f1f634c0b876",
      "deletedDateTime": null,
      "appId": "59c06144-a668-4828-9ca8-ed6e117c8344",
      "applicationTemplateId": null,
      "disabledByMicrosoftStatus": null,
      "createdDateTime": "2021-01-17T15:30:55Z",
      "displayName": "active-directory-dotnet-console-app-client-credential-flow",
      "description": null,
      "groupMembershipClaims": null,
      ...
    }
    ```

## Related content

* Learn by building this ASP.NET web app with the series [Tutorial: Register an application with the Microsoft identity platform](./tutorial-web-app-dotnet-sign-in-users.md).
* [Quickstart: Protect an ASP.NET Core web API with the Microsoft identity platform](./quickstart-web-api-aspnet-core-protect-api.md).
* [Quickstart: Deploy an ASP.NET web app to Azure App Service](/azure/app-service/quickstart-dotnetcore?tabs=net70&pivots=development-environment-vs)