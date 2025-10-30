---
title: Use Custom Attribute Triggers in Lifecycle Workflows (Preview)
description: This article discusses how to use Custom Attribute Triggers as an attribute change trigger within a workflow in Lifecycle Workflows.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 10/29/2025

#CustomerIntent: As a Lifecycle Workflows Administrator, I want to use Custom Attribute triggers as an attribute change trigger so that I can trigger workflows based on other custom attributes.
---



# Use Custom Attribute Triggers in Lifecycle Workflows (Preview)

Lifecycle Workflows allows you to trigger workflows to run automatically for users that meet the execution conditions of the workflow. There are a number of default attributes that you can use to trigger workflows, but sometimes you might require triggering a workflow based on a specific attribute not offered by default. Using custom attribute triggers, you can trigger a workflow to run for users based on when they move within the organizations based on:

- [Custom security attributes (CSA)](manage-workflow-custom-security-attribute.md)
- directory extension attributes
- on-premises extension attributes (1-15)
- employeeOrgData attributes

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](../includes/entra-entra-governance-license.md)]


## Use Custom Attribute Triggers in Lifecycle Workflows using the Microsoft Entra admin center

To use custom attribute triggers in Lifecycle Workflows, do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator) and [Attribute Assignment Administrator](../identity/role-based-access-control/permissions-reference.md#attribute-assignment-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **Create a workflow**.

1. On the Workflows page, select a mover workflow template that you want to use a custom security attribute as part of the scope for.

1. Enter the basic information such as display name, description, and administration scope.

1. Under **Trigger type** select **Attribute changes**.

1. For Attribute, select the attribute trigger you want to have trigger the workflow to run. 

1. Add tasks, and save the workflow.  

## "\<verb\> * \<noun\>"
TODO: Add introduction sentence(s)
[Include a sentence or two to explain only what is needed to complete the procedure.]
TODO: Add ordered list of procedure steps
1. Step 1
1. Step 2
1. Step 3

## "\<verb\> * \<noun\>"
TODO: Add introduction sentence(s)
[Include a sentence or two to explain only what is needed to complete the procedure.]
TODO: Add ordered list of procedure steps
1. Step 1
1. Step 2
1. Step 3

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

