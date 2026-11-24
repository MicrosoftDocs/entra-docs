---
title: Assign app roles in PIM (preview)
description: Learn how to assign eligible and active app roles and update or remove assignments in Microsoft Entra Privileged Identity Management.
ms.topic: how-to
ms.date: 11/16/2026
ms.custom: pim, msecd-doc-authoring-1031
ai-usage: ai-generated
#customer intent: As an administrator, I want to assign and maintain eligible and active app roles so that assignees have access when they need it.
---
# Assign app roles in Privileged Identity Management (preview)

With Microsoft Entra Privileged Identity Management (PIM), you can create eligible and active app role assignments. PIM for app roles is in preview. This article shows you how to create, update, and remove app role assignments.

<a name="permissions"></a>

## Role assignment conditions

With Microsoft Entra PIM, assignees must activate an eligible app role assignment before they can use the role. The app role's settings control activation requirements and assignment duration.

App role assignments support the following assignees:

- **Eligible** assignments support users, groups, agents, and agent identities.
- **Active** assignments support users, groups, and workload identities.

You can create permanent or time-bound assignments, subject to the app role's settings.



> [!NOTE]
> PIM for app roles (preview) requires a **Microsoft 365 E7** license plan to preview. Agents and agent identities can receive eligible app role assignments in preview. Capabilities are subject to change and licensing requirements have not yet been announced. Existing assignment-management permissions remain unchanged.

To create, update, or remove app role assignments in Microsoft Entra PIM, you must be an owner of the target service principal or have one of the following roles:

- **Directory Writers**.
- **Hybrid Identity Administrator**.
- **Identity Governance Administrator**.
- **Privileged Role Administrator**.
- **User Administrator**.
- **Application Administrator**.
- **Cloud Application Administrator**.
- **CSP Partner Admin Agent**.

## Assign a role

Follow these steps to create an eligible or active app role assignment. Before adding an assignment, review the role's [activation and assignment settings](app-roles-settings.md).

The application must already define the app role you want to assign. You can manage any enterprise application with app roles, including Microsoft and third-party applications. The application's registration doesn't have to be owned by your tenant. For background, see [PIM for app roles (preview)](concept-pim-for-app-roles.md).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **ID Governance** > **Privileged Identity Management** > **App Roles (Preview)**.

1. Select the application you want to manage. Use the application and object IDs in the application list to identify the intended application.

1. Under **Manage**, select **Roles** to see the list of app roles and their active and eligible assignment counts.

1. Select **Add assignments**.

    You can also start from the application's **Assignments** page.

1. On the **Membership** tab, review **Resource** to confirm the application. Under **Select role**, select the app role you want to assign.

    **Resource type** identifies the application as a service principal. It doesn't identify the type of assignee.

1. Under **Select member(s)**, select **No member selected** to open **Select a member or group**.

1. Use **Search** to find the target identity. Select the checkbox for the identity, and then select **Select**.

1. Select **Next** to continue to the **Setting** tab. Under **Assignment type**, select **Eligible** or **Active**. Privileged Identity Management provides two distinct assignment types:

    - *Eligible* assignments require the assignee to activate the role before using it. Depending on the role settings, activation might require additional actions such as multifactor authentication (MFA), a business justification, or approval from designated approvers.
    - *Active* assignments don't require the assignee to activate the role before using it.

1. Configure the assignment duration:

    - For a permanent eligible assignment, use **Permanently eligible**.
    - For a permanent active assignment, use **Permanently assigned**.
    - For a time-bound assignment, clear the corresponding permanent option and set **Assignment starts** and **Assignment ends**.

1. If you're creating an active assignment and the role settings require justification, enter the reason in **Enter justification**.

1. Review the role, assignee, assignment type, and schedule, and select **Assign**.

1. Return to the role's **Eligible assignments** or **Active assignments** tab to verify the new assignment.

For information about activating an eligible assignment, see [Activate app roles in PIM (preview)](app-roles-activate.md).

## Update or remove an existing role assignment

Follow these steps to update or remove an existing role assignment.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **ID Governance** > **Privileged Identity Management** > **App Roles (Preview)**.

1. Select the application you want to manage.

1. Under **Manage**, select **Assignments**.

1. Use **Eligible assignments** and **Active assignments** to review existing assignments for the selected application. Use **Expired assignments** to review expired assignments.

    To review assignments for a single role instead, select **Roles**, and then select the role.

1. Find the eligible direct-user assignment you want to update or remove.

1. Select the action for the assignment:

    - To change the assignment, select **Update** to open **Membership settings**. Review **Assignment details** to confirm the application, role, and member. Update **Permanently eligible** or **Assignment ends** as needed, and then select **Save**.

        The panel also shows an **Assignment type** dropdown.

        PIM displays an **Updating role grant** notification while processing the update, followed by **Update role assignment request queued**. The queued notification acknowledges the request; it doesn't confirm that the assignment has finished updating.

    - To remove the assignment, select **Remove**. In the **Remove** confirmation, check the member and role, and select **Yes** to proceed or **No** to cancel.

1. Return to the assignment list and verify the result of your change. For an update, check that the assignment reflects the requested values rather than relying only on the queued notification.

The eligible direct-user assignment list also provides an **Extend** action. For information about extending or renewing an assignment, see [Extend or renew app role assignments in PIM (preview)](app-roles-renew-extend.md).

## Next steps

- [Configure app role settings in PIM (preview)](app-roles-settings.md).
- [Activate app roles in PIM (preview)](app-roles-activate.md).
- [Approve or deny app role requests in PIM (preview)](app-roles-approval-workflow.md).
