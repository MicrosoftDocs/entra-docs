---
title: "Configure an ASP.NET Core web app for authorization and authentication"
description: Learn how to install identity packages and sign-in components to an ASP.NET Core application and enable user authentication.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.date: 01/18/2024
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an application developer, I want to install the NuGet packages necessary for authentication in my IDE, and implement authentication in my web app.
---

# Tutorial: Configure an ASP.NET Core web app for authorization and authentication

In this tutorial, you add the authentication and authorization elements to an ASP.NET Core web app. In the [previous tutorial](./tutorial-web-app-dotnet-prepare-app.md), you created an ASP.NET Core project and configured it for authentication. 

In this tutorial:

> [!div class="checklist"]
>
> * Add authorization and authentication elements to the code
> * Enable viewing of claims in an ID token
> * Add the sign in and sign out experiences

## Prerequisites

* Completion of the prerequisites and steps in [Tutorial: Set up an ASP.NET Core web app that authenticates users](tutorial-web-app-dotnet-prepare-app.md).

## Add authentication and authorization elements

The *Program.cs* and *HomeController.cs* files need to be modified to add authorization and authentication to the web app and to authorize the user.

### Add authorization to *HomeController.cs*

The *HomeController.cs* file contains the code for the home page of the application and needs to have the capability to authorize the user. The `Microsoft.AspNetCore.Authorization` namespace provides the classes and interfaces to implement authorization to the web app, and the `[Authorize]` attribute is used to specify that only authenticated users can use the web app.

1. In your code editor, open *Controllers\HomeController.cs* file.
1. Authorization needs to be added to the controller, add `Microsoft.AspNetCore.Authorization` so that the top of the file is identical to the following snippet:

    ```cshtml
    using System.Diagnostics;
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Mvc;
    using dotnetcore_webapp.Models;
    ```

1. Add the `[Authorize]` attribute directly above the `HomeController` class definition.

    ```csharp
    [Authorize]
    ```

### Modify *Program.cs*

The *Program.cs* file is where we add authentication and authorization to the web app itself. You need to add the correct namespaces and add the capability to sign in users with the Microsoft identity platform. 

1. Open *Program.cs* and add the namespaces in the following snippet to the top of the file:

    ```csharp
    using Microsoft.AspNetCore.Authentication.OpenIdConnect;
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Mvc.Authorization;
    using Microsoft.Identity.Web;
    using Microsoft.Identity.Web.UI;
    using System.IdentityModel.Tokens.Jwt;
    ```

1. Next, add the authentication services to the application which will enable the web app to sign in users with the Microsoft identity platform. You can replace the rest of the code in *Program.cs* with the following snippet:
1. 
   :::code language="csharp" source="~/../ms-identity-docs-code-dotnet/web-app-aspnet/Program.cs" :::


## View ID token claims

The web app is now configured to sign in users with the Microsoft identity platform. The next step is to add code that allows us to view the ID token claims. The app will check that the user is authenticated using `User.Identity.IsAuthenticated`, and lists out the ID token claims by looping through each item in `User.Claims`, returning their `Type` and `Value`.

1. Open *Views/Home/Index.cshtml* and replace the contents of the file with the following snippet:

    :::code language="csharp" source="~/../ms-identity-docs-code-dotnet/web-app-aspnet/Program.cs" :::


## Add the sign in and sign out experience

Now that the code has authentication and authorization elements, we need to configure the UI to enable the sign-in and sign-out experiences. The code reads the ID token claims to check that the user is authenticated and uses `User.Claims` to extract ID token claims.

1. In the Explorer bar, select **Pages**, right-click **Shared**, and select **New File**. Give it the name *_LoginPartial.cshtml*.
1. Open the file and add the following code for adding the sign in and sign out experience:

   :::code language="csharp" source="~/../ms-identity-docs-code-dotnet/web-app-aspnet/Pages/Shared/_LoginPartial.cshtml" :::

1. Open *_Layout.cshtml* and add a reference to `_LoginPartial` created in the previous step. This single line should be placed between `</ul>` and `</div>`:

   :::code language="csharp" source="~/../ms-identity-docs-code-dotnet/web-app-aspnet/Pages/Shared/_Layout.cshtml" range="29-31" :::

### Use custom URL domain (Optional)

#### [Workforce tenant](#tab/workforce-tenant)

Custom URL domains are not supported in workforce tenants.

#### [External tenant](#tab/external-tenant)

Use a custom domain to fully brand the authentication URL. From a user perspective, users remain on your domain during the authentication process, rather than being redirected to the *ciamlogin.com* domain name.

Follow these steps to use a custom domain:

1. Use the steps in [Enable custom URL domains for apps in external tenants](../external-id/customers/how-to-custom-url-domain.md) to enable custom URL domain for your external tenant.

1. Open *appsettings.json* file:
    1. Update the value of the `Authority` property to *https://Enter_the_Custom_Domain_Here/Enter_the_Tenant_ID_Here*. Replace `Enter_the_Custom_Domain_Here` with your custom URL domain and `Enter_the_Tenant_ID_Here` with your tenant ID. If you don't have your tenant ID, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details). 
    1. Add `knownAuthorities` property with a value *[Enter_the_Custom_Domain_Here]*.
    
After you make the changes to your *appsettings.json* file, if your custom URL domain is *login.contoso.com*, and your tenant ID is *aaaabbbb-0000-cccc-1111-dddd2222eeee*, then your file should look similar to the following snippet:

```json
{
  "AzureAd": {
    "Authority": "https://login.contoso.com/aaaabbbb-0000-cccc-1111-dddd2222eeee",
    "ClientId": "Enter_the_Application_Id_Here",
    "ClientCredentials": [
      {
        "SourceType": "ClientSecret",
        "ClientSecret": "Enter_the_Client_Secret_Here"
      }
    ],
    "CallbackPath": "/signin-oidc",
    "SignedOutCallbackPath": "/signout-callback-oidc",
    "KnownAuthorities": ["login.contoso.com"]
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

## Next step

> [!div class="nextstepaction"]
> [Test your ASP.NET Core web app](./tutorial-web-app-dotnet-call-api.md)