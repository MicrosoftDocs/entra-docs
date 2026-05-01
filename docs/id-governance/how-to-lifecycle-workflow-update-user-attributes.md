---
title: Update user attributes with Lifecycle Workflows (Preview)
description: Learn how to update user attributes using the Update user attributes task in Lifecycle Workflows.
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.date: 05/01/2026
ms.custom: template-how-to
ai-usage: ai-assisted

#Customer Intent: As an IT admin, I want to update user attributes automatically using Lifecycle Workflows so that user information stays accurate throughout the identity lifecycle.
---

# Update user attributes with Lifecycle Workflows (Preview)

Lifecycle Workflows allow you to automate the updating of user attributes as part of joiner, mover, and leaver scenarios. The **Update user attributes** task enables you to set or clear attribute values for users in your organization when lifecycle events occur, such as a department change or an employee leaving.

This article walks you through configuring a workflow with the Update user attributes task using the Microsoft Entra admin center and Microsoft Graph.

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](~/includes/entra-entra-governance-license.md)]

- You must have at least the [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator) role to configure workflows with this task.

## Supported attributes

The Update user attributes task supports the following attribute types:

- Built-in user attributes (for example, `department`, `jobTitle`, `city`)
- On-premises extension attributes (for example, `extensionAttribute1` through `extensionAttribute15`)
- Directory extension attributes

> [!NOTE]
> Custom security attributes are not supported with this task.

## Limitations

Before configuring this task, be aware of the following limitations:

- **Up to 10 attributes** can be updated per task instance.
- **Synced users are not supported.** This task doesn't support updating attributes for users synchronized from Active Directory Domain Services (AD DS). The task runs only for cloud-managed users.
- **The `employeeLeaveDateTime` attribute is not currently supported.** Support for this attribute is planned for general availability.

## Configure the Update user attributes task using the Microsoft Entra admin center

To add the Update user attributes task to a workflow using the Microsoft Entra admin center, complete the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **Workflows**.

1. Select an existing workflow or create a new workflow where you want to add the task.

1. On the workflow screen, select **Tasks**.

1. Select **Add task**, and then select **Update user attributes (Preview)** from the list of available tasks.

    :::image type="content" source="media/how-to-lifecycle-workflow-update-user-attributes/select-update-user-attributes-task.png" alt-text="Screenshot showing the Select tasks panel with Update user attributes (Preview) selected.":::

1. Configure the attribute updates:
    - Select the attributes you want to update or clear.
    - Provide the new values for each attribute, or leave the value empty to clear an attribute.

    :::image type="content" source="media/how-to-lifecycle-workflow-update-user-attributes/configure-attribute-user-task.png" alt-text="Screenshot showing the attribute configuration panel for the Update user attributes task.":::

1. Select **Save** to add the task to the workflow.

> [!NOTE]
> You can configure up to 10 attribute updates within a single task instance.

## Configure the Update user attributes task using Microsoft Graph

To add the Update user attributes task to a workflow using Microsoft Graph, include the task in the `tasks` collection when [creating a workflow](/graph/api/identitygovernance-lifecycleworkflowscontainer-post-workflows) or [creating a new version of an existing workflow](/graph/api/identitygovernance-workflow-createnewversion).

The following example shows how to configure the task to update the `department` and `jobTitle` attributes:

```json
{
    "category": "joiner",
    "continueOnError": false,
    "description": "Update or clear user attribute values including custom attributes",
    "displayName": "Update user attributes",
    "isEnabled": true,
    "taskDefinitionId": "2c8f4a1b-7d3e-4f9c-8a5b-6e1d2c3f4a5b",
    "arguments": [
        {
            "name": "attributeUpdates",
            "value": "[{\"attribute\":\"department\",\"value\":\"Sales\"},{\"attribute\":\"jobTitle\",\"value\":\"Account Executive\"}]"
        }
    ]
}
```

The `attributeUpdates` argument accepts a JSON string containing an array of objects, where each object specifies:

- `attribute`: The name of the user attribute to update.
- `value`: The new value for the attribute. Use an empty string (`""`) to clear the attribute.

### Clear an attribute example

To clear an attribute value, set the `value` to an empty string:

```json
{
    "name": "attributeUpdates",
    "value": "[{\"attribute\":\"department\",\"value\":\"\"}]"
}
```

## Next steps

- [Lifecycle Workflow tasks and definitions](lifecycle-workflow-tasks.md)
- [Manage workflow versions](manage-workflow-tasks.md)
- [Check status of a workflow](check-status-workflow.md)
- [Customize workflow schedule](customize-workflow-schedule.md)
