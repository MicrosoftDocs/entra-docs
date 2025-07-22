---
title: Access Review Agent with Microsoft Security Copilot
description: Learn how the Access Review Agent, with Microsoft Security Copilot, can help secure your organization through recommendations based on your data.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: access-reviews
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 07/17/2025

#CustomerIntent: As a Security Administrator, I want to set up the Access Review Agent so that Copilot can be used to help complete access reviews for users in my organization.
---

# Access Review Agent with Microsoft Security Copilot


The Access Review Agent helps you ensure that access to resources provided to users is up to date, and based on specific data from your organization. The agent recommends access review decisions based not only on [existing best practices](review-recommendations-access-reviews.md) for reviews, but also based on other criteria developed with the agent.


The Access Review agent evaluates current access reviews based on policies around previous access review decisions, user activity, governance behavior, and account status. When the agent identifies a suggestion, you can have the agent complete the review based on you accepting, or rejecting, the recommendation.

## Prerequisites

- You must have at least the [Microsoft Entra ID Governance](licensing-fundamentals.md) license.
- You must have available [security compute units (SCU)](/copilot/security/manage-usage).
   - On average each agent decision, which includes reasoning and your conversation with the Access Review Agent, consumes less than one SCU.
- To activate the agent the first time, you need the [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) or [Global Administrator](../identity/role-based-access-control/permissions-reference.md#global-administrator).
- You can assign [Identity Governance Administrators](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator) with Security Copilot access, which gives your Identity Governance Administrators the ability to use the agent as well.
   - For more information, see [Assign Security Copilot access](/copilot/security/authentication#assign-security-copilot-access)
- [Global Administrator](../identity/role-based-access-control/permissions-reference.md#global-administrator), [Global Reader](../identity/role-based-access-control/permissions-reference.md#global-reader), and [Identity Governance  Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator) used along with [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator) roles can view the agent and any suggestions.
- [Global Administrator](../identity/role-based-access-control/permissions-reference.md#global-administrator) and [Identity Governance  Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator) used along with [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator) roles can view the agent and take action on the suggestions.
- Review [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security)

### Limitations

- Avoid using an account to set up the agent that requires role activation with Privileged Identity Management (PIM). Using an account that doesn't have standing permissions might cause authentication failures for the agent.
- Once agents are started, they can't be stopped or paused. It might take a few minutes to run.
- Recommendations are only available for single stage reviews.
- The agent currently runs as the user who enables it.
- The reviewer must be a [internal user (of userType member or guest)](../external-id/user-properties.md) within the tenant in which the review is scheduled. External guests or external members as reviewers aren't currently supported.
- We recommend running the agent from the Microsoft Entra admin center.
- Scanning is limited to a 24 hour period.
- Suggestions from the agent can't be customized or overridden.


## How it works


The Access Review Agent proactively scans active access reviews, and assists reviewers in making informed decisions about access for users in your environment. The agent, which reviewers communicate with directly via a [Microsoft Teams](/microsoftteams/teams-overview) chat, uses user context to help inform decisions. When providing review recommendations, the agent provides details that led to the recommendations, allowing reviewers to review the reasoning used and make their own decisions with the information provided.

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



## Using the Access Review Agent as a reviewer

With the Access Review Agent started, and reviewers assigned, you're now ready to use the agent to review your access reviews. As a reviewer, you'd do the following:

1. Open your Microsoft Teams application signed in as the user assigned as a reviewer.

1. Select **+ Apps**.

1. On the Apps page, locate the **Access Review Agent**, and select **Open**.
    :::image type="content" source="media/access-review-agent/access-review-agent-teams.png" alt-text="Screenshot of the Access Review Agent application in Microsoft Teams.":::
    > [!NOTE]
    > For reviewers in your organization to use the Access Review Agent, the app must be made [available to users within your organization](/microsoftteams/manage-apps#manage-org-wide-app-settings). Work with your Microsoft Teams Administrator to make sure the app is published and available in your org.
1. When open start the chat with the agent. An example of this is asking the agent "*Help me with my access reviews*."

From this chat, you're able to see information about your access reviews, the recommendations and reasoning the agent makes, and can reply so that the agent takes action based on your choices. 

## Remove agent

If you no longer wish to use the Access Review agent, select **Remove agent** from the top of the agent window. The existing data (agent activity, suggestions, and metrics) is removed but any reviews approved or revoked based on the agent suggestions remain intact. Previously applied suggestions remain unchanged for the access reviews completed.

<!-- 5. Next step/Related content------------------------------------------------------------------------

Optional: You have two options for manually curated links in this pattern: Next step and Related content. You don't have to use either, but don't use both.
  - For Next step, provide one link to the next step in a sequence. Use the blue box format
  - For Related content provide 1-3 links. Include some context so the customer can determine why they would click the link. Add a context sentence for the following links.

-->

### Providing feedback

Use the **Give Microsoft feedback** button at the top of the agent window to provide feedback to Microsoft about the agent.

## Related content

- [Access Review Agent logs and metrics (Preview)](access-review-agent-logs-metrics.md)
- [Review recommendations for Access reviews](review-recommendations-access-reviews.md)
- [Learn more about Microsoft Security Copilot](/copilot/security/microsoft-security-copilot)