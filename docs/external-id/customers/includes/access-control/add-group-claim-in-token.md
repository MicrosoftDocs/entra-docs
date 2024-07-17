---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: customers
ms.topic: include
ms.date: 06/20/2024
ms.author: kengaderdus
ms.manager: mwongerapk
---
To emit the group membership claims in security tokens, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an Application Administrator.
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="~/external-id/customers/media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu.
1. Browse to **Identity** > **Applications** > **App registrations**.
1. Select the application in which you want to add the groups claim.
1. Under **Manage**, select **Token configuration**.
1. Select **Add groups claim**.
1. Select group types to include in the security tokens.
1. For the **Customize token properties by type**, select **Group ID**.
1. Select **Add** to add the groups claim.