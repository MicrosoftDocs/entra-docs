---
title: Manage synced on-premises users with workflows
description: A how to article on how to manage synced on-premises users with lifecycle workflows.
author: owinfreyATL
ms.author: owinfrey
manager: amycolannino
ms.service: active-directory
ms.workload: identity
ms.topic: how-to 
ms.date: 1/12/2024
ms.subservice: compliance
ms.custom: template-how-to 

#CustomerIntent: As an administrator, I want to be able to create workflows for synced on-prem users so that they can be manged.

---

# Manage synced on-premises users with workflows

Workflows created by Lifecycle Workflows can be used to manage the lifecycle of synced on-premises users. This allows for greater, and simplified, control of the lifecycle of users within your organization in hybrid environments. In this article, you're walked through the steps of enabling a task to be run for an on-premises user.

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](~/includes/entra-entra-governance-license.md)]

To manage synced on-premises users with Lifecycle Workflows, you must have the following on-premises prerequisites:

1. You must have the [Microsoft Entra provisioning agent](../identity/hybrid/cloud-sync/what-is-provisioning-agent.md) installed in your environment. You can follow the existing installation [prerequisites](../identity/hybrid/cloud-sync/how-to-prerequisites.md) and [steps](../identity/hybrid/cloud-sync/how-to-install.md) in our public documentation. During installation, choose “**HR-driven provisioning / Azure AD Connect Cloud Sync**” as “**extension configuration**”. You aren't required to add any other configuration for the provisioning agent, such as the cloud sync configuration, and you can install the provisioning agent even if you're currently using Microsoft Entra Connect Sync for your user synchronization (side-by-side).

1. Ensure the gMSA used by the provisioning agent has the [appropriate permissions](../identity/hybrid/cloud-sync/how-to-prerequisites.md#custom-gmsa-account) to delete user accounts.

1. Enable the Active Directory recycle bin. For a step-by-step guide on enabling the recycle bin, see: [Active Directory Recycle Bin step-by-step](/windows-server/identity/ad-ds/get-started/adac/introduction-to-active-directory-administrative-center-enhancements--level-100-#active-directory-recycle-bin-step-by-step).

## Edit a task to be compatible with synced on-premises users using the Microsoft Entra admin center

Account related tasks within workflows can be quickly edited to apply to synced on-premises users. To edit a task in such way using the Microsoft Entra admin center, you do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](~/identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **Identity governance** > **Lifecycle workflows** > **workflows**.

1. Select the workflow you want to edit the task within.

1. On the workflow screen, select **Tasks**.

1. On the Tasks screen, either select an existing task you want to run for synced on-premises users, or create a new one by selecting **Add task**.

1. On the individual task screen, enable the checkbox that corresponds to running for an on-premises account. The following image shows it being enabled for a delete user account task.
    :::image type="content" source="media/manage-workflow-onprem/delete-user-account-task-flag.png" alt-text="Screenshot of setting on-premises flag to delete account.":::
1. Select **Save**.

## Next steps

- [Check status of a workflows](check-status-workflow.md)
- [Customize workflow schedule](customize-workflow-schedule.md)

