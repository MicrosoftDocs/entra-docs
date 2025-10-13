---
title: "Configure an ASP.NET Core web app for authorization and authentication"
description: Learn how to install identity packages and sign-in components to an ASP.NET Core application and enable user authentication.
author: cilwerner
manager: pmwongera
ms.author: cwerner
ms.date: 01/18/2024
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an application developer, I want to install the NuGet packages necessary for authentication in my IDE, and implement authentication in my web app.
---

# Tutorial: Configure an ASP.NET Core web app for authorization and authentication

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

In this tutorial, you add the authentication and authorization elements to an ASP.NET Core web app. In the [previous tutorial](./tutorial-web-app-dotnet-prepare-app.md), you created an ASP.NET Core project and configured it for authentication. 

In this tutorial, you:

> [!div class="checklist"]
>
> * Add authorization and authentication elements to the code
> * Enable viewing of claims in an ID token
> * Add the sign in and sign out experiences

## Prerequisites

* Completion of the prerequisites and steps in [Tutorial: Set up an ASP.NET Core web app that authenticates users](tutorial-web-app-dotnet-prepare-app.md).

## Add authentication and authorization elements

The *HomeController.cs* and *Program.cs* files need to be modified to add the authentication and authorization elements to the ASP.NET Core web app. This includes managing the home page, adding correct namespaces and configuring sign-in.

### Add authorization to *HomeController.cs*

The home page of the application needs to have the capability to authorize the user. The `Microsoft.AspNetCore.Authorization` namespace provides the classes and interfaces to implement authorization to the web app. The `[Authorize]` attribute is used to specify that only authenticated users can use the web app.

1. In your web app, open *Controllers/HomeController.cs*, and add the following snippet to the top of the file:

    ```csharp
    using System.Diagnostics;
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Mvc;
    using dotnetcore_webapp.Models;
    ```

1. Add the `[Authorize]` attribute above the `HomeController` class definition, as shown in the following snippet:

    ```csharp
    [Authorize]
    public class HomeController : Controller
    {
    ...
    ```

### Add authentication and authorization elements to *Program.cs*

The *Program.cs* file is the entry point of the application, and needs to be modified to add authentication and authorization to the web app. Services need to be added to allow the app to use the settings defined in *appsettings.json* for authentication.

1. Add the following namespaces to the top of the file.

    ```csharp
    using Microsoft.AspNetCore.Authentication.OpenIdConnect;
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Mvc.Authorization;
    using Microsoft.Identity.Web;
    using Microsoft.Identity.Web.UI;
    using System.IdentityModel.Tokens.Jwt;
    ```

1. Next, add the Microsoft Identity Web app authentication service, which configures the app to use Microsoft Identity for authentication.  

    ```csharp
    // Add services to the container.
    builder.Services.AddControllersWithViews();
    
    // This is required to be instantiated before the OpenIdConnectOptions starts getting configured.
    // By default, the claims mapping will map claim names in the old format to accommodate older SAML applications.
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

    ```

1. Next, the middleware needs to be configured to enable the authentication capabilities. Replace the rest of the code with the following snippet.

    ```csharp
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

## Add the sign in and sign out experience

The UI needs to be updates to provide a more user-friendly experience for sign-in and sign-out. This section shows how to create a new file that displays navigation items based on the user's authentication status. The code reads the ID token claims to check that the user is authenticated and uses `User.Claims` to extract ID token claims.

1. Create a new file in *Views/Shared* and give it the name *_LoginPartial.cshtml*.
1. Open the file and add the following code for adding the sign in and sign out experience:

    ```csharp
    @using System.Security.Principal

    <ul class="navbar-nav">
    @if (User.Identity is not null && User.Identity.IsAuthenticated)
    {
            <li class="nav-item">
                <span class="nav-link text-dark">Hello @User.Claims.First(c => c.Type == "preferred_username").Value!</span>
            </li>
            <li class="nav-item">
                <a class="nav-link text-dark" asp-area="MicrosoftIdentity" asp-controller="Account" asp-action="SignOut">Sign out</a>
            </li>
    }
    else
    {
            <li class="nav-item">
                <a class="nav-link text-dark" asp-area="MicrosoftIdentity" asp-controller="Account" asp-action="SignIn">Sign in</a>
            </li>
    }
    </ul>
    ```

1. Open *Views/Shared/_Layout.cshtml* and add a reference to `_LoginPartial` created in the previous step. Place this near the end of the `navbar-nav` class as shown in the following snippet:

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

### [Workforce tenant](#tab/workforce-tenant)

> [!div class="nextstepaction"]
> [Test your ASP.NET Core web app](./tutorial-web-app-dotnet-call-api.md)

### [External tenant](#tab/external-tenant)

> [!div class="nextstepaction"]
> [Test your ASP.NET Core web app](./tutorial-web-app-dotnet-call-api.md?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&tabs=external-tenant)

---
