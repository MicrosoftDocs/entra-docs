---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 11/31/2024
ms.author: kengaderdus
ms.manager: mwongerapk
---

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Developer](~/identity/role-based-access-control/permissions-reference.md#application-developer).

1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="~/external-id/customers/media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu. 

1. Browse to **Entra ID** > **App registrations**.

1. Select **+ New registration**.

1. In the **Register an application** page that appears, enter your application's registration information:

    1. In the Name section, enter a meaningful application name, for example *edit-profile-service*.

    1. Under **Supported account types**, select **Accounts in this organizational directory only**.

1. Select **Register** to create the application.

1. The application's **Overview pane** is displayed when registration is complete. Record the **Application (client) ID** for use in your application source code.