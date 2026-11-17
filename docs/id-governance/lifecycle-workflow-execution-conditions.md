---
title: Lifecycle workflow execution conditions and scheduling
description: Conceptual article about Lifecycle workflows execution conditions.
ms.subservice: lifecycle-workflows
ms.workload: identity
ms.topic: concept-article
ms.date: 11/10/2026
ms.custom: template-concept 
ai-usage: ai-assisted
#Customer Intent: As an IT admin, I want to understand lifecycle workflow execution conditions and scheduling so that I can configure when and how workflows run.
---

# Lifecycle workflows execution conditions and scheduling

Workflows created using Lifecycle workflows allow you to automate common tasks for users based on where they fall in the joiner, mover, and leaver model of their lifecycle within your organization. These workflows are able to run in two ways, manually (on-demand) for specific users, or based on a schedule if a user meets the defined execution conditions of a workflow. These execution conditions are defined by two parts: a trigger and a scope. This article describes execution conditions, the difference between the workflow triggers and scopes, and the conditions for when a scheduled workflow runs for users.

## Workflow execution conditions

For a workflow to run for users based on a schedule, they must first meet its execution conditions. The execution conditions consist of:

- Trigger: Defines the conditions for when a workflow runs for users.
- Scope: Defines which users the workflow runs for.

The trigger you choose depends on what type of workflow you want to run for users, and the scope you choose is based on the trigger selected.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/trigger-details.png" alt-text="Screenshot of the trigger details section of a workflow's execution conditions." lightbox="media/lifecycle-workflow-execution-conditions/trigger-details.png":::

There are a number of triggers supported, some only available for certain workflow templates:

- **Time based attribute**: The workflow is triggered on schedule when a user's date attribute meets an exact offset or a relative time range.
- **Attribute changes**: The workflow is triggered on schedule when a change to an attribute happens.
- **Group membership change**: The workflow is triggered on schedule when a group membership change is met.
- **Sign-in activity**: The workflow is triggered on schedule when a minimum number of days since the user last signed in is met.
- **On-demand only**: The workflow is only triggered manually.

> [!NOTE]
> The **On-demand only** trigger is the only available trigger for workflow templates that are marked as on-demand only. For the full list of workflow templates, and their compatible triggers, see: [Lifecycle workflows templates and categories](lifecycle-workflow-templates.md).

## Time based attribute trigger

The **Time based attribute** trigger runs a workflow based on a date attribute for each user. You can match an exact number of days before or after the date, a range of days, or a maximum number of days. For example, you can configure a workflow to run seven days before a user's hire date or match users whose hire date was within the past seven days.

For this trigger, event attributes specify a date, not a time of day. The trigger matches dates in Coordinated Universal Time (UTC). A matching day starts at 00:00 UTC, and users who also meet the scope rules fall into scope at the first scheduled evaluation on that day.

> [!IMPORTANT]
> If your organization operates across multiple time zones, check how the start of the UTC day maps to each user's local time zone. A matching date can begin on the previous calendar day in some local time zones. Account for these differences when you configure date attributes and workflow schedules.

When you create or edit a workflow, select **Time based attribute** under **Trigger details**, and configure the following fields:

| Trigger detail | Description |
| --- | --- |
| Operator | Select **Equal to** to match a single day offset, **Between** to match a range of offsets, or **Within** to match offsets up to a specified number of days. |
| Days from event | Enter the number of days relative to the event attribute date, from 0 through 365. |
| Days to event | When you select **Between**, enter the other end of the range, from 0 through 365 days. |
| Event timing | Select **Before** or **After** to apply the offset or range before or after the event attribute date. All date comparisons use UTC. To match the event date itself, select **Equal to**, enter 0 in **Days from event**, and select **On**. |
| Event attribute | Select the user date attribute to evaluate. `employeeHireDate`, `employeeLeaveDateTime`, and `createdDateTime` will always appear as options. If the tenant contains any Directory Extension attributes (must be specified as type DateTime), these will appear in the dropdown as well. |

> [!NOTE]
> Set the event attribute for each user in Microsoft Entra ID before the user needs to meet the trigger conditions. For more information, see [How to synchronize attributes for Lifecycle workflows](how-to-lifecycle-workflow-sync-attributes.md).

