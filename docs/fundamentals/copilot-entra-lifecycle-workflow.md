---
# required metadata

title: Manage lifecycle workflows with Microsoft Security Copilot 
description: Use Microsoft Security Copilot in the Microsoft Entra admin center to create lifecycle workflows for Joiner, Mover, and Leaver scenarios. Execute workflows on-demand and use workflow insights to monitor execution and troubleshoot as needed.
keywords:
author: rwike77
ms.author: ryanwi
manager: celestedg
ms.date: 12/16/2024
ms.topic: conceptual
ms.service: entra
ms.custom: microsoft-copilot

# Customer intent: As a lifecycle workflows Administrators or Global Administrators, I want to learn about risky user summarization in the Identity Protection UX so that I can quickly respond to identity threats.
---

# Manage employee lifecycle using Microsoft Security Copilot

Microsoft Entra ID Governance applies the capabilities of [Microsoft Security Copilot](/security-copilot/microsoft-security-copilot) to save identity administors time and effort when configuring custom workflows to manage the lifecycle of users across JML scenarios. It also helps you to customize workflows more efficiently using natural language to configure workflow information including custom tasks, execute workflows, and get workflow insights.

This article describes how to work with lifecycle workflows using Security Copilot in the Microsoft Entra admin center.  Using this feature requires [Microsoft Entra ID Governance licenses](/entra/id-governance/identity-governance-overview#license-requirements).

Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administor](/entra/identity/role-based-access-control/permissions-reference#lifecycle-workflows-administrator). Navigate to **Identity Governance** -> **Lifecycle workflows overview**.

Launch Security Copilot from the **Copilot** button in the Microsoft Entra admin center.  Use natural language questions or prompts to:

- Create a lifecycle workflow
- Run a lifecycle workflow
- Explore available workflow configurations
- Analyze the active workflow list
- Troubleshoot the processing results of workflows

:::image type="content" source="./media/copilot-entra-lifecycle-workflow/security-copilot-button.png" alt-text="Screenshot that shows the Copilot in the Microsoft Entra admin center.":::

## Create a new lifecycle workflow

Security Copilot can give you the steps for creating a new lifecycle workflow. Provide a prompt with actions to take when the workflow is triggered and conditions that define which users (scope) this workflow should run against, and when (trigger) the workflow should run.  For example:

*Create a lifecycle workflow for new hires in the Marketing department that sends a welcome email and a TAP and adds them to the "All Users in My Tenant" group.  Also, provide the option to enable the schedule of the workflow.*

Review the returned results to see what the workflow includes and then [create a new worflow](/entra/id-governance/create-lifecycle-workflow) in the Microsoft Entra admin center. After the workflow is created, you can perform verification testing before enabling the schedule.

## Run a lifecycle workflow on demand

Security Copilot can also provide steps for running a workflow on demand or on a schedule.  Provide a prompt with information on a specific workflow to run, when it should run, and which user(s) to run it for. For example:

Review the returned steps to see what the workflow includes then run the workflow. 

## Explore available workflow configurations

Using Microsoft Security Copilot, you can efficiently manage various lifecycle workflows. Here are some common tasks you can accomplish with Security Copilot:

For example:

- *List all lifecycle workflows in my tenant*
- *List all the supported workflow templates for creating a new workflow*
- *Which mover tasks can I automate with lifecycle workflows?*
- *Which joiner tasks can I automate with lifecycle workflows?*
- *Which leaver tasks can I automate with lifecycle workflows?*
- *What are my lifecycle workflow settings?*
- *List all new hire templates in lifecycle workflows*
- *List all onboarding templates in lifecycle workflows*
- *List all offboarding templates in lifecycle workflows*
- *What templates can be used for creating a joiner workflow?* 
- *What templates can be used for creating a leaver workflow?*
- *What templates can be used for creating a mover workflow?*

## Analyze active workflow list

With Microsoft Security Copilot, you can easily analyze and manage your active workflow list and retrieve specific workflow information.

For example:

- *List all joiner workflows in my tenant*
- *List all leaver workflows in my tenant*
- *List all mover workflows in my tenant*
- *List all the deleted lifecycle workflows in my tenant*
- *Show me the details of deleted workflow <workflow name>*
- *List all disabled lifecycle workflows in my tenant*
- *Show me the details of disabled workflow <workflow>*
- *Get my lifecycle workflows with the name <workflow name>*

## Troubleshoot a Lifecyle Workflow run

You can use Security Copilot to help troubleshoot a workflow run.  Security Copilot uses the information provided to generate and return a rich summary of the workflow history over the given time period for the specified workflow. 

Explore workflow processing results of a specific workflow:

- *Summarize the runs for <workflow> in the last 7 days*
- *List the run results for <workflow> in the last 30 days*
- *Show me the task results summary for <workflow> in the last 7 days*
- *How many users have failed for this workflow in the last 14 days?*
- *Which users failed to be processed by this workflow in the last 7 days?*
- *Show me the user processing results summary for <workflow> in the last 7 days*
- *Which tasks failed for <workflow> in the last 7 days?*
- *How many times did the workflow run in the last 24 hours*

Explore workflow processing results across workflows:

- *How many users were successfully processed by workflows in the last 14 days?* 
- *How many workflows were processed in the last 7 days?* 
- *How many workflows were run on-demand in the last 30 days?* 
- *Which workflows have been run the most in the last 7 days?* 
- *Which tasks have been executed the most in the last 7 days?* 
- *Which workflows failed the most in the last 7 days?* 
- *How many mover workflows were executed in the last 30 days?*
- *Which workflow category was processed the most in the last 30 days?* 
- *Which tasks failed the most in the last 30 days?* 
- *Which tasks had the most failed users in the last 7 days?* 

## Compare versions of a lifecycle workflow 

You can use Security Copilot to compare workflow versions. Security Copilot uses the information provided to generate and return a rich summary of the content of two versions of the specified workflow as well as the core differences between the workflow versions including tasks and execution conditions.

For example:

- *List all workflow versions for <workflow>*
- *Show me who last modified <workflow> and when*
- *Show me the details of <version #> for this workflow*
- *What changed in the last version of this workflow?*
- *Compare the last two versions of this workflow*
- *Compare <version #> and <version #> of this workflow*

## Next steps

- Learn more about [lifecycle workflows](/entra/id-governance/what-are-lifecycle-workflows).
- [Create a lifecycle workflow](/entra/id-governance/create-lifecycle-workflow).
- [Run a workflow](/entra/id-governance/on-demand-workflow) on demand.
