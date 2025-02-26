---
title: "Tutorial: Build and secure an ASP.NET Core web API with the Microsoft identity platform"
description: Protect the endpoint of an API, then run it to ensure it's listening for HTTP requests.
author: Dickson-Mwendia
manager: CelesteDG
ms.author: dmwendia
ms.date: 2/21/2025
ms.service: identity-platform

ms.topic: tutorial

#Customer intent: As an application developer I want to build an ASP.NET web API, protect its endpoints, and run it to ensure it's listening for HTTP requests
---

# Tutorial: Build and secure an ASP.NET Core web API with the Microsoft identity platform

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

This tutorial series demonstrates how to protect an ASP.NET Core web API with the Microsoft identity platform to limit it's access to only authorized users and client apps. The web API you build uses both delegated permissions (scopes) and application permissions (app roles).

In this tutorial, you'll:

> [!div class="checklist"]
>
>- Build an ASP.NET Core web API 
>- Configure the web API to use it's Microsoft Entra app registration details
>- Protect your web API endpoints
>- Run the web API to ensure it's listening to HTTP requests

## Prerequisites

- If you haven't already, complete the steps in [Quickstart: Sign in users in a sample web app](quickstart-web-app-sign-in.md?pivots=external&tabs=node-external). In the quickstart, you don't have to clone and run the code sample.
- [.NET 8.0 SDK](https://dotnet.microsoft.com/download/dotnet) or later.
- [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.

## Create a new ASP.NET Core web API project

To create a minimal ASP.NET Core web API project, follow these steps:

1. Open your terminal on Visual Studio Code or any other code editor and navigate to the directory where you want to create your project.
1. Run the following commands on the .NET CLI or any other command line tool.

    ```dotnetcli
    dotnet new webapi -n MyProtectedApi
    cd MyProtectedApi
    ```
1. Select **Yes** when a dialog box asks if you want to trust the authors.

1. Select **Yes** When a dialog box asks if you want to add required assets to the project.

## Install required packages

To protect an ASP.NET Core web API, you need the `Microsoft.Identity.Web` package - a set of ASP.NET Core libraries that simplify adding authentication and authorization support to web apps and web APIs that integrate with the Microsoft identity platform.

To install the package, use:

```dotnetcli
dotnet add package Microsoft.Identity.Web
```
## Configure app registration details

#### [Workforce tenant](#tab/workforce-tenant)

Custom URL domains aren't supported in workforce tenants.

#### [External tenant](#tab/external-tenant)

[!INCLUDE [external-id-custom-domain](./includes/use-custom-domain-url.md)] 
---

Open the *appsettings.json* file in your app folder and add the app registration details you recorded after registering the web API.

```json
{
    "AzureAd": {
        "Instance": "Enter_the_Authority_URL_Here",
        "TenantId": "Enter_the_Tenant_Id_Here",
        "ClientId": "Enter_the_Application_Id_Here",
    },
    "Logging": {...},
  "AllowedHosts": "*"
}
```
Replace the following placeholders as shown:

- Replace `Enter_the_Application_Id_Here` with your application (client) ID.
- Replace `Enter_the_Tenant_Id_Here` with your Directory (tenant) ID.
- Replace `Enter_the_Authority_URL_Here` with your Authority URL, as explained in the next section.

###  Authority URL for your app

The authority URL specifies the directory from which Microsoft Authentication Library (MSAL) can request tokens from. It's built differently in both workforce and external tenants, as shown:

#### [Workforce tenant](#tab/workforce-tenant)

```json
//Instance for workforce tenant
Instance: "https://login.microsoftonline.com/"
```

#### [External tenant](#tab/external-tenant)

```json
//Authority URL for external tenant
Instance: "https://Enter_the_Tenant_Subdomain_Here.ciamlogin.com/"
```
---

### Use custom URL domain (Optional)

#### [Workforce tenant](#tab/workforce-tenant)

Custom URL domains aren't supported in workforce tenants.

#### [External tenant](#tab/external-tenant)

[!INCLUDE [external-id-custom-domain](./includes/use-custom-domain-url.md)] 

---

## Add app role and scope

All APIs must publish a minimum of one scope, also called delegated permission, for the client apps to obtain an access token for a user successfully. APIs should also publish a minimum of one app role, also called application permissions, for the client apps to obtain an access token as themselves, that is, when they aren't signing-in a user.

We specify these permissions in the *appsettings.json* file. In this tutorial, you register both delegated and application permissions with the scopes "Forecast.Read". This means that only users or client applications that call the API with an access token containing the scope "Forecast.Read" get authorized to access the protected endpoint.

```json
{
  "AzureAd": {
    "Instance": "Enter_the_Authority_URL_Here",
    "TenantId": "Enter_the_Tenant_Id_Here",
    "ClientId": "Enter_the_Application_Id_Here",
    "Scopes": {
      "Read": "Forecast.Read",
    },
    "AppPermissions": {
      "Read": ["Forecast.Read"],
    }
  },
  "Logging": {...},
  "AllowedHosts": "*"
}
```

## Implement authentication and authorization in the API

To configure authentication and authorization, open the `program.cs` file and replace its contents the following code snippets:

### Add an authentication scheme

In this API, we use the JSON Web Token (JWT) Bearer scheme as the default authentication mechanism. Use the  `AddAuthentication` method to register the JWT bearer scheme.

```cs
// Import the required packages

using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.Identity.Web;

var builder = WebApplication.CreateBuilder(args);

// Configure authentication
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddMicrosoftIdentityWebApi(options =>
    {
        builder.Configuration.Bind("AzureAd", options);
        options.TokenValidationParameters.NameClaimType = "name";
    }, options => { builder.Configuration.Bind("AzureAd", options); });

```
### Configure authorization

Authorization determines what an authenticated user is allowed to do. We define a policy named `AuthZPolicy` that requires client calling the API to have the `Forecast.Read` role for client apps or the `Forecast.Read` scope for a signed in user.

```cs
builder.Services.AddAuthorization(config =>
{
config.AddPolicy("AuthZPolicy", policy =>
    policy.RequireRole("Forecast.Read"));
});
```

The `AddPolicy` method creates a named policy (`AuthZPolicy`) that checks for the presence of the `Forecast.Read` role in the user's token claims. If the token lacks the `roles` claim, access to endpoints requiring this policy is denied.

### Build the HTTP request pipeline

In this tutorial, we use a minimal API without controllers as the focus is more on protecting the API. We configure the API middleware pipeline by adding the following: 

- **HTTPS redirection**: Enforce secure communication by redirecting HTTP requests to HTTPS.
- **Authentication middleware**: Validates incoming tokens before processing requests.
- **Authorization middleware**: Applies policies after authentication, ensuring only authorized clients can access protected endpoints. 

```csharp
var app = builder.Build();

// Configure the HTTP request pipeline

app.UseHttpsRedirection();
app.UseAuthentication();
app.UseAuthorization();
```

### Define the weather forecast endpoint

The `/weatherforecast` endpoint generates a random five-day forecast, protected by the authorization policy.`RequireAuthorization("AuthZPolicy")` ensures only clients with the `Forecast.Read` role can access it.

```cs
var summaries = new[]
{
    "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
};

app.MapGet("/weatherforecast", () =>
{
    var forecast =  Enumerable.Range(1, 5).Select(index =>
        new WeatherForecast
        (
            DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
            Random.Shared.Next(-20, 55),
    
        summaries[Random.Shared.Next(summaries.Length)]
        ))
        .ToArray();
    return forecast;
})
.WithName("weatherForecast")
.RequireAuthorization("AuthZPolicy"); // Protect this endpoint with the AuthZPolicy

app.Run();

record WeatherForecast(DateOnly Date, int TemperatureC, string? Summary)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}
```

The authentication and authorization flow in the sample web API we created works as follows: 

- The client sends a GET request to `/weatherforecast` with a JWT in the `Authorization` header.
- `UseAuthentication` validates the token against Microsoft Entra ID
- `UseAuthorization` checks for the `Forecast.Read` role in the token’s claims.
- If successful, the endpoint returns the forecast; otherwise, it responds with `401 Unauthorized` (invalid/no token) or `403 Forbidden` (missing role).

## Run your API

Run your API to ensure that it's running without any errors using the command `dotnet run`. If you intend to use HTTPS protocol even during testing, you need to [trust .NET's development certificate](/aspnet/core/tutorials/first-web-api#test-the-project).

1. Start the application by typing the following in the terminal:

    ```powershell
    dotnet run
    ```
1. A similar output to the following should be displayed in the terminal, which confirms that the application is running on `http://localhost:{port}` and listening for requests.

    ```powershell
    Building...
    info: Microsoft.Hosting.Lifetime[0]
        Now listening on: http://localhost:{port}
    info: Microsoft.Hosting.Lifetime[0]
        Application started. Press Ctrl+C to shut down.
    ...
    ```

The web page `http://localhost:{host}` displays an output similar to the following image. This is because the API is being called without authentication. In order to make an authorized call, refer to [Next steps](#next-steps) for guidance on how to access a protected web API.

:::image type="content" source="./media/web-api-tutorial-03-protect-endpoint/display-web-page-401.png" alt-text="Screenshot that shows the 401 error when the web page is launched.":::

For a full example of this API code, see the [samples file](https://github.com/Azure-Samples/ms-identity-ciam-dotnet-tutorial/tree/main/2-Authorization/3-call-own-api-dotnet-core-daemon/ToDoListAPI).

## Next steps

> [!div class="nextstepaction"]
> [Part 2: Test your protected ASP.NET Core web API](tutorial-web-api-dotnet-core-test-protected-api.md)