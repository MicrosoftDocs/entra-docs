---
title: Lifecycle workflow execution conditions and scheduling
description: Conceptual article about Lifecycle workflows execution conditions.
author: owinfreyATL
ms.author: owinfrey
manager: amycolannino
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.workload: identity
ms.topic: article
ms.date: 06/25/2024
ms.custom: template-concept 
---

# Lifecycle workflows execution conditions and scheduling

Workflows created using Lifecycle workflows allow you to automate common tasks for users based on where they fall in the joiner, mover, and leaver model of their lifecycle within your organization. These workflows are able to run in two ways, manually(on-demand) for specific users, or based on a schedule if a user meets the defined execution conditions of a workflow. These execution conditions are defined by two parts, a trigger, and a scope. This article describes execution conditions, the difference between the workflow triggers and scopes, and the conditions for when a scheduled workflow runs for users.

## Workflow execution conditions

For a workflow to run for users based on a schedule, they must first meet its execution conditions. The execution conditions consist of:

- Trigger: Defines the conditions for when a workflow runs for users.
- Scope: Defines which users the workflow runs for.

The trigger you choose depends on what type of workflow you want to run for users, and the scope you choose is based on the trigger selected. There are currently four types of triggers supported:

:::image type="content" source="media/lifecycle-workflow-execution-conditions/trigger-details.png" alt-text="Screenshot of the trigger details section of a workflow's execution conditions.":::

- **Time based attribute**: The workflow is triggered on schedule when a time value is met.
- **Attribute changes**: The workflow is triggered on schedule when a change to an attribute happens.
- **Group membership change**: The workflow is triggered on schedule when a group membership change is met.
- **On-demand only**: The workflow is only triggered manually.

> [!NOTE]
> The **On-demand only** trigger is the default trigger of workflow templates that are on-demand only. For the full list of workflow templates, and their compatible triggers, see: [Lifecycle workflows templates and categories](lifecycle-workflow-templates.md).

## Time based attribute trigger

The **time based attribute** trigger allows you to set a trigger based on when a time value is met.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/time-based-trigger.png" alt-text="Screenshot of the time based workflow trigger.":::

When setting a workflow where the trigger type is **Time based attribute**, the following details are defined:

|Trigger detail  |Description  |
|---------|---------|
|Days from Event     |  The days from the event user attribute for when the workflow is triggered. Value can be from 0-180.     |
|Event timing     |   Defines when the *Days from Event*  detail for a workflow is triggered. For example, a workflow that is scheduled to run for a user before they start working would have an event timing value of **Before**, while a workflow scheduled to run for a user after they leave your organization would have an event timing value of **After**. If selecting a template for a workflow that runs on the same day as the event user attribute, the value is **On**.      |
|Event user attribute     | The attribute defining the change that triggers the workflow. The type of workflow being used determines the attributes available. A joiner workflow can have the attribute value of "*employeeHireDate*" or "*createdDateTime*", while a leaver workflow has an attribute value of "*employeeLeaveDate*" or "*LastSignInDateTime*". For a list of templates, and their event user attributes, see: [Lifecycle Workflows templates and categories](lifecycle-workflow-templates.md).       |

> [!NOTE]
> The event user attribute must be set within Microsoft Entra ID for users. For more information on this process, see: [How to synchronize attributes for Lifecycle workflows](how-to-lifecycle-workflow-sync-attributes.md).

### Time based attribute scope

The time based attribute scope allows you to define for who the workflow runs when the time trigger is met.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/time-based-scope.png" alt-text="Screenshot of the scope screen for time based attribute trigger.":::

When setting the scope of the time based attribute trigger, the following details are defined:

|Scope detail  |Description  |
|---------|---------|
|Scope type     |  Rule based.       |
|Rule     |  Defines the rule for who meets the scope of the time based attribute trigger.       |

>[!NOTE]
> The rule evaluation is case-sensitive.

## Attribute change trigger

The **Attribute change** trigger allows you to set a trigger based on when an attribute changes for users.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/attribute-changes-trigger.png" alt-text="Screenshot of the attribute changes trigger for a workflow.":::

When setting a workflow where the trigger type is **Attribute change**, the following details are defined:

|Trigger detail  |Description  |
|---------|---------|
|Trigger Attribute     | The trigger attribute defines the attribute that is being changed to trigger the workflow to run.        |
|Action/Operator     |  Defines the change to the attribute that triggers the workflow to run.       |
|Value     |  The value of the trigger attribute.      |

### Attribute changes trigger scope

The attribute changes trigger scope allows you to define for who the workflow runs when the attribute change trigger is met.

When setting the scope of the attribute changes trigger, the following details are defined:

|Scope detail  |Description  |
|---------|---------|
|Scope type     |  Rule based.       |
|Rule     |  Defines the rule for who meets the scope of the attribute changes trigger.       |

