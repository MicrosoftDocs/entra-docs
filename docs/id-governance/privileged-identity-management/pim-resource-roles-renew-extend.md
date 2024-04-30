---
title: Renew Azure resource role assignments in PIM
description: Learn how to extend or renew Azure resource role assignments in Privileged Identity Management (PIM).

author: barclayn
manager: amycolannino
ms.service: entra-id-governance
ms.topic: how-to
ms.subservice: privileged-identity-management
ms.date: 09/13/2023
ms.author: barclayn
ms.reviewer: shaunliu
ms.custom: pim

---



# Extend or renew Azure resource role assignments in Privileged Identity Management

Microsoft Entra Privileged Identity Management (PIM), provides controls to manage the access and assignment lifecycle for Azure resources. Administrators can assign roles using start and end date-time properties. When the assignment end approaches, Privileged Identity Management sends email notifications to the affected users or groups. It also sends email notifications to administrators of the resource to ensure that appropriate access is maintained. Assignments might be renewed and remain visible in an expired state for up to 30 days, even if access is not extended.

## Who can extend and renew?

Only administrators of the resource can extend or renew role assignments. The affected user or group can request to extend roles that are about to expire and request to renew roles that are already expired.

## When are notifications sent?

Privileged Identity Management sends email notifications to administrators and affected user or groups of roles that are expiring within 14 days and one day prior to expiration. It sends an additional email when an assignment officially expires.

Administrators receive notifications when a user or group assigned an expiring or expired role requests to extend or renew. When a specific administrator resolves the request, all other administrators are notified of the resolution decision (approved or denied). Then the requesting user or group is notified of the decision.

## Extend role assignments

The following steps outline the process for requesting, resolving, or administering an extension or renewal of a role assignment.

### Self-extend expiring assignments

Users assigned to a role can extend expiring role assignments directly from the **Eligible** or **Active** tab on the **My roles** page of a resource and from the top level **My roles** page of the Privileged Identity Management portal. In the portal, users can request to extend eligible or active (assigned) roles that expire in the next 14 days.

:::image type="content" source="media/pim-resource-roles-renew-extend/aadpim-rbac-extend-ui.png" alt-text="Screenshot of the My roles page listing eligible roles with an Action column.":::

When the assignment end date-time is within 14 days, the link to **Extend** becomes an active in the Microsoft Entra admin center. In the following example, assume the current date is March 27.

>[!Note]
>For a group assigned to a role, the **Extend** link never becomes available so that a user with an inherited assignment can't extend the group assignment.

:::image type="content" source="media/pim-resource-roles-renew-extend/aadpim-rbac-extend-within-14.png" alt-text="Screenshot of the action column with links to Activate or Extend.":::

To request an extension of this role assignment, select **Extend** to open the request form.

:::image type="content" source="media/pim-resource-roles-renew-extend/aadpim-rbac-extend-role-assignment-request.png" alt-text="Screenshot of the Extend role assignment pane with a Reason box.":::

To view information about the original assignment, expand **Assignment details**. Enter a reason for the extension request, and then select **Extend**.

>[!NOTE]
>We recommend including the details of why the extension is necessary, and for how long the extension should be granted (if you have this information).

:::image type="content" source="media/pim-resource-roles-renew-extend/aadpim-rbac-extend-form-complete.png" alt-text="Screenshot of the Extend role assignment pane with Assignment details expanded.":::

In a matter of moments, resource administrators receive an email notification requesting that they review the extension request. If a request to extend has already been submitted, an Azure notification appears in the portal.

:::image type="content" source="media/pim-resource-roles-renew-extend/aadpim-rbac-extend-failed-existing-request.png" alt-text="Screenshot of a Notification explaining that there is already an existing pending role assignment extension.":::

Go to the **Pending requests** page to view the status of your request or to cancel it.

:::image type="content" source="media/pim-resource-roles-renew-extend/aadpim-rbac-extend-cancel-request.png" alt-text="Screenshot of Azure resources - Pending requests page listing any pending requested and a link to Cancel.":::

### Admin approved extension

When a user or group submits a request to extend a role assignment, resource administrators receive an email notification that contains the details of the original assignment and the reason for the request. The notification includes a direct link to the request for the administrator to approve or deny.

