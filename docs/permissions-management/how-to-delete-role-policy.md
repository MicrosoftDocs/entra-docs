---
title: Delete a role/policy in the Remediation dashboard in Permissions Management
description: How to delete a role/policy in the Microsoft Entra Permissions Management Remediation dashboard.
author: jenniferf-skc
manager: pmwongera
ms.service: entra-permissions-management

ms.topic: how-to
ms.date: 04/01/2025
ms.author: jfields
---

# Delete a role/policy in the Remediation dashboard

> [!NOTE]
> Effective April 1, 2025, Microsoft Entra Permissions Management will no longer be available for purchase, and on October 1, 2025, we'll retire and discontinue support of this product. More information can be found [here](https://aka.ms/MEPMretire).

This article describes how you can use the **Remediation** dashboard in Microsoft Entra Permissions Management to delete roles/policies for the Amazon Web Services (AWS), Microsoft Azure, or Google Cloud Platform (GCP) authorization systems.

> [!NOTE]
> To view the **Remediation** dashboard, you must have **Viewer**, **Controller**, or **Administrator** permissions. To make changes on this tab, you must have **Controller** or **Administrator** permissions. If you don't have these permissions, contact your system administrator.

> [!NOTE]
> Microsoft Azure uses the term *role* for what other Cloud providers call *policy*. Permissions Management automatically makes this terminology change when you select the authorization system type. In the user documentation, we use *role/policy* to refer to both.

## Delete a role/policy

1. On the Permissions Management home page, select the **Remediation** tab, and then select the **Role/Policies** subtab.
1. Select the role/policy you want to delete, and from the **Actions** column, select **Delete**.

    You can only delete a role/policy if it isn't assigned to an identity.

    You can't delete system roles/policies.

1. On the **Preview** page, review the role/policy information to make sure you want to delete it, and then select **Submit**.

## Next steps


- To view existing roles/policies, requests, and permissions, see [View roles/policies, requests, and permission in the Remediation dashboard](ui-remediation.md).
