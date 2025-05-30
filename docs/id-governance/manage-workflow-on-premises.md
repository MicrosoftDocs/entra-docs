---
title: Manage users synchronized from Active Directory Domain Services with workflows
description: A how to article on how to edit a user account related task to run for users synchronized from Active Directory Domain Services (AD DS) with Lifecycle workflows.
author: owinfreyATL
ms.author: owinfrey
manager: femila
ms.service: entra-id-governance
ms.workload: identity
ms.topic: how-to
ms.date: 08/27/2024
ms.subservice: lifecycle-workflows
ms.custom: template-how-to, sfi-image-nochange
#CustomerIntent: As an administrator, I want to be able to edit user account tasks in workflows so that they will run for users synchronized from Active Directory Domain Services.
---

# Manage users synchronized from Active Directory Domain Services with workflows

Workflows created by Lifecycle workflows can be used to manage the lifecycle of users synchronized from Active Directory Domain Services (AD DS). Synced AD DS support allows you to use workflow tasks to enable, disable, and delete synchronized users. In this article, you're walked through the steps of enabling a user account task to be run for users synchronized from AD DS.

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](~/includes/entra-entra-governance-license.md)]

While most Lifecycle workflow tasks can manage users synchronized from Active Directory Domain Services without any extra configuration, certain tasks such as enabling, disabling, and deleting tasks require some extra configuration. For more information on setting these prerequisites, see:  [User account tasks](lifecycle-workflow-on-premises.md#user-account-tasks).

## Configure a user account task to manage users synchronized from Active Directory Domain Services using the Microsoft Entra admin center

Account related tasks within workflows can be quickly edited to apply to users synchronized from Active Directory Domain Services. To edit a task in such way using the Microsoft Entra admin center, you do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](~/identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **Workflows**.

1. Select the workflow you want to edit the task within.

1. On the workflow screen, select **Tasks**.

1. On the Tasks screen, either select an existing task you want to run for users synchronized from Active Directory Domain Services, or create a new one by selecting **Add task**.

1. On the individual task screen, enable the checkbox that corresponds to running for a synchronized Active Directory Domain Services user. The following image shows it being enabled for a delete user account task.
    :::image type="content" source="media/manage-workflow-on-premises/delete-user-account-task-flag.png" alt-text="Screenshot of setting on-premises flag to delete account.":::
1. Select **Save**.

## Edit a user account task to be compatible with users synchronized from Active Directory Domain Services using Microsoft Graph

To manage user tasks to be compatible with users synchronized from Active Directory Domain Services via API using Microsoft Graph, see: [Configure the arguments for built-in Lifecycle Workflow tasks](/graph/identitygovernance-lifecycleworkflows-task-arguments).

## Next steps

- [Check status of a workflows](check-status-workflow.md)
- [Customize workflow schedule](customize-workflow-schedule.md)

