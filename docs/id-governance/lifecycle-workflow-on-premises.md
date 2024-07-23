---
title: Managing Users synchronized from Active Directory Domain Services to Microsoft Entra ID with Lifecycle Workflows
description: Conceptual article discussing managing Users synchronized from Active Directory Domain Services (AD DS) to Microsoft Entra with Lifecycle Workflows.
author: owinfreyATL
ms.author: owinfrey
manager: amycolannino
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.workload: identity
ms.topic: conceptual 
ms.date: 07/10/2024
ms.custom: template-concept 

#CustomerIntent: As an IT administrator, I want to learn about managing users with Lifecycle workflows so that I can use workflows to manage these users in my environment.
---

# Managing Users synchronized from Active Directory Domain Services to Microsoft Entra ID with Lifecycle Workflows

Lifecycle Workflows supports governing the identity lifecycle for user accounts that are synchronized from Active Directory Domain Services (AD DS) to Microsoft Entra ID. For Lifecycle Workflows, it's essential that a user account exists in Microsoft Entra ID, but how the account was created or how lifecycle relevant changes are being made to the account plays a minor role when it comes to processing workflows and associated tasks for the user account. The support includes accounts and changes made via paths such as [HR driven provisioning](../identity/app-provisioning/what-is-hr-driven-provisioning.md), Microsoft Graph APIs, the Microsoft Entra Admin Portal as well as changes synchronized by Microsoft Entra Connect and MicrosoftCloud Sync.

The following table lists common automation scenarios for synchronized users from Active Directory Domain Services using Microsoft Entra ID Governance:

