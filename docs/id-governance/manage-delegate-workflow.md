---
title: Delegate Workflow Management (Preview)
description: This article informs a user about delegating management of workflows using Lifecycle workflows.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to 
ms.date: 07/31/2025

#CustomerIntent: As a Lifecycle Workflow administrator, I want to delegate management of specific lifecycle workflows so that workflow management is more granular.
---


# Delegate Workflow Management (Preview)

Workflows, unless specified during creation, by default are managed by users with either the Lifecycle Workflows, or Global, administrator roles. As workflows grow and change to meet the needs of members of your organization, so does the need to limit who can manage it. With delegated workflow management, you can scope management of the workflow using specific [Administrative Units](../identity/role-based-access-control/administrative-units.md). When scoped, specific admins are only granted access to manage specific workflows. This allows for greater security within your environment by following Microsoft's least access principal guidelines, and only giving access to specifically what's needed.

The following table shows the differences between the Lifecycle Administrator role, and the scoped workflow admin role in terms of Lifecycle workflow capability:


|Capability | Lifecycle Workflows Administrator  | Workflow Administrator  |
|-----------|-----------------------------------|------------------------|
|[Create Workflow](create-lifecycle-workflow.md)    | Yes | No |
|[Edit Workflow](manage-workflow-properties.md)    | Yes | Yes (only assigned workflows) |
|[Custom Task Extensions](trigger-custom-task.md)    | Yes | No |
|[Delete Workflow](delete-lifecycle-workflow.md#delete-a-workflow-by-using-the-microsoft-entra-admin-center)    | Yes | Yes (only assigned workflows) |
|[Restore Workflow](delete-lifecycle-workflow.md#view-deleted-workflows-in-the-microsoft-entra-admin-center)     | Yes | Yes (only assigned workflows) |
|[View workflow history](lifecycle-workflow-history.md)     | Yes | Yes (only assigned workflows) |
|[View Audit Logs](lifecycle-workflow-audits.md)   | Yes | No |
|[Run Workflow on-demand](on-demand-workflow.md)    | Yes | Yes (only assigned workflows) |
|[Scope Workflows](manage-delegate-workflow.md#edit-the-administrative-scope-of-a-workflow)     | Yes | No |

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](~/includes/entra-entra-governance-license.md)]

## Edit the administrative scope of a workflow

Existing workflows can have their scopes updated to be managed by certain administrators. To edit the properties of a workflow using the Microsoft Entra admin center, you do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **workflows**.

1. Here you see a list of all of your current workflows. Select the workflow that you want to edit the administrative scope of.

1. Select the administrative unit you want to scope the workflow for. 

1. Select **Save**.

## Next steps

- [Manage workflow properties](manage-workflow-properties.md)
- [Check status of a workflows](check-status-workflow.md)
