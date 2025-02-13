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

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

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

The *Program.cs* file needs to be modified to add authorization and authentication to the web app and to authorize the user. This section guides you through how to add the capability to sign in users with the Microsoft identity platform, update the application middleware and enable authentication by default. 

### Add authentication elements

1. Open *Program.cs* and remove the existing code. Add the following namespaces to the file:

    :::code language="csharp" source="~/../ms-identity-docs-code-dotnet/web-app-aspnet/Program.cs" range="2-5" :::

1. Add the `WebApplicationBuilder` and retrieve the initial scopes for the downstream API calls.

    :::code language="csharp" source="~/../ms-identity-docs-code-dotnet/web-app-aspnet/Program.cs" range="9-10" :::

1. Next, add the Microsoft Identity Web app authentication, which configures the app to use Microsoft Identity for authentication, specifically, the `AzureAd` section in *appsettings.json*.

    :::code language="csharp" source="~/../ms-identity-docs-code-dotnet/web-app-aspnet/Program.cs" range="12-15" :::

### Enable authentication by default

Add the following code to *Program.cs* to provide the default pages for sign-in and sign-out:

:::code language="csharp" source="~/../ms-identity-docs-code-dotnet/web-app-aspnet/Program.cs" range="19-25" :::

### Add authentication to the middleware

Add the following snippet, which builds the web app and configures the application middleware:

:::code language="csharp" source="~/../ms-identity-docs-code-dotnet/web-app-aspnet/Program.cs" range="28-43" :::
    
## View Microsoft Graph API data

To display data from the Microsoft Graph API call, you need to modify the UI to display it.

Open *Pages/Index.cshtml* and add the following code to the end of the file. 

:::code language="csharp" source="~/../ms-identity-docs-code-dotnet/web-app-aspnet/Pages/Index.cshtml" range="13-17" :::

## Add the sign in and sign out experience

The UI needs to be updates to provide a more user-friendly experience for sign-in and sign-out. This section shows how to create a new file that displays navigation items based on the user's authentication status.

1. Create a new file in *Pages/Shared* and give it the name *_LoginPartial.cshtml*.
1. Open the file and add the following code for adding the sign in and sign out experience:

   :::code language="csharp" source="~/../ms-identity-docs-code-dotnet/web-app-aspnet/Pages/Shared/_LoginPartial.cshtml" :::

1. Open *Pages/Shared_Layout.cshtml* and add a reference to `_LoginPartial` created in the previous step. Place this near the end of the `navbar-nav` class as shown in the following snippet:

    ```csharp
    <div class="navbar-collapse collapse d-sm-inline-flex justify-content-between">
        <ul class="navbar-nav flex-grow-1">
            <li class="nav-item">
                <a class="nav-link text-dark" asp-area="" asp-page="/Index">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-dark" asp-area="" asp-page="/Privacy">Privacy</a>
            </li>
        </ul>
        <partial name="_LoginPartial" />
    </div>
    ```

## Use custom URL domain (Optional)

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-external-only.md)]

Use a custom domain to fully brand the authentication URL. From a user perspective, users remain on your domain during the authentication process, rather than being redirected to the *ciamlogin.com* domain name.

Follow these steps to use a custom domain:

1. Use the steps in [Enable custom URL domains for apps in external tenants](../external-id/customers/how-to-custom-url-domain.md) to enable custom URL domain for your external tenant.

1. Open *appsettings.json* file:
    1. Update the `Instance` and `TenantId` parameters to an `Authority` property.
    1. Add the following string to the `Authority` value to `https://Enter_the_Custom_Domain_Here/Enter_the_Tenant_ID_Here`. Replace `Enter_the_Custom_Domain_Here` with your custom URL domain and `Enter_the_Tenant_ID_Here` with your tenant ID. If you don't have your tenant ID, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details). 
    1. Add a `knownAuthorities` property with a value *[Enter_the_Custom_Domain_Here]*.
    
After you make the changes to your *appsettings.json* file, if your custom URL domain is *login.contoso.com*, and your tenant ID is *aaaabbbb-0000-cccc-1111-dddd2222eeee*, then your file should look similar to the following snippet:

```json
{
  "AzureAd": {
    "Authority": "https://login.contoso.com/aaaabbbb-0000-cccc-1111-dddd2222eeee",
    "ClientId": "Enter_the_Application_Id_Here",
    "ClientCertificates": [
      {
        "SourceType": "StoreWithThumbprint",
        "CertificateStorePath": "CurrentUser/My",
        "CertificateThumbprint": "AA11BB22CC33DD44EE55FF66AA77BB88CC99DD00"
      }   
    ],
    "CallbackPath": "/signin-oidc",
    "SignedOutCallbackPath": "/signout-callback-oidc",
    "KnownAuthorities": ["login.contoso.com"]
    ...
```

## Next step

> [!div class="nextstepaction"]
> [Test your ASP.NET Core web app](./tutorial-web-app-dotnet-call-api.md)