---
title: "Include file - Register a single-page application in the Microsoft identity platform"
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.date: 01/02/2024
ms.reviewer: 
ms.service: identity-platform
ms.topic: include
ms.custom: sfi-image-nochange
#Customer intent:
---

To complete registration, provide the application a name, specify the supported account types, and add a redirect URI. Once registered, the application **Overview** pane displays the identifiers needed in the application source code.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="../../../media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the tenant in which you want to register the application from the **Directories + subscriptions** menu.
1. Browse to **Entra ID** > **App registrations**, select **New registration**.
1. Enter a **Name** for the application, such as *identity-client-spa*.
1. For **Supported account types**, select **Accounts in this organizational directory only**. For information on different account types, select the **Help me choose** option.
1. Select **Register**.

    :::image type="content" source="../../../media/common-register-application/register-spa-common.png" alt-text="Screenshot that shows how to enter a name and select the account type in the Microsoft Entra admin center." lightbox="../../../media/common-register-application/register-spa-common.png":::

1. The application's **Overview** pane is displayed when registration is complete. Record the **Directory (tenant) ID** and the **Application (client) ID** to be used in your application source code.

    :::image type="content" source="../../../media/common-register-application/record-identifiers-spa-common.png" alt-text="Screenshot that shows the identifier values on the overview page on the Microsoft Entra admin center." lightbox="../../../media/common-register-application/record-identifiers-spa-common.png":::

    >[!NOTE]
    > The **Supported account types** can be changed by referring to [Modify the accounts supported by an application](../../../howto-modify-supported-accounts.md).
