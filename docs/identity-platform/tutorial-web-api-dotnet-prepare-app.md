---
title: "Tutorial: Create and configure an ASP.NET Core project for authentication"
description: "Create and configure the API in an IDE, add configuration for authentication and install required packages"
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.date: 11/1/2022
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an application developer, I want to create an ASP.NET Core project in an IDE, then configure it in such a way that I can add authentication with Microsoft Entra ID.
---

# Tutorial: Create and configure an ASP.NET Core project for authentication

In this tutorial, you learn how to create an ASP.NET Core project using an IDE and configure it for authentication and authorization. This tutorial is the second part of a series that demonstrates how to secure a web API using the Microsoft identity platform. In the [previous article](web-api-tutorial-01-register-app.md), you registered an application in your Microsoft Entra ID tenant. In this article, you;

> [!div class="checklist"]
> * Create an **ASP.NET Core Empty** project in your IDE
> * Configure the settings for the application
> * Identify and install the required NuGet packages

## Prerequisites

* Completion of the prerequisites and steps in [Tutorial: Register web API with the Microsoft identity platform](web-api-tutorial-01-register-app.md).
* You can download the IDEs used in this tutorial from the [Downloads](https://visualstudio.microsoft.com/downloads) page.
  - Visual Studio 2022
  - Visual Studio Code
  - Visual Studio 2022 for Mac
- A minimum requirement of [.NET 6.0 SDK](https://dotnet.microsoft.com/download/dotnet).

## Create an ASP.NET Core project

Use the following tabs to create an ASP.NET Core project within an IDE.

### [Visual Studio](#tab/visual-studio)

1. Open Visual Studio, and then select **Create a new project**.
1. Search for and choose the **ASP.NET Core Empty** template, and then select **Next**.
1. Enter a name for the project, such as *NewWebAPILocal*.
1. Choose a location for the project or accept the default option, and then select **Next**.
1. Accept the default for the **Framework** and **Configure for HTTPS**.
1. Select **Create**.

### [Visual Studio Code](#tab/visual-studio-code)

1. Open Visual Studio Code, select **File > Open Folder...**. Navigate to and select the location in which to create your project.
1. Open up a new terminal by selecting **Terminal** in the top bar, then **New Terminal**.
1. Create a new folder using the **New Folder...** icon in the **Explorer** pane. Provide a name similar to the one registered previously, for example, *NewWebAPILocal*.
1. Open a new terminal by selecting **Terminal > New Terminal**.
1. To create an **ASP.NET Core Empty** template, run the following commands in the terminal to change into the directory and create the project:

    ```powershell
    cd NewWebAPILocal
    dotnet new web
    ```
---

## Configure the ASP.NET Core project

The values recorded earlier will be used in *appsettings.json* to configure the application for authentication. *appsettings.json* is a configuration file that is used to store application settings used during run-time.

1. Open *appsettings.json* and replace the file contents with the following code snippet:

    ```json
    {
      "AzureAd": {
        "Instance": "https://login.microsoftonline.com/",
        "ClientId": "Enter the client ID here",
        "TenantId": "Enter the tenant ID here",
        "Scopes": "Forecast.Read"
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

    * `Instance` - The endpoint of the cloud provider. Check with the different available endpoints in [National clouds](authentication-national-cloud.md#azure-ad-authentication-endpoints).
    * `TenantId` - The identifier of the tenant where the application is registered. Replace the text in quotes with the **Directory (tenant) ID** value that was recorded earlier from the overview page of the registered application.
    * `ClientId` - The identifier of the application, also referred to as the client. Replace the text in quotes with the **Application (client) ID** value that was recorded earlier from the overview page of the registered application.
    * `Scopes` - The scope that is used to request access to the application. For this tutorial, the scope is `Forecast.Read`.
1. Save the changes to the file.

## Install identity packages

Identity related **NuGet packages** must be installed in the project for authentication of users to be enabled.

### [Visual Studio](#tab/visual-studio)

1. In the top menu, select **Tools** > **NuGet Package Manager** > **Manage NuGet Packages for Solution**.
1. With the **Browse** tab selected, search for **Microsoft.Identity.Web**, select the `Microsoft.Identity.Web` package, select the **Project** checkbox, and then select **Install**.
1. Select **Ok** or **I Accept** for other windows that may appear.

### [Visual Studio Code](#tab/visual-studio-code)

1. In the terminal opened in the previous section, enter the following command:

    ```powershell
    dotnet add package Microsoft.Identity.Web
    ```

---

## Next steps

> [!div class="nextstepaction"]
> [Tutorial: Implement a protected endpoint to your API](tutorial-web-api-dotnet-protect-endpoint.md)
