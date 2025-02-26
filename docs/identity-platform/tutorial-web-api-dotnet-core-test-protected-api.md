---
title: "Tutorial: Test an ASP.NET Core web API"
description:  Learn how to test a web API whose endpoints are protected using the Microsoft identity platform 
author: Dickson-Mwendia
manager: CelesteDG
ms.author: dmwendia
ms.date: 2/21/2025
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an application developer I want to test the security and functionality of my ASP.NET Core web API endpoints to ensure they're properly protected and responsive to HTTP requests.
---

# Test a protected ASP.NET Core web API

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

This tutorial is the final part of a series that demonstrates building and testing a protected web API registered in a Microsoft Entra tenant. In [Part 1 of this series](tutorial-web-api-dotnet-core-build-app.md), you created an ASP.NET Core web API and protected its endpoints. You'll now create a lightweight daemon app, register it in your tenant, and use the daemon app to test the web API you built.

In this tutorial, you learn how to:

> [!div class="checklist"]
>
> - Register the daemon app
> - Assign an app role to your daemon app
> - Create the daemon app
> - Run your daemon app to call the protected web API

## Prerequisites

- If you haven't already, complete the [Tutorial: Build and protect an ASP.NET Core web API with the Microsoft identity platform](tutorial-web-api-dotnet-core-build-app.md)

## Register the daemon app

[!INCLUDE [Register daemon app](../external-id/customers/includes/register-app/register-daemon-app.md)]

[!INCLUDE [Add app client secret](../external-id/customers/includes/register-app/add-app-client-secret.md)]

## Assign app role to your daemon app

Apps authenticating by themselves require app permissions.

[!INCLUDE [Add app client secret](../external-id/customers/includes/register-app/grant-api-permissions-app-permissions.md)]

## Build a daemon app

1. Initialize a .NET console app and navigate to its root folder:

    ```dotnetcli
    dotnet new console -o MyTestApp
    cd MyTestApp
    ```

1. Install MSAL.NET to help with handling authentication by running the following command:

    ```dotnetcli
    dotnet add package Microsoft.Identity.Client
    ```

1. Run your API project and note the port on which it's running.
1. Open the *Program.cs* file and replace the "Hello world" code with the following code.

    ```csharp
    using System;
    using System.Net.Http;
    using System.Net.Http.Headers;

    HttpClient client = new HttpClient();

    var response = await client.GetAsync("http://localhost:<your-api-port>/weatherforecast");
    Console.WriteLine("Your response is: " + response.StatusCode);
    ```

    Navigate to the daemon app root directory and run app using the command `dotnet run`. This code sends a request without an access token. You should see the string: *Your response is: Unauthorized* printed in your console.
1. Remove the code in step 4 and replace with the following to test your API by sending a request with a valid access token. This daemon app uses the client credentials flow to acquire an access token as it authenticates without user interaction. 

    ```csharp
    using Microsoft.Identity.Client;
    using System;
    using System.Net.Http;
    using System.Net.Http.Headers;

    HttpClient client = new HttpClient();

    var clientId = "<your-daemon-app-client-id>";
    var clientSecret = "<your-daemon-app-secret>";
    var scopes = new[] {"api://<your-web-api-application-id>/.default"};
    var tenantName= "<your-tenant-name>";
    var authority = $"https://{tenantName}.ciamlogin.com/"; 

    var app = ConfidentialClientApplicationBuilder
        .Create(clientId)
        .WithAuthority(authority)
        .WithClientSecret(clientSecret)
        .Build();

    var result = await app.AcquireTokenForClient(new string[] { scopes }).ExecuteAsync();
    Console.WriteLine($"Access Token: {result.AccessToken}");
    
    client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", result.AccessToken);
    var response = await client.GetAsync("http://localhost:/<your-api-port>/weatherforecast");
    var content = await response.Content.ReadAsStringAsync();
    
    Console.WriteLine("Your response is: " + response.StatusCode);
    Console.WriteLine(content);
    ```

    Navigate to the daemon app root directory and run app using the command `dotnet run`. This code sends a request with a valid access token. You should see the string: *Your response is: OK* printed in your console alongside some dummy weather forecast data from our minimal API.

## Related content

- [How to call a protected Web API with cURL](howto-call-a-web-api-with-curl.md)
- [How to call a protected web API with Insomnia](howto-call-a-web-api-with-rest-client.md)