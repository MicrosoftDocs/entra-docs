---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: customers
ms.topic: include
ms.date: 09/06/2024
ms.author: kengaderdus
ms.manager: mwongerapk
---
Now that you've added app groups claim in your application, add users to the security groups. If you don't have security group, [create one](~/fundamentals/how-to-manage-groups.yml#create-a-basic-group-and-add-members).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](../../../../identity/role-based-access-control/permissions-reference.md#groups-administrator).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="~/external-id/customers/media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu. 
1. Browse to **Identity** > **Groups** > **All groups**.
1. Select the group you want to manage.
1. Select  **Members**.
1. Select **+ Add members**.
1. Scroll through the list or enter a name in the search box. You can choose multiple names. When you're ready, choose **Select**.
1. The **Group Overview** page updates to show the number of members who are now added to the group.