In addition to using following the link from email, administrators can approve or deny requests by going to the Privileged Identity Management administration portal and selecting **Approve requests** in the left pane.

:::image type="content" source="media/pim-resource-roles-renew-extend/aadpim-rbac-extend-admin-approve-grid.png" alt-text="Screenshot of Azure resources - Approve requests page listing requests and links to approve or deny.":::

When an Administrator selects **Approve** or **Deny**, the details of the request are shown, along with a field to provide a business justification for the audit logs.

:::image type="content" source="media/pim-resource-roles-renew-extend/aadpim-rbac-extend-admin-approve-blade.png" alt-text="Screenshot of Approve role assignment request with requestor reason, assignment type, start time, end time, and reason.":::

When approving a request to extend role assignment, resource administrators can choose a new start date, end date, and assignment type. Changing assignment type might be necessary if the administrator wants to provide limited access to complete a specific task (one day, for example). In this example, the administrator can change the assignment from **Eligible** to **Active**. This means they can provide access to the requestor without requiring them to activate.

### Admin initiated extension

If a user assigned to a role doesn't request an extension for the role assignment, an administrator can extend an assignment on behalf of the user. Administrative extensions of role assignment don't require approval, but notifications are sent to all other administrators after the role has been extended.

To extend a role assignment, browse to the resource role or assignment view in Privileged Identity Management. Find the assignment that requires an extension. Then select **Extend** in the action column.

:::image type="content" source="media/pim-resource-roles-renew-extend/aadpim-rbac-extend-admin-extend.png" alt-text="Screenshot of Azure resources - assignments page listing eligible roles with links to extend.":::

## Renew role assignments

While conceptually similar to the process for requesting an extension, the process to renew an expired role assignment is different. Using the following steps, assignments and administrators can renew access to expired roles when necessary.

### Self-renew

Users who can no longer access resources can access up to 30 days of expired assignment history. To do this, they browse to **My Roles** in the left pane, and then select the **Expired roles** tab in the Azure resource roles section.

:::image type="content" source="media/pim-resource-roles-renew-extend/aadpim-rbac-renew-from-myroles.png" alt-text="Screenshot of My roles page - Expired roles tab.":::

The list of roles shown defaults to **Eligible roles**. Use the drop-down menu to toggle between Eligible and Active assigned roles.

To request renewal for any of the role assignments in the list, select the **Renew** action. Then provide a reason for the request. It's helpful to provide a duration in addition to any additional context or a business justification that can help the resource administrator decide to approve or deny.

:::image type="content" source="media/pim-resource-roles-renew-extend/aadpim-rbac-renew-request-form.png" alt-text="Screenshot of Renew role assignment pane showing Reason box.":::

After the request has been submitted, resource administrators are notified of a pending request to renew a role assignment.

### Admin approves

Resource administrators can access the renewal request from the link in the email notification or by accessing Privileged Identity Management from the Azure portal and selecting **Approve requests** from the left pane.

:::image type="content" source="media/pim-resource-roles-renew-extend/aadpim-rbac-extend-admin-approve-grid.png" alt-text="Screenshot of Azure resources - Approve requests page listing requests and links to approve or deny.":::

When an administrator selects **Approve** or **Deny**, the details of the request are shown along with a field to provide a business justification for the audit logs.

:::image type="content" source="media/pim-resource-roles-renew-extend/aadpim-rbac-extend-admin-approve-blade.png" alt-text="Screenshot of Approve role assignment request with requestor reason, assignment type, start time, end time, and reason.":::

When approving a request to renew role assignment, resource administrators must enter a new start date, end date, and assignment type.

### Admin renew

Resource administrators can renew expired role assignments from the **Members** tab in the left navigation menu of a resource. They can also renew expired role assignments from within the **Expired** roles tab of a resource role.

To view a list of all expired role assignments, on the **Members** screen, select **Expired roles**.

:::image type="content" source="media/pim-resource-roles-renew-extend/aadpim-rbac-renew-from-member-blade.png" alt-text="Screenshot of Azure resources - Members page listing expired roles with links to renew.":::

## Next steps

- [Approve or deny requests for Azure resource roles in Privileged Identity Management](pim-resource-roles-approval-workflow.md)
- [Configure Azure resource role settings in Privileged Identity Management](pim-resource-roles-configure-role-settings.md)
