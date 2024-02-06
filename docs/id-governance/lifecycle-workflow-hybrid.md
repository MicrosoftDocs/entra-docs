---
title: Lifecycle Workflow hybrid capabilities (preview)
description: Conceptual article discussing Lifecycle Workflow's hybrid compatibility
author: owinfreyATL
ms.author: owinfrey
manager: amycolannino
ms.service: active-directory
ms.subservice: compliance
ms.workload: identity
ms.topic: conceptual 
ms.date: 01/31/2024
ms.custom: template-concept 

#CustomerIntent: As an IT administrator, I want to learn about hybrid support with Lifecycle workflows so that I can manage synced on-premises users using workflows.
---

# Lifecycle Workflow hybrid capabilities (preview)

Lifecycle Workflows allow you to create workflows that can be triggered for users based on joiner, mover, or leaver scenarios. With hybrid support, you're able to trigger specific user-based tasks for users synced from on-premises Active Directory to Microsoft Entra ID. This is accomplished by allowing you to create a task enabling an on-premises user account, so that you're able to run other tasks in a workflow for the user. You're also able to disable, or even delete, a user account when they're no longer active in your organization. This allows you to use workflows to automate tasks across the lifecycle of users in your hybrid environment. Using Lifecycle Workflows with hybrid users requires additional prerequisites. For a step by step guide on creating a task for hybrid users, see: [Manage synced on-premises users with workflows](manage-workflow-onprem.md).

## Hybrid specific tasks

With Lifecycle Workflow's hybrid-specific tasks, you're able to set a flag on the following tasks so that they run for hybrid users. The following tasks are able to have the hybrid flag set for them:

- Delete user account
- Disable user account
- Enable user account

The respective flags can be found on their task screen:

:::image type="content" source="media/lifecycle-workflow-hybrid/delete-onprem-user.png" alt-text="Screenshot of delete user on-premises flag in task.":::

For more information on these tasks, see: [Lifecycle Workflow built-in tasks](lifecycle-workflow-tasks.md).

## Hybrid Prerequisites

To manage synced on-premises users with Lifecycle Workflows, you must have the following on-premises prerequisites:

1. You must have the [Microsoft Entra provisioning agent](../identity/hybrid/cloud-sync/what-is-provisioning-agent.md) installed in your environment. You can follow the existing installation [prerequisites](../identity/hybrid/cloud-sync/how-to-prerequisites.md) and [steps](../identity/hybrid/cloud-sync/how-to-install.md) in our public documentation. During installation, choose “**HR-driven provisioning / Azure AD Connect Cloud Sync**” as “**extension configuration**”. You aren't required to add any other configuration for the provisioning agent, such as the cloud sync configuration, and you can install the provisioning agent even if you're currently using Microsoft Entra Connect Sync for your user synchronization (side-by-side).

1. Ensure the gMSA used by the provisioning agent has the [appropriate permissions](../identity/hybrid/cloud-sync/how-to-prerequisites.md#custom-gmsa-account) to delete user accounts.

1. Enable the Active Directory recycle bin. For a step-by-step guide on enabling the recycle bin, see: [Active Directory Recycle Bin step-by-step](/windows-server/identity/ad-ds/get-started/adac/introduction-to-active-directory-administrative-center-enhancements--level-100-#active-directory-recycle-bin-step-by-step).

## Next steps

> [!div class="nextstepaction"]
> [Manage synced on-premises users with workflows(preview)](manage-workflow-onprem.md)
