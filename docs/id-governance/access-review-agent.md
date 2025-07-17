---
title: #Required; "<verb> * <noun>"
description: #Required; Keep the description within 100- and 165-characters including spaces.
author: #Required; your GitHub user alias, with correct capitalization
ms.author: #Required; microsoft alias of author
ms.service: #Required; use the name-string related to slug in ms.product/ms.service
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: #Required; mm/dd/yyyy format

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

# Access Review Agent with Microsoft Security Copilot



<!-- 2. Introductory paragraph ----------------------------------------------------------

Required: Lead with a light intro that describes, in customer-friendly language, what the customer will do. Answer the fundamental “why would I want to do this?” question. Keep it short.

Readers should have a clear idea of what they will do in this article after reading the introduction.

* Introduction immediately follows the H1 text.
* Introduction section should be between 1-3 paragraphs.
* Don't use a bulleted list of article H2 sections.

Example: In this article, you will migrate your user databases from IBM Db2 to SQL Server by using SQL Server Migration Assistant (SSMA) for Db2.

-->

TODO: Add your introductory paragraph

<!---Avoid notes, tips, and important boxes. Readers tend to skip over them. Better to put that info directly into the article text.

-->

<!-- 3. Prerequisites --------------------------------------------------------------------

Required: Make Prerequisites the first H2 after the H1. 

* Provide a bulleted list of items that the user needs.
* Omit any preliminary text to the list.
* If there aren't any prerequisites, list "None" in plain text, not as a bulleted item.

-->

## Prerequisites

- You must have at least the [Microsoft Entra ID Governance](licensing-fundamentals.md) license.
- You must have available [security compute units (SCU)](/copilot/security/manage-usage).
   - On average each agent decision, which includes reasoning and your conversation with the agent, consumes less than one SCU.
- To activate the agent the first time, you need the [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) or [Global Administrator](../identity/role-based-access-control/permissions-reference.md#global-administrator).
- You can assign [Identity Governance Administrators](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator) with Security Copilot access, which gives your Identity Governance Administrators the ability to use the agent as well.
   - For more information, see [Assign Security Copilot access](/copilot/security/authentication#assign-security-copilot-access)
- [Global Reader](../identity/role-based-access-control/permissions-reference.md#global-reader) and [Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader) roles can view the agent and any suggestions, but can't take any actions.
- [Global Administrator](../identity/role-based-access-control/permissions-reference.md#global-administrator), [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator), and [Identity Governance  Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator) roles can view the agent and take action on the suggestions.
- Review [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security)

### Limitations

- Avoid using an account to set up the agent that requires role activation with Privileged Identity Management (PIM). Using an account that doesn't have standing permissions might cause authentication failures for the agent.
- Once agents are started, they can't be stopped or paused. It might take a few minutes to run.
- Recommendations are only available for single stage reviews.
- Reviews must be for ‘*Teams + Groups*’ or ‘*Applications*’. Reviews for Access Packages, Microsoft Entra Roles, and Azure Resources are not currently supported.
- The agent currently runs as the user who enables it.
- The reviewer must be a [internal user (of userType member or guest)](../external-id/user-properties.md) within the tenant in which the review is scheduled. External guests or external members as reviewers are not currently supported.
- We recommend running the agent from the Microsoft Entra admin center.
- Scanning is limited to a 24 hour period.
- Suggestions from the agent can't be customized or overridden.

## How it works


The Access Review Agent proactively scans active access reviews, and assists reviewers in making informed decisions about access for users in your environment. The agent, which reviewers communicates with directly via [Microsoft Teams](), uses user context to help inform decisions. When providing review recommendations, the agent provides details that led to the recommendations, allowing reviewers to review the reasoning used and make their own decisions with the information provided.

Each time the agent runs, it takes the following steps. **The initial scanning steps do not consume any SCUs.**

1. The agent scans all access reviews in your tenant.
1. The agent analyzes the data, such as their activity, of users being reviewed.
1. The agent reviews previous access review decisions to help inform its recommendations.

If the agent identifies something that wasn't previously suggested, it takes the following steps. **These action steps consume SCUs.**

1. The agent evaluates access review durations, and recommends that the reviewer reviews the access review expiring earlier first.
1. The agent identifies that a user is no longer active and recommends revoking access.
1. The agent identifies that a user is still active and using resources, the access review agent recommends approving access.




## Getting started
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

