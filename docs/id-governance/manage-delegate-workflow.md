---
title: Delegate Workflow Management (Preview)
description: This article guides a user to editing a workflow's properties using Lifecycle Workflows.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to 
ms.date: 07/31/2025

#CustomerIntent: As a < type of user >, I want < what? > so that < why? >.
---

<!--
Remove all the comments in this template before you sign-off or merge to the main branch.

This template provides the basic structure of a How-to article pattern. See the
[instructions - How-to](../level4/article-how-to-guide.md) in the pattern library.

You can provide feedback about this template at: https://aka.ms/patterns-feedback

How-to is a procedure-based article pattern that show the user how to complete a task in their own environment. A task is a work activity that has a definite beginning and ending, is observable, consist of two or more definite steps, and leads to a product, service, or decision.

-->

<!-- 1. H1 -----------------------------------------------------------------------------

Required: Use a "<verb> * <noun>" format for your H1. Pick an H1 that clearly conveys the task the user will complete.

For example: "Migrate data from regular tables to ledger tables" or "Create a new Azure SQL Database".

* Include only a single H1 in the article.
* Don't start with a gerund.
* Don't include "Tutorial" in the H1.

-->

# Delegate Workflow Management (Preview)

Workflows, unless specified during creation, by default can be managed by users with either the Lifecycle Workflows, or Global, administrator roles. As workflows can grow and change to meet the members of your organization, so can the need to limit who can manage it. With delegated workflow management, you can scope workflow management down to the specific user level. When you scope a Lifecycle Workflows administrator to a workflow, you grant this workflow admin the ability to handle all tasks associated with that workflow, while keeping separate workflows out of their scope. This allows for greater security within your environment by following Microsoft's least access principal guidelines, and only giving access to specifically whats needed.

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
|[Scope Workflows](manage-delegate-workflow.md#edit-the-properties-of-a-workflow-using-the-microsoft-entra-admin-center)     | Yes | No |

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](~/includes/entra-entra-governance-license.md)]

<!-- 4. Task H2s ------------------------------------------------------------------------------

Required: Multiple procedures should be organized in H2 level sections. A section contains a major grouping of steps that help users complete a task. Each section is represented as an H2 in the article.

For portal-based procedures, minimize bullets and numbering.

* Each H2 should be a major step in the task.
* Phrase each H2 title as "<verb> * <noun>" to describe what they'll do in the step.
* Don't start with a gerund.
* Don't number the H2s.
* Begin each H2 with a brief explanation for context.
* Provide a ordered list of procedural steps.
* Provide a code block, diagram, or screenshot if appropriate
* An image, code block, or other graphical element comes after numbered step it illustrates.
* If necessary, optional groups of steps can be added into a section.
* If necessary, alternative groups of steps can be added into a section.

-->

## Edit the properties of a workflow using the Microsoft Entra admin center

To edit the properties of a workflow using the Microsoft Entra admin center, you do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **workflows**.

1. Here you see a list of all of your current workflows. Select the workflow that you want to edit the administrative scope of.

1. On the list, select the user you want to assign the administrator role over this workflow.

1. Select **Save**. 

<!-- 5. Next step/Related content------------------------------------------------------------------------

Optional: You have two options for manually curated links in this pattern: Next step and Related content. You don't have to use either, but don't use both.
  - For Next step, provide one link to the next step in a sequence. Use the blue box format
  - For Related content provide 1-3 links. Include some context so the customer can determine why they would click the link. Add a context sentence for the following links.

-->

## Next step

TODO: Add your next step link(s)

> [!div class="nextstepaction"]
> [Write concepts](article-concept.md)

<!-- OR -->

## Related content

TODO: Add your next step link(s)

- [Write concepts](article-concept.md)

<!--
Remove all the comments in this template before you sign-off or merge to the main branch.
-->

