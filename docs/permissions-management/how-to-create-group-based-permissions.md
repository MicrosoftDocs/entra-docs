---
title: Select group-based permissions settings with the User management dashboard
description: How to select group-based permissions settings with the User management dashboard.
author: jenniferf-skc
manager: pmwongera
ms.service: entra-permissions-management

ms.topic: how-to
ms.date: 04/01/2025
ms.author: jfields
---

# Select group-based permissions settings

> [!NOTE]
> Effective April 1, 2025, Microsoft Entra Permissions Management will no longer be available for purchase, and on October 1, 2025, we'll retire and discontinue support of this product. More information can be found [here](https://aka.ms/MEPMretire).

This article describes how you can create  and manage group-based permissions in Microsoft Entra Permissions Management with the User management dashboard.

> [!NOTE] 
> The Permissions Management Administrator for all authorization systems will be able to create the new group based permissions.

## Select administrative permissions settings for a group

1. To display the **User Management** dashboard, select **User** (your initials) in the upper right of the screen, and then select **User Management**.
1. Select the **Groups** tab, and then press the **Create Permission** button in the upper right of the table.
1. In the **Set Group Permission** box, begin typing the name of a **Microsoft Entra Security Group** in your tenant.

1. Select the permission setting you want:
2.
    - **Admin for all Authorization System Types** provides **View**, **Control**, and **Approve** permissions for all authorization system types.
    - **Admin for selected Authorization System Types** provides **View**, **Control**, and **Approve** permissions for selected authorization system types.
    - **Custom** allows you to set **View**, **Control**, and **Approve** permissions for the authorization system types that you select.
1. Select **Next**

1. If you selected **Admin for all Authorization System Types**
    - Select Identities to add for each Authorization System. Added Identities will have access to submit requests from the **Remediation** tab.

1. If you selected **Admin for selected Authorization System Types**
    - Select **Viewer**, **Controller**, or **Approver** for the **Authorization System Types** you want.
    - Select **Next** and then select Select Identities to add for each Authorization System. Added Identities will have access to submit requests from the **Remediation** tab.

1. If you select **Custom**, select the **Authorization System Types** you want.
    - Select **Viewer**, **Controller**, or **Approver** for the **Authorization Systems** you want.
    - Select **Next** and then select Select Identities to add for each Authorization System. Added Identities will have access to submit requests from the **Remediation** tab.

1. Select **Save**, The following message appears: **New Group Has been Created Successfully.**
1. To see the group you created in the **Groups** table, refresh the page.

## Next steps

- For information about how to manage user information, see [Manage users and groups with the User management dashboard](ui-user-management.md).
