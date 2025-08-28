---
title: Manage inactive users using Lifecycle Workflows (Preview)
description: This article walks you through managing inactive users with Lifecycle Workflows.
author: owinfreyATL
ms.author: owinfrey
manager: dougeby
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 08/28/2025

#CustomerIntent: As an IT administrator, I want to automate managing users with Lifecycle Workflows so that management and security is streamlined.
---

# Manage inactive users using Lifecycle Workflows (Preview)

As part of supporting users no matter where they fall in the Joiner-Mover-Leaver (JML)  model of their lifecycle within your organization, Lifecycle Workflows support automating the disabling and deleting of users once they are inactive for a set period of time. This [sign-in inactivity](lifecycle-workflow-execution-conditions.md#sign-in-inactivity-trigger) allows you to set a workflow to run when a user is inactive for a set number of days. This feature allows you to seamlessly maintain a secure environment by automating the removal of inactive based on criteria you set for your organization.

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](~/includes/entra-entra-governance-license.md)]


## Manage inactive users using the Microsoft Entra Admin Center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **workflows**.

1. On the workflow screen, select the specific workflow you want to add the inactive user task to, or create a new workflow based on a template.
    > [!NOTE]
    > To use any of the leaver tasks, you must select a leaver workflow template.
1. On the **Basics** tab, after entering a unique display name and description for the workflow,  select the **Sign-in inactivity** trigger.

1. Once you select your desired workflow template enter in basic details, and then select the **Sign-in inactivity** trigger.

1.  Under the **Days of inactivity**, enter the number of days you want the trigger to run for if exceeded, and then select **Next**.
    :::image type="content" source="media/lifecycle-workflow-inactive-users/inactivity-trigger.png" alt-text="Screenshot of days of inactivity.":::
1. On the **Scope** page, enter the scope you want for the trigger, and then select **Next**.

1. On the **Review Tasks** page, select the task you want to run for the users who you consider to be inactive and select **Review + Create**.
    > [!NOTE]
    > Lifecycle Workflows comes with a built-in task, [Send inactivity notification email (Preview)](lifecycle-workflow-tasks.md#send-inactivity-notification-email-preview), that is directly related to helping manage inactive users.


## Next step

- [Manage workflow versions](manage-workflow-tasks.md)
> [Manage workflow properties](manage-workflow-properties.md)

