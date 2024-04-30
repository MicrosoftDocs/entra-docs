---
title: "Tutorial: Register a web API with the Microsoft identity platform"
description: In this tutorial, you learn how to register a web API with the Microsoft identity platform.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.date: 11/1/2022
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an application developer, I want to know how to register my application with the Microsoft identity platform so that the security token service can issue access tokens to client applications that request them.
---

# Tutorial: Register a web API with the Microsoft identity platform

In this tutorial, you learn how to register a web API in a Microsoft Entra ID tenant. You must register an application in the Microsoft Entra admin center to enable your application to interact with the Microsoft identity platform. In this article, you;

> [!div class="checklist"]
> * Register a web API in a tenant
> * Record the web API's unique identifiers
> * Expose an API by adding a scope

## Prerequisites

* An Azure account with an active subscription. [Create an account for free](https://azure.microsoft.com/free/).
* This Azure account must have permissions to manage applications. Use any of the following roles needed to register the application:
  * Application Administrator
  * Application developer
  * Cloud Application Administrator

## Register the application and record identifiers

[!INCLUDE [portal updates](~/includes/portal-update.md)]

To complete registration, provide the application a name and specify the supported account types. Once registered, the application **Overview** page will display the identifiers needed in the application source code.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Developer](~/identity/role-based-access-control/permissions-reference.md#application-developer).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the tenant in which you want to register the application from the **Directories + subscriptions** menu.
1. Browse to **Identity** > **Applications** > **App registrations**.
1. Select **New registration**.
1. Enter a **Name** for the application, such as *NewWebAPI1*.
1. For **Supported account types**, select **Accounts in this organizational directory only**. For information on different account types, select **Help me choose** option.
1. Select **Register**.

    :::image type="content" source="./media/web-api-tutorial-01-register-app/register-application.png" alt-text="Screenshot that shows how to enter a name and select the account type.":::

1. The application's **Overview** pane is displayed when registration is complete. Record the **Directory (tenant) ID** and the **Application (client) ID** to be used in your application source code.

    :::image type="content" source="./media/web-api-tutorial-01-register-app/record-identifiers.png" alt-text="Screenshot that shows the identifier values on the overview page.":::

>[!NOTE]
> The **Supported account types** can be changed by referring to [Modify the accounts supported by an application](howto-modify-supported-accounts.md).

## Expose an API

Once the API is registered, you can configure its permission by defining the scopes that the API exposes to client applications. Client applications request permission to perform operations by passing an access token along with its requests to the protected web API. The web API then performs the requested operation only if the access token it receives contains the required scopes.

1. Under **Manage**, select **Expose an API > Add a scope**. Accept the proposed **Application ID URI** `(api://{clientId})` by selecting **Save and continue**. The `{clientId}` will be the value recorded from the **Overview** page. Then enter the following information:
    1. For **Scope name**, enter `Forecast.Read`.
    1. For **Who can consent**, ensure that the **Admins and users** option is selected.
    1. In the **Admin consent display name** box, enter `Read forecast data`.
    1. In the **Admin consent description** box, enter `Allows the application to read weather forecast data`.
    1. In the **User consent display name** box, enter `Read forecast data`.
    1. In the **User consent description** box, enter `Allows the application to read weather forecast data`.
    1. Ensure that the **State** is set to **Enabled**.
1. Select **Add scope**. If the scope has been entered correctly, it'll be listed in the **Expose an API** pane.

    :::image type="content" source="./media/web-api-tutorial-01-register-app/add-a-scope.png" alt-text="Screenshot that shows the field values when adding the scope to an API." lightbox="./media/web-api-tutorial-01-register-app/add-a-scope.png":::

## Next steps

> [!div class="nextstepaction"]
> [Tutorial: Create an ASP.NET Core project and configure the API](tutorial-web-api-dotnet-prepare-app.md)
