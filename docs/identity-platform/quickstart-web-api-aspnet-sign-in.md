---
title: "Quickstart: Call a web API that is protected by the Microsoft identity platform"
description: In this quickstart, you download and modify a code sample that demonstrates how to protect an ASP.NET web API by using the Microsoft identity platform for authorization.
author: henrymbuguakiarie
manager: CelesteDG
ms.author: henrymbugua
ms.custom: devx-track-csharp, scenarios:getting-started, "languages:aspnet-core", mode-api, 
ms.date: 01/31/2025
ms.reviewer: jmprieur
ms.service: identity-platform

ms.topic: quickstart
#Customer intent: As an application developer, I want to know how to write an ASP.NET web API that uses the Microsoft identity platform to authorize API requests from clients.
---

# Quickstart: Call a web API that is protected by the Microsoft identity platform

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-workforce-only.md)]

In this quickstart, you use a sample web app to show you how to protect an ASP.NET web API by using the Microsoft identity platform. The sample uses [Microsoft Authentication Library (MSAL)](msal-overview.md) to handle authentication.

## Prerequisites

* An Azure account with an active subscription. [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* Visual Studio 2022. Download [Visual Studio for free](https://www.visualstudio.com/downloads/).

## Register web API application

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

#### [ASP.NET](#tab/aspnet-workforce)

1. Under **Manage**, select **Expose an API** > **Add a scope**. Accept the proposed Application ID URI (`api://{clientId}`) by selecting **Save and continue**, and then enter the following information:

    1. For **Scope name**, enter `access_as_user`.
    1. For **Who can consent**, ensure that the **Admins and users** option is selected.
    1. In the **Admin consent display name** box, enter `Access TodoListService as a user`.
    1. In the **Admin consent description** box, enter `Accesses the TodoListService web API as a user`.
    1. In the **User consent display name** box, enter `Access TodoListService as a user`.
    1. In the **User consent description** box, enter `Accesses the TodoListService web API as a user`.
    1. For **State**, keep **Enabled**.
1. Select **Add scope**.

#### [ASP.NET CORE](#tab/aspnet-core-workforce)

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

---

## Clone or download the sample application

To obtain the sample application, you can either clone it from GitHub or download it as a *.zip* file.

#### [ASP.NET](#tab/aspnet-workforce)

```console
git clone https://github.com/AzureADQuickStarts/AppModelv2-NativeClient-DotNet.git
```

* [Download it as a ZIP file](https://github.com/AzureADQuickStarts/AppModelv2-NativeClient-DotNet/archive/complete.zip).

[!INCLUDE [active-directory-develop-path-length-tip](includes/error-handling-and-tips/path-length-tip.md)]

#### [ASP.NET CORE](#tab/aspnet-core-workforce)

```console
git clone https://github.com/Azure-Samples/ms-identity-docs-code-dotnet.git
```

* [Download the .zip file](https://github.com/Azure-Samples/ms-identity-docs-code-dotnet/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.

---

## Configure the sample application

Configure the code sample to match the registered web API.

#### [ASP.NET](#tab/aspnet-workforce)

1. Open the solution in Visual Studio, and then open the *appsettings.json* file under the root of the TodoListService project.

1. Replace the value of the `Enter_the_Application_Id_here` by the Client ID (Application ID) value from the application you registered in the **App registrations** portal both in the `ClientID` and the `Audience` properties.

### Add the new scope to the app.config file

To add the new scope to the TodoListClient *app.config* file, follow these steps:

1. In the TodoListClient project root folder, open the *app.config* file.

1. Paste the Application ID from the application that you registered for your TodoListService project in the `TodoListServiceScope` parameter, replacing the `{Enter the Application ID of your TodoListService from the app registration portal}` string.

  > [!NOTE]
  > Make sure that the Application ID uses the following format: `api://{TodoListService-Application-ID}/access_as_user` (where `{TodoListService-Application-ID}` is the GUID representing the Application ID for your TodoListService app).

## Register the web app (TodoListClient)

Register your TodoListClient app in **App registrations** in the Azure portal, and then configure the code in the TodoListClient project. If the client and server are considered the same application, you can reuse the application that's registered in step 2. Use the same application if you want users to sign in with a personal Microsoft account.

### Register the app

To register the TodoListClient app, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 
1. Browse to **Identity** > **Applications** > **App registrations** and select **New registration**.
1. Select **New registration**.
1. When the **Register an application page** opens, enter your application's registration information:

    1. In the **Name** section, enter a meaningful application name that will be displayed to users of the app (for example, **NativeClient-DotNet-TodoListClient**).
    1. For **Supported account types**, select **Accounts in any organizational directory**.
    1. Select **Register** to create the application.

   > [!NOTE]
   > In the TodoListClient project *app.config* file, the default value of `ida:Tenant` is set to `common`. The possible values are:
   >
   > - `common`: You can sign in by using a work or school account or a personal Microsoft account (because you selected **Accounts in any organizational directory** in a previous step).
   > - `organizations`: You can sign in by using a work or school account.
   > - `consumers`: You can sign in only by using a Microsoft personal account.

1. On the app **Overview** page, select **Authentication**, and then complete these steps to add a platform:

    1. Under **Platform configurations**, select the **Add a platform** button.
    1. For **Mobile and desktop applications**, select **Mobile and desktop applications**.
    1. For **Redirect URIs**, select the `https://login.microsoftonline.com/common/oauth2/nativeclient` check box.
    1. Select **Configure**.

1. Select **API permissions**, and then complete these steps to add permissions:

    1. Select the **Add a permission** button.
    1. Select the **My APIs** tab.
    1. In the list of APIs, select **AppModelv2-NativeClient-DotNet-TodoListService API** or the name you entered for the web API.
    1. Select the **access_as_user** permission check box if it's not already selected. Use the Search box if necessary.
    1. Select the **Add permissions** button.

### Configure your project

Configure your TodoListClient project by adding the Application ID to the *app.config* file.

1. In the **App registrations** portal, on the **Overview** page, copy the value of the **Application (client) ID**.

1. From the TodoListClient project root folder, open the *app.config* file, and then paste the Application ID value in the `ida:ClientId` parameter.

#### [ASP.NET CORE](#tab/aspnet-core-workforce)

1. In your IDE, open the project folder, *ms-identity-docs-code-dotnet/web-api*, containing the sample.
1. Open `appsettings.json` file, which contains the following code snippet:

    :::code language="json" source="~/../ms-identity-docs-code-dotnet/web-api/appsettings.json" :::

    Find the following `key`:

    - `ClientId` - The identifier of the application, also referred to as the client. Replace the `value` text in quotes with **Application (client) ID** that was recorded earlier from the **Overview** page of the registered application.
    - `TenantId` - The identifier of the tenant where the application is registered. Replace the `value` text in quotes with **Directory (tenant) ID** value that was recorded earlier from the **Overview** page of the registered application.

---

## Run the sample application

#### [ASP.NET](#tab/aspnet-workforce)

Start both projects. For Visual Studio users;

1. Right click on the Visual Studio solution and select **Properties**

1. In the **Common Properties** select **Startup Project** and then **Multiple startup projects**. 

1. For both projects choose **Start** as the action

1. Ensure the TodoListService service starts first by moving it to the first position in the list, using the up arrow.

Sign in to run your TodoListClient project.

1. Press F5 to start the projects. The service page opens, as well as the desktop application.

1. In the TodoListClient, at the upper right, select **Sign in**, and then sign in with the same credentials you used to register your application, or sign in as a user in the same directory.

   If you're signing in for the first time, you might be prompted to consent to the TodoListService web API.

   To help you access the TodoListService web API and manipulate the *To-Do* list, the sign-in also requests an access token to the *access_as_user* scope.

## Pre-authorize your client application

You can allow users from other directories to access your web API by pre-authorizing the client application to access your web API. You do this by adding the Application ID from the client app to the list of pre-authorized applications for your web API. By adding a pre-authorized client, you're allowing users to access your web API without having to provide consent.

1. In the **App registrations** portal, open the properties of your TodoListService app.
1. In the **Expose an API** section, under **Authorized client applications**, select **Add a client application**.
1. In the **Client ID** box, paste the Application ID of the TodoListClient app.
1. In the **Authorized scopes** section, select the scope for the `api://<Application ID>/access_as_user` web API.
1. Select **Add application**.

### Run your project

1. Press <kbd>F5</kbd> to run your project. Your TodoListClient app opens.
1. At the upper right, select **Sign in**, and then sign in by using a personal Microsoft account, such as a *live.com* or *hotmail.com* account, or a work or school account.

## Optional: Limit sign-in access to certain users

By default, any personal accounts, such as *outlook.com* or *live.com* accounts, or work or school accounts from organizations that are integrated with Microsoft Entra ID can request tokens and access your web API.

To specify who can sign in to your application, by changing the `TenantId` property in the *appsettings.json* file.

#### [ASP.NET CORE](#tab/aspnet-core-workforce)

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

---

## Next steps

#### [ASP.NET](#tab/aspnet-workforce)

Learn more by building a protected ASP.NET Core web api in the following tutorial series:

> [!div class="nextstepaction"]
> [Protected web API tutorial](tutorial-web-api-dotnet-register-app.md)


#### [ASP.NET CORE](#tab/aspnet-core-workforce)

Proceed to the next article to learn how to call the protected web API using cURL.

> [!div class="nextstepaction"]
> [How-to: Call an ASP.NET Core web API with cURL](howto-call-a-web-api-with-curl.md)

---

