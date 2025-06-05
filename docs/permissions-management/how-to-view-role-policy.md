---
title: View information about roles/policies in the Remediation dashboard
description: How to view and filter information about roles/policies in the Microsoft Entra Permissions Management Remediation dashboard.
author: jenniferf-skc
manager: femila
ms.service: entra-permissions-management

ms.topic: how-to
ms.date: 04/01/2025
ms.author: jfields
---

# View information about roles/ policies in the Remediation dashboard

> [!NOTE]
> Effective April 1, 2025, Microsoft Entra Permissions Management will no longer be available for purchase, and on October 1, 2025, we'll retire and discontinue support of this product. More information can be found [here](https://aka.ms/MEPMretire).

The **Remediation** dashboard in Permissions Management enables system administrators to view, adjust, and remediate excessive permissions based on a user's activity data. You can use the **Roles/Policies** subtab in the dashboard to view information about roles and policies in the Amazon Web Services (AWS), Microsoft Azure, or Google Cloud Platform (GCP) authorization systems.

> [!NOTE]
> To view the **Remediation dashboard** tab, you must have **Viewer**, **Controller**, or **Administrator** permissions. To make changes on this tab, you must have **Controller** or **Administrator** permissions. If you don't have these permissions, contact your system administrator.

> [!NOTE]
> Microsoft Azure uses the term *role* for what other Cloud providers call *policy*. Permissions Management automatically makes this terminology change when you select the authorization system type. In the user documentation, we use *role/policy* to refer to both.


## View information about roles/policies

1. On the Permissions Management home page, select the **Remediation** tab, and then select the **Role/Policies** subtab.

    The **Role/Policies list** displays a list of existing roles/policies and the following information about each role/policy
        - **Role/Policy Name**: The name of the roles/policies available to you.
        - **Role/Policy Type**: **Custom**, **System**, or **Permissions Management Only**
        - **Actions**: The type of action you can perform on the role/policy, **Clone**, **Modify**, or **Delete**


1. To display details about the role/policy and view its assigned tasks and identities, select the arrow to the left of the role/policy name.

    The **Tasks** list appears, displaying:
    - A list of **Tasks**.
    - **For AWS:**
        - The **Users**, **Groups**, and **Roles** the task is **Directly Assigned To**.
        - The **Group Members** and **Role Identities** the task is **Indirectly Accessible By**.

    - **For Azure:**
        - The **Users**, **Groups**, **Enterprise Applications** and **Managed Identities** the task is **Directly Assigned To**.
        - The **Group Members** the task is **Indirectly Accessible By**.

    - **For GCP:**
        - The **Users**, **Groups**, and **Service Accounts** the task is **Directly Assigned To**.
        - The **Group Members** the task is **Indirectly Accessible By**.

1. To close the role/policy details, select the arrow to the left of the role/policy name.

## Export information about roles/policies

- **Export CSV**: Select this option to export the displayed list of roles/policies as a comma-separated values (CSV) file.

    When the file is successfully exported, a message appears: **Exported Successfully.**

    - Check your email for a message from the Permissions Management Customer Success Team. This email contains a link to:
        - The **Role Policy Details** report in CSV format.
        - The **Reports** dashboard where you can configure how and when you can automatically receive reports.

## Filter information about roles/policies

1. On the Permissions Management home page, select the **Remediation** dashboard, and then select the **Role/Policies** tab.
1. To filter the roles/policies, select from the following options:

    - **Authorization System Type**: Select **AWS**, **Azure**, or **GCP**.
    - **Authorization System**: Select the accounts you want.
    - **Role/Policy Type**: Select from the following options:

         - **All**: All managed roles/policies.
         - **Custom**: A customer-managed role/policy.
         - **System**: A cloud service provider-managed role/policy.
         - **Permissions Management Only**: A role/policy created by Permissions Management.

    - **Role/Policy Status**: Select **All**, **Assigned**, or **Unassigned**.
    - **Role/Policy Usage**: Select **All** or **Unused**.
1. Select **Apply**.

    To discard your changes, select **Reset Filter**.


## Next steps

- For information on how to view existing roles/policies, requests, and permissions, see [View roles/policies, requests, and permission in the Remediation dashboard](ui-remediation.md).
- For information on how to create a role/policy, see [Create a role/policy](how-to-create-role-policy.md).
