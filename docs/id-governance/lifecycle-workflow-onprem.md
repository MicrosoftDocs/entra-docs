---
title: Managing synced on-premises users with lifecycle workflows
description: Conceptual article discussing managing synced on-premises users with Lifecycle Workflows.
author: owinfreyATL
ms.author: owinfrey
manager: amycolannino
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.workload: identity
ms.topic: conceptual 
ms.date: 04/10/2024
ms.custom: template-concept 

#CustomerIntent: As an IT administrator, I want to learn about managing synced on-premises users with Lifecycle workflows so that I can use workflows to manage these users in my environment.
---

# Managing synced on-premises users with lifecycle workflows

Lifecycle workflows allow you to create workflows that can be triggered for users based on where they fall in the joiner, mover, or leaver(JML) lifecycle within your organization. With these workflows, you can also streamline the process of managing cloud-based, and synced on-premises users in your environment via tasks. For example, you're able to enable synced on-premises user accounts, onboard users while also sending required information to their manager, automatically add users to groups or teams when their job role changes, disable accounts when users are no longer active, and even delete the user account. These capabilities work either out of the box, or with some configuration. In this article, you learn what is needed to use lifecycle workflow tasks on synced on-premises users in your environment.


## Synced on-premises user capabilities compatibility with workflow triggers

In lifecycle workflows, a workflow runs based on if a user meets its execution conditions. Each execution condition must have a trigger, which defines when a user meets the execution condition of a workflow, and a scope, which defines which users for who the workflow runs. The trigger you set for an execution condition depends on the user situation for which you want the workflow to run.

The following table shows what is required to use each workflow trigger with synced on-premises users:

|Workflow Trigger  | Requirements  |
|---------|---------|
|Attribute changes (preview)     | No further configuration needed as long as attributes are synced. For information on synced attributes, see: [Attribute mapping in Microsoft Entra Cloud Sync](../identity/hybrid/cloud-sync/how-to-attribute-mapping.md) and [Microsoft Entra Connect Sync: Directory extensions](../identity/hybrid/connect/how-to-connect-sync-feature-directory-extensions.md).       |
|Group membership based  (preview)   | Group needs to have a presence in Microsoft Entra ID. If the group is synced in, there might be a delay, as processing starts once the change is synced into Microsoft Entra ID.       |
|On-demand     |   No further configuration needed.      |
|Time based    |  **employeeHireDate**, **employeeLeaveDateTime**: These attributes must be synced before being used. For more information on this process, see: [How to synchronize attributes for Lifecycle workflows](./how-to-lifecycle-workflow-sync-attributes.md).<br></br>**createdDateTime**: No further requirements needed. This date is the day the user account is synced to Microsoft Entra ID, not when they were created within Active Directory.       |


## Synced on-premises users and workflow capabilities

All Lifecycle workflow tasks work for both cloud, and synced on-premises, users out of the box except for limitations listed on specific tasks further in this article. For more information on all Lifecycle Workflow tasks, see: [Lifecycle Workflow built-in tasks](lifecycle-workflow-tasks.md).

### Group tasks

The group membership trigger works with on-premises Active Directory to Microsoft Entra ID synced groups. To control access to on-premises Active directory group-based applications and resources, you need to enable group writeback. For more information, see: [Microsoft Entra Cloud Sync group writeback](~/identity/hybrid/cloud-sync/how-to-configure-entra-to-active-directory.md) and [using group writeback with entitlement management](../id-governance/entitlement-management-group-writeback.md).

## User account tasks (preview)

Tasks related to enabling, disabling, and deleting user accounts work with synced on-premises users as long as you have satisfied the following prerequisites in your environment:

- You must have the [Microsoft Entra provisioning agent](../identity/hybrid/cloud-sync/what-is-provisioning-agent.md) installed in your environment. For prerequisites on installing the Microsoft Entra provisioning agent, see: [Cloud provisioning agent requirements](../identity/hybrid/cloud-sync/how-to-prerequisites.md#cloud-provisioning-agent-requirements). For a step by step guide on installing the Microsoft Entra Provisioning agent, see: [Install the Microsoft Entra Provisioning Agent](../identity/hybrid/cloud-sync/how-to-install.md). During installation, choose “**HR-driven provisioning / Microsoft Entra Connect Sync**” as “**extension configuration**”. You aren't required to add any other configuration for the provisioning agent, such as the cloud sync configuration, and you can install the provisioning agent even if you're also currently using Microsoft Entra Connect Sync for your user synchronization.

> [!NOTE]
> The Provisioning agent installed must be at least version 1.1.1586.0.

- Ensure the Group Managed Service Account(gMSA) used by the provisioning agent has the [appropriate permissions](../identity/hybrid/cloud-sync/how-to-prerequisites.md#custom-gmsa-account) to perform operations to user accounts.

- To delete users accounts, you must enable the Active Directory recycle bin. For a step-by-step guide on enabling the recycle bin, see: [Active Directory Recycle Bin step-by-step](/windows-server/identity/ad-ds/get-started/adac/introduction-to-active-directory-administrative-center-enhancements--level-100-#active-directory-recycle-bin-step-by-step).

For a step by step guide on setting the flag so that user account tasks run for synced on-premises users, see: [Manage synced on-premises users with workflows (preview)](./manage-workflow-onprem.md).

## Next steps

> [!div class="nextstepaction"]
> [Manage synced on-premises users with workflows (preview)](manage-workflow-onprem.md)