Time-based attribute rules can be complex, especially when you use the **Between** operator. Select **View Rule Syntax** to see the Microsoft Graph filter query that the Lifecycle workflows service runs to evaluate the rule.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/view-rule-syntax.png" alt-text="Screenshot of the time based attribute trigger details with the View rule syntax button highlighted." lightbox="media/lifecycle-workflow-execution-conditions/view-rule-syntax.png":::

### Time-based comparison examples

The following examples use `employeeHireDate` as the event attribute. All dates and day offsets are evaluated in UTC, not the user's local time zone. Users must also meet the workflow's scope rules to be processed.

| Scenario | Operator | Days from event | Days to event | Event timing | Rule Syntax |
| --- | --- | --- | --- | --- | --- |
| Run seven days before the user's hire date. | **Equal to** | 7 | N/A | **Before** | employeeHireDate eq (system.now plus P7D) |
| Run on the user's hire date. | **Equal to** | 0 | N/A | **On** | employeeHireDate eq system.now |
| Match users whose hire date was between one and seven days ago. | **Between** | 1 | 7 | **After** | employeeHireDate ge (system.now minus P7D) and employeeHireDate le (system.now minus P1D) |
| Match users whose hire date was no more than seven days ago. | **Within** | 7 | N/A | **After** | employeeHireDate ge (system.now minus P7D) and employeeHireDate le system.now |

