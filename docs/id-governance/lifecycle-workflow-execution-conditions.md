---
title: Lifecycle Workflow Execution conditions and scheduling
description: Conceptual article about Lifecycle Workflows execution conditions and scheduling
author: owinfreyATL
ms.author: owinfrey
manager: amycolannino
ms.service: active-directory
ms.subservice: compliance
ms.workload: identity
ms.topic: conceptual 
ms.date: 11/06/2023
ms.custom: template-concept 
---

# Lifecycle workflow execution condition and scheduling

Workflows created using Lifecycle workflows allows you to automate common tasks for users based on where they fall in the joiner, mover, and leaver model of their lifecycle within your organization. These workflows are able to run in two ways, manually(on-demand) for specific users, or based on a schedule if the user meets the defined execution conditions of a workflow. This article describes the difference between the workflow triggers, the conditions for a scheduled workflow, and when they run for users. 

## Workflow trigger details

The trigger of a workflow defines the conditions for when a workflow runs for users.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/trigger-details.png" alt-text="Screenshot of the trigger details section of a workflow's execution conditions.":::

 There are currently four types of triggers supported:

- **Time based attribute**: The workflow is triggered on schedule when a time value is met.
- **On-demand only**: The workflow is only triggered manually.
- **Attribute changes**: The workflow is triggered on schedule when a change to an attribute is met. 
- **Scope based**: The workflow is triggered on schedule when a scope criteria attribute is met.


## Time based attribute trigger

The **time based attribute** trigger allows you to set a trigger based on when a time value is met.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/time-based-trigger.png" alt-text="Screenshot of the time based workflow trigger.":::

When setting a workflow where the trigger type is **Time based attribute**, the following details are defined:

|Trigger detail  |Description  |
|---------|---------|
|Days from Event     |  The days from the event user attribute for when the workflow is triggered. Value can be from 0-180.     |
|Event timing     |   Defines when the *Days from Event* for a workflow is triggered. For example, a workflow that is scheduled to run for a user before they start working would have an event timing value of **Before**, while a workflow scheduled to run for a user after they leave your organization would have an event timing value of **After**. If selecting a template for a workflow that runs on the same day as the event user attribute, the value is **On**.      |
|Event user attribute     | The attribute defining the change that triggers the workflow. The type of workflow being used determines the attributes available. A joiner workflow can have the attribute value of "*employeeHireDate*" or "*createdDateTime*", while a leaver workflow has an attribute value of "*employeeLeaveDate*" or "*LastSignInDateTime*". For a list of templates, and their event user attributes, see: [Lifecycle Workflows templates and categories](lifecycle-workflow-templates.md).       |

> [!NOTE]
> The event user attribute must be set within Azure AD for users. For more information on this process, see [How to synchronize attributes for Lifecycle workflows](how-to-lifecycle-workflow-sync-attributes.md).

## On-demand only trigger

The **On-demand only** trigger is set to only run the workflow for users you manually select. As the workflow will only run for users you select, it will not run on a schedule. The users are selected within the scope details section of the workflow.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/on-demand-select-users.png" alt-text="Screenshot of selecting users for manual workflow execution.":::

When setting a workflow where the trigger type is **on-demand only**, the following details are defined:


|Trigger detail  |Description  |
|---------|---------|
|Scope type     |  The scope type determines how the scope of the workflow is defined to run. The default for this is *User selection*.       |
|Selection type     |  The selection type of the workflow can be set as to either allowing you to choose users during its creation for who it runs as soon as the workflow is created, or by allowing you to choose which users to run the workflow for at a later date.       |

For a detailed guide on running a workflow on-demand for users, see: [Run a workflow on-demand](on-demand-workflow.md).

## Attribute change trigger

The **Attribute change** trigger allows you to set a trigger based on when an attribute changes for users.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/attribute-changes-trigger.png" alt-text="Screenshot of the attribute changes trigger for a workflow.":::

When setting a workflow where the trigger type is **Attribute change**, the following details are defined:


