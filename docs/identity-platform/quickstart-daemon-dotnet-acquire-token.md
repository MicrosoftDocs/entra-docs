---
title: "Quickstart: .NET console app that accesses a protected web API"
description: In this quickstart, you learn how a .NET console application can get an access token to call the Microsoft Graph API and display a list of users in the directory. The application is a daemon application, which is a confidential client application.
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.custom: devx-track-csharp,  'scenarios:getting-started', 'languages:aspnet-core', mode-other, devx-track-dotnet
ms.date: 04/09/2024
ms.reviewer: jmprieur
ms.service: identity-platform

ms.topic: quickstart
#Customer intent: As an application developer, I want to learn how to get access tokens and refresh tokens by using the Microsoft identity platform so that my .NET console application can call the Microsoft Graph API.
---

# Quickstart: .NET console app that accesses a protected web API

This quickstart uses a sample .NET console application to access a protected web API as its own identity by using the [Microsoft Authentication Library (MSAL) for .NET](/entra/msal/dotnet). The application is a daemon application, which is a confidential client application, and uses the [client credentials OAuth flow](v2-oauth2-client-creds-grant-flow.md) to get an access token to call the Microsoft Graph API.

## Prerequisites

* An Azure account with an active subscription. If you don't already have one, [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* A minimum requirement of [.NET 6.0 SDK](https://dotnet.microsoft.com/download/dotnet)
* [Visual Studio 2022](https://visualstudio.microsoft.com/vs/) or [Visual Studio Code](https://code.visualstudio.com/)

## Register the application and record identifiers

[!INCLUDE [Register a daemon in the Microsoft identity platform](includes/register-app/daemon-common/register-application-daemon-common.md)]

## Create a client secret

[!INCLUDE [Create a client secret](includes/register-app/create-client-secret.md)]

## Clone or download the sample application

To obtain the sample application, you can either clone it from GitHub or download it as a *.zip* file.

* To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-docs-code-dotnet.git
    ```

* [Download the .zip file](https://github.com/Azure-Samples/ms-identity-docs-code-dotnet/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.


## Configure the project

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

    * `Authority` - The authority is a URL that indicates a directory that MSAL can request tokens from. Replace *Enter_the_tenant_ID* with the **Directory (tenant) ID** value that was recorded earlier.
    * `ClientId` - The identifier of the application, also referred to as the client. Replace the text in quotes with the `Application (client) ID` value that was recorded earlier from the overview page of the registered application.
    * `ClientSecret` - The client secret created for the application in the Microsoft Entra admin center. Enter the **value** of the client secret.
    * `ClientObjectId` - The object ID of the client application. Replace the text in quotes with the `Object ID` value that was recorded earlier from the overview page of the registered application.

## Run the application

1. In a terminal, navigate to the project directory, *ms-identity-docs-code-dotnet/console-daemon*.
1. Run the following command to build and run the application:

    ```console
    dotnet run
    ```
1. The application runs and displays a response similar to the following (shortened for brevity):

    ```console
    {
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications/$entity",
    "id": "00001111-aaaa-2222-bbbb-3333cccc4444",
    "deletedDateTime": null,
    "appId": "00001111-aaaa-2222-bbbb-3333cccc4444",
    "applicationTemplateId": null,
    "disabledByMicrosoftStatus": null,
    "createdDateTime": "2021-01-17T15:30:55Z",
    "displayName": "identity-dotnet-console-app",
    "description": null,
    "groupMembershipClaims": null,
    ...
    }
    ```

## Related content

* Learn by building this ASP.NET web app with the series [Tutorial: Register an application with the Microsoft identity platform](./tutorial-web-app-dotnet-sign-in-users.md).
* [Quickstart: Protect an ASP.NET Core web API with the Microsoft identity platform](./quickstart-web-api-aspnet-core-protect-api.md).
* [Quickstart: Deploy an ASP.NET web app to Azure App Service](/azure/app-service/quickstart-dotnetcore?tabs=net70&pivots=development-environment-vs)