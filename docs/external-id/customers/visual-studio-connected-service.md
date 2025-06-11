---
title: Get Started with the Microsoft identity platform Visual Studio's Connected Services
description: Learn how to use Visual Studio Connected Services to integrate Microsoft Entra ID into your applications right from your development environment.
author: Dickson-Mwendia
manager: dougeby
ms.service: identity-platform
ms.topic: quickstart
ms.date: 12/23/2024
ms.author: dmwendia

# Customer intent: As a dev, devops, or it admin, I want to use Visual Studio Connected Services to integrate Microsoft Entra ID authentication into my application
---

# Quickstart: Get Started with the Microsoft identity platform Visual Studio Connected Services

[!INCLUDE [applies to both workforce and external tenants](../includes/applies-to-workforce-external.md)]

Integrating identity management solutions into your organizational and customer-facing applications is essential for securing resources and customer data. Visual Studio's Connected Services allow you to quickly integrate the Microsoft identity platform into your ASP.NET web apps and configure sign-in experiences, all within Visual Studio. This article provides details of using Visual Studio's Connected Services feature for Microsoft Entra ID.

## Prerequisites

- [**Visual Studio 2022**](https://visualstudio.microsoft.com/downloads/) with the ASP.NET and web development workload installed.
- A **Microsoft Entra tenant** (workforce or external). If you don’t have one, choose from the following methods:
  - [Create a new tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
  - Use an Azure account with an active subscription. If you don't have one, [create an account for free](https://azure.microsoft.com/free/).
- The account you use must have permissions to manage applications in your tenant. Any of the following Microsoft Entra roles have the required permissions:
  - Application Administrator
  - Application Developer
  - Cloud Application Administrator

## Create your project and connect it to the Microsoft identity platform

1. In Visual Studio, create or open an ASP.NET Model–view–controller (MVC) project, or an ASP.NET Web API project. For this quickstart, you use the ‘ASP.NET Core Web App (Razor Pages) template.
1. Enter **Project Name**, for example,‘sample-asp-dotnet-webapp’ and the **Location** where you’d like to create the project then select **Next**.
1. In the **Framework** selection, select .NET 8.0 (Long Term Support).
1. Under **Authentication Type**, select Microsoft identity platform.

If you’re creating your app from an empty project template in Visual Studio or already have an existing ASP.NET web app and would like to add Microsoft Entra ID authentication, follow these steps:

1.  Open the solutions explorer and select **Connected Services**.
1.  When the Connected Services pane opens on Visual Studio, select **Add a service dependency** or use the + icon.
 
    :::image type="content" source="media/visual-studio-connected-service/add-service-dependency.png" alt-text="Screenshot showing the Connected Services pane on Visual Studio.":::

1.  From the dropdown list, select **Microsoft identity platform**. You can use the search tab if needed.

    :::image type="content" source="media/visual-studio-connected-service/microsoft-identity-platform-service-dependency.png" alt-text="Screenshot showing Microsoft identity platform and other service dependencies on Visual Studio.":::

1.  Microsoft identity platform shows under service dependencies in the Connected Services pane, as shown:
 
    :::image type="content" source="media/visual-studio-connected-service/microsoft-identity-platform-connected.png" alt-text="Screenshot showing Microsoft identity platform successfully connected as a service dependency on Visual Studio.":::

## Install required components

To use Microsoft identity platform in your project, you need to install the **dotnet msidentity tool**. This command line tool enables you to create Microsoft Entra app registrations. It also updates your app to use Microsoft identity platform by modifying the configuration files of your ASP.NET Core applications (MVC, Razor Pages, Blazor WebAssembly (WASM), Blazor WASM Hosted, Blazor Server).

If you don't have the dotnet msidentity tool installed on your device, Visual Studio prompts you to install it, as shown:
 
  :::image type="content" source="media/visual-studio-connected-service/dotnet-msidentity-tool-installation-prompt.png" alt-text="Screenshot showing a Visual Studio prompt to install the dotnet msidentity tool":::

You can install the dotnet msidentity tool from your command line by running:

  ```sh
  dotnet tool install --global Microsoft.dotnet-msidentity --version 2.0.8
  ```

Once you complete installing the dotnet msidentity tool, select **Next** to proceed to configuration.

## Configure application to use Microsoft identity platform

The Microsoft identity platform connected service allows you to configure applications in either workforce or external tenants. To complete configuration, follow these steps:

1. In the top right section, sign in to your Microsoft account. If you have multiple accounts, select the account with the tenant where you’d like to register your application.

    :::image type="content" source="media/visual-studio-connected-service/configure-application-to-use-microsoft-identity-platform.png" alt-text="Screenshot showing the Visual Studio window where you configure the application to use Microsoft identity platform.":::

1. Once you're signed in, you see a list of applications registered in your tenant; with the application’s display name, client ID, and date created.
1. If you're yet to create an app registration in the Microsoft Entra admin center, select **Create new**. Choose the tenant where you’d like to create the application and provide a display name, such as sample-web-app and Select **Register**. You can change the application's display name later. 

    :::image type="content" source="media/visual-studio-connected-service/register-new-application.png" alt-text="Screenshot showing the Visual Studio window where you register a new application.":::

1. The application you created now shows in the list. Select it and choose **Next.**

    :::image type="content" source="media/visual-studio-connected-service/app-registrations-list.png" alt-text="Screenshot showing a list of app registrations in your tenant.":::

1. On the next screen, you can configure your app's permissions to access Microsoft Graph or other APIs. Select **Next** to complete the configuration later if you don't have the information yet.
1. A screen with the summary of the changes being made to your project appears. Select **Finish** to complete the process.

    :::image type="content" source="media/visual-studio-connected-service/summary-of-changes-to-the-project.png" alt-text="Screenshot showing a list of the changes being made to your project.":::

1. A Dependency configuration progress screen showing the actual changes being in your project appears, as shown. Once successful, select **Close**.

    :::image type="content" source="media/visual-studio-connected-service/dependency-configuration-progress.png" alt-text="Screenshot showing the dependency configuration progress.":::

## [Optional]: Configure permissions to access a web API

The Microsoft identity platform connected service allows you to optionally add permissions to access Microsoft Graph or any other web API. You can add support for your own API or third-party APIs registered with the Microsoft identity platform.

If you want to modify it, such as to add support for an API such as Microsoft Graph, select the three dots on the Microsoft identity platform service dependency, and then choose **Edit dependency**. You can repeat the steps and add the APIs that you want to grant access to.

:::image type="content" source="media/visual-studio-connected-service/configure-additional-api-permissions.png" alt-text="Screenshot showing the window that allows you to add permissions to access Microsoft Graph or any other web API.":::

## Run and test the app

To run the sample
 application, follow these steps:

1. Navigate to Visual Studio’s top navigation bar and select **Debug > Start Without Debugging** to start building your application, as shown:

    :::image type="content" source="media/visual-studio-connected-service/build-sample-application.png" alt-text="Screenshot showing a sample application building on Visual Studio.":::

1. Once your build is complete, a new browser window opens at [https://localhost:7142](https://localhost:7142).
1. Depending on what your application does, Microsoft Entra ID will redirect you to perform the required action. For our sample application, the app prompts you to complete the sign-up and sign-in process as shown:

    :::image type="content" source="media/visual-studio-connected-service/sample-app-running.png" alt-text="Screenshot showing a sample application integrated with Microsoft identity platform running on Visual Studio.":::

### Related content

*	[Add sign-in with Microsoft to an ASP.NET web app](~/identity-platform/quickstart-v2-aspnet-webapp.md)
*	[Visual Studio Code extension for Microsoft Entra External ID](visual-studio-code-extension.md)