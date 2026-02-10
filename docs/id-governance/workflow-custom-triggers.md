---
title: Use custom attribute triggers in lifecycle workflows (Preview)
description: This article discusses how to use Custom Attribute Triggers as an attribute change trigger within a workflow in Lifecycle Workflows.
ms.subservice: lifecycle-workflows
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 10/29/2025

#CustomerIntent: As a Lifecycle Workflows Administrator, I want to use Custom Attribute triggers as an attribute change trigger so that I can trigger workflows based on other custom attributes.
---



# Use Custom attribute triggers in lifecycle workflows (Preview)

Lifecycle Workflows allows you to trigger workflows to run automatically for users that meet the execution conditions of the workflow. There are many default attributes that you can use to trigger workflows, but sometimes you might require triggering a workflow based on a specific attribute not offered by default. Using custom attribute triggers, you can trigger a workflow to run for users based on when they move within your organization based on:

- [Custom security attributes (CSA)](manage-workflow-custom-security-attribute.md)
- Directory extension attributes
- On-premises extension attributes (1-15)
- EmployeeOrgData attributes

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](../includes/entra-entra-governance-license.md)]


## Use custom attribute triggers in a new workflow using the Microsoft Entra admin center

To use custom attribute triggers in a new workflow, do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator) and [Attribute Assignment Administrator](../identity/role-based-access-control/permissions-reference.md#attribute-assignment-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **Create a workflow**.

1. On the Workflows page, select a workflow template that you want to use a custom security attribute as part of the scope for.

1. Enter the basic information such as display name, description, and administration scope.

1. Under **Trigger type** select **Attribute changes**.

1. For Attribute, select the attribute trigger you want to trigger the workflow to run. 

1. Finish configuring the workflow and save it.  
    > [!NOTE]
    > Attribute changes are only detected for scheduled workflows.

## Add a custom attribute to an existing workflow trigger using the Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator) and [Attribute Assignment Administrator](../identity/role-based-access-control/permissions-reference.md#attribute-assignment-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **workflows**.
    
1. Select the workflow that you want to add a custom attribute to the trigger of.

1. On the workflow overview page, select **Execution conditions**.

1. Under **Trigger details**, update the trigger with the custom attribute you want to use to trigger the workflow.

1. Select **Save**.


## Custom attribute trigger considerations

Currently the workflow and the workflow schedule must be enabled for attributes changes to be picked up and workflows executions to be scheduled. Once Lifecycle Workflows starts checking for attribute changes, the time it takes for changes to be picked up might be delayed for these custom attributes. While changes should be picked up within minutes, there are upstream processes that will add further delays after the user attribute changes, for example:
- Custom attributes might take up to 4 hours for their changes to be updated by the underlying service, however, once the custom attributes changes are propagated, Lifecycle Workflows should pick up the change within seconds.
- Once changes are picked up by Lifecycle workflows, workflow execution will occur in the next target run, according to the schedule for users that meet the workflow scope.

## Attribute vs custom attribute processing timing

The following image shows the potential differences in processing times for using regular attributes and custom attributes in the workflow trigger. 

:::image type="content" source="media/workflow-custom-triggers/custom-attribute-timing.png" alt-text="Screenshot of a comparison between regular and custom attribute processing timing in a workflow run.":::


In example A, The workflow is scheduled to run when the department attribute changes, it's 12:00 pm and the next target runs are at 1pm and 2pm:
- At 12:10pm, the user department changes
- At 12:15 pm, the user is detected to be in scope of the workflow
- In the 1pm run, the user gets processed by the workflow


In example B, Workflow is scheduled to run when the TestCustomSecurityAttribute1 attribute changes, it's 12:00 pm and the next target runs are at 1pm and 2pm:
- At 12:10pm the TestCustomSecurityAttribute1 attribute changes for a user
- At 3:55 pm the change is passed to Lifecycle Workflows
- At 4:00 pm the user is detected to be in scope of the workflow (too late for the 4pm run)
- In the 5pm run, the user gets processed by the workflow

For frequently asked question about using custom attribute triggers within lifecycle workflows, see: [Lifecycle workflows FAQs](workflows-faqs.md).



## Next step

- [Lifecycle workflows execution conditions and scheduling](lifecycle-workflow-execution-conditions.md)
- [Custom security attributes (CSA)](manage-workflow-custom-security-attribute.md)



