---
title: Tutorial - Prepare an ASP.NET Core web app for authentication in an external tenant
description: Learn how to prepare an ASP.NET Core web app for authentication with your external tenant.

author: cilwerner
ms.author: cwerner
manager: celestedg
ms.service: entra-external-id

ms.subservice: customers
ms.custom: devx-track-dotnet
ms.topic: tutorial
ms.date: 05/23/2023
#Customer intent: As a dev, DevOps, I want to learn about how to enable authentication in my own ASP.NET web app with an external tenant.
---

# Tutorial: Prepare an ASP.NET Core web app for authentication in an external tenant

This tutorial is part 2 of a series that demonstrates how to build an ASP.NET Core web application and prepare it for authentication using the Microsoft Entra admin center. In [Part 1 of this series](./tutorial-web-app-dotnet-sign-in-prepare-tenant.md), you registered an application and configured user flows in your external tenant. This tutorial demonstrates how to create an ASP.NET Core web app, and configure it for authentication.

In this tutorial you'll;

> [!div class="checklist"]
> - Create an ASP.NET Core project in Visual Studio Code
> - Add the required NuGet packages
> - Configure the settings for the application
> - Add code to implement authentication

## Prerequisites

- [Tutorial: Prepare your external tenant for building an ASP.NET Core web app](./tutorial-web-app-dotnet-sign-in-prepare-tenant.md).
- Although any integrated development environment (IDE) that supports ASP.NET Core applications can be used, this tutorial uses **Visual Studio Code**. You can download it [here](https://visualstudio.microsoft.com/downloads/).
- [.NET 7.0 SDK](https://dotnet.microsoft.com/download/dotnet).

## Create an ASP.NET Core project

1. Open Visual Studio Code, select **File** > **Open Folder...**. Navigate to and select the location in which to create your project.
1. Open a new terminal by selecting **Terminal** > **New Terminal**.
1. Enter the following command to make a Model View Controller (MVC) ASP.NET Core project.

    ```powershell
    dotnet new mvc -n dotnetcore_webapp
    ```

## Install identity packages

Identity related NuGet packages must be installed in the project to authenticate users.

1. Enter the following commands to change into the *dotnetcore_webapp* folder and install the relevant NuGet package:

    ```powershell
    cd dotnetcore_webapp
    dotnet add package Microsoft.Identity.Web.UI
    ```

## Configure the application for authentication

1. Open the *appsettings.json* file and replace the existing code with the following snippet.

    ```json
    {
      "AzureAd": {
        "Authority": "https://Enter_the_Tenant_Subdomain_Here.ciamlogin.com/",
        "ClientId": "Enter_the_Application_Id_Here",
        "ClientCredentials": [
          {
            "SourceType": "ClientSecret",
            "ClientSecret": "Enter_the_Client_Secret_Here"
          }
        ],
        "CallbackPath": "/signin-oidc",
        "SignedOutCallbackPath": "/signout-callback-oidc"
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

    - `Authority` - The identity provider instance and sign-in audience for the app. Replace `Enter_the_Tenant_Subdomain_Here` with the subdomain of your external tenant. To find this, select **Overview** in the sidebar menu, then switch to the **Overview tab**. Find the **Primary domain**, in the form *caseyjensen.onmicrosoft.com*. The subdomain is *caseyjensen*.
    - `ClientId` - The identifier of the application, also referred to as the client. Replace the text in quotes with the **Application (client) ID** value that was recorded earlier from the overview page of the registered application.
    - `ClientSecret` - The value of the client secret you created in [Prepare your tenant](./tutorial-web-app-dotnet-sign-in-prepare-tenant.md). Replace the text in quotes with the client secret **value** in the Microsoft Entra admin center.
    - `CallbackPath` - Is an identifier to help the server redirect a response to the appropriate application.

1. Save changes to the file.
1. Open the *Properties/launchSettings.json* file.
1. In the `https` section of `profiles`, change the `https` URL in `applicationUrl` so that it reads `https://localhost:7274`. You used this URL to define the **Redirect URI**.
1. Save the changes to your file.

## Add authorization to *HomeController.cs*

The *HomeController.cs* file contains the code for the home page of the application and needs to have the capability to authorize the user. The `Microsoft.AspNetCore.Authorization` namespace provides the classes and interfaces to implement authorization to the web app, and the `[Authorize]` attribute is used to specify that only authenticated users can use the web app.

1. In your code editor, open *Controllers\HomeController.cs* file.
1. Authorization needs to be added to the controller, add `Microsoft.AspNetCore.Authorization` so that the top of the file is identical to the following snippet:

    ```cshtml
    using System.Diagnostics;
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Mvc;
    using dotnetcore_webapp.Models;
    ```

1. Additionally, add the `[Authorize]` attribute directly above the `HomeController` class definition.

    ```csharp
    [Authorize]
    ```

## Add authentication and authorization to *Program.cs*

The *Program.cs* needs to be modified to add authentication and authorization to the web app. This includes adding namespaces for authentication and authorization, and being able to sign in users with the Microsoft identity platform.

1. To add the required namespaces, open *Program.cs* and add the following snippet to the top of the file:

    ```csharp
    using Microsoft.AspNetCore.Authentication.OpenIdConnect;
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Mvc.Authorization;
    using Microsoft.Identity.Web;
    using Microsoft.Identity.Web.UI;
    using System.IdentityModel.Tokens.Jwt;
    ```

1. Next, add the authentication services to the application which will enable the web app to sign in users with the Microsoft identity platform. You can replace the rest of the code in *Program.cs* with the following snippet:

    ```csharp
    var builder = WebApplication.CreateBuilder(args);

    // Add services to the container.
    builder.Services.AddControllersWithViews();

    // This is required to be instantiated before the OpenIdConnectOptions starts getting configured.
    // By default, the claims mapping will map claim names in the old format to accommodate older SAML applications.
    // For instance, 'http://schemas.microsoft.com/ws/2008/06/identity/claims/role' instead of 'roles' claim.
    // This flag ensures that the ClaimsIdentity claims collection will be built from the claims in the token
    JwtSecurityTokenHandler.DefaultMapInboundClaims = false;

    // Sign-in users with the Microsoft identity platform
    builder.Services.AddAuthentication(OpenIdConnectDefaults.AuthenticationScheme)
        .AddMicrosoftIdentityWebApp(builder.Configuration)
        .EnableTokenAcquisitionToCallDownstreamApi()
        .AddInMemoryTokenCaches();

    builder.Services.AddControllersWithViews(options =>
    {
        var policy = new AuthorizationPolicyBuilder()
            .RequireAuthenticatedUser()
            .Build();
        options.Filters.Add(new AuthorizeFilter(policy));
    }).AddMicrosoftIdentityUI();

    var app = builder.Build();

    // Configure the HTTP request pipeline.
    if (!app.Environment.IsDevelopment())
    {
        app.UseExceptionHandler("/Home/Error");
        // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
        app.UseHsts();
    }

    app.UseHttpsRedirection();
    app.UseStaticFiles();

    app.UseRouting();
    app.UseAuthorization();

    app.MapControllerRoute(
        name: "default",
        pattern: "{controller=Home}/{action=Index}/{id?}");

    app.Run();

    ```

## Next step

> [!div class="nextstepaction"]
> [Step 3: Add sign-in and sign-out to an ASP.NET Core web application for an external tenant](tutorial-web-app-dotnet-sign-in-sign-out.md)
