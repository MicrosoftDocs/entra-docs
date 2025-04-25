---
title: Revoke access to high-risk and unused tasks or assign read-only status for Microsoft Azure and Google Cloud Platform (GCP) identities in the Remediation dashboard
description: How to revoke access to high-risk and unused tasks or assign read-only status for Microsoft Azure and Google Cloud Platform (GCP) identities in the Remediation dashboard.
author: jenniferf-skc
manager: femila
ms.service: entra-permissions-management

ms.topic: how-to
ms.date: 04/01/2025
ms.author: jfields
---

# Revoke access to high-risk and unused tasks or assign read-only status for Microsoft Azure and Google Cloud Platform (GCP) identities

> [!NOTE]
> Effective April 1, 2025, Microsoft Entra Permissions Management will no longer be available for purchase, and on October 1, 2025, we'll retire and discontinue support of this product. More information can be found [here](https://aka.ms/MEPMretire).

This article describes how you can revoke high-risk and unused tasks or assign read-only status for Microsoft Azure and Google Cloud Platform (GCP) identities using the **Remediation** dashboard.

> [!NOTE]
> To view the **Remediation** tab, your must have **Viewer**, **Controller**, or **Administrator** permissions. To make changes on this tab, you must have **Controller** or **Administrator** permissions. If you don't have these permissions, contact your system administrator.

## View an identity's permissions

1. On the Permissions Management home page, select the **Remediation** tab, and then select the **Permissions** subtab.
1. From the **Authorization System Type** dropdown, select **Azure** or **GCP**.
1. From the **Authorization System** dropdown, select the accounts you want to access.
1. From the **Search for** dropdown, select **Group**, **User**, or **APP/Service Account**.
1. To search for more parameters, you can make a selection from the **User States**, **Permission Creep Index**, and **Task Usage** dropdowns.
1. Select **Apply**.

    Permissions Management displays a list of groups, users, and service accounts that match your criteria.
1. In **Enter a username**, enter or select a user.
1. In **Enter a Group Name**, enter or select a group, then select **Apply**.
1. Make a selection from the results list.

    The table displays the **Username** **Domain/Account**, **Source**, **Resource** and **Current Role**.


## Revoke an identity's access to unused tasks

1. On the Permissions Management home page, select the **Remediation** tab, and then select the **Permissions** subtab.
1. From the **Authorization System Type** dropdown, select **Azure** or **GCP**.
1. From the **Authorization System** dropdown, select the accounts you want to access.
1. From the **Search for** dropdown, select **Group**, **User**, or **APP/Service Account**, and then select **Apply**.
1. Make a selection from the results list.

1. To revoke an identity's access to tasks they aren't using, select **Revoke Unused Tasks**.
1. When the following message displays: **Are you sure you want to change permission?**, select:
    - **Generate Script** to generate a script where you can manually add/remove the permissions you selected.
    - **Execute** to change the permission.
    - **Close** to cancel the action.

## Revoke an identity's access to high-risk tasks

1. On the Permissions Management home page, select the **Remediation** tab, and then select the **Permissions** subtab.
1. From the **Authorization System Type** dropdown, select **Azure** or **GCP**.
1. From the **Authorization System** dropdown, select the accounts you want to access.
1. From the **Search For** dropdown, select **Group**, **User**, or **APP/Service Account**, and then select **Apply**.
1. Make a selection from the results list.

1. To revoke an identity's access to high-risk tasks, select **Revoke High-Risk Tasks**.
1. When the following message displays: **Are you sure you want to change permission?**, select:
    - **Generate Script** to generate a script where you can manually add/remove the permissions you selected.
    - **Execute** to change the permission.
    - **Close** to cancel the action.

## Revoke an identity's ability to delete tasks

1. On the Permissions Management home page, select the **Remediation** tab, and then select the **Permissions** subtab.
1. From the **Authorization System Type** dropdown, select **Azure** or **GCP**.
1. From the **Authorization System** dropdown, select the accounts you want to access.
1. From the **Search For** dropdown, select **Group**, **User**, or **APP/Service Account**, and then select **Apply**.
1. Make a selection from the results list.

1. To revoke an identity's ability to delete tasks, select **Revoke Delete Tasks**.
1. When the following message displays: **Are you sure you want to change permission?**, select:
    - **Generate Script** to generate a script where you can manually add/remove the permissions you selected.
    - **Execute** to change the permission.
    - **Close** to cancel the action.

## Assign read-only status to an identity

1. On the Permissions Management home page, select the **Remediation** tab, and then select the **Permissions** subtab.
1. From the **Authorization System Type** dropdown, select **Azure** or **GCP**.
1. From the **Authorization System** dropdown, select the accounts you want to access.
1. From the **Search for** dropdown, select **Group**, **User**, or **APP/Service Account**, and then select **Apply**.
1. Make a selection from the results list.

1. To assign read-only status to an identity, select **Assign Read-Only Status**.
1. When the following message displays: **Are you sure you want to change permission?**, select:
    - **Generate Script** to generate a script where you can manually add/remove the permissions you selected.
    - **Execute** to change the permission.
    - **Close** to cancel the action.


## Next steps

- For information on how to add and remove roles and tasks for Azure and GCP identities, see [Add and remove roles and tasks for Azure and GCP identities](how-to-attach-detach-permissions.md).
