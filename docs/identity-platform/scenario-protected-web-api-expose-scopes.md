---
title: Expose scopes in a protected web API 
description: Learn how to expose scopes in a protected web API.
author: cilwerner
manager: pmwongera
ms.author: cwerner
ms.custom: 
ms.date: 05/28/2024
ms.reviewer: jmprieur
ms.service: identity-platform
ms.subservice: workforce
ms.topic: how-to
#Customer intent: As an application developer, I want to know how to expose scopes for a protected web API using the Microsoft identity platform for developers.
---

Expose scopes in a protected web API 

[!INCLUDE [applies-to-workforce-only](../external-id/includes/applies-to-workforce-only.md)]

This article explains how to add scopes to an application for a protected web API.

## Prerequisites

* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID

## Scopes and the Application ID URI

Scopes usually have the form `resourceURI/scopeName`. For Microsoft Graph, the scopes have shortcuts. For example, `User.Read` is a shortcut for `https://graph.microsoft.com/user.read`.

During app registration, define these parameters:

- The resource URI
- One or more scopes
- One or more app roles

By default, the application registration portal recommends that you use the resource URI `api://{clientId}`. This URI is unique but not human readable. If you change the URI, make sure the new value is unique. The application registration portal will ensure that you use a [configured publisher domain](howto-configure-publisher-domain.md).

To client applications, scopes show up as *delegated permissions* and app roles show up as *application permissions* for your web API.

Scopes also appear on the consent window that's presented to users of your app. Therefore, provide the corresponding strings that describe the scope:

- As seen by a user.
- As seen by a tenant admin, who can grant admin consent.

App roles cannot be consented to by a user (as they're used by an application that calls the web API on behalf of itself). A tenant administrator will need to consent to client applications of your web API exposing app roles. See [Admin consent](v2-admin-consent.md) for details.

### Expose delegated permissions (scopes)

To expose delegated permissions, or *scopes*, follow the steps in [Configure an application to expose a web API](quickstart-configure-app-expose-web-apis.md).

If you're following along with the web API scenario described in this set of articles, use these settings:

- **Application ID URI**: Accept the proposed application ID URI (_api://\<clientId\>_) (if prompted)
- **Scope name**: *access_as_user*
- **Who can consent**: _Admins and users_
- **Admin consent display name**: _Access TodoListService as a user_
- **Admin consent description**: _Accesses the TodoListService web API as a user_
- **User consent display name**: _Access TodoListService as a user_
- **User consent description**: _Accesses the TodoListService web API as a user_
- **State**: _Enabled_

> [!TIP] 
> For the **Application ID URI**, you have the option to set it to the physical authority of the API, for example `https://graph.microsoft.com`. This can be useful if the URL of the API that needs to be called is known.

### If your web API is called by a service or daemon app

Expose *application permissions* instead of delegated permissions if your API should be accessed by daemons, services, or other non-interactive (by a human) applications. Because daemon- and service-type applications run unattended and authenticate with their own identity, there is no user to "delegate" their permission.

#### Expose application permissions (app roles)

To expose application permissions, follow the steps in [Add app roles to your app](./howto-add-app-roles-in-apps.md).

In the **Create app role** pane under **Allowed member types**, select **Applications**. Or, add the role by using the **Application manifest editor** as described in the article.

#### Restrict access tokens to specific clients apps

App roles are the mechanism an application developer uses to expose their app's permissions. Your web API's code should check for app roles in the access tokens it receives from callers.

To add another layer of security, a Microsoft Entra tenant administrator can configure their tenant so the Microsoft identity platform issues security tokens *only* to the client apps they've approved for API access.

To increase security by restricting token issuance only to client apps that have been assigned app roles:

1. In the [Microsoft Entra admin center](https://entra.microsoft.com), select your app under **Entra ID** > **App registrations**.
1. On the application's **Overview** page, in **Essentials**, find and select its **Managed application in local directory** link to navigate to its **Enterprise Application Overview** page.
1. Under **Manage**, select **Properties**.
1. Set **Assignment required?** to **Yes**.
1. Select **Save**.

Microsoft Entra ID will now check for app role assignments of client applications that request access tokens for your web API. If a client app hasn't been assigned any app roles, Microsoft Entra ID returns an error message to the client similar to `_invalid_client: AADSTS501051: Application \<application name\> isn't assigned to a role for the \<web API\>_`.

> [!WARNING]
> **DO NOT use AADSTS error codes** or their message strings as literals in your application's code. The "AADSTS" error codes and the error message strings returned by Microsoft Entra ID are *not immutable*, and may be changed by Microsoft at any time and without your knowledge. If you make branching decisions in your code based on the values of either the AADSTS codes or their message strings, you put your application's functionality and stability at risk.

## Next step

The next article in this series is [App code configuration](scenario-protected-web-api-app-configuration.md).
