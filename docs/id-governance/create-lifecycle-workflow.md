---
title: Create a lifecycle workflow - Microsoft Entra ID
description: Create a lifecycle workflow from a template, clone an existing workflow, or use Microsoft Graph. Configure a profile for identity verification templates.
author: rogulati
ms.author: rogulati
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.date: 11/03/2026
ms.custom: template-how-to, msecd-doc-authoring-1026
ai-usage: ai-assisted
#Customer Intent: As an IT admin, I want to create a lifecycle workflow so that I can automate identity lifecycle processes in my organization.
---

# Create a lifecycle workflow

Lifecycle workflows allow for tasks associated with the lifecycle process to be run automatically for users as they move through their lifecycle in your organization. Workflows consist of:

- **Tasks**: Actions taken when a workflow is triggered.
- **Execution conditions**: The who and when of a workflow. These conditions define which users this workflow should run against, and when (trigger) the workflow should run.

In the Microsoft Entra admin center, you can create and customize workflows for common scenarios by using built-in templates or by cloning an existing workflow. To build a workflow from scratch without using a template or an existing workflow, use Microsoft Graph.

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](../includes/entra-entra-governance-license.md)]

- An ID verification profile with purpose set to `all` or `onboarding`, if you use either identity-verification template (Preview). You can create a profile before you start or select **Create new verification profile** during workflow creation. For profile configuration, see [Create an ID verification profile](../verified-id/how-to-create-id-verification-profile.md).

## Create a lifecycle workflow by cloning an existing workflow in the Microsoft Entra admin center

You can use an existing workflow as the starting point for a new workflow. The clone option is available only in the Microsoft Entra admin center.

To start cloning from the workflow list:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **Workflows**.

1. Select the workflow that you want to clone, and then select **Clone**.

    :::image type="content" source="media/create-lifecycle-workflow/clone-workflow-list.png" alt-text="Screenshot of a selected workflow and the Clone option on the Lifecycle workflows page." lightbox="media/create-lifecycle-workflow/clone-workflow-list.png":::

You can also start cloning from the workflow creation experience:

1. Browse to **ID Governance** > **Lifecycle workflows** > **Create workflow**.

1. On the **Choose a workflow** page, find the **Clone an existing workflow** card, and then select **Browse workflows**.

    :::image type="content" source="media/create-lifecycle-workflow/clone-workflow-template-card.png" alt-text="Screenshot of the Clone an existing workflow card on the Choose a workflow page." lightbox="media/create-lifecycle-workflow/clone-workflow-template-card.png":::

1. Select the workflow that you want to clone.

After you select a workflow to clone, the **Review + create** tab opens directly. Review the workflow settings, and then select **Create** to create the workflow without making changes.

To customize the workflow before you create it, select the other tabs and update the workflow details or configuration. When you're finished, return to the **Review + create** tab and select **Create**.

## Create a lifecycle workflow by using a template in the Microsoft Entra admin center

Use a built-in template as the starting point for a workflow, and customize it to meet your organization's needs. For available templates and their default settings, see [Lifecycle Workflows templates](lifecycle-workflow-templates.md).

To create a workflow based on a template:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **Create a workflow**.

1. On the **Choose a workflow** page, select the workflow template that you want to use.

    For identity-verification onboarding, select **Pre-hire identity verification initiation (Preview)** or **New Hire employee onboarding with identity verification (Preview)**. See [Lifecycle Workflows templates](lifecycle-workflow-templates.md).

    :::image type="content" source="media/create-lifecycle-workflow/templates-list.png" alt-text="Screenshot of the workflow template gallery, including the two identity-verification templates in preview." lightbox="media/create-lifecycle-workflow/templates-list.png":::

1. On the **Basics** tab, enter a unique display name, description, and [administrative scope](manage-delegate-workflow.md) for the workflow.

    If you selected either identity-verification template, also select **Trigger type** on this tab. When you're finished, select **Next**.

    :::image type="content" source="media/create-lifecycle-workflow/template-basics.png" alt-text="Screenshot of basic information about a workflow template.":::

