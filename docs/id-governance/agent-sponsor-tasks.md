---
title: Agent identity sponsor tasks in Lifecycle Workflows (Preview)
description: This article describes workflow tasks that involve sponsors of agent identities.
ms.subservice: lifecycle-workflows
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 10/25/2025

#CustomerIntent: As a lifecycle workflows administrator, I want to create workflows that target agent identity sponsors so that agent identity sponsor management can be streamlined.
---

# Agent identity sponsor tasks in Lifecycle Workflows (Preview)


Governing agent identities sponsors is a critical aspect of maintaining lifecycle governance and access control in your organization. Agent identity sponsors are responsible for overseeing the lifecycle and access decisions of agent identities. Keeping sponsor information up to date helps with effective governance and compliance. 

Lifecycle Workflows currently contain the following two tasks that involve the governing of sponsors of agent identities:

- [Send email to manager about sponsorship changes (Preview)](lifecycle-workflow-tasks.md#send-email-to-manager-about-sponsorship-changes-preview)
- [Send email to cosponsors about sponsor changes (Preview)](lifecycle-workflow-tasks.md#send-email-to-co-sponsors-about-sponsor-changes-preview)


This article explains how to configure Lifecycle Workflows to streamline agent identity sponsor governance.

## License Requirements

[!INCLUDE [entra-agent-id-license](../includes/entra-agent-id-license-note.md)]

## Create a sponsor workflow using the Microsoft Entra Admin Center

To create a workflow that notifies the manager or cosponsors of an existing agent identity sponsor's move, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **workflows**.

1. On the workflow screen, select the specific mover or leaver workflow template you want to add the sponsorship email tasks to, or create a new workflow based on a template.
    > [!NOTE]
    > Both the **Send email to manager about sponsorship changes (Preview)** and **Send email to co-sponsors about sponsor changes (Preview)** are mover and leaver tasks, and are only available as selectable tasks under workflow templates of the same category.
1. On the **Basics** tab, after entering a unique display name and description for the workflow,  select your trigger and select **Next**.

1. On the **Configure scope** screen, select the scope of the workflow and select **Next**.

1. On the **Tasks** page, select which sponsor related tasks you want to include and select **Next**.
    :::image type="content" source="media/manage-agent-sponsors/sponsor-workflow-tasks.png" alt-text="Screenshot of the sponsor workflow tasks.":::
1. Review the created workflow, and then select **Create**. 

## Next step

- [Write concepts](manage-workflow-tasks.md)
- [Manage workflow properties](manage-workflow-properties.md)
