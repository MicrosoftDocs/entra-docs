---
title: Extend or renew app role assignments in PIM (preview)
description: Learn how to extend or renew time-bound app role assignments in Microsoft Entra Privileged Identity Management (PIM) during preview.
ms.topic: how-to
ms.date: 10/29/2026
ms.custom: pim, msecd-doc-authoring-1031
ai-usage: ai-generated
#Customer Intent: As an administrator or assignee, I want to extend or renew time-bound app role assignments so that I can maintain necessary access.
---

# Extend or renew app role assignments in Privileged Identity Management (preview)

Microsoft Entra Privileged Identity Management (PIM) for app roles is in preview. This article describes how to request, approve, or administer an extension or renewal of a time-bound app role assignment.

<a name="overview"></a>

## Prerequisites

PIM for app roles (preview) requires Microsoft Entra ID Governance licenses.

## Navigate to the PIM section for the desired application

Use the following entry point for the procedures in this article:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **ID Governance** > **Privileged Identity Management** > **App Roles (Preview)**.
1. Select the application whose role assignments you want to extend or renew.

## Who can extend and renew?

The assignee can request to extend role assignments that are about to expire and request to renew role assignments that are already expired. Only users with permissions to manage these assignments can complete an extension or renewal on behalf of an assignee.

To initiate an extension or renewal on behalf of an assignee, you need one of the administrative roles listed in [Permissions for app role assignments](app-roles-assign.md#permissions), or you must own the target service principal.

## When are notifications sent?

In the common PIM workflow, email notifications help affected users and administrators maintain appropriate access as assignments approach expiration. Administrators receive notifications when an assignee requests to extend or renew an expiring or expired role. When an administrator resolves the request, notifications report the approval or denial.


App-role notification recipients, schedules, and message contents haven't been verified. Use **Pending requests** to check your request status, or **Approve requests** to review requests, rather than depending on an email notification.

## Extend role assignments

Extend an assignment before it expires. The following steps outline the process for requesting, resolving, or administering an extension of a role assignment.

Extending an eligible assignment changes its assignment period; it doesn't replace [activating the role](app-roles-activate.md). For background on eligible and active app role assignments, see [PIM for app roles (preview)](concept-pim-for-app-roles.md).

### Self-extend expiring assignments

Users with a time-bound eligible app role assignment can request an extension from **My roles** > **Eligible assignments** when **Extend** is available. The following steps describe that eligible-assignment workflow.


1. On the application's **My roles** page, select **Eligible assignments**.
1. Find the role assignment that you want to extend.
1. Select **Extend** to open **Extend role assignment**.
1. Review **Assignment details**, including the application, role, assignee type, member, and start and end times.
1. Enter the business justification in the required **Reason** box.
1. Select **Extend** to submit the request.

PIM displays **Request to Extend role assignment is submitted** after submission. This notification confirms submission, not approval or a changed assignment end time.

Go to **Pending requests** to view the status of your request or to cancel it. To cancel a pending request, find the request and select **Cancel**.

### Extension approval

Administrators can approve or deny requests by going to the Privileged Identity Management administration experience and selecting **Approve requests**. For app roles, this page separates **Requests to renew or extend role assignments** from **Requests for role activations**.

When approving an extension request, an approver can change the assignment's start date and time, end date and time, and assignment type.



1. On the application's **Approve requests** page, locate **Requests to renew or extend role assignments**.
1. Find the extension request. Select **Refresh** to update the list if needed.
1. Select **Approve** or **Deny** for the request.
1. Review the original assignment and the reason for the request. When approving, adjust the start and end dates and times and assignment type as needed.
1. Complete any required decision fields, and submit the approval or denial.

For the related approval workflow, see [Approve or deny app role requests in PIM (preview)](app-roles-approval-workflow.md).

### Admin initiated extension

If a user assigned to a role doesn't request an extension for the role assignment, an administrator with the required app-role permissions can extend an assignment on behalf of the user.

To extend a role assignment, browse to the application's assignment view in Privileged Identity Management. Find the assignment that requires an extension, and then select **Extend** in the action column.

The following steps describe extending a time-bound eligible assignment.

1. On the application's **Assignments** page, select **Eligible assignments**.
1. Find the assignment that requires an extension, and then select **Extend**.
1. In **Membership settings**, review **Assignment details** to confirm the application, role, and member.
1. Set **Assignment ends** to the new end date and time. If the role settings allow it and permanent eligibility is appropriate, select **Permanently eligible** instead.



1. Select **Save**.
1. Review the notification. PIM shows **Extending role grant** followed by **Extend role assignment request queued**.
1. Return to **Assignments** and check **End time** to verify the result. A queued notification doesn't confirm that the extension has finished processing.



## Renew role assignments

Renew an assignment after it expires. The following steps describe self-service renewal, approval, and administrator-initiated renewal.

### Self-renew

Use **My roles** > **Expired assignments** to find your expired role assignments and request renewal.

1. On the application's **My roles** page, select **Expired assignments**.
1. Review the **Assignment type** filter to check which assignments the list shows.



1. Find the expired assignment that you want to renew.
1. Select **Renew** to open the request form.
1. If the role requires a renewal reason, enter the reason for the request. Otherwise, skip this step.
1. Select **Renew** to submit the renewal request for approval.



When a reason is required, include context that helps the approver decide whether to approve or deny the request.


After submitting the request, open **Pending requests** to view its status. To cancel a pending request, find the request and select **Cancel**.

### Admin approves

Administrators can access renewal requests by opening **Approve requests** for the application and using **Requests to renew or extend role assignments**.

When approving a renewal request, an approver can change the assignment's start date and time, end date and time, and assignment type.



1. On the application's **Approve requests** page, locate **Requests to renew or extend role assignments**.
1. Find the renewal request. Select **Refresh** to update the list if needed.
1. Select **Approve** or **Deny** for the request.
1. Review the original assignment and the reason for the request. When approving, adjust the start and end dates and times and assignment type as needed.
1. Complete any required decision fields, and submit the approval or denial.

### Admin renew

Administrators can use the application's **Assignments** > **Expired assignments** view to locate expired role assignments. An administrator with the required permissions can renew an assignment on behalf of the assignee. The following steps describe an expired eligible assignment.



1. On the application's **Assignments** page, select **Expired assignments**.
1. Review the **Assignment type** filter to check which assignments the list shows.
1. Find the expired assignment that you want to renew.
1. Select **Renew** to open **Membership settings**.
1. Review **Assignment details** to confirm the application, role, and member.
1. Set **Assignment starts** to the new start date and time. Set **Assignment ends** for a time-bound assignment, or select **Permanently eligible** if the role settings allow it and permanent eligibility is appropriate.
1. Select **Save**.
1. Review the notification. PIM shows **Renewing role grant** followed by **Renew role assignment request queued**.
1. Return to **Assignments** and verify that the assignment reflects the renewal. A queued notification acknowledges the request; it doesn't confirm that renewal has finished processing.



## Next steps

- [Approve or deny app role requests in PIM (preview)](app-roles-approval-workflow.md).
- [Configure app role settings in PIM (preview)](app-roles-settings.md).
