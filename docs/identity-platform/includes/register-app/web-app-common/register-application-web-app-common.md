---
title: "Include file - Register a web application in the Microsoft identity platform"
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.custom:
ms.date: 01/18/2024
ms.reviewer:
ms.service: identity-platform

ms.topic: include
---

To enable your application to sign in users, Microsoft Entra ID must be made aware of the application you create. The app registration establishes a trust relationship between the app and Microsoft Entra. When you register an application, External ID generates a unique identifier known as an **Application (client) ID**, a value used to identify your app when creating authentication requests.

To complete registration, provide the application a name and specify the supported account types. Once registered, the application **Overview** pane displays the identifiers needed in the application source code.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="../../../media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the tenant in which you want to register the application from the **Directories + subscriptions** menu.
1. Browse to **Identity** > **Applications** > **App registrations**, select **New registration**.
1. Enter a **Name** for the application, such as *identity-client-web-app*.
1. For **Supported account types**, select **Accounts in this organizational directory only**. For information on different account types, select the **Help me choose** option.
1. Select **Register**.

    :::image type="content" source="../../../media/common-register-application/register-web-app-common.png" alt-text="Screenshot that shows how to enter a name and select the account type in the Microsoft Entra admin center." lightbox="../../../media/common-register-application/register-web-app-common.png":::

1. The application's **Overview** pane is displayed when registration is complete. Record the **Directory (tenant) ID** and the **Application (client) ID** to be used in your application source code.

    :::image type="content" source="../../../media/common-register-application/record-identifiers-web-app-common.png" alt-text="Screenshot that shows the identifier values on the overview page on the Microsoft Entra admin center." lightbox="../../../media/common-register-application/record-identifiers-web-app-common.png":::

    >[!NOTE]
    > The **Supported account types** can be changed by referring to [Modify the accounts supported by an application](../../../howto-modify-supported-accounts.md).