>[!NOTE]
> The rule evaluation is case-sensitive.

## Group membership change trigger

For workflows that are triggered based on a group membership change, the workflow runs on a schedule when a user is added to, or removed from, a group.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/group-membership-trigger.png" alt-text="Screenshot of the group membership change trigger.":::

When setting a workflow where the trigger type is **Group membership change**, the following details are defined:

|Trigger detail  |Description  |
|---------|---------|
|Action    |  Describes which group membership change that triggers the execution condition. Can be **Added to group** or **Removed from group**.     |

### Group membership change scope

The group membership change scope allows you to define for who the workflow runs when the group membership change trigger is met.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/group-membership-scope.png" alt-text="Screenshot of setting scope for group membership change.":::

When setting the scope of the group membership change trigger, the following details are defined:

|Scope detail  |Description  |
|---------|---------|
|Scope type     |  Group based.       |
|Selected group     |  Defines the group for which the trigger action is based on.       |

## On-demand only trigger

The **On-demand only** trigger is set to run the workflow for users you manually select. Workflows with these triggers don't run on a schedule. The users are selected within the scope details section of the workflow.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/on-demand-select-users.png" alt-text="Screenshot of selecting users for manual workflow execution.":::

When setting a workflow where the trigger type is **On-demand only**, the following details are defined:

|Trigger detail  |Description  |
|---------|---------|
|Scope type     |  The scope type determines how the scope of the workflow is defined to run. The default for this is *User selection*.       |
|Selection type     |  The selection type of the workflow can be set as to either allow you to choose users during its creation for who it runs as soon as the workflow is created, or by allowing you to choose which users to run the workflow for at a later date.       |

For a detailed guide on running a workflow on-demand for users, see: [Run a workflow on-demand](on-demand-workflow.md).

## Execution user scope

After the execution conditions are set for an enabled workflow, you're able to see a list of users who currently meet it's execution conditions. This user list is made up of users who the workflow runs for the next time it executes, and is based on the last time the workflow engine evaluated users within your tenant.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/execution-user-scope.png" alt-text="Screenshot of a list of users in scope of the workflow's execution conditions.":::

If the execution conditions recently changed for the workflow, then the execution user scope list might not be current. When the execution conditions are recently changed, the list refreshes with users meeting the latest execution conditions after the workflow engine evaluates the users again. Before the workflow runs for the users, it also checks to make sure the list of users still meet the current execution conditions.

For a detailed guide on viewing the execution user scope of a specific workflow, see: [Check execution user scope of a workflow](check-workflow-execution-scope.md).

## Lifecycle workflow catch-up window

By design, Lifecycle workflows provide a 3 day catch up window to help customers process users that may have been missed due to delays in HR user data updates. This means when the workflow engine evaluates users that meet the current execution conditions for the scheduled workflow, it includes users for whom the expected trigger date has already passed but was not more than 3 days ago. Once the user is processed, it would only be considered again if there was a change for the user or workflows that allowed it to meet the execution conditions again.

The following table shows examples of Lifecycle workflow's catch up window:


|Workflow Scenario  |User Data  |Lifecycle workflow behavior  |
|---------|---------|---------|
|A [pre-hire template](lifecycle-workflow-templates.md#onboard-pre-hire-employee) workflow is scheduled to run for users 4 days before their **EmployeeHireDate**.    |  A user exists in Microsoft Entra ID that has an **EmployeeHireDate** that is 1 day away      |  The workflow runs for the user during its first scheduled run.      |
|A [Post-Onboarding of an employee template](lifecycle-workflow-templates.md#post-onboarding-of-an-employee) workflow is scheduled to run for users 7 days after their **EmployeeHireDate**.     | A user exists in the system with an **EmployeeHireDate** that is 10 days before. The user subsequently has their **EmployeeHireDate** changed a day later to be 8 days after.        |   The user is in scope of the workflow and it runs for them when it is scheduled to run. After the **EmployeeHireDate** attribute is updated, the user enters the scope of the workflow again and it runs for them again.      |





## Workflow scheduling

While newly created workflows are enabled by default, scheduling is an option that must be enabled manually. To verify whether the workflow is scheduled, you can view the **Scheduled** column on the workflow overview page.

Once scheduling is enabled, the workflow is evaluated either every three hours(by default), or by the interval you select in **workflow settings**, to determine whether or not it should run.

> [!NOTE]
> Once the user meets the execution conditions, and is in scope of the workflow, the Lifecycle workflow engine evaluates the user once again before the workflow starts to process them. If the user no longer meets the execution conditions of the workflow, then they won't be processed.

For a detailed guide on setting the execution conditions for a workflow, see: [Create a lifecycle workflow](create-lifecycle-workflow.md).

## Next steps

- [Lifecycle Workflow History](lifecycle-workflow-history.md)
- [Workflow Extensibility](lifecycle-workflow-extensibility.md)
