---
title: Use custom security attributes to scope a workflow
description: Learn how to use custom security attribute to configure the scope of a workflow with lifecycle workflows.
author: owinfreyATL
manager: femila
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to
ms.date: 08/13/2024
ms.author: owinfrey
ms.reviewer: krbain

#CustomerIntent: As an administrator, I want to be able to use custom security attributes of a user as part of the scope of a workflow so that I have greater control over which users specific workflows will run for.
---

# Use custom security attributes to scope a workflow

Workflows created using Lifecycle workflows can be scoped based on attributes, including custom security attributes, configured for a user. You can use existing custom security attributes configured for your tenant, which contains sensitive data for a user to further control the set of users the workflow is to be executed. For more information about custom security attributes, and their use cases, see: [What are custom security attributes in Microsoft Entra ID?](../fundamentals/custom-security-attributes-overview.md).

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](../includes/entra-entra-governance-license.md)]

To scope a workflow using a custom security attribute, you must have a custom security attribute set and its definitions created in your tenant. For a guide on adding a custom security attribute set, and setting its definitions, see: [Add or deactivate custom security attribute definitions in Microsoft Entra ID](../fundamentals/custom-security-attributes-add.md). When you have created a custom set attribute and set its definitions, you must also assign this attribute to a user. For a guide on assigning custom security attributes to a user, see: [Assign custom security attributes to a user](../identity/users/users-custom-security-attributes.md#assign-custom-security-attributes-to-a-user).

> [!NOTE]
> The [prerequisite](../id-governance/manage-workflow-custom-security-attribute.md#prerequisites) steps of creating, defining, and assigning a custom security attribute must be performed using the [Attribute Assignment Administrator](../identity/role-based-access-control/permissions-reference.md#attribute-assignment-administrator) role. The Lifecycle Workflows Administrator role alone cannot create, update, or assign custom security attributes.

## Add a custom security attribute to the scope of a workflow using the Microsoft Entra admin center

Workflows can be created with, or edited, to include a custom security attribute as a scope. The following steps walk you through editing an existing workflow to use a custom security attribute as a scope. For a guide on creating a workflow from scratch, with which you could scope a workflow using custom security attributes, see: [Create a lifecycle workflow](../id-governance/create-lifecycle-workflow.md). To edit a workflow to include a custom security attribute to its scope, you complete the following steps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator) and [Attribute Assignment Administrator](../identity/role-based-access-control/permissions-reference.md#attribute-assignment-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **Workflows**.

1. On the Workflows page, select the workflow that you want to use a custom security attribute as part of the scope for.

1. On the specific workflow page, select **Execution conditions**. 

1. On the execution conditions page, select **Scope details**.  

1. On the scope details page, select **Add expression**, and from the drop-down list locate your custom security attributes, and then set its value.
    :::image type="content" source="media/manage-workflow-custom-security-attribute/custom-attribute-list.png" alt-text="Screenshot of a list of custom security attributes on the scope screen.":::
    > [!NOTE]
    > Deactivated Custom Security Attributes will not appear in this list.
1. After setting the value for the custom security attribute, select **Save**.

## Add a custom security attribute to the scope of the workflow using Microsoft Graph

As adding a custom security attribute to the scope of a workflow updates its execution conditions, you'd be creating a new version of the workflow. To create a new version of a workflow via API using Microsoft Graph, see: [workflow: createNewVersion](/graph/api/identitygovernance-workflow-createnewversion).

## View custom security attribute used as a scope of the workflow

After you scoped a workflow using a custom security attribute, you can view this information within the workflow audit logs. To view these details, you'd do the following steps:

1.  Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator) and [Attribute Assignment Administrator](../identity/role-based-access-control/permissions-reference.md#attribute-assignment-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **Workflows**.

1.  On the workflows page, select **Audit Logs**.
    > [!TIP]
    > Custom security attribute information of a workflow is also viewable, with proper permissions, from a specific workflow's version page.
1. Select an event where a custom security attribute was used to scope a workflow during creation, or added to an updated workflow and select **Modified properties**.

1. On the version information page, under **Configure**, you should see the custom security attribute as the rule.
    :::image type="content" source="media/manage-workflow-custom-security-attribute/custom-attribute-scope.png" alt-text="Screenshot of custom security attribute as scope.":::
1. Depending on your roles determines if you can see the full details of the custom security attributes being used. If you attempt to view custom security attribute information while not having the [Attribute Assignment Administrator](../identity/role-based-access-control/permissions-reference.md#attribute-assignment-administrator) or [Attribute Assignment Reader](../identity/role-based-access-control/permissions-reference.md#attribute-assignment-reader) roles set, you see that the information is hidden.
    :::image type="content" source="media/manage-workflow-custom-security-attribute/attribute-information-hidden.png" alt-text="Screenshot of hidden attribute information.":::

> [!NOTE]
> For more information about custom security attributes being hidden, see: [Why can’t I see any custom security attributes in the Property list?](../id-governance/workflows-faqs.md#why-cant-i-see-any-custom-security-attributes-in-the-property-list).

## Next step

> [!div class="nextstepaction"]
> [Manage workflow versions](manage-workflow-tasks.md)

