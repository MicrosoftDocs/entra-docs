---
# required metadata

title: Manage Lifecycle Workflows with Copilot in Microsoft Entra 
description: Use Microsoft Copilot in Microsoft Entra to assist with the creation of Lifecycle Workflows for Joiner, Mover and Leaver scenarios, execute workflows on-demand, and assist with using workflow insights to monitor workflow execution and troubleshoot if needed.
keywords:
author: rwike77
ms.author: ryanwi
manager: celestedg
ms.date: 03/26/2024
ms.topic: conceptual
ms.service: entra
ms.custom: microsoft-copilot

# Customer intent: As a Lifecycle Workflows Administrators or Global Administrators , I want to learn about risky user summarization in the Identity Protection UX so that I can quickly respond to identity threats.
---

# Respond to identity threats using risky user summarization

Microsoft Entra ID Governance applies the capabilities of [Microsoft Copilot for Microsoft Entra](/security-copilot/microsoft-security-copilot) to save identity administors time and effort when configuring custom workflows to manage the lifecycle of users across JML scenarios. It also helps you to customize workflows more efficiently using natural language to configure workflow information including custom tasks, execute workflows, and get workflow insights.

This article describes how to work with Lifecycle Workflows using Copilot for Microsoft Entra.  Using this feature requires [Microsoft Entra ID Governance licenses](/entra/id-governance/identity-governance-overview#license-requirements).


Sign in to the Microsoft Entra admin center as at least a [Lifecycle Workflows Administor](/entra/identity/role-based-access-control/permissions-reference#lifecycle-workflows-administrator). Navigate to **Identity Governance** -> **Lifecycle Workflows Overview**.

Copilot can be launched from the **Copilot can help** button in Lifecycle Workflows which offers a few prompt suggestions to choose from to help the admin get started, including:

- Create a new Lifecycle Workflow
- Run a Lifecycle Workflow on demand
- Help me troubleshoot a Lifecyle Workflow run
- Compare versions of a Lifecycle Workflow 

Copilot can also be launched by clicking the button in the Entra global command bar. Once the Copilot experience is launched, the admin provides a “prompt" which provides Copilot with context about which Lifecycle Workflows scenario Copilot can assist with. 




## Create a new Lifecycle Workflow

Provide a prompt with information on how Copilot should craft the Lifecycle Workflow.  Copilot uses information provided in the prompt to generate a draft Joiner, Leaver, or Mover workflow template.  For example:

*Create a lifecycle workflow for new hires in the Marketing department that sends a welcom email and a TAP and adds them to the "All Users in My Tenant" group.  Also, provide the option to enable the schedule of the workflow.*

Review the results to see what the Workflow includes, then click **Create draft**. Click **Add task** to extend the tasks that will be performed. When an email task is part of the workflow, you can click **Customize Email Task** to optionally customize the email subject and content to ensure a personalized email is sent to users in thescope of the workflow.

Click **Create draft** when you're satisfied with the draft, which launches the **Create workflow** wizard. A fully populated draft templae is launched in the **Review + create** tab. Click through the different tabs to see how the various tasks were completed and make any changes needed. Click **Create** when the draft is complete. After the workflow is created, you can perform verification testing before enabling the schedule.

## Run a Lifecycle Workflow on demand

Provide a prompt with information on how Copilot can run a specific workflow on-demand. Copilot uses the information provided to configure the on-demand run of the that workflow for the specified users. Review the summary to see what the Workflow includes and click **Create draft**. If needed, click **Add more users** to select more users that will be run ondemand. 

Click **Create draft** when you're satisfied with the draft, which launches the **Run on demand** page for the specific workflow with a fully populated draft. Click through the different tabs to see users and the various tasks to execute or make any changes to the selected users. Click **Run workflow** when your draft is complete. 

## Troubleshoot a Lifecyle Workflow run

Provide a prompt with information asking Copilot to help troubleshoot a workflow run.  Copilot uses the information provided to generate and return a rich summary of the workflow history over the given time period for the specified workflow. 

## Compare versions of a Lifecycle Workflow 

Provide a “prompt" with information asking Copilot to compare workflow versions. Copilot uses the information provided to generate and return a rich summary of the content of two versions of the specified workflow as well as the core differences between the workflow versions including tasks and execution conditions.

## Next steps

- Learn more about [risky users](/entra/id-protection/howto-identity-protection-investigate-risk#risky-users).

