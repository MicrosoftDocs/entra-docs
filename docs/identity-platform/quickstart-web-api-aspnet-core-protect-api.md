---
title: "Quickstart: Protect an ASP.NET Core web API with the Microsoft identity platform"
description: In this quickstart, you download and modify a code sample that demonstrates how to protect an ASP.NET Core web API by using the Microsoft identity platform for authorization.
author: henrymbuguakiarie
manager: CelesteDG
ms.author: henrymbugua
ms.custom: devx-track-csharp, scenarios:getting-started, "languages:aspnet-core", mode-api, 
ms.date: 01/31/2024
ms.reviewer: jmprieur
ms.service: identity-platform

ms.topic: quickstart
#Customer intent: As an application developer, I want to know how to write an ASP.NET Core web API that uses the Microsoft identity platform to authorize API requests from clients.
---

# Quickstart: Protect an ASP.NET Core web API with the Microsoft identity platform

This quickstart uses an ASP.NET Core web API code sample to demonstrate how to restrict resource access to authorized accounts. The sample uses [ASP.NET Core Identity](/aspnet/core/security/authentication/identity) that interacts with [Microsoft Authentication Library (MSAL)](msal-overview.md) to handle authentication.


## Prerequisites

- Azure account with an active subscription. If you don't already have one, [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- A minimum requirement of [.NET 8.0 SDK](https://dotnet.microsoft.com/download/dotnet)
- [Visual Studio 2022](https://visualstudio.microsoft.com/vs/) or [Visual Studio Code](https://code.visualstudio.com/)

## Register the application and record identifiers

[!INCLUDE [portal updates](~/includes/portal-update.md)]

To complete registration, provide the application a name and specify the supported account types. Once registered, the application **Overview** page displays the identifiers needed in the application source code.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Developer](~/identity/role-based-access-control/permissions-reference.md#application-developer).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the tenant in which you want to register the application from the **Directories + subscriptions** menu.
1. Browse to **Identity** > **Applications** > **App registrations**.
1. Select **New registration**.
1. Enter a **Name** for the application, such as *NewWebAPI1*.
1. For **Supported account types**, select **Accounts in this organizational directory only**. For information on different account types, select **Help me choose** option.
1. Select **Register**.

    :::image type="content" source="./media/web-api-tutorial-01-register-app/register-application.png" alt-text="Screenshot that shows how to enter a name and select the account type.":::

1. The application's **Overview** pane is displayed when registration is complete. Record the **Directory (tenant) ID** and the **Application (client) ID** to be used in your application source code.

    :::image type="content" source="./media/web-api-tutorial-01-register-app/app-identifiers.png" alt-text="Screenshot that shows the identifier values on the overview page.":::

>[!NOTE]
> The **Supported account types** can be changed by referring to [Modify the accounts supported by an application](howto-modify-supported-accounts.md).

## Expose an API

Once the API is registered, you can configure its permission by defining the scopes that the API exposes to client applications. Client applications request permission to perform operations by passing an access token along with its requests to the protected web API. The web API then performs the requested operation only if the access token it receives contains the required scopes.

1. Under **Manage**, select **Expose an API > Add a scope**. Accept the proposed **Application ID URI** `(api://{clientId})` by selecting **Save and continue**. The `{clientId}` is the value recorded from the **Overview** page. Then enter the following information:
    1. For **Scope name**, enter `Forecast.Read`.
    1. For **Who can consent**, ensure that the **Admins and users** option is selected.
    1. In the **Admin consent display name** box, enter `Read forecast data`.
    1. In the **Admin consent description** box, enter `Allows the application to read weather forecast data`.
    1. In the **User consent display name** box, enter `Read forecast data`.
    1. In the **User consent description** box, enter `Allows the application to read weather forecast data`.
    1. Ensure that the **State** is set to **Enabled**.
1. Select **Add scope**. If the scope has been entered correctly, it's listed in the **Expose an API** pane.

    :::image type="content" source="./media/web-api-tutorial-01-register-app/add-a-scope.png" alt-text="Screenshot that shows the field values when adding the scope to an API." lightbox="./media/web-api-tutorial-01-register-app/add-a-scope.png":::

## Clone or download the sample application

To obtain the sample application, you can either clone it from GitHub or download it as a *.zip* file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

  ```console
  git clone https://github.com/Azure-Samples/ms-identity-docs-code-dotnet.git
  ```

- [Download the .zip file](https://github.com/Azure-Samples/ms-identity-docs-code-dotnet/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.

## Configure the ASP.NET Core sample application

1. In your IDE, open the project folder, *ms-identity-docs-code-dotnet/web-api*, containing the sample.
1. Open `appsettings.json` file, which contains the following code snippet:

    :::code language="json" source="~/../ms-identity-docs-code-dotnet/web-api/appsettings.json" :::

    Find the following `key`:

    - `ClientId` - The identifier of the application, also referred to as the client. Replace the `value` text in quotes with **Application (client) ID** that was recorded earlier from the **Overview** page of the registered application.
    - `TenantId` - The identifier of the tenant where the application is registered. Replace the `value` text in quotes with **Directory (tenant) ID** value that was recorded earlier from the **Overview** page of the registered application.

## Run the sample application

1. Execute the following command to start the app:

   ```bash
   dotnet run
   ```

1. An output like the following sample appears:

   ```bash
   ...
   info: Microsoft.Hosting.Lifetime[14]
         Now listening on: http://localhost:{port}
   ...
   ```

   Record the port number in the `http://localhost:{port}` URL.

1. To verify the endpoint is protected, update the base URL in the following cURL command to match the one you received in the previous step, and then run the command:

   ```bash
   curl -X GET https://localhost:5001/weatherforecast -ki
   ```

   The expected response is 401 Unauthorized with output similar to:

   ```bash
   user@host:~$ curl -X GET https://localhost:5001/weatherforecast -ki
   HTTP/2 401
   date: Fri, 23 Sep 2023 23:34:24 GMT
   server: Kestrel
   www-authenticate: Bearer
   content-length: 0
   ```

## Next steps

Proceed to the next article to learn how to call the protected web API using cURL.

> [!div class="nextstepaction"]
> [How-to: Call an ASP.NET Core web API with cURL](howto-call-a-web-api-with-curl.md)