The workflow and its schedule must both be enabled for the trigger to be evaluated. At each scheduled evaluation, the workflow checks whether users meet the configured comparison and scope. For details, see [Workflow scheduling](#workflow-scheduling).

### Time based attribute scope

The time based attribute scope allows you to define for whom the workflow runs when the time trigger is met.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/time-based-scope.png" alt-text="Screenshot of the scope screen for time based attribute trigger." lightbox="media/lifecycle-workflow-execution-conditions/time-based-scope.png":::

When setting the scope of the time based attribute trigger, the following details are defined:

|Scope detail  |Description  |
|---------|---------|
|Scope type     |  Rule based.       |
|Rule     |  Defines the rule for who meets the scope of the time based attribute trigger.       |

>[!NOTE]
> The rule evaluation is case-sensitive.

## Attribute change trigger

The **Attribute change** trigger allows you to set a trigger based on when an attribute changes for users.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/attribute-changes-trigger.png" alt-text="Screenshot of the attribute changes trigger for a workflow." lightbox="media/lifecycle-workflow-execution-conditions/attribute-changes-trigger.png":::

When setting a workflow where the trigger type is **Attribute change**, the following details are defined:

|Trigger detail  |Description  |
|---------|---------|
|Trigger Attribute     | The trigger attribute defines the attribute that's being changed to trigger the workflow to run. You are also able to set custom attribute triggers. For more information, see [Use Custom Attribute Triggers in Lifecycle Workflows (Preview)](workflow-custom-triggers.md).         |
|Action/Operator     |  Defines the change to the attribute that triggers the workflow to run.       |
|Value     |  The value of the trigger attribute.      |

### Attribute changes trigger scope

The attribute changes trigger scope allows you to define for whom the workflow runs when the attribute change trigger is met.

When setting the scope of the attribute changes trigger, the following details are defined:

|Scope detail  |Description  |
|---------|---------|
|Scope type     |  Rule based.       |
|Rule     |  Defines the rule for who meets the scope of the attribute changes trigger.       |

>[!NOTE]
> The rule evaluation is case-sensitive.

## Group membership change trigger

For workflows that are triggered based on a group membership change, the workflow runs on a schedule when a user is added to, or removed from, a group.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/group-membership-trigger.png" alt-text="Screenshot of the group membership change trigger." lightbox="media/lifecycle-workflow-execution-conditions/group-membership-trigger.png":::

When setting a workflow where the trigger type is **Group membership change**, the following details are defined:

|Trigger detail  |Description  |
|---------|---------|
|Action    |  Describes which group membership change triggers the execution condition. Can be **Added to group** or **Removed from group**.     |

### Group membership change scope

The group membership change scope allows you to define for whom the workflow runs when the group membership change trigger is met.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/group-membership-scope.png" alt-text="Screenshot of setting scope for group membership change." lightbox="media/lifecycle-workflow-execution-conditions/group-membership-scope.png":::

When setting the scope of the group membership change trigger, the following details are defined:

|Trigger detail  |Description  |
|---------|---------|
|Scope type     |  Group based.       |
|Selected group     |  Defines the group on which the trigger action is based.       |

## Sign-in inactivity trigger

The **Sign-in inactivity** trigger allows you to set a trigger based on when a certain number of days has passed since the user last signed in.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/sign-in-inactivity-trigger.png" alt-text="Screenshot of the sign-in inactivity trigger." lightbox="media/lifecycle-workflow-execution-conditions/sign-in-inactivity-trigger.png":::

When setting the scope of the sign-in inactivity trigger, the following details are defined:


|Scope detail  |Description  |
|---------|---------|
|Days of inactivity     |   The number of days since the user last signed in.      |

### Sign-in inactivity scope

The sign-in inactivity scope allows you to define for whom the workflow runs when the sign-in inactivity trigger is met.

|Scope detail  |Description  |
|---------|---------|
|Scope type     |  Rule based.       |
|Rule     |  Defines the rule for who meets the scope of the attribute changes trigger.       |

## On-demand only trigger

The **On-demand only** trigger is set to run the workflow for users you manually select. Workflows with these triggers don't run on a schedule. The users are selected within the scope details section of the workflow.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/on-demand-select-users.png" alt-text="Screenshot of selecting users for manual workflow execution." lightbox="media/lifecycle-workflow-execution-conditions/on-demand-select-users.png":::

When setting a workflow where the trigger type is **On-demand only**, the following details are defined:

|Trigger detail  |Description  |
|---------|---------|
|Scope type     |  The scope type determines how the scope of the workflow is defined to run. The default for this is *User selection*.       |
|Selection type     |  The selection type of the workflow can be set as to either allow you to choose users during its creation for who it runs as soon as the workflow is created, or by allowing you to choose which users to run the workflow for at a later date.       |

For a detailed guide on running a workflow on-demand for users, see: [Run a workflow on-demand](on-demand-workflow.md).

## Execution user scope

After the execution conditions are set for an enabled workflow, you're able to see a list of users who currently meet its execution conditions. This user list is made up of users who the workflow runs for the next time it executes, and is based on the last time the workflow engine evaluated users within your tenant.

:::image type="content" source="media/lifecycle-workflow-execution-conditions/execution-user-scope.png" alt-text="Screenshot of a list of users in scope of the workflow's execution conditions." lightbox="media/lifecycle-workflow-execution-conditions/execution-user-scope.png":::

If the execution conditions recently changed for the workflow, then the execution user scope list might not be current. When the execution conditions are recently changed, the list refreshes with users meeting the latest execution conditions after the workflow engine evaluates the users again. Before the workflow runs for the users, it also checks to make sure the list of users still meet the current execution conditions.

For a detailed guide on viewing the execution user scope of a specific workflow, see: [Check execution user scope of a workflow](check-workflow-execution-scope.md).

## Lifecycle workflow catch-up window

New workflows that use the updated **Time based attribute** trigger don't have an automatic three-day catch-up window. Existing workflows aren't affected by this change and retain their current catch-up behavior.

For new workflows that use **Equal to**, users are eligible only on the UTC calendar day that matches the configured offset. This matching day isn't an additional catch-up window. Users must meet both the time-based comparison and scope rules when the workflow evaluates them. If a user's data becomes available after that UTC day ends, the workflow doesn't process that user for the missed offset.

To allow for delays in user data updates, configure **Between** or **Within** to match a period that meets your requirements. For example, use **Within**, 7 days, and **After** with `employeeHireDate` to match users whose hire date was within the past seven days. This period is part of the trigger configuration, not an additional catch-up window.

## Workflow scheduling

While newly created workflows are enabled by default, scheduling is an option that must be enabled manually. To verify whether the workflow is scheduled, you can view the **Scheduled** column on the workflow overview page.

Once scheduling is enabled, the workflow is evaluated either every three hours (by default), or by the interval you select in **workflow settings**, to determine whether or not it should run.

> [!NOTE]
> Once the user meets the execution conditions, and is in scope of the workflow, the Lifecycle workflow engine evaluates the user once again before the workflow starts to process them. If the user no longer meets the execution conditions of the workflow, then they won't be processed.

For a detailed guide on setting the execution conditions for a workflow, see: [Create a lifecycle workflow](create-lifecycle-workflow.md).

## Next steps

- [Lifecycle Workflow History](lifecycle-workflow-history.md)
- [Workflow Extensibility](lifecycle-workflow-extensibility.md)
