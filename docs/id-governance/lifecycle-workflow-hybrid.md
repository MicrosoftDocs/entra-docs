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
ms.date: 02/13/2024
ms.custom: template-concept 

#CustomerIntent: As an IT administrator, I want to learn about hybrid support with Lifecycle workflows so that I can manage synced on-premises users using workflows.
---

# Lifecycle Workflow hybrid capabilities (preview)

Lifecycle Workflows allow you to create workflows that can be triggered for users based on joiner, mover, or leaver scenarios. These workflows allow you to streamline the process of managing users in your hybrid environment via tasks. You're able to enable a synced hybrid user via a user account task, run workflows when the user changes a team or job role, disable an account when the user leaves, and even delete the user account when they're no longer in your organization. These capabilities can be extended to hybrid users either out of the box, or with some prerequisites. In this article, you learn what is needed to use workflow features in your hybrid environment.


## Workflow triggers and hybrid capabilities

In Lifecycle Workflows, a workflow runs based on if a user meets its execution conditions. Each execution condition must have a trigger, which defines when a user meets the execution condition of a workflow. The trigger you set for an execution condition depends on the user situation for which you want the workflow to run. For more information on these execution conditions, and when you would use each, see: **Execution Condition conceptual article**.

The following table shows what is required to use each workflow trigger in a hybrid environment:

|Workflow Trigger  |Hybrid requirements  |
|---------|---------|
|Attribute changes     | No further setup needed as long as attributes are synced.       |
|Group membership based     | No further setup needed. Also works for on-premises groups as long as they're synced.        |
|On-demand     |   No further setup needed.      |
|Time-based    |  **employeeHireDate**, **employeeLeaveDateTime**: These attributes must be synced before being used. For more information on this process, see: [How to synchronize attributes for Lifecycle workflows](./how-to-lifecycle-workflow-sync-attributes.md).<br></br>**createdDateTime**: No further requirements needed. This date is the day the user account is synced to Microsoft Entra ID, not when they were created within Active Directory.       |


## Workflow tasks and hybrid capabilities

All of the Lifecycle Workflow tasks work the same for both cloud, and hybrid, users out of the box except for limitations listed on specific tasks further in this article. For more information on all Lifecycle Workflow tasks, see: [Lifecycle Workflow built-in tasks](lifecycle-workflow-tasks.md).

### Group tasks

Tasks related to adding and removing users to a group work except for that the hybrid group that you're adding a user to, or removing a user from, must also be synced to Microsoft Entra ID. You can enable access from on-premises Active Directory to Microsoft Entra ID by using [Microsoft Entra Cloud Sync group writeback](~/identity/hybrid/cloud-sync/how-to-configure-entra-to-active-directory.md).

## User account tasks 

Tasks related to managing user accounts when they're enabled, disabled, or deleted, work with hybrid users as long as you have satisfied the following prerequisites in setting up your hybrid environment:

- You must have the [Microsoft Entra provisioning agent](../identity/hybrid/cloud-sync/what-is-provisioning-agent.md) installed in your environment. You can follow the existing installation [prerequisites](../identity/hybrid/cloud-sync/how-to-prerequisites.md) and [steps](../identity/hybrid/cloud-sync/how-to-install.md) in our public documentation. During installation, choose “**HR-driven provisioning / Azure AD Connect Cloud Sync**” as “**extension configuration**”. You aren't required to add any other configuration for the provisioning agent, such as the cloud sync configuration, and you can install the provisioning agent even if you're currently using Microsoft Entra Connect Sync for your user synchronization (side-by-side).

- Ensure the gMSA used by the provisioning agent has the [appropriate permissions](../identity/hybrid/cloud-sync/how-to-prerequisites.md#custom-gmsa-account) to delete user accounts.

- Enable the Active Directory recycle bin. For a step-by-step guide on enabling the recycle bin, see: [Active Directory Recycle Bin step-by-step](/windows-server/identity/ad-ds/get-started/adac/introduction-to-active-directory-administrative-center-enhancements--level-100-#active-directory-recycle-bin-step-by-step).

For a step by step guide on setting the flag so that user account tasks run for hybrid users, see: [Manage user account tasks for hybrid users (preview)](./manage-workflow-onprem.md).

## Next steps

> [!div class="nextstepaction"]
> [Manage synced on-premises users with workflows(preview)](manage-workflow-onprem.md)
