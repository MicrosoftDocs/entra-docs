---
# required metadata

title: Manage lifecycle workflows with Microsoft Security Copilot 
description: Use Microsoft Security Copilot in the Microsoft Entra admin center to create lifecycle workflows for Joiner, Mover, and Leaver scenarios. Execute workflows on-demand and use workflow insights to monitor execution and troubleshoot as needed.
keywords:
author: rwike77
ms.author: ryanwi
manager: celestedg
ms.date: 02/19/2025
ms.topic: conceptual
ms.service: entra
ms.custom: microsoft-copilot
---
# Manage employee lifecycle using Microsoft Security Copilot (Preview)

Microsoft Entra ID Governance applies the capabilities of [Microsoft Security Copilot](/security-copilot/microsoft-security-copilot) to save identity administrators time and effort when configuring custom workflows to manage the lifecycle of users across JML scenarios. It also helps you to customize workflows more efficiently using natural language to configure workflow information including custom tasks, execute workflows, and get workflow insights.

This article describes how to work with lifecycle workflows using Security Copilot in the Microsoft Entra admin center.  Using this feature requires [Microsoft Entra ID Governance licenses](/entra/id-governance/identity-governance-overview#license-requirements).

Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](/entra/identity/role-based-access-control/permissions-reference#lifecycle-workflows-administrator). Navigate to **ID Governance** > **Lifecycle workflows overview**.

Launch Security Copilot from the **Copilot** button in the Microsoft Entra admin center.  Use natural language questions or prompts to:

- Get step-by-step guidance for creating a lifecycle workflow
- Explore available workflow configurations
- Analyze the active workflow list
- Troubleshoot the processing results of workflows

:::image type="content" source="./media/copilot-entra-lifecycle-workflow/security-copilot-button.png" alt-text="Screenshot that shows the Copilot in the Microsoft Entra admin center.":::

## Create step-by-step guidance for a new lifecycle workflow

Security Copilot can give you the steps to guide you in creating a new lifecycle workflow. Provide a prompt with actions to take when the workflow is triggered and conditions that define which users (scope) this workflow should run against, and when (trigger) the workflow should run.  For example:

*Create a lifecycle workflow for new hires in the Marketing department that sends a welcome email and a TAP and adds them to the "All Users in My Tenant" group.  Also, provide the option to enable the schedule of the workflow.*

Review the returned results to see what the workflow includes and then follow the steps to [create a new workflow](/entra/id-governance/create-lifecycle-workflow) in the Microsoft Entra admin center. After the workflow is created, you can perform verification testing before enabling the schedule.

## Explore available workflow configurations

Using Microsoft Security Copilot, you can efficiently manage various lifecycle workflows. Here are some common tasks you can accomplish with Security Copilot:

For example:

- *List all lifecycle workflows in my tenant*
- *List all the supported workflow templates for creating a new workflow*
- *What are my lifecycle workflow settings?*
- *Which leaver tasks can I automate with lifecycle workflows?*
- *What templates can be used for creating a mover workflow?*

## Analyze active workflow list

With Microsoft Security Copilot, you can easily analyze and manage your active workflow list and retrieve specific workflow information.

For example:

- *Get my lifecycle workflows with the name {workflow name}*
- *List all mover workflows in my tenant*
- *List all the deleted lifecycle workflows in my tenant*
- *List all disabled lifecycle workflows in my tenant*
- *Show me the details of disabled workflow {workflow}*

## Troubleshoot a Lifecycle Workflow run

You can use Security Copilot to help troubleshoot a workflow run.  Security Copilot uses the information provided to generate and return a rich summary of the workflow history over the given time period for the specified workflow. 

Explore workflow processing results of a specific workflow:

- *Summarize the runs for {workflow} in the last 7 days*
- *How many times did the workflow run in the last 24 hours*
- *Which users failed to be processed by this workflow in the last 7 days?*
- *Which tasks failed for {workflow} in the last 7 days?*
- *Show me the user processing results summary for {workflow} in the last 7 days*

Explore workflow processing results across workflows:

- *How many workflows were processed in the last 7 days?*
- *How many users were successfully processed by workflows in the last 14 days?* 
- *Which workflows have been run the most in the last 7 days?* 
- *Which tasks failed the most in the last 30 days?* 
- *Which workflows failed the most in the last 7 days?* 
- *How many mover workflows were executed in the last 30 days?*
 
## Compare versions of a lifecycle workflow 

You can use Security Copilot to compare workflow versions. Security Copilot uses the information provided to generate and return a rich summary of the content of two versions of the specified workflow as well as the core differences between the workflow versions including tasks and execution conditions.

For example:

- *List all workflow versions for {workflow}*
- *Show me who last modified {workflow} and when*
- *Show me the details of {version #} for this workflow*
- *What changed in the last version of this workflow?*
- *Compare the last two versions of this workflow*
- *Compare {version #} and {version #} of this workflow*

## Next steps

- Learn more about [lifecycle workflows](/entra/id-governance/what-are-lifecycle-workflows).
- [Create a lifecycle workflow](/entra/id-governance/create-lifecycle-workflow).
- [Run a workflow](/entra/id-governance/on-demand-workflow) on demand.
