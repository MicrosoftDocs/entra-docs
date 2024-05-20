---
title: Managing synced on-premises users with Lifecycle Workflows
description: Conceptual article discussing managing synced on-premises users with Lifecycle Workflows.
author: owinfreyATL
ms.author: owinfrey
manager: amycolannino
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.workload: identity
ms.topic: conceptual 
ms.date: 05/17/2024
ms.custom: template-concept 

#CustomerIntent: As an IT administrator, I want to learn about managing synced on-premises users with Lifecycle workflows so that I can use workflows to manage these users in my environment.
---

# Managing synced on-premises users with lifecycle workflows

Lifecycle Workflows supports governing the identity lifecycle for user accounts that are synchronized from on-premises Active Directory Domain Services (AD-DS) to Microsoft Entra. For Lifecycle Workflows, it's essential that a user account exists in Microsoft Entra, but how the account was created or how lifecycle relevant changes are being made to the account plays a minor role when it comes to processing workflows and associated tasks for the user account. The support includes accounts and changes made via paths such as [HR driven provisioning](../identity/app-provisioning/what-is-hr-driven-provisioning.md), Microsoft Graph APIs, the Microsoft Entra Admin Portal as well as changes synchronized by Microsoft Entra Connect and MicrosoftCloud Sync.

In this article, you learn what needs to be considered if you want to use Lifecycle Workflows for user accounts that are synchronized from on-premises Active Directory Domain Services (AD-DS) to Microsoft Entra, referred to as ‘*synced on-premises users*’.


## Workflow execution conditions with synced on-premises users

Lifecycle Workflows are processed for user accounts when they meet the workflows execution conditions. Executing conditions are composed of a trigger and scope. The trigger describes the event that occurs for a user account. The scope allows you to further define for whom the workflow starts when the event occurs.

### Workflow triggers

The following table shows what should be considered for each workflow trigger when used with synced on-premises users:

|Workflow Trigger  | Requirements  |
|---------|---------|
|Attribute changes (preview)     | No further configuration needed as long as attributes are synced. For information on synced attributes, see: [Attribute mapping in Microsoft Entra Cloud Sync](../identity/hybrid/cloud-sync/how-to-attribute-mapping.md) and [Microsoft Entra Connect Sync: Directory extensions](../identity/hybrid/connect/how-to-connect-sync-feature-directory-extensions.md). When a change is made in on-premises Active Directory, the synchronization via Microsoft Entra Cloud Sync or Microsoft Entra Connect Sync needs to occur before changes can be picked up from Lifecycle Workflows.      |
|Group membership based  (preview)   | As any type of group is supported, no further configuration is required. If the group originates from on-premises Active Directory, it must be synchronized to Microsoft Entra. The Microsoft Entra Cloud Sync, or Microsoft Entra Connect Sync, synchronization needs to occur before changes can be picked up from Lifecycle Workflows.       |
|On-demand     |   No further configuration needed.      |
|Time based    |  **employeeHireDate**, **employeeLeaveDateTime**: These attributes must be synced before being used. For more information on this process, see: [How to synchronize attributes for Lifecycle workflows](./how-to-lifecycle-workflow-sync-attributes.md).<br></br>**createdDateTime**: No further requirements needed. This date is the day the user account is synced to Microsoft Entra ID, not when they were created within Active Directory.       |

### Workflow scoping

For user attributes used within the workflow scoping capabilities, no further configuration is needed if the selected attributes are already synchronized. For information on synchronized attributes, see: [Attribute mapping in Microsoft Entra Cloud Sync](../identity/hybrid/cloud-sync/how-to-attribute-mapping.md) and [Microsoft Entra Connect Sync: Directory extensions](../identity/hybrid/connect/how-to-connect-sync-feature-directory-extensions.md). When a change is made in on-premises Active Directory, the synchronization via Microsoft Entra Cloud Sync or Microsoft Entra Connect Sync needs to occur before changes can be picked up from Lifecycle Workflows.


## Workflow tasks and synced on-premises capabilities

All Lifecycle workflow tasks work for both cloud, and synced on-premises, users out of the box except for limitations listed on specific tasks further in this article. For more information on all Lifecycle Workflow tasks, see:  [Lifecycle Workflow built-in tasks](lifecycle-workflow-tasks.md).

### Tasks to govern group memberships

The Lifecycle Workflows tasks to govern group memberships can't be used for groups that are synchronized from on-premises Active Directory to Microsoft Entra. However, Microsoft Entra ID Governance can be used to [govern on-premises Active Directory (Kerberos) application access](../identity/hybrid/cloud-sync/govern-on-premises-groups.md) with groups from the cloud, which are supported within Lifecycle Workflows.

## User account tasks (preview)

Additional configuration is required for the Lifecycle Workflow tasks to enable, disable, and delete user accounts to work with synced on-premises users. The following prerequisites must be completed before you can configure the tasks to perform actions in on-premises Active Directory.

- You must have the [Microsoft Entra provisioning agent](../identity/hybrid/cloud-sync/what-is-provisioning-agent.md) installed in your environment. For prerequisites on installing the Microsoft Entra provisioning agent, see: [Cloud provisioning agent requirements](../identity/hybrid/cloud-sync/how-to-prerequisites.md#cloud-provisioning-agent-requirements). For a step by step guide on installing the Microsoft Entra Provisioning agent, see: [Install the Microsoft Entra Provisioning Agent](../identity/hybrid/cloud-sync/how-to-install.md). During installation, choose “**HR-driven provisioning / Microsoft Entra Connect Sync**” as “**extension configuration**”. You aren't required to add any other configuration for the provisioning agent, such as the cloud sync configuration, and you can install the provisioning agent even if you're also currently using Microsoft Entra Connect Sync for your user synchronization.

> [!NOTE]
> The Provisioning agent installed must be at least version 1.1.1586.0, which was released May 13th, 2024.

- Ensure the Group Managed Service Account(gMSA) used by the provisioning agent has the [appropriate permissions](../identity/hybrid/cloud-sync/how-to-prerequisites.md#custom-gmsa-account) to perform operations on user accounts.

- To delete users accounts, you must enable the Active Directory recycle bin. For a step-by-step guide on enabling the recycle bin, see: [Active Directory Recycle Bin step-by-step](/windows-server/identity/ad-ds/get-started/adac/introduction-to-active-directory-administrative-center-enhancements--level-100-#active-directory-recycle-bin-step-by-step).

For a step by step guide on setting the flag so that user account tasks run for synced on-premises users, see: [Manage synced on-premises users with workflows (preview)](./manage-workflow-on-premises.md).

## Next steps

> [!div class="nextstepaction"]
> [Manage synced on-premises users with workflows (preview)](manage-workflow-on-premises.md)
