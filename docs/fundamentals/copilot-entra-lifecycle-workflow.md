---
# required metadata

title: Manage Lifecycle Workflows with Copilot in Microsoft Entra 
description: Use Copilot in Microsoft Entra to assist with the creation of Lifecycle Workflows for Joiner, Mover and Leaver scenarios, execute workflows on-demand, and assist with using workflow insights to monitor workflow execution and troubleshoot if needed.
keywords:
author: rwike77
ms.author: ryanwi
manager: celestedg
ms.date: 12/16/2024
ms.topic: conceptual
ms.service: entra
ms.custom: microsoft-copilot

# Customer intent: As a Lifecycle Workflows Administrators or Global Administrators, I want to learn about risky user summarization in the Identity Protection UX so that I can quickly respond to identity threats.
---

# Manage Lifecycle Workflows

Microsoft Entra ID Governance applies the capabilities of [Microsoft Security Copilot](/security-copilot/microsoft-security-copilot) to save identity administors time and effort when configuring custom workflows to manage the lifecycle of users across JML scenarios. It also helps you to customize workflows more efficiently using natural language to configure workflow information including custom tasks, execute workflows, and get workflow insights.

This article describes how to work with Lifecycle Workflows using Security Copilot in the Microsoft Entra admin center.  Using this feature requires [Microsoft Entra ID Governance licenses](/entra/id-governance/identity-governance-overview#license-requirements).

Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administor](/entra/identity/role-based-access-control/permissions-reference#lifecycle-workflows-administrator). Navigate to **Identity Governance** -> **Lifecycle Workflows Overview**.

Security Copilot can be launched from the **Copilot** button in Microsoft Entra admin center, which offers the the following Lifecycle Workflow skills:

- Create a Lifecycle Workflow
- Explore available workflow configurations
- Analyze active workflow list
- Explore workflow processing results of a specific workflow
- Explore workflow processing results across workflows 

:::image type="content" source="./media/copilot-entra-lifecycle-workflow/security-copilot-button.png" alt-text="Screenshot that shows the Copilot in the Microsoft Entra admin center.":::

## Create a new Lifecycle Workflow

Provide a prompt with information so Security Copilot can give you the steps for creating a new Lifecycle Workflow.  Copilot uses information provided in the prompt to generate a draft Joiner, Leaver, or Mover workflow template.  For example:

*Create a lifecycle workflow for new hires in the Marketing department that sends a welcom email and a TAP and adds them to the "All Users in My Tenant" group.  Also, provide the option to enable the schedule of the workflow.*

Review the results to see what the Workflow includes, then click **Create draft**. Click **Add task** to extend the tasks that will be performed. When an email task is part of the workflow, you can click **Customize Email Task** to optionally customize the email subject and content to ensure a personalized email is sent to users in thescope of the workflow.

Click **Create draft** when you're satisfied with the draft, which launches the **Create workflow** wizard. A fully populated draft templae is launched in the **Review + create** tab. Click through the different tabs to see how the various tasks were completed and make any changes needed. Click **Create** when the draft is complete. After the workflow is created, you can perform verification testing before enabling the schedule.

## Run a Lifecycle Workflow on demand

Provide a prompt with information on how Copilot can run a specific workflow on-demand. Copilot uses the information provided to configure the on-demand run of the that workflow for the specified users. Review the summary to see what the Workflow includes and click **Create draft**. If needed, click **Add more users** to select more users that will be run ondemand. 

Click **Create draft** when you're satisfied with the draft, which launches the **Run on demand** page for the specific workflow with a fully populated draft. Click through the different tabs to see users and the various tasks to execute or make any changes to the selected users. Click **Run workflow** when your draft is complete. 

## Explore available workflow configurations

- *List all Lifecycle workflows in my tenant*
- *List all the supported workflow templates for creating a new workflow*
- *Which mover tasks can I automate with Lifecycle workflows?*
- *Which joiner tasks can I automate with Lifecycle workflows?*
- *Which leaver tasks can I automate with Lifecycle workflows?*
- *What are my Lifecycle workflow settings?*
- *List all new hire templates in Lifecycle workflows*
- *List all onboarding templates in Lifecycle workflows*
- *List all offboarding templates in Lifecycle workflows*
- *What templates can be used for creating a joiner workflow?* 
- *What templates can be used for creating a leaver workflow?*
- *What templates can be used for creating a mover workflow?*

## Analyze active workflow list

- *List all joiner workflows in my tenant*
- *List all leaver workflows in my tenant*
- *List all mover workflows in my tenant*
- *List all the deleted Lifecycle workflows in my tenant*
- *Show me the details of deleted workflow <workflow name>*
- *List all disabled Lifecycle workflows in my tenant*
- *Show me the details of disabled workflow <workflow>*
- *Get my lifecycle workflows with the name <workflow name>*

## Explore and compare versions of workflows

- *List all workflow versions for <workflow>*
- *Show me who last modified <workflow> and when*
- *Show me the details of <version #> for this workflow*
- *What changed in the last version of this workflow?*
- *Compare the last two versions of this workflow*
- *Compare <version #> and <version #> of this workflow*

## Explore workflow processing results of a specific workflow

- *Summarize the runs for <workflow> in the last 7 days*
- *List the run results for <workflow> in the last 30 days*
- *Show me the task results summary for <workflow> in the last 7 days*
- *How many users have failed for this workflow in the last 14 days?*
- *Which users failed to be processed by this workflow in the last 7 days?*
- *Show me the user processing results summary for <workflow> in the last 7 days*
- *Which tasks failed for <workflow> in the last 7 days?*
- *How many times did the workflow run in the last 24 hours*

## Explore workflow processing results across workflows 

- *How many users were successfully processed by workflows in the last 14 days?* 
- *How many workflows were processed in the last 7 days?* 
- *How many workflows were run on-demand in the last 30 days?* 
- *Which workflows have been run the most in the last 7 days?* 
- *Which tasks have been executed the most in the last 7 days?* 
- *Which workflows failed the most in the last 7 days?* 
- *How many mover workflows were executed in the last 30 days? *
- *Which workflow category was processed the most in the last 30 days?* 
- *Which tasks failed the most in the last 30 days?* 
- *Which tasks had the most failed users in the last 7 days?* 

## Troubleshoot a Lifecyle Workflow run

Provide a prompt with information asking Security Copilot to help troubleshoot a workflow run.  Security Copilot uses the information provided to generate and return a rich summary of the workflow history over the given time period for the specified workflow. 

## Compare versions of a Lifecycle Workflow 

Provide a “prompt" with information asking Security Copilot to compare workflow versions. Security Copilot uses the information provided to generate and return a rich summary of the content of two versions of the specified workflow as well as the core differences between the workflow versions including tasks and execution conditions.

## Next steps

- Learn more about [risky users](/entra/id-protection/howto-identity-protection-investigate-risk#risky-users).

