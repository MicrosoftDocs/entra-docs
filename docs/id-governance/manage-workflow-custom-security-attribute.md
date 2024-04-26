---
title: Add a custom security attribute to the scope of a workflow
description: Learn how to add a custom security attribute as the scope of a workflow with lifecycle workflows.
author: owinfreyATL
manager: amycolannino
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.date: 04/23/2024
ms.author: owinfrey
ms.reviewer: krbain

#CustomerIntent: As an administrator, I want to be able to add custom security attributes of a user to the scope of a workflow so that I have greater control over which users specific workflows will run for.
---

# Add a Custom Security Attribute to the scope of a workflow 

Workflows created with Lifecycle workflows can run for users on schedule based on custom security attributes. Using custom security attributes to narrow the scope of your workflow gives you greater control over who the workflow runs for by increasing customization of supported user properties. Examples of these properties include:

- Pay grade
- Certification status
- Cost Center

For more information about custom security attributes, and their use cases, see: [What are custom security attributes in Microsoft Entra ID?](../fundamentals/custom-security-attributes-overview.md).

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](../includes/entra-entra-governance-license.md)]


To assign a custom security attribute to the scope of a workflow, you must have a custom security attribute set, and its definitions, created in your tenant. For a guide on adding a custom security attribute set, and setting its definitions, see: [Add or deactivate custom security attribute definitions in Microsoft Entra ID](../fundamentals/custom-security-attributes-add.md). When you have created a custom set attribute and set its definitions, you must also assign this attribute to a user. For a guide on assigning custom security attributes to a user, see: [Assign custom security attributes to a user](../identity/users/users-custom-security-attributes.md#assign-custom-security-attributes-to-a-user).

## Add a custom security attribute to the scope of a workflow using the Microsoft Entra admin center

Workflows can be created with, or edited to include, a custom security attribute as a scope. The following steps walk you through editing an existing workflow to add a custom security attribute to the scope. For a guide on creating a workflow from scratch, with which you could assign a custom security attribute as the scope, see: [Create a lifecycle workflow](../id-governance/create-lifecycle-workflow.md). To edit a workflow to include a custom security attribute to its scope, you complete the following steps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).
    > [!NOTE]
    > The [prerequisite](../id-governance/manage-workflow-csa-scope.md#prerequisites) steps of creating, defining, and assigning a custom security attribute must be completed before using the [Attribute Assignment Administrator](../identity/role-based-access-control/permissions-reference.md#attribute-assignment-administrator) role. The Lifecycle Workflows Administrator role alone cannot create, update, or assign custom security attributes.
1. Browse to **Identity governance** > **Lifecycle workflows** > **Workflows**.

1. On the Workflows page, select the workflow that you want to use a custom security attribute as part of the scope for.

1. On the specific workflow page, select **Execution conditions**. 

1. On the execution conditions page, select **Scope details**.  

1. On the scope details page you select **Add expression**, and from the drop-down list locate your custom security attributes, and then set its value.
    :::image type="content" source="media/manage-workflow-csa-scope/csa-scope-list.png" alt-text="Screenshot of a list of custom security attributes on the scope screen.":::
1. After setting the value for the custom security attribute, select **Save**.

## Next step

> [!div class="nextstepaction"]
> [Manage workflow versions](manage-workflow-tasks.md)