|Trigger detail  |Description  |
|---------|---------|
|Trigger Attribute     | The trigger attribute defines the attribute that is being changed to trigger the workflow to run.        |
|Action/Operator     |  This defines the change to the attribute that triggers the workflow to run.       |
|Value     |  The value of the trigger attribute.      |


## Scope based trigger


For workflows that are scope-based, the workflow runs on a schedule when trigger conditions for the scope are met.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/scope-details.png" alt-text="Screenshot of scope settings for lifecycle workflows.":::

The scope-based details are made up of the following two parts:

- Scope type: Narrows the rule.
- Rule: Where you can set expressions on user properties that define for whom the scheduled workflow runs. You can add extra expressions using **And, And not, Or, Or not** to create complex conditionals, and apply the workflow more granularly across your organization. Lifecycle Workflows supports a [rich set of user properties](/graph/api/resources/identitygovernance-rulebasedsubjectset#supported-user-properties-and-query-parameters) for configuring the scope.


When setting a workflow where the trigger type is **scope based**, the following details are defined:


|Trigger detail  |Description  |
|---------|---------|
|Days from Event     |  The days from the event user attribute for when the workflow is triggered. Value can be from 0-180.     |
|Event timing     |   Defines for when the days from event a workflow is triggered. For example, a workflow that is scheduled to run for a user before they start working would have an event timing value of **Before**, while a workflow scheduled to run for a user after they have left your organization would have an event timing value of **After**. If selecting a template for a workflow that runs on the same day as the event user attribute, the value is **On**.      |
|Event user attribute     | The attribute defining the trigger of the workflow. The type of workflow being used determines the attributes available. A joiner workflow can have the attribute value of "*employeeHireDate*" or "*createdDateTime*", while a leaver workflow has an attribute value of "*employeeLeaveDate*". For a list of templates and their event user attributes, see: [Lifecycle Workflows templates and categories](lifecycle-workflow-templates.md).       |

> [!NOTE]
> The event user attribute must be set within Azure AD for users. For more information on this process, see [How to synchronize attributes for Lifecycle workflows](how-to-lifecycle-workflow-sync-attributes.md).

While newly created workflows are enabled by default, scheduling is an option that must be enabled manually. To verify whether the workflow is scheduled, you can view the **Scheduled** column on the workflow overview page.

Once scheduling is enabled, the workflow is evaluated either every three hours(by default), or by the interval you select in **workflow settings**, to determine whether or not it should run based on the execution conditions.

> [!NOTE]
> Once the user meets the execution conditions and is queued to have the workflow run for them the Lifecycle Workflow engine will evaluate the user once again before the workflow starts to process them. If the user no longer meets the execution conditions of the workflow, then they will not be processed.

For a detailed guide on setting the execution conditions for a workflow, see: [Create a lifecycle workflow.](create-lifecycle-workflow.md)

## Execution user scope

When a workflow is scheduled to run you're able to see a list of users who currently meet the conditions for the workflow. The list of users are who the workflow will run for, and is based on the last time the workflow engine evaluated users within your tenant.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/execution-user-scope.png" alt-text="Screenshot of a list of users in scope of the workflow's execution conditions.":::

If the execution conditions recently changed for the workflow, then the execution user scope list might not be current. When the execution conditions have changed recently, the list refreshes with users meeting the latest execution conditions after the workflow engine evaluates the users again. Before the workflow runs for the users, it also checks to make sure the list of users still meet the current execution conditions.

> [!NOTE]
> There is currently a catch up window for users based on a 3 day period. This means that when a workflow is created, the workflow engine will consider users, who previously met its execution conditions, within 3 days of the scope of the users. For example, if you created a pre-hire workflow to run for users in a certain department 1 week before their hire date, a user who was created within 10 days before their hire date would also fall under the scope of the workflow and have it ran for them.

For a detailed guide on viewing the execution user scope of a specific workflow, see: [Check execution user scope of a workflow](check-workflow-execution-scope.md).



## Next steps

- [Lifecycle Workflow History](lifecycle-workflow-history.md)
- [Workflow Extensibility](lifecycle-workflow-extensibility.md)