---
title: "Tutorial: Test a  ASP.NET Core web API"
description:  Learn how to test a protected web API protected 
author: Dickson-Mwendia
manager: CelesteDG
ms.author: dmwendia
ms.date: 2/21/2025
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an application developer I want to protect the endpoint of my API and run it to ensure it is listening for HTTP requests
---

# Test a protected ASP.NET Core web API

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]


In this tutorial, you'll:




## Prerequisites

# Test your protected API

This tutorial is the final part of a series that demonstrates building and testing a protected web API that is registered in an external tenant. In [Part 1 of this series](./tutorial-protect-web-api-dotnet-core-build-app.md), you created an ASP.NET Core web API and protected its endpoints. In this final step, you'll create a lightweight daemon app, register it in the  and test your API.

In this tutorial, you learn how to:

> [!div class="checklist"]
>
> - Test a protected web API using a lightweight daemon app that calls the web API

## Prerequisites

- If you haven't already, complete the [Tutorial: Build and protect an ASP.NET Core web API with the Microsoft identity platform](tutorial-web-api-dotnet-core-build-app.md)

## Register the daemon app

[!INCLUDE [Register daemon app](./includes/register-app/register-daemon-app.md)]

[!INCLUDE [Add app client secret](./includes/register-app/add-app-client-secret.md)]

## Assign app role to your daemon app

Apps authenticating by themselves require app permissions.

[!INCLUDE [Add app client secret](./includes/register-app/grant-api-permissions-app-permissions.md)]

## Write code

1. Initialize a .NET console app and navigate to its root folder

    ```dotnetcli
    dotnet new console -o MyTestApp
    cd MyTestApp
    ```

1. Install MSAL to help you with handling authentication by running the following command:

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

    var response = await client.GetAsync("https://localhost:<your-api-port>/api/todolist");
    Console.WriteLine("Your response is: " + response.StatusCode);
    ```

    Navigate to the daemon app root directory and run app using the command `dotnet run`. This code sends a request without an access token. You should see the string: *Your response is: Unauthorized* printed in your console.
1. Remove the code in step 4 and replace with the following to test your API by sending a request with a valid access token.

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

    var result = await app.AcquireTokenForClient(scopes).ExecuteAsync();

    client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", result.AccessToken);
    var response = await client.GetAsync("https://localhost:44351/api/todolist");
    Console.WriteLine("Your response is: " + response.StatusCode);
    ```

    Navigate to the daemon app root directory and run app using the command `dotnet run`. This code sends a request with a valid access token. You should see the string: *Your response is: OK* printed in your console.

## See also