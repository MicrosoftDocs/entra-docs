---
title: Add a Custom Security Attribute as the scope of a workflow
description: Learn how to add a custom security attribute as the scope of a workflow with lifecycle workflows.
author: owinfreyATL
manager: amycolannino
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.date: 04/23/2024
ms.author: owinfrey
ms.reviewer: krbain

#CustomerIntent: As an administrator, I want to be able to add Custom Security Attributes of a user to the scope of a workflow so that I have greater control over which users specific workflows will run for.
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

# Add a Custom Security Attribute as the scope of a workflow 

Workflows created with Lifecycle workflows can run for users on schedule based on a custom security attribute. Using a custom security attribute to narrow the scope of your workflow gives you greater control over who the workflow runs for by increasing customization of supported user properties. Examples of these properties include:

- Pay grade
- Certification status
- Cost Center

For more information about Custom Security Attributes, and their use cases, see: [What are custom security attributes in Microsoft Entra ID?](../fundamentals/custom-security-attributes-overview.md).

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](../includes/entra-entra-governance-license.md)]


To assign a custom security attribute to the scope of a workflow, you must have a custom security attribute set and it's definitions created in your tenant. For a guide on adding a custom security attribute set, and setting its definitions, in your tenant, see: [Add or deactivate custom security attribute definitions in Microsoft Entra ID](../fundamentals/custom-security-attributes-add.md). When you have created a custom set attribute and set its definitions you must also assign this attribute to a user. For a guide on this, see: [Assign custom security attributes to a user](../identity/users/users-custom-security-attributes.md#assign-custom-security-attributes-to-a-user).

## Add a Custom Security Attribute as the scope of a workflow using the Microsoft Entra admin center

Workflows can be created with, or edited to include, a Custom Security Attribute as a scope. The following steps will walk you through editing an existing workflow to add a Custom Security Attribute as the scope. For a guide on creating a workflow from scratch with which you could use a Custom security attribute as a scope, see: [Create a lifecycle workflow](../id-governance/create-lifecycle-workflow.md). To edit a workflow to include a Custom Security Attribute within it's scope, you complete the following steps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).
    > [!NOTE]
    > The prerequisite steps of creating, defining, and assigning a custom security attribute must be completed before using the [Attribute Assignment Administrator](../identity/role-based-access-control/permissions-reference.md#attribute-assignment-administrator) role. The Lifecycle Workflows Administrator role alone cannot create, update, or assign custom security attributes.
1. Browse to **Identity governance** > **Lifecycle workflows** > **Workflows**.

1. On the Workflows page select the workflow which you want to use a custom security attribute as part of the scope for.

1. On the specific workflow page select **Execution conditions**. 

1. On the execution conditions page, select **Scope details**.  

1. On the scope details page you select **Add expression**, and from the drop down list locate your custom security attributes.
    :::image type="content" source="media/manage-workflow-csa-scope/csa-scope-list.png" alt-text="Screenshot of a list of CSA on the scope screen.":::
1. After you select the custom security attribute you want to use, Select **Save**.

## Next step

> [!div class="nextstepaction"]
> [Manage workflow versions](manage-workflow-tasks.md)

