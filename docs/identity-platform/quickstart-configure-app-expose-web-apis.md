---
title: "Quickstart: Register and expose a web API"
description: In this quickstart, your register a web API with the Microsoft identity platform and configure its scopes, exposing it to clients for permissions-based access to the API's resources.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: has-adal-ref 
ms.date: 06/10/2024
ms.reviewer: sureshja
ms.service: identity-platform

ms.topic: quickstart
#Customer intent: As an application developer, I need learn to how to register my web API with the Microsoft identity platform and expose permissions (scopes) to make the API's resources available to users of my client application.
---

# Quickstart: Configure an application to expose a web API

In this quickstart, you'll register a web API with the Microsoft identity platform and expose it to client apps by adding a scope. By registering your web API and exposing it through scopes, assigning an owner and app role, you can provide permissions-based access to its resources to authorized users and client apps that access your API.

## Prerequisites

* An Azure account with an active subscription - [create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F)
* Completion of [Quickstart: Set up a tenant](quickstart-create-new-tenant.md)
* An application registered in the Microsoft Entra admin center. If you don't have one, [register an application](quickstart-register-app.md#register-an-application) now.

## Register the web API

Access to APIs requires configuration of access scopes and roles. If you want to expose your resource application web APIs to client applications, configure access scopes and roles for the API. If you want a client application to access a web API, configure permissions to access the API in the app registration. To provide scoped access to the resources in your web API, you first need to register the API with the Microsoft identity platform.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="./media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the tenant containing the app registration from the **Directories + subscriptions** menu.
1. Perform the steps in [register an application](quickstart-register-app.md#register-an-application) and skip the **Redirect URI (optional)** section. You don't need to configure a redirect URI for a web API since no user is logged in interactively.

## Assign application owner 

1. In your app registration, under **Manage**, select **Owners**, and **Add owners**.
1. In the new window, find and select the owner(s) that you want to assign to the application. Selected owners appear in the right panel. Once done, confirm with **Select**. The app owner(s) will now appear in the owner's list.

>[!NOTE]
> Ensure that both the API application and the application you want to add permissions to both have an owner, otherwise the API will not be listed when requesting API permissions.

## Assign app role

1. In your app registration, under **Manage**, select **App roles**, and **Create app role**.
1. Next, specify the app role's attributes in the **Create app role** pane. For this walk-through, you can use the example values or specify your own. 

   | Field | Description | Example |
   |-------|-------------|---------|
   | **Display name** | The name of your app role | *Employee Records* |
   | **Allowed member types** | Specifies whether the app role can be assigned to users/groups and/or applications | *Applications* |
   | **Value** | The value displayed in the "roles" claim of a token | `Employee.Records` |
   | **Description** | A more detailed description of the app role | *Applications have access to employee records* |

1. Select the checkbox to enable the app role, and then select **Apply**.

## Add a scope

[!INCLUDE [portal updates](~/includes/portal-update.md)]

With the web API registered, assigned an app role and owner, you can add scopes to the API's code so it can provide granular permission to consumers.

The code in a client application requests permission to perform operations defined by your web API by passing an access token along with its requests to the protected resource (the web API). Your web API then performs the requested operation only if the access token it receives contains the scopes required for the operation.

### Add a scope requiring admin and user consent

First, follow these steps to create an example scope named `Employees.Read.All`:

1. Select **Expose an API**.
1. At the top of the page, select **Add** next to **Application ID URI**. This defaults to `api://<application-client-id>`. The App ID URI acts as the prefix for the scopes you'll reference in your API's code, and it must be globally unique. Select **Save**.
1. Select **Add a scope**:

    :::image type="content" source="media/quickstart-configure-app-expose-web-apis/portal-02-expose-api.png" alt-text="An app registration's Expose an API pane in the Azure portal":::


1. Next, specify the scope's attributes in the **Add a scope** pane. For this walk-through, you can use the example values or specify your own.

    | Field | Description | Example |
    |-------|-------------|---------|
    | **Scope name** | The name of your scope. A common scope naming convention is `resource.operation.constraint`. | `Employees.Read.All` |
    | **Who can consent** | Whether this scope can be consented to by users or if admin consent is required. **Admins only** should be used for higher-privileged permissions. | **Admins and users** |
    | **Admin consent display name** | A short description of the scope's purpose that only admins will see. | *Read-only access to Employee records* |
    | **Admin consent description** | A more detailed description of the permission granted by the scope that only admins will see. | *Allow the application to have read-only access to all Employee data.* |
    | **User consent display name** | A short description of the scope's purpose. Shown to users only if you set **Who can consent** to **Admins and users**. | *Read-only access to your Employee records* |
    | **User consent description** | A more detailed description of the permission granted by the scope. Shown to users only if you set **Who can consent** to **Admins and users**. | *Allow the application to have read-only access to your Employee data.* |
    | **State** | Whether the scope is enabled or disabled. | **Enabled** |

1. Select **Add scope**.

1. (Optional) To suppress prompting for consent by users of your app to the scopes you've defined, you can *pre-authorize* the client application to access your web API. Pre-authorize *only* those client applications you trust since your users won't have the opportunity to decline consent.
    1. Under **Authorized client applications**, select **Add a client application**
    1. Enter the **Application (client) ID** of the client application you want to pre-authorize. For example, that of a web application you've previously registered.
    1. Under **Authorized scopes**, select the scopes for which you want to suppress consent prompting, then select **Add application**.

    If you followed this optional step, the client app is now a pre-authorized client app (PCA), and users won't be prompted for their consent when signing in to it.

### Add a scope requiring admin consent

Next, add another example scope named `Employees.Write.All` that only admins can consent to. Scopes that require admin consent are typically used for providing access to higher-privileged operations, and often by client applications that run as backend services or daemons that don't sign in a user interactively.

To add the `Employees.Write.All` example scope, follow the steps in the [Add a scope](#add-a-scope) section and specify these values in the **Add a scope** pane. Select **Add scope** when you're done:

| Field                          | Example value                                                      |
|--------------------------------|--------------------------------------------------------------------|
| **Scope name**                 | `Employees.Write.All`                                              |
| **Who can consent**            | **Admins only**                                                    |
| **Admin consent display name** | *Write access to Employee records*                                 |
| **Admin consent description**  | *Allow the application to have write access to all Employee data.* |
| **User consent display name**  | *None (leave empty)*                                               |
| **User consent description**   | *None (leave empty)*                                               |
| **State**                      | **Enabled**                                                        |        

### Verify the exposed scopes

If you have successfully added both example scopes described in the previous sections, they'll appear in the **Expose an API** pane of your web API's app registration, similar to the following image:

:::image type="content" source="media/quickstart-configure-app-expose-web-apis/portal-03-scopes-list.png" alt-text="Screenshot of the Expose an API pane showing two exposed scopes.":::

The scope's full string is the concatenation of your web API's **Application ID URI** and the scope's **Scope name**. For example, if your web API's application ID URI is `https://contoso.com/api` and the scope name is `Employees.Read.All`, the full scope is:

`https://contoso.com/api/Employees.Read.All`

## Using the exposed scopes

In the next article in this series, you configure a client app's registration with access to your web API and the scopes you defined by following the steps in this article.

Once a client app registration is granted permission to access your web API, the client can be issued an OAuth 2.0 access token by the identity platform. When the client calls the web API, it presents an access token whose scope (`scp`) claim is set to the permissions you've specified in the client's app registration.

You can expose additional scopes later as necessary. Consider that your web API can expose multiple scopes associated with several operations. Your resource can control access to the web API at runtime by evaluating the scope (`scp`) claims in the OAuth 2.0 access token it receives.

## Next step

Now that you've exposed your web API by configuring its scopes, configure your client app's registration with permission to access the scopes.

> [!div class="nextstepaction"]
> [Configure an app registration for web API access](quickstart-configure-app-access-web-apis.md)

<!-- REF LINKS -->
[ms-graph-application]: /graph/api/resources/application
