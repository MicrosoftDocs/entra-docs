---
title: Lifecycle Workflows templates and categories
description: Conceptual article discussing workflow templates and categories with Lifecycle Workflows.
author: owinfreyATL
ms.author: owinfrey
manager: amycolannino
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: conceptual
ms.date: 05/31/2023
ms.custom: template-concept
---

# Lifecycle Workflows templates and categories

Lifecycle Workflows allows you to automate the lifecycle management process for your organization by creating workflows that contain both built-in tasks, and custom task extensions. These workflows, and the tasks within them, all fall into categories based on the Joiner-Mover-Leaver(JML) model of lifecycle management. To make this process even more efficient, Lifecycle Workflows also provide you with templates, which you can use to accelerate the setup, creation, and configuration of common lifecycle management processes. You can create workflows based on these templates as is, or you can customize them even further to match the requirements for users within your organization. In this article, you get the complete list of workflow templates, common template parameters, default template parameters for specific templates, and the list of compatible tasks for each template. For full task definitions, see [Lifecycle Workflow tasks and definitions](lifecycle-workflow-tasks.md).

## Lifecycle Workflows built-in templates

Lifecycle Workflows currently have eight built-in templates you can use or customize:

:::image type="content" source="media/lifecycle-workflow-templates/templates-list.png" alt-text="Screenshot of a list of lifecycle workflow templates." lightbox="media/lifecycle-workflow-templates/templates-list.png":::

The list of templates are as follows:

