---
author: henrymbuguakiarie
ms.service: entra-external-id
ms.subservice: customers
ms.topic: include
ms.date: 07/12/2023
ms.author: henrymbugua
ms.manager: mwongerapk
---

Security groups manage user and computer access to shared resources. You can create a security group so that all group members have the same set of security permissions.

To create a security group, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a Conditional Access Administrator, Security Administrator, or Global Administrator. 
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="~/external-id/customers/media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu. 
1. Browse to **Identity** > **Groups** > **All groups**.
1. Select **New group**.
1. Under **Group type** dropdown, select **Security**.
1. Enter **Group name** for the security group, such as _Contoso_App_Administrators_.
1. Enter **Group description** for the security group, such as _Contoso app Security Administrator_.
1. Select **Create**.

The new security group appears in the **All groups** list. If you don't see it immediately, refresh the page.