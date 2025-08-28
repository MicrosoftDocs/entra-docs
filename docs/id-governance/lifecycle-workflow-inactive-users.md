---
title: Manage inactive users using Lifecycle Workflows (Preview)
description: This articles walks you through managing inactive users with Lifecycle Workflows.
author: owinfreyATL
ms.author: owinfrey
manager: dougeby
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 08/28/2025

#CustomerIntent: As an IT administrator, I want to automate managing users with Lifecycle Workflows so that management and security is streamlined.
---

# Manage inactive users using Lifecycle Workflows (Preview)

As part of supporting users no matter where they fall in the Joiner-Mover-Leaver (JML)  model of their lifecycle within your organization, Lifecycle Workflows support automating the disabling and deleting of users once they have been inactive for a set period of time. This [sign-in inactivity](lifecycle-workflow-execution-conditions.md#sign-in-inactivity-trigger) allows you to set a workflow to run when a user has been inactive for a set number of days. This feature allows you to seamlessly maintain a secure environment by automating the removal of inactive based on criteria you set for your organization.

## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](~/includes/entra-entra-governance-license.md)]


## Manage inactive users using the Microsoft Entra Admin Center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **ID Governance** > **Lifecycle workflows** > **workflows**.

1. On the workflow screen, select the specific workflow you want to add the inactive user task to, or create a new workflow based on a template.
    > [!NOTE]
    > To use any of the leaver tasks, you must select a leaver workflow template.
1. Once you have selected your desired workflow template enter in basic details, and then select the **Sign-in inactivity** trigger.

1.  

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

