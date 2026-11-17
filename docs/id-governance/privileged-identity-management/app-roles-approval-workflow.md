---
title: Approve or deny app role requests in PIM (preview)
description: Learn how to view, approve, and deny app role activation and assignment renewal or extension requests in Microsoft Entra Privileged Identity Management.
ms.topic: how-to
ms.date: 10/29/2026
ms.custom: pim, msecd-doc-authoring-1031
ai-usage: ai-generated
# Customer intent: As an app role approver, I want to review and approve or deny requests so that users receive appropriate application access.
---
# Approve or deny app role requests in PIM (preview)

Microsoft Entra Privileged Identity Management (PIM) for app roles is in preview. Follow the steps in this article to approve or deny requests for app role activation and assignment renewal or extension.

<a name="prerequisites"></a>

## Overview

Microsoft Entra Privileged Identity Management (PIM) enables you to configure app roles so that they require approval for activation, and choose users or groups from your Microsoft Entra organization as delegated approvers. Configure delegated approvers in the application's [role settings](app-roles-settings.md).

For activation requests, being designated as an approver in the app role's settings is sufficient to approve or deny requests. You don't need an additional administrative role.

For assignment extension and renewal requests, you must own the target service principal or have one of the administrative roles listed in [Permissions for app role assignments](app-roles-assign.md#permissions) to approve or deny requests.

For the requester's workflow, see [Activate app roles in PIM](app-roles-activate.md) and [Extend or renew app role assignments in PIM](app-roles-renew-extend.md).

## View pending requests

You can view requests pending your approval in Privileged Identity Management.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **ID Governance** > **Privileged Identity Management** > **App Roles (Preview)**, and select the application.

1. Select **Approve requests**.

    In **Requests for role activations**, you see the activation requests pending your approval. **Requests to renew or extend role assignments** lists assignment extension and renewal requests.

1. Select **Refresh** in a request section to update its list.

If you can't find a request, check that you've selected the correct application and refresh both request sections.

## Approve requests

Follow these steps to approve a pending activation request.

1. In **Requests for role activations**, find and select the checkbox for the request that you want to approve. Select **Approve** to open the decision panel.

    Review **Request details**, including the role, requestor, resource, reason, and start and end times.

1. Enter your business justification in the required box showing **Enter the reason**.

    If the box is empty, the panel displays **Required fields are missing or invalid**, and **Submit** is unavailable.

1. Select **Submit** to approve the request.

    PIM shows **Approving** while processing the decision and **Request(s) approved successfully.** when approval succeeds.

1. After submitting the decision, select **Refresh** in **Requests for role activations** to check that the approved request is no longer listed.

1. To check the resulting PIM assignment state, open **Assignments** > **Active assignments** and check for **Activated** in the **State** column for the user's app role.

An approval decision isn't confirmation that the application has started granting access. For activation status and the application-access considerations, see [Activate app roles in PIM](app-roles-activate.md).

## Deny requests

If a request doesn't meet your organization's access requirements, deny it and provide the business justification.

The following steps describe an activation request in **Requests for role activations**.

1. On the application's **Approve requests** page, select the checkbox for the request in **Requests for role activations**, and then select **Deny**.

1. In **Denying request(s)**, review **Request details** to confirm the request.

1. Enter your business justification in the required box showing **Enter the reason**.

1. Select **Submit** to deny the request.

1. Select **Refresh** in the request section to review the list after your decision.

## Workflow notifications

Here's some information about workflow notifications:

- Approvers are notified by email when a request for a role is pending their review. Email notifications include a direct link to the request, where the approver can approve or deny.
- Requests are resolved by the first approver who approves or denies.
- When an approver responds to the request, all approvers are notified of the action.
- Resource administrators are notified when an approved user becomes active in their role.

> [!NOTE]
> A resource administrator who believes that an approved user shouldn't be active can remove the active role assignment in Privileged Identity Management. Although resource administrators aren't notified of pending requests unless they're an approver, they can view and cancel pending requests for all users by viewing pending requests in Privileged Identity Management.


## Next steps

- [Configure app role settings in PIM](app-roles-settings.md).
- [Extend or renew app role assignments in PIM](app-roles-renew-extend.md).
