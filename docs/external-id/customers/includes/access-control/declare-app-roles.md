---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 09/06/2024
ms.author: kengaderdus
ms.manager: dougeby
---

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Privileged Role Administrator](../../../../identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="~/external-id/customers/media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu. 
1. Browse to **Entra ID** > **App registrations**.
1. Select the application you want to define app roles in.
1. Select **App roles**, and then select **Create app role**.
1. In the **Create app role** pane, enter the settings for the role. The following table describes each setting and its parameters.
    
   | Field    | Description | Example |
   | ----- | ----- | ----- |
   | **Display name** | Display name for the app role that appears in the app assignment experiences. This value may contain spaces. | `Orders manager`|
   | **Allowed member types**  | Specifies whether this app role can be assigned to users, applications, or both. | `Users/Groups`                |
   | **Value** | Specifies the value of the roles claim that the application should expect in the token. The value should exactly match the string referenced in the application's code. The value can't contain spaces.| `Orders.Manager`               |
   | **Description** | A more detailed description of the app role displayed during admin app assignment experiences. | `Manage online orders.` |
   | **Do you want to enable this app role?** | Specifies whether the app role is enabled. To delete an app role, deselect this checkbox and apply the change before attempting the delete operation.| *Checked* |

1. Select **Apply** to create the application role.
