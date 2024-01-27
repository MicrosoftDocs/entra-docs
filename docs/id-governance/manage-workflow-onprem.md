---
title: Manage synced on-prem users with workflows
description: A how to article on how to manage synced on-prem users with lifecycle workflows.
author: owinfreyATL
ms.author: owinfrey
manager: amycolannino
ms.service: active-directory
ms.workload: identity
ms.topic: how-to 
ms.date: 1/12/2024
ms.subservice: compliance
ms.custom: template-how-to 

#CustomerIntent: As an administrator, I want to be able to create workflows for synced on-prem users so that they can be manged.

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

# Manage synced on-prem users with workflows


<!-- 2. Introductory paragraph ----------------------------------------------------------

Required: Lead with a light intro that describes, in customer-friendly language, what the customer will do. Answer the fundamental “why would I want to do this?” question. Keep it short.

Readers should have a clear idea of what they will do in this article after reading the introduction.

* Introduction immediately follows the H1 text.
* Introduction section should be between 1-3 paragraphs.
* Don't use a bulleted list of article H2 sections.

Example: In this article, you will migrate your user databases from IBM Db2 to SQL Server by using SQL Server Migration Assistant (SSMA) for Db2.

-->

Workflows created by Lifecycle Workflows can be used to manage the lifecycle of synced on-prem users. This allows for greater, and simplified, control of the lifecycle of users within your organization in hybrid environments. In this article, you'll be walked through the steps of enabling a task to be run for an on-prem user.




## Prerequisites

[!INCLUDE [Microsoft Entra ID Governance license](~/includes/entra-entra-governance-license.md)]

To manage synced on-prem users with Lifecycle Workflows, you must have the following on-prem prerequisites:

1. You must have the [Azure AD provisioning agent](../identity/hybrid/cloud-sync/what-is-provisioning-agent.md) installed in your environment. You can follow the existing installation [prerequisites](../identity/hybrid/cloud-sync/how-to-prerequisites.md) and [steps](../identity/hybrid/cloud-sync/how-to-install.md) in our public documentation. During installation choose “**HR-driven provisioning / Azure AD Connect Cloud Sync**” as “**extension configuration**”. You are not required to add any additional configuration for the provisioning agent, such as the cloud sync configuration, and you can install the provisioning agent even if you are currently using Azure AD Connect Sync for your user synchronization (side-by-side).

1. Ensure the gMSA used by the provisioning agent has the [appropriate permissions](../identity/hybrid/cloud-sync/how-to-prerequisites.md#custom-gmsa-account) to delete user accounts.

1. Enable the Active Directory recycle bin. For a step-by-step guide on this, see: [Active Directory Recycle Bin step-by-step](/windows-server/identity/ad-ds/get-started/adac/introduction-to-active-directory-administrative-center-enhancements--level-100-#active-directory-recycle-bin-step-by-step).

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

## Edit a task to be compatible with synced on-prem users using the Microsoft Entra Admin center

Account related tasks within workflows can be quickly edited to apply to synced on-prem users. To edit a task in such way using the Microsoft Entra Admin center, you do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Lifecycle Workflows Administrator](~/identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator).

1. Browse to **Identity governance** > **Lifecycle workflows** > **workflows**.

1. Select the workflow you want to edit the task within.

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
> [Delete a lifecycle workflow](delete-lifecycle-workflow.md)

<!--
Remove all the comments in this template before you sign-off or merge to the main branch.
-->

