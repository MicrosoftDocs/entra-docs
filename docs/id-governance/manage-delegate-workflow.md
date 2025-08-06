---
title: Delegated Workflow Management (Preview)
description: This article informs a user about delegating management of workflows using Lifecycle workflows.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to 
ms.date: 07/31/2025

#CustomerIntent: As a Lifecycle Workflow administrator, I want to delegate management of specific lifecycle workflows so that workflow management is more granular.
---


# Delegated Workflow Management (Preview)

Workflows by default, unless specified during creation, are managed by users with either the Lifecycle Workflows, or Global, administrator roles. As workflows grow and change to meet the needs of members of your organization, so does the need to limit who can manage it. With delegated workflow management, you can scope management of the workflow using specific [Administrative Units](../identity/role-based-access-control/administrative-units.md). When scoped, specific admins are only granted access to manage specific workflows. This allows for greater security within your environment by following Microsoft's least access principal guidelines, and only giving access to specifically what's needed.

The following table shows the differences between the Lifecycle Administrator role, and the scoped workflow admin role in terms of Lifecycle workflow capability:


|Capability | Lifecycle Workflows Administrator  | Workflow Administrator  |
|-----------|-----------------------------------|------------------------|
|[Create Workflow](create-lifecycle-workflow.md)    | Yes | No |
|[Edit Workflow](manage-workflow-properties.md)    | Yes | Yes (only assigned workflows) |
|[Custom Task Extensions](trigger-custom-task.md)    | Yes | No |
|[Delete Workflow](delete-lifecycle-workflow.md#delete-a-workflow-by-using-the-microsoft-entra-admin-center)    | Yes | Yes (only assigned workflows) |
|[Restore Workflow](delete-lifecycle-workflow.md#view-deleted-workflows-in-the-microsoft-entra-admin-center)     | Yes | Yes (only assigned workflows) |
|[View workflow history](lifecycle-workflow-history.md)     | Yes | Yes (only assigned workflows) |
|[Run Workflow on-demand](on-demand-workflow.md)    | Yes | Yes (only assigned workflows) |
|[Scope Workflows](manage-delegate-workflow.md#edit-the-administrative-scope-of-a-workflow-using-the-microsoft-entra-admin-center)     | Yes | No |

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](~/includes/entra-entra-governance-license.md)]. You must also have at least one administrative unit within your tenant. For steps on creating an administrative unit, see [Create an administrative unit](../identity/role-based-access-control/admin-units-manage.md#create-an-administrative-unit).

## Assign Lifecycle Workflows Administrator role to Scope

To delegate workflow management to administrative scopes, you must first assign the Lifecycle Workflows administrator role to the administrative unit. To do so, you'd follow these steps:

> [!TIP]
> While the following steps walk you through setting the role to a specific user, you can set the role to a group within the administrative unit to delegate management within a scope to multiple users.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](permissions-reference.md#privileged-role-administrator).

1. Browse to **Entra ID** > **Users**.

1. On the users page, select the user you want assign the admin scope to.

1. From the user overview page, select **Assigned roles**.

1. On the assigned roles page, select **Add assignments**.

1. On the add assignments page select the following:
    **Select role**: Lifecycle Workflows Administrator
    **Scope type**: Administrative unit
1. On the **Selected scope** pane, select the administrative unit where your workflow will be scoped to, and select **Next**.
    :::image type="content" source="media/manage-delegate-workflow/add-administrative-unit.png" alt-text="Screenshot of adding administrative unit.":::
1. On the **Setting** tab, you can set the assignment as either eligible or active.

1. Select **Save**.

## Edit the administrative scope of a workflow using the Microsoft Entra admin center

With the role set for admins over the administrative unit, you must edit the workflow to be assigned within the scope of that administrative unit. To edit the properties of a workflow to be in an administrative unit's scope using the Microsoft Entra admin center, you do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **workflows**.

1. On the list of workflows page, select the workflow that you want to edit the administrative scope of.

1. On the workflow overview page, select **Properties**.

1. Under properties, select **Administrative Scope**.

1. From the administrative scope pane, you can see the list of all administrative units in your tenant. 

1. Select the administrative unit(s) you want to scope the workflow to. 

1. Select **Save**.

## View the administrative scopes of a workflow using the Microsoft Entra admin center



## Remove the administrative scopes of a workflow using the Microsoft Entra admin center

## Edit the administrative scopes of a workflow using Microsoft Graph

To edit the administrative scope of a workflow via API using Microsoft Graph, see: [Update workflow](/graph/api/identitygovernance-workflow-update).

## View the administrative scopes of a workflow using Microsoft Graph

To edit the administrative scope of a workflow via API using Microsoft Graph, see: [Update workflow](/graph/api/identitygovernance-workflow-update).

## Remove the administrative scopes of a workflow using Microsoft Graph

To edit the administrative scope of a workflow via API using Microsoft Graph, see: [Update workflow](/graph/api/identitygovernance-workflow-update).

## Next steps

- [Manage workflow properties](manage-workflow-properties.md)
- [Check status of a workflows](check-status-workflow.md)
