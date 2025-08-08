---
title: Configure Group Source of Authority (SOA) in Microsoft Entra ID (Preview)
description: Learn how to convert user management from Active Directory Domain Services (AD DS) to Microsoft Entra ID by using user Source of Authority (SOA).
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id
ms.subservice: hybrid
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 08/07/2025
ms.reviewer: dhanyak

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

# Configure User Source of Authority (SOA) (Preview)

<!-- 2. Introductory paragraph ----------------------------------------------------------

Required: Lead with a light intro that describes, in customer-friendly language, what the customer will do. Answer the fundamental “why would I want to do this?” question. Keep it short.

Readers should have a clear idea of what they will do in this article after reading the introduction.

* Introduction immediately follows the H1 text.
* Introduction section should be between 1-3 paragraphs.
* Don't use a bulleted list of article H2 sections.

Example: In this article, you will migrate your user databases from IBM Db2 to SQL Server by using SQL Server Migration Assistant (SSMA) for Db2.

-->

This article explains the prerequisites, and steps, to configure User Source of Authority (SOA). This article also explains how to revert changes, and current feature limitations. For a full overview for User SOA, see [Embrace cloud-first posture: Convert User Source of Authority to the cloud (Preview)](test.md).

<!---Avoid notes, tips, and important boxes. Readers tend to skip over them. Better to put that info directly into the article text.

-->

<!-- 3. Prerequisites --------------------------------------------------------------------

Required: Make Prerequisites the first H2 after the H1. 

* Provide a bulleted list of items that the user needs.
* Omit any preliminary text to the list.
* If there aren't any prerequisites, list "None" in plain text, not as a bulleted item.

-->

## Prerequisites

## Prerequisites

| Requirement | Description |
|-------------|-------------|
| **Roles** | [Hybrid Administrator](/entra/identity/role-based-access-control/permissions-reference#hybrid-administrator) is required to call the Microsoft Graph APIs to read and update SOA of groups.<br>[Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) or [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator) is required to grant user consent to the required permissions to Microsoft Graph Explorer or the app used to call the Microsoft Graph APIs. |
| **Permissions** | For apps calling into the `onPremisesSyncBehavior` Microsoft Graph API, the `Group-OnPremisesSyncBehavior.ReadWrite.All` permission scope needs to be granted. For more information, see [how to grant this permission](#grant-permission-to-apps) to Graph Explorer or an existing app in your tenant. |
| **License needed** | Microsoft Entra Free or Basic license. |
| **Connect Sync client** | Minimum version is [2.5.76.0](/entra/identity/hybrid/connect/reference-connect-version-history#25760) |
| **Cloud Sync client** | Minimum version is [1.1.1370.0](/entra/identity/hybrid/cloud-sync/reference-version-history#1113700)|

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

## Setup

You need to set up Connect Sync client and the Microsoft Entra Provisioning agent.

### Connect Sync client

1. Download the latest version of the Connect Sync build.

1. Verify the Connect Sync build is successfully installed. Go to **Programs** in Control Panel and confirm that the version of Microsoft Entra Connect Sync is [2.5.76.0](/entra/identity/hybrid/connect/reference-connect-version-history#25760).

### Cloud Sync client

Download the Microsoft Entra Provisioning agent with build version [1.1.1370.0](/entra/identity/hybrid/cloud-sync/reference-version-history#1113700) or later.

1. Follow the [instructions to download the Cloud Sync client](/entra/identity/hybrid/cloud-sync/reference-version-history#download-link).

1. Learn how to [identify the agent's current version](/azure/active-directory/hybrid/cloud-sync/how-to-automatic-upgrade).

1. Follow the [instructions to configure provisioning from AD DS to Microsoft Entra ID](/entra/identity/hybrid/cloud-sync/how-to-configure).

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

