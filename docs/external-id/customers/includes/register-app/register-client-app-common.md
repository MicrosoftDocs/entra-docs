---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: customers
ms.topic: include
ms.date: 03/30/2023
ms.author: kengaderdus
ms.manager: mwongerapk
---
<!--Doesn't apply to daemon app-->

To enable your application to sign in users with Microsoft Entra, Microsoft Entra External ID must be made aware of the application you create. The app registration establishes a trust relationship between the app and Microsoft Entra. When you register an application, External ID generates a unique identifier known as an **Application (client) ID**, a value used to identify your app when creating authentication requests.

The following steps show you how to register your app in the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Developer](~/identity/role-based-access-control/permissions-reference.md#application-developer).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="~/external-id/customers/media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu. 
1. Browse to **Identity** >**Applications** > **App registrations**.
1. Select **+ New registration**.
1. In the **Register an application** page that appears;

    1. Enter a meaningful application **Name** that is displayed to users of the app, for example *ciam-client-app*.
    1. Under **Supported account types**, select **Accounts in this organizational directory only**.

1. Select **Register**.
1. The application's **Overview** pane displays upon successful registration. Record the **Application (client) ID** to be used in your application source code.
