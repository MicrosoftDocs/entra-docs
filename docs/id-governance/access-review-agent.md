---
title: Access Review Agent with Microsoft Security Copilot
description: Learn how the Access Review Agent, with Microsoft Security Copilot, can help secure your organization through recommendations based on your data.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: access-reviews
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 07/17/2025

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


The Access Review Agent helps you ensure that access to resources provided to users are up to date, and based on specific data from your organization. The agent recommends access review decisions based not only on [existing best practices](review-recommendations-access-reviews.md) for reviews, but also based on other criteria developed with the agent.


The Access Review agent evaluates current access reviews based on policies around previous access review decisions, user activity, governance behavior, and account status. When the agent identifies a suggestion, you can have the agent complete the review based on you accepting, or rejecting, the recommendation.

## Prerequisites

- You must have at least the [Microsoft Entra ID Governance](licensing-fundamentals.md) license.
- You must have available [security compute units (SCU)](/copilot/security/manage-usage).
   - On average each agent decision, which includes reasoning and your conversation with the Access Review Agent, consumes less than one SCU.
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

The agent considers the following about a user when making review recommendations:

- **Enabled Status**: Whether or not the user being reviewed is an enabled account.
- **Creation date**: When the account of the user being reviewed was created.
- **Specific Previous decisions**: When the review in question is a recurring review.
- **The account state**: Whether or not the user being reviewed state is enabled.
- **Microsoft Entra ID Governance History**: Whether or not the user has recently had other actions performed on it, such as having a workflow from Lifecycle Workflows ran for them.
- **Related access package assignment request approval decisions**: When making access package recommendations, related access package assignment request decisions are taken into account of the agent recommendation.




## Getting started


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator).
1. From the new home page, select **Go to agents** from the agent notification card.
   - You can also select **Agents** from the left navigation menu.
   :::image type="content" source="media/access-review-agent/start-access-review-agent.png" alt-text="Screenshot of starting the Access Review Agent.":::
1. Select **View details** on the Access Review Agent tile.
    
1. Select **Start agent** to begin your first run. 
   - Avoid using an account with a role activated through PIM.
   - A message that says "The agent is starting its first run" appears in the upper-right corner.
   - The first run might take a few minutes to complete.
1. 


## Settings

Once the agent is enabled, you can adjust a few settings. You can access the settings by doing the following in the Microsoft Entra admin center:

- From **Agents** > **Access Review Agent** > **Settings**.

### Trigger

The agent is configured to run every 6 hours based on when it's initially configured. You can run it at a specific time by toggling the **Trigger** setting off and then back on when you want it to run.

   :::image type="content" source="media/access-review-agent/access-review-agent-trigger.png" alt-text="Screenshot of the Access Review Agent trigger.":::

### Reviewers

Use the checkboxes under **Reviewers** to specify which reviewers can use the agent for access reviews.

   :::image type="content" source="media/access-review-agent/access-review-agent-reviewers.png" alt-text="Screenshot of setting reviewers for the Access Review Agent.":::



    

## Remove agent

If you no longer wish to use the Access Review agent, select **Remove agent** from the top of the agent window. The existing data (agent activity, suggestions, and metrics) is removed but any reviews approved or revoked based on the agent suggestions remain intact. Previously applied suggestions remain unchanged for the access reviews completed.

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

