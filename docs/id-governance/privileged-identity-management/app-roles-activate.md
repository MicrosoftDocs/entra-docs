---
title: Activate app roles in PIM (preview)
description: Learn how to activate and deactivate app roles, view request status, and cancel pending requests in Microsoft Entra Privileged Identity Management.
ms.topic: how-to
ms.date: 10/29/2026
ms.custom: pim, msecd-doc-authoring-1031
ai-usage: ai-generated
# Customer intent: As a user with eligible app role assignments, I want to activate and deactivate my roles and manage activation requests so that I can use application permissions when I need them.
---
# Activate app roles in Privileged Identity Management (preview)

Microsoft Entra Privileged Identity Management (PIM) for app roles is in preview. Follow the steps in this article to activate an eligible app role, view or cancel a pending request, and deactivate a role when you finish your work.

## Prerequisites

- A Microsoft Entra ID Governance license.
- An eligible app role assignment, either assigned directly or through a group. For information about assignments, see [Assign app roles in PIM](app-roles-assign.md).

## Activate a role

When you need to take on an app role, you can request activation by using the **My roles** navigation option in PIM. The [app role's settings](app-roles-settings.md) determine the requirements for activation.

If your eligibility comes from a group's eligible app role assignment, you activate the role for yourself. Your activation doesn't activate the role for the whole group or its other members.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **ID Governance** > **Privileged Identity Management** > **App Roles (Preview)**, and select the application.

1. Select **My roles** > **Eligible assignments**, and review the list of app roles that you're eligible to activate.

1. Select **Activate** for the eligible assignment you want to activate.

1. Depending on the application's role settings, you might be asked to provide multifactor authentication or another form of credential. Follow the instructions to complete the required verification.

1. On the **Activate** tab, select **Custom activation start time** if you need to schedule activation. Enter **Start time** and select the time zone.

1. Set **Duration (hours)** using the slider or numeric field, within the maximum configured for the role.

1. Depending on the application's role settings, justification for activation might be required. If needed, provide the justification in **Reason (max 500 characters)**.

1. Select **Activate** to submit the request.

1. Review the request status.

    The **Status** tab shows progress through request processing, validation, and completion. Wait for the stages to finish. The status panel indicates that the PIM page refreshes automatically after completion.

If the [role requires approval](app-roles-approval-workflow.md) to activate, use **Pending requests** to view the status of your request while it awaits review. The request list shows **Pending approval** for a request awaiting a decision.

After activation, select **My roles** > **Active assignments** to review your active app roles. An activated assignment shows **Activated** in the **State** column and its **End time**.

Before using the activated role in the application, the application must obtain a new token. Follow the application's sign-in instructions if another sign-in is needed, and then perform the tasks that require the role. The PIM page's automatic refresh doesn't replace token acquisition by the application.

## View the status of your requests

You can view the status of your pending activation requests. Check the status when your requests require another person's approval.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **ID Governance** > **Privileged Identity Management** > **App Roles (Preview)**, and select the application.

1. Select **Pending requests**.

1. Review the list of requests, including the reason and status for each request.

To review your assignments rather than pending requests, select **My roles**. Use the **Eligible assignments**, **Active assignments**, and **Expired assignments** tabs to view the corresponding assignments for the application.

## Cancel a pending request

If you no longer need to activate a role that requires approval, you can cancel the pending request.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **ID Governance** > **Privileged Identity Management** > **App Roles (Preview)**, and select the application.

1. Select **Pending requests**.

1. For the request that you want to cancel, select **Cancel**.

To activate the role after canceling the pending request, submit a new activation request.

## Deactivate a role

If you no longer need an activated app role assignment, you can deactivate it before the activation expires.

<a name="overview"></a>

> [!IMPORTANT]
> Deactivation or expiration doesn't automatically invalidate already-issued tokens or existing application sessions. Application access can persist according to token lifetime and the application's session and authorization behavior. Ending an activation in PIM isn't a guarantee of immediate access removal in the application.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **ID Governance** > **Privileged Identity Management** > **App Roles (Preview)**, and select the application.

1. Select **My roles** > **Active assignments**.

1. Find the assignment with **State** set to **Activated** that you want to deactivate, and select **Deactivate**.

1. In the **Deactivate** panel, review **Resource name**, **Role**, **Scope**, **Member**, **Start time**, and **End time** to confirm the activation.

1. Select **Deactivate** to submit the request, or **Cancel** to close the panel without submitting.

    > [!NOTE]
    > If PIM reports **Deactivate role failed** because the active duration is too short and the minimum required is five minutes, wait until the activation has been active for at least five minutes before retrying. A failed deactivation doesn't end the activation.

1. Review the result, and then check **Active assignments** to verify that the activation has ended. If PIM reports a failure, don't treat the request as a completed deactivation.

Deactivation ends the activation, not your eligible assignment. You can request activation again while your eligible assignment remains valid.

## Next steps

- [Approve or deny app role requests in PIM](app-roles-approval-workflow.md).
- [Configure app role settings in PIM](app-roles-settings.md).
- [Learn about PIM for app roles (preview)](concept-pim-for-app-roles.md).