1. On the **Configure scope** tab, configure the execution conditions for the workflow. For other templates, also select the trigger type on this tab. For more information on what you can configure, see [Execution conditions](understanding-lifecycle-workflows.md#execution-conditions).

1. Under **Rule**, enter values for **Property**, **Operator**, and **Value**. The following screenshot gives an example of a rule being set up for a sales department. For a full list of user properties that lifecycle workflows support, see [Supported user properties and query parameters](/graph/api/resources/identitygovernance-rulebasedsubjectset?view=graph-rest-beta&preserve-view=true#supported-user-properties-and-query-parameters).

    :::image type="content" source="media/create-lifecycle-workflow/template-scope.png" alt-text="Screenshot of scope configuration options for a lifecycle workflow template.":::

1. To view your rule syntax, select the **View rule syntax** button. You can copy and paste multiple user property rules on the panel that appears. For more information on which properties you can include, see [User properties](/graph/aad-advanced-queries?tabs=http#user-properties). When you finish adding rules, select **Next**.

    :::image type="content" source="media/create-lifecycle-workflow/template-syntax.png" alt-text="Screenshot of workflow rule syntax.":::

1. If you selected either identity-verification template, on the **Select identity verification profile** tab, select a profile from **Verified ID Profile**. If you need a new profile, select **Create new verification profile**. The profile's purpose must be set to `all` or `onboarding`. Select **Next: Review tasks**.

    For other templates, skip this step and continue to **Review tasks**.

    :::image type="content" source="media/create-lifecycle-workflow/select-identity-verification-profile.png" alt-text="Screenshot of the identity verification profile selection tab, with the Verified ID Profile dropdown and Create new verification profile link." lightbox="media/create-lifecycle-workflow/select-identity-verification-profile.png":::

1. On the **Review tasks** tab, you can add a task to the template by selecting **Add task**. To enable an existing task on the list, select **Enable**. To disable a task, select **Disable**. To remove a task from the template, select **Remove**.

    For identity-verification tasks, select or change the profile on the workflow's **Select identity verification profile** tab, not in the task settings. For task settings and email requirements, see [Lifecycle workflow tasks](lifecycle-workflow-tasks.md).

    When you're finished with tasks for your workflow, select **Next: Review and create**.

    :::image type="content" source="media/create-lifecycle-workflow/template-tasks.png" alt-text="Screenshot of adding tasks to templates.":::

1. On the **Review and create** tab, review the workflow's settings. Leave the scheduling checkbox cleared to test the workflow before automatic processing begins. Select it when you're ready to enable scheduled runs. Select **Create** to create the workflow.

    :::image type="content" source="media/create-lifecycle-workflow/template-review.png" alt-text="Screenshot of reviewing and creating a workflow.":::

> [!IMPORTANT]
> In the Microsoft Entra admin center, a newly created workflow is enabled (`isEnabled` is `true`), but scheduling is disabled (`isSchedulingEnabled` is `false`) unless you select the scheduling checkbox. This lets you [run the workflow on-demand](on-demand-workflow.md) for a small audience before enabling scheduled processing. Disabling the workflow itself (`isEnabled` is `false`) prevents both scheduled and on-demand runs.

## Create a lifecycle workflow by using Microsoft Graph

To create a lifecycle workflow by using the Microsoft Graph API, see [Create workflow](/graph/api/identitygovernance-lifecycleworkflowscontainer-post-workflows).

For API creation, explicitly set `isEnabled` and `isSchedulingEnabled` for the intended run mode. The values you set control workflow execution and scheduling; don't assume the admin center's checkbox defaults apply to an API request.

The three Preview tasks used by the two identity-verification templates are available only in Microsoft Graph `/beta`, not `/v1.0`. To create a workflow that includes these tasks, see [Create workflow (beta)](/graph/api/identitygovernance-lifecycleworkflowscontainer-post-workflows?view=graph-rest-beta&preserve-view=true). For task definitions and arguments, see [Lifecycle workflow tasks](lifecycle-workflow-tasks.md).

> [!NOTE]
> Microsoft Graph beta APIs are subject to change. Use of these APIs in production applications isn't supported.

## Related content

- [Manage a workflow's properties](manage-workflow-properties.md)
- [Manage workflow versions](manage-workflow-tasks.md)