- [Onboard pre-hire employee](lifecycle-workflow-templates.md#onboard-pre-hire-employee)
- [Onboard new hire employee](lifecycle-workflow-templates.md#onboard-new-hire-employee)
- [Post-Onboarding of an employee](lifecycle-workflow-templates.md#post-onboarding-of-an-employee)
- [Real-time employee change](lifecycle-workflow-templates.md#real-time-employee-change)
- [Real-time employee termination](lifecycle-workflow-templates.md#real-time-employee-termination)  
- [Pre-Offboarding of an employee](lifecycle-workflow-templates.md#pre-offboarding-of-an-employee)
- [Offboard an employee](lifecycle-workflow-templates.md#offboard-an-employee)
- [Post-Offboarding of an employee](lifecycle-workflow-templates.md#post-offboarding-of-an-employee)
- [Employee group membership changes](lifecycle-workflow-templates.md#employee-group-membership-changes)
- [Employee job profile change](lifecycle-workflow-templates.md#employee-job-profile-change)

For a complete guide on creating a new workflow from a template, see: [Tutorial: On-boarding users to your organization using Lifecycle workflows with the Microsoft Entra admin center](tutorial-onboard-custom-workflow-portal.md).

### Onboard pre-hire employee

 The **Onboard pre-hire employee** template is designed to configure tasks that must be completed before an employee's start date.

:::image type="content" source="media/lifecycle-workflow-templates/onboard-pre-hire-template.png" alt-text="Screenshot of a Lifecycle Workflow onboard pre-hire template.":::

The default specific parameters and properties for the **Onboard pre-hire employee** template are as follows:

|Parameter  |Description  |Customizable  |
|---------|---------|---------|
|Category     |  Joiner       |  ❌       |
|Trigger Type     | Time based attribute, Attribute changes, Group Membership change        |  ✔️       |
|Trigger details     | Depends on trigger type selection. <br> • **Time based**:  Days from event, Event timing, Event user attribute<br> • **Attribute changes**: Trigger attribute <br>• **Group membership changes**: Added to group/Remove from group    |   ✔️      |
|Days from event     | -7        | ✔️        |
|Event timing     | Before        |  ❌       |
|Event User attribute     | EmployeeHireDate        |   ❌      |
|Scope     | Depends on trigger. <br> **Rule based**: Time based attribute, Attribute changes.<br> **Group membership change**: Group based.         | ✔️        |
|Tasks     | **Generate TAP And Send Email**     |  ✔️       |

For a tutorial on setting up a workflow that uses the **Onboard pre-hire employee** template, see: [Automate employee onboarding tasks before their first day of work with the Microsoft Entra admin center](tutorial-onboard-custom-workflow-portal.md).

### Onboard new hire employee

The **Onboard new-hire employee** template is designed to configure tasks that are completed on an employee's start date.

:::image type="content" source="media/lifecycle-workflow-templates/onboard-new-hire-template.png" alt-text="Screenshot of a Lifecycle Workflow onboard new hire template.":::

The default specific parameters for the **Onboard new hire employee** template are as follows:

|Parameter  |Description  |Customizable  |
|---------|---------|---------|
|Category     |  Joiner       |  ❌       |
|Trigger Type     | Time based attribute, Attribute changes, Group Membership change          |  ✔️       |
|Trigger details     | Depends on trigger type selection. <br> • **Time based**:  Days from event, Event timing, Event user attribute<br> • **Attribute changes**: Trigger attribute <br>• **Group membership changes**: Added to group/Remove from group    |   ✔️      |
|Days from event     | 0        | ❌        |
|Event timing     | On        |  ❌       |
|Event User attribute     | EmployeeHireDate, createdDateTime        |   ✔️      |
|Scope     | Depends on trigger. <br> **Rule based**: Time based attribute, Attribute changes.<br> **Group membership change**: Group based.         | ✔️        |
|Tasks     | **Add User To Group**, **Enable User Account**, **Send Welcome Email**      |  ✔️       |

### Post-Onboarding of an employee

The **Post-Onboarding of an employee** template is designed to configure tasks that will be completed after an employee's start, or creation, date.

:::image type="content" source="media/lifecycle-workflow-templates/onboard-post-employee-template.png" alt-text="Screenshot of a Lifecycle Workflow post-onboard new hire template.":::

The default specific parameters for the **Post-Onboarding of an employee** template are as follows:

|Parameter  |Description  |Customizable  |
|---------|---------|---------|
|Category     |  Joiner       |  ❌       |
|Trigger Type     | Time based attribute, Attribute changes, Group Membership change       |  ✔️       |
|Trigger details     | Depends on trigger type selection. <br> • **Time based**:  Days from event, Event timing, Event user attribute<br> • **Attribute changes**: Trigger attribute <br>• **Group membership changes**: Added to group/Remove from group     |   ✔️      |
|Days from event     | 7       | ✔️        |
|Event timing     | After        |  ❌       |
|Event User attribute     | EmployeeHireDate, createdDateTime        |   ✔️      |
|Scope     | Depends on trigger. <br> **Rule based**: Time based attribute, Attribute changes.<br> **Group membership change**: Group based.         | ✔️        |
|Tasks     | **Add User To Group**, **Add user to selected teams**    |  ✔️       |

### Real-time employee change

The **Real-time employee change** template is designed to configure tasks that are completed immediately when an employee changes roles.

:::image type="content" source="media/lifecycle-workflow-templates/on-demand-change-template.png" alt-text="Screenshot of a Lifecycle Workflow real time employee change template.":::

The default specific parameters for the **Real-time employee change** template are as follows:

|Parameter  |Description  |Customizable  |
|---------|---------|---------|
|Category     |  Mover       |  ❌       |
|Trigger Type     | On-demand        |  ❌       |
|Tasks     | **Run a Custom Task Extension**    |  ✔️       |

> [!NOTE]
> As this template is designed to run on-demand, no execution condition is present.

### Real-time employee termination

The **Real-time employee termination** template is designed to configure tasks that are completed immediately when an employee is terminated.

:::image type="content" source="media/lifecycle-workflow-templates/on-demand-termination-template.png" alt-text="Screenshot of a Lifecycle Workflow real time employee termination template.":::

The default specific parameters for the **Real-time employee termination** template are as follows:

|Parameter  |Description  |Customizable  |
|---------|---------|---------|
|Category     |  Leaver       |  ❌       |
|Trigger Type     | On-demand        |  ❌       |
|Tasks     | **Remove user from all groups**, **Delete User Account**, **Remove user from all Teams**      |  ✔️       |

> [!NOTE]
> As this template is designed to run on-demand, no execution condition is present.

### Pre-Offboarding of an employee

The **Pre-Offboarding of an employee** template is designed to configure tasks that are completed before an employee's last day of work.

:::image type="content" source="media/lifecycle-workflow-templates/offboard-pre-employee-template.png" alt-text="Screenshot of a pre offboarding employee template.":::

The default specific parameters for the **Pre-Offboarding of an employee** template are as follows:

|Parameter  |Description  |Customizable  |
|---------|---------|---------|
|Category     |  Leaver       |  ❌       |
|Trigger Type     | Time based attribute, Attribute changes, Group Membership change         |  ✔️       |
|Trigger details     | Depends on trigger type selection. <br> • **Time based**:  Days from event, Event timing, Event user attribute<br> • **Attribute changes**: Trigger attribute <br>• **Group membership changes**: Added to group/Remove from group    |   ✔️      |
|Days from event     | 7        | ✔️        |
|Event timing     | Before        |  ❌       |
|Event User attribute     | employeeLeaveDateTime        |   ❌      |
|Scope     | Depends on trigger. <br> **Rule based**: Time based attribute, Attribute changes.<br> **Group membership change**: Group based.         | ✔️        |
|Tasks     | **Remove user from selected groups**, **Remove user from selected Teams**     |  ✔️       |

### Offboard an employee

The **Offboard an employee** template is designed to configure tasks that are completed on an employee's last day of work.

:::image type="content" source="media/lifecycle-workflow-templates/offboard-employee-template.png" alt-text="Screenshot of an offboard employee template lifecycle workflow.":::

The default specific parameters for the **Offboard an employee** template are as follows:

|Parameter  |Description  |Customizable  |
|---------|---------|---------|
|Category     |  Leaver       |  ❌       |
|Trigger Type     | Time based attribute, Attribute changes, Group Membership change        |  ✔️       |
|Trigger details     | Depends on trigger type selection. <br> • **Time based**:  Days from event, Event timing, Event user attribute<br> • **Attribute changes**: Trigger attribute <br>• **Group membership changes**: Added to group/Remove from group    |   ✔️      |
|Days from event     | 0        | ✔️        |
|Event timing     | On        |  ❌       |
|Event User attribute     | employeeLeaveDateTime      |   ❌      |
|Scope     | Depends on trigger. <br> **Rule based**: Time based attribute, Attribute changes.<br> **Group membership change**: Group based.         | ✔️        |
|Tasks     | **Disable User Account**, **Remove user from all groups**, **Remove user from all Teams**     |  ✔️       |

### Post-Offboarding of an employee

The **Post-Offboarding of an employee** template is designed to configure tasks that will be completed after an employee's last day of work.

:::image type="content" source="media/lifecycle-workflow-templates/offboard-post-employee-template.png" alt-text="Screenshot of an offboarding an employee after last day template.":::

The default specific parameters for the **Post-Offboarding of an employee** template are as follows:

|Parameter  |Description  |Customizable  |
|---------|---------|---------|
|Category     |  Leaver       |  ❌       |
|Trigger Type     | Time based attribute, Attribute changes, Group Membership change        |  ✔️       |
|Trigger details     | Depends on trigger type selection. <br> • **Time based**:  Days from event, Event timing, Event user attribute<br> • **Attribute changes**: Trigger attribute <br>• **Group membership changes**: Added to group/Remove from group     |   ✔️      |
|Event User attribute     | employeeLeaveDateTime      |   ❌      |
|Scope     | Depends on trigger. <br> **Rule based**: Time based attribute, Attribute changes.<br> **Group membership change**: Group based.         | ✔️        |
|Tasks     | **Remove all licenses for user**, **Remove user from all Teams**, **Delete User Account**     |  ✔️       |

For a tutorial on setting up a workflow that uses the **Post-Offboarding of an employee** template, see: [Automate employee offboarding tasks after their last day of work with the Microsoft Entra admin center](tutorial-scheduled-leaver-portal.md).

### Employee group membership changes

The **Employee group membership changes** template is designed to configure tasks that are completed when an employee has a change in a group membership.

:::image type="content" source="media/lifecycle-workflow-templates/employee-group-membership-changes-template.png" alt-text="Screenshot of an Employee group membership changes template.":::

The default specific parameters for the **Employee group membership changes** template are as follows:

|Parameter  |Description  |Customizable  |
|---------|---------|---------|
|Category     |  mover       |  ❌       |
|Trigger Type     | Attribute changes, Group Membership change        |  ✔️       |
|Trigger details     | Depends on trigger type selection. <br> • **Attribute changes**: Trigger attribute <br>• **Group membership changes**: Added to group/Remove from group    |   ✔️      |
|Scope     | Depends on trigger. <br> **Rule based**: Attribute changes.<br> **Group membership change**: Group based.       | ✔️        |
|Tasks     | **Remove access package assignment for user**, **Remove user from selected Teams**, **Send email to notify manager of user move**     |  ✔️       |

### Employee job profile change

The **Employee job profile change** template is designed to configure tasks that are completed when an employee has a change in job title.

:::image type="content" source="media/lifecycle-workflow-templates/employee-job-profile-change-template.png" alt-text="Screenshot of the Employee job profile change template.":::

The default specific parameters for the **Employee job profile change** template are as follows:

|Parameter  |Description  |Customizable  |
|---------|---------|---------|
|Category     |  mover       |  ❌       |
|Trigger Type     | Attribute changes, Group Membership change        |  ✔️       |
|Trigger details     | Depends on trigger type selection. <br> • **Attribute changes**: Trigger attribute <br>• **Group membership changes**: Added to group/Remove from group    |   ✔️      |
|Scope     | Depends on trigger. <br> **Rule based**: Attribute changes.<br> **Group membership change**: Group based.         | ✔️        |
|Tasks     | **Send email to notify manager of user move**, **Remove user from selected groups**, **Remove user from selected Teams**, **Request user access package assignment**    |  ✔️       |

For a tutorial on setting up a workflow that uses the **Employer job profile change** template, see: [Automate employee mover tasks when they change jobs using the Microsoft Entra admin center](tutorial-mover-custom-workflow-portal.md).

## Next steps

- [`workflowTemplate` resource type](/graph/api/resources/identitygovernance-workflowtemplate?view=graph-rest-beta&preserve-view=true)
- [Lifecycle Workflow tasks and definitions](lifecycle-workflow-tasks.md)
- [Create a Lifecycle workflow](create-lifecycle-workflow.md)