|Scenario to automate  |Microsoft Entra ID Governance solution  |
|---------|---------|
|Creating the user account in Active Directory Domain Services    |   [HR driven provisioning](../identity/app-provisioning/what-is-hr-driven-provisioning.md)      |
|Providing initial credentials or password for user accounts  |  The [Generate Temporary Access Pass and send via email to user's manager](../id-governance/lifecycle-workflow-tasks.md#generate-temporary-access-pass-and-send-via-email-to-users-manager) task can be used to set up password-less credentials. For setting up a regular Active Directory password, you can use [Microsoft Entra self-service password reset](../identity/authentication/concept-sspr-howitworks.md).      |
|Assigning licenses     |  The [Assign licenses to user (Preview)](../id-governance/lifecycle-workflow-tasks.md#assign-licenses-to-user-preview) Lifecycle Workflow task can be used to assign licenses. You're also able to assign licenses to to user via [a group](../fundamentals/license-users-groups.yml).    |
|Give user access to Active Directory group-based applications     |  [Govern on-premises Active Directory (Kerberos) application access](../identity/hybrid/cloud-sync/govern-on-premises-groups.md)       |
|Update user attributes in Active Directory as they move organizations     |  [Plan scoping filters and attribute mapping](../identity/app-provisioning/plan-cloud-hr-provision.md#plan-scoping-filters-and-attribute-mapping)       |
|Move the user to different OUs as they move organizations     | [Configure Active Directory OU container assignment](../identity/app-provisioning/plan-cloud-hr-provision.md#configure-active-directory-ou-container-assignment)        |
|Disable users on last day     |   The [Disable user account](../id-governance/lifecycle-workflow-tasks.md#disable-user-account) Lifecycle Workflow task can be used to disable a user account on their last day.     |
|Deleting users some days after termination     |   The [Delete User](../id-governance/lifecycle-workflow-tasks.md#delete-user) Lifecycle Workflow task can be used within a workflow template to delete users a set number of days after their termination.      |

In this article, you learn what needs to be considered if you want to use Lifecycle Workflows for user accounts that are synchronized from AD DS to Microsoft Entra ID.

## Workflow execution conditions with Users synchronized from Active Directory Domain Services (AD DS) to Microsoft Entra ID

Lifecycle Workflows are processed for user accounts when they meet the workflows execution conditions. Executing conditions are composed of a trigger and scope. The trigger describes the event that occurs for a user account. The scope allows you to further define for whom the workflow starts when the event occurs.

### Workflow triggers

The following table shows what should be considered for each workflow trigger when used with users synchronized from AD DS:

|Workflow Trigger  | Requirements  |
|---------|---------|
|Attribute changes (preview)     | No further configuration needed as long as attributes are synced. For information on synced attributes, see: [Attribute mapping in Microsoft Entra Cloud Sync](../identity/hybrid/cloud-sync/how-to-attribute-mapping.md) and [Microsoft Entra Connect Sync: Directory extensions](../identity/hybrid/connect/how-to-connect-sync-feature-directory-extensions.md). When a change is made in Active Directory, the synchronization via Microsoft Entra Cloud Sync or Microsoft Entra Connect Sync needs to occur before changes can be picked up from Lifecycle Workflows.      |
|Group membership based  (preview)   | As any type of group is supported, no further configuration is required. If the group originates from Active Directory, it must be synchronized to Microsoft Entra. The Microsoft Entra Cloud Sync, or Microsoft Entra Connect Sync, synchronization needs to occur before changes can be picked up from Lifecycle Workflows.       |
|On-demand     |   No further configuration needed.      |
|Time based    |  **employeeHireDate**, **employeeLeaveDateTime**: These attributes must be synced before being used. For more information on this process, see: [How to synchronize attributes for Lifecycle workflows](./how-to-lifecycle-workflow-sync-attributes.md).<br></br>**createdDateTime**: No further requirements needed. This date is the day the user account is synced to Microsoft Entra ID, not when they were created within Active Directory.       |

### Workflow scoping

For user attributes used within the workflow scoping capabilities, no further configuration is needed if the selected attributes are already synchronized. For information on synchronized attributes, see: [Attribute mapping in Microsoft Entra Cloud Sync](../identity/hybrid/cloud-sync/how-to-attribute-mapping.md) and [Microsoft Entra Connect Sync: Directory extensions](../identity/hybrid/connect/how-to-connect-sync-feature-directory-extensions.md). When a change is made in Active Directory, the synchronization via Microsoft Entra Cloud Sync or Microsoft Entra Connect Sync needs to occur before changes can be picked up from Lifecycle Workflows.


## Workflow tasks for users synchronized from Active Directory Domain Services to Microsoft Entra ID

All Lifecycle workflow tasks work for both cloud, and synchronized from Active Directory, users out of the box except for limitations listed on specific tasks further in this article. For more information on all Lifecycle Workflow tasks, see:  [Lifecycle Workflow built-in tasks](lifecycle-workflow-tasks.md).

### Tasks to govern group memberships

**Scenario:** When you have synchronized users from Active Directory Domain Services to Microsoft Entra ID, you're able to add, or remove, users from cloud-based security groups via Lifecycle Workflow's group tasks. This allows you to govern group membership of the synchronized users in the cloud, and to also add this group back to Active Directory using [Microsoft Entra Cloud Sync group writeback](../identity/hybrid/cloud-sync/how-to-configure-entra-to-active-directory.md).

For groups that are synchronized from AD DS to Microsoft Entra ID, you wouldn't be able to use Lifecycle Workflow group tasks as mentioned in the scenario. However, Microsoft Entra ID Governance can be used to [govern on-premises Active Directory (Kerberos) application access](../identity/hybrid/cloud-sync/govern-on-premises-groups.md) with groups from the cloud, which are supported within Lifecycle Workflows.

## User account tasks (preview)

Additional configuration is required for the Lifecycle Workflow tasks to enable, disable, and delete user accounts to work with synchronized from AD DS. The following prerequisites must be completed before you can configure the tasks to perform actions in Active Directory.

- You must have the [Microsoft Entra provisioning agent](../identity/hybrid/cloud-sync/what-is-provisioning-agent.md) installed in your environment. For prerequisites on installing the Microsoft Entra provisioning agent, see: [Cloud provisioning agent requirements](../identity/hybrid/cloud-sync/how-to-prerequisites.md#cloud-provisioning-agent-requirements). For a step by step guide on installing the Microsoft Entra Provisioning agent, see: [Install the Microsoft Entra Provisioning Agent](../identity/hybrid/cloud-sync/how-to-install.md). During installation, choose “**HR-driven provisioning / Microsoft Entra Connect Sync**” as “**extension configuration**”. You aren't required to add any other configuration for the provisioning agent, such as the cloud sync configuration, and you can install the provisioning agent even if you're also currently using Microsoft Entra Connect Sync for your user synchronization.

> [!NOTE]
> The Provisioning agent installed must be at least version 1.1.1586.0, which was released May 13th, 2024.

- Ensure the Group Managed Service Account(gMSA) used by the provisioning agent has the [appropriate permissions](../identity/hybrid/cloud-sync/how-to-prerequisites.md#custom-gmsa-account) to perform operations on user accounts.

- To delete users accounts, you must enable the Active Directory recycle bin. For a step-by-step guide on enabling the recycle bin, see: [Active Directory Recycle Bin step-by-step](/windows-server/identity/ad-ds/get-started/adac/introduction-to-active-directory-administrative-center-enhancements--level-100-#active-directory-recycle-bin-step-by-step).

For a step by step guide on setting the flag so that user account tasks run for users synchronized from Active Directory Domain Services, see: [Manage synchronized from Active Directory Domain Services (AD DS) with workflows (preview)](./manage-workflow-on-premises.md).

## Next steps

> [!div class="nextstepaction"]
> [Manage synchronized from Active Directory Domain Services (AD DS) with workflows (preview)](manage-workflow-on-premises.md)
