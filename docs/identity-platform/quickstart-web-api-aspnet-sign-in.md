---
title: "Quickstart: Call a web API that is protected by the Microsoft identity platform"
description: In this quickstart, you download and modify a code sample that demonstrates how to protect an ASP.NE web API by using the Microsoft identity platform for authorization.
author: henrymbuguakiarie
manager: CelesteDG
ms.author: henrymbugua
ms.custom: devx-track-csharp, scenarios:getting-started, "languages:aspnet-core", mode-api, 
ms.date: 01/31/2024
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

#### [ASP.NET CORE](#tab/aspnet-core-workforce)

1. Under **Manage**, select **Expose an API** > **Add a scope**. Accept the proposed Application ID URI (`api://{clientId}`) by selecting **Save and continue**, and then enter the following information:

    1. For **Scope name**, enter `access_as_user`.
    1. For **Who can consent**, ensure that the **Admins and users** option is selected.
    1. In the **Admin consent display name** box, enter `Access TodoListService as a user`.
    1. In the **Admin consent description** box, enter `Accesses the TodoListService web API as a user`.
    1. In the **User consent display name** box, enter `Access TodoListService as a user`.
    1. In the **User consent description** box, enter `Accesses the TodoListService web API as a user`.
    1. For **State**, keep **Enabled**.
1. Select **Add scope**.

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