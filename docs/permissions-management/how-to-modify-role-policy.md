---
title: Modify a role/policy in the Remediation dashboard in Permissions Management
description: How to modify a role/policy in the Remediation dashboard in Microsoft Entra Permissions Management.
author: jenniferf-skc
manager: femila
ms.service: entra-permissions-management

ms.topic: how-to
ms.date: 04/01/2025
ms.author: jfields
---

# Modify a role/policy in the Remediation dashboard

> [!NOTE]
> Effective April 1, 2025, Microsoft Entra Permissions Management will no longer be available for purchase, and on October 1, 2025, we'll retire and discontinue support of this product. More information can be found [here](https://aka.ms/MEPMretire).

This article describes how you can use the **Remediation** dashboard in Microsoft Entra Permissions Management to modify roles/policies for the Amazon Web Services (AWS), Microsoft Azure, or Google Cloud Platform (GCP) authorization systems.

> [!NOTE]
> To view the **Remediation** tab, you must have **Viewer**, **Controller**, or **Administrator** permissions. To make changes on this tab, you must have **Controller** or **Administrator** permissions. If you don't have these permissions, contact your system administrator.

> [!NOTE]
> Microsoft Azure uses the term *role* for what other cloud providers call *policy*. Permissions Management automatically makes this terminology change when you select the authorization system type. In the user documentation, we use *role/policy* to refer to both.

## Modify a role/policy

1. On the Permissions Management home page, select the **Remediation** tab, and then select the **Role/Policies** tab.
1. Select the role/policy you want to modify, and from the **Actions** column, select **Modify**.

     You can't modify **System** policies and roles.

1. On the **Statements** page, make your changes to the **Tasks**, **Resources**, **Request conditions**, and **Effect** sections as required, and then select **Next**.

1. Review the changes to the JSON or script on the **Preview** page, and then select **Submit**.

## Next steps

- For information on how to view existing roles/policies, requests, and permissions, see [View roles/policies, requests, and permission in the Remediation dashboard](ui-remediation.md).
- To view information about roles/policies, see [View information about roles/policies](how-to-view-role-policy.md).