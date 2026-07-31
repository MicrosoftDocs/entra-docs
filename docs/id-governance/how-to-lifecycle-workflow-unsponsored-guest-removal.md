---
title: Manage unsponsored guests using Lifecycle Workflows (Preview)
description: Learn how to manage unsponsored guest removal in your organization using Lifecycle Workflows.
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.date: 07/31/2026
ms.custom: template-how-to
ai-usage: ai-assisted

#Customer Intent: As an IT admin, I want to manage unsponsored guests and automate their removal using Lifecycle Workflows to maintain security and compliance.
---

# Manage unsponsored guests using Lifecycle Workflows (Preview)

Unsponsored guests—guest users without a valid sponsor assigned—represent a security and compliance risk in your organization. Lifecycle Workflows help you automate the management and removal of unsponsored guests. Microsoft Entra ID Governance includes a built-in **Unsponsored guest cleanup (Preview)** workflow template that automates the detection and management of unsponsored guests.

This article walks you through managing unsponsored guests using the **Unsponsored guest cleanup (Preview)** workflow template.

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](~/includes/entra-entra-governance-license.md)]

> [!IMPORTANT]
> This functionality is subject to the guest billing model. For details, see [Microsoft Entra ID Governance licensing for guest users](microsoft-entra-id-governance-licensing-for-guest-users.md).

## Manage unsponsored guests using the Microsoft Entra admin center

To create a workflow for managing unsponsored guests:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **Workflows**.

1. On the workflow screen, select **Create new workflow**.

1. On the template selection screen, find and select the **Unsponsored guest cleanup (Preview)** workflow template.

    > [!NOTE]
    > This template is specifically designed for leaver workflows.

1. Enter basic details for your workflow:
   - **Display name**: A descriptive name for your workflow
   - **Description**: Information about the workflow's purpose

1. Configure the workflow execution conditions. The trigger type is set to **Guest sponsor status (Preview)** by the template and can't be changed.

    :::image type="content" source="./media/lifecycle-workflow-unsponsored-guest-removal/trigger-details.png" alt-text="Screenshot that shows the trigger details section with Guest sponsor status trigger type and number of sponsors set to equal to zero.":::

    > [!NOTE]
    > The **Number of sponsors** condition is set to **Equal to 0** and is not currently configurable. This workflow targets users with no sponsors assigned.

1. Configure the workflow tasks based on your organization's requirements.

1. Select **Review + Create** to finalize and enable the workflow.

## Add email notifications for unsponsored guest removal (optional)

The **Unsponsored guest cleanup (Preview)** template includes the **Delete User Account** task by default. You can optionally add the **Send email about unsponsored guest removal (Preview)** task to notify specified recipients when unsponsored guests are being removed from your organization.

> [!NOTE]
> For detailed information about adding and configuring the email task, including recipient options, email customization, and dynamic attributes, see [Lifecycle Workflow tasks and definitions - Send email about unsponsored guest removal (Preview)](lifecycle-workflow-tasks.md#send-email-about-unsponsored-guest-removal-preview).

## Next steps

- [Lifecycle Workflow tasks and definitions](lifecycle-workflow-tasks.md)
- [Check status of a workflow](check-status-workflow.md)
- [Customize workflow schedule](customize-workflow-schedule.md)
- [Customize emails sent out by workflow tasks](customize-workflow-email.md)
