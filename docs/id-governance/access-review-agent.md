---
title: Microsoft Security Copilot Access Review Agent in Microsoft Entra
description: Learn how the Access Review Agent, with Microsoft Security Copilot, can help secure your organization through recommendations based on your data.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id-governance
ms.subservice: access-reviews
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 07/17/2025

#CustomerIntent: As a Security Administrator, I want to set up the Access Review Agent so that Security Copilot can be used to help complete access reviews for users in my organization.
---

# Access Review Agent
Say goodbye to time-consuming research and the uncertainty of rushed decisions. The Access Review Agent works for your reviewers by automatically gathering insights and generating recommendations. It then guides reviewers through the review process in Microsoft Teams with natural language, with simple summaries and proposed decisions, so they can make the final call with confidence and clarity.

:::image type="content" source="media/access-review-agent/access-review-agent-prompt.png" alt-text="Screenshot of the initial prompt in the access review agent chat.":::

## Prerequisites
- You must have [Microsoft Entra ID Governance or Microsoft Entra Suite licenses](licensing-fundamentals.md).
- You must [Onboard to Security Copilot](/copilot/security/get-started-security-copilot#onboarding-to-security-copilot) with at least one [security compute unit (SCU)](/copilot/security/manage-usage) provisioned.
   - Completing an access review that includes 20 decisions consumes on average one SCU. This includes the agent gathering insights and generating recommendations and the reviewer's natural language conversation in Microsoft Teams with the agent. The SCU consumption can vary based on the conversation length between the reviewer and agent.
- Admins must have at least **all** the following roles to set up and manage the agent in the Microsoft Entra admin center:
   - [Identity Governance  Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator)
   - [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator)
   - [Security Copilot Contributor](/copilot/security/authentication#assign-security-copilot-access)
- For reviewers to use the Access Review Agent, they must have access to Microsoft Teams and must have an active access review assigned to them. They must also have at least the [Security Copilot Contributor](/copilot/security/authentication#assign-security-copilot-access) role assigned to them.
- Review [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security)

### Limitations
- Avoid using an account to set up the agent that requires role activation with Privileged Identity Management (PIM). Using an account that doesn't have standing permissions can cause authentication failures for the agent.
- Once agents are started, they can't be stopped or paused. It might take a few minutes to run.
- The agent runs using the identity of the administrator who activated it for the first time to gather insights and save recommendations. Final decisions, as part of the Microsoft Teams conversation, is written with the reviewer’s identity.
- We recommend running the agent from the Microsoft Entra admin center.

## Supported Scenarios
The following tables show current Access Review Agent support based on review scenarios:

| Scenario |Supported  |
|---------|---------|
|**Resources**  |  |
|Teams + Groups     |   :white_check_mark:       |
|Access package assignment     |    :white_check_mark:      |
|Application assignment        |   :white_check_mark:       |
|Azure resource roles          |    ❌                        |
|Microsoft Entra roles         |   ❌                         |
|Groups managed by Privileged Identity Management         |   ❌                         |
|**Size**  |  |
|Up to 35 decisions (per review, not reviewer)     |  :white_check_mark:       |
|>35 decisions per review     |   ❌       |
|**Stages**  |  |
|Single Stage     |  :white_check_mark:       |
|Multi-stage     |   ❌       |
|**Reviewers**  |  |
|Specific     |   :white_check_mark:       |
|Group owners     |  :white_check_mark:        |
|Managers     |  :white_check_mark:        |
|Self-reviews     |  ❌    |

## How it works
The Access Review Agent proactively scans for active access reviews in your tenant that are flagged for processing by the agent. The agent then analyzes identified reviews by gathering extra insights, and generates a recommendation (approve / deny) and a justification summary for each decision. Once the agent analyzes the recommendations and corresponding justification summaries, it's able to guide reviewers, in natural language, through the review process in Microsoft Teams. Reviewers are empowered to complete their reviews through the natural language chat experience in Microsoft Teams. As the agent guides them through the review, they're able to review the agent's reasoning behind the recommendations, ask questions in the context of the review itself, and finally make their own informed decision.

The agents recommendation (approve / deny) for each decision relies on a deterministic scoring mechanism powered by multiple signals. The signals used for the recommendation are then used to provide an end-user friendly justification summary powered by a large language model (LLM). The subsequent natural language chat experience in Microsoft Teams is facilitated by the large language model with previously generated recommendations and justification summaries as available context.

The agent considers the following signals:

- **User inactivity**: If the user has [signed in](review-recommendations-access-reviews.md#inactive-user-recommendations)
- **User-to-Group affiliation**: If the user has a [low affiliation](review-recommendations-access-reviews.md#user-to-group-affiliation) with other users who have this access
- **Account enabled**: If the user's account is enabled (accountEnabled property)
- **Employment status**: If the user's employment ended ([employeeLeaveDateTime property](/graph/tutorial-lifecycle-workflows-set-employeeleavedatetime))
- **Lifecycle workflow history**: If the user has had a mover workflow ran for them in the past 30 days
- **Decisions from previous reviews**: For recurring reviews, decisions from previous review iterations are considered
- **Access request history**: For access package assignment reviews, the request and approval history is considered

> [!NOTE]
> The justification summary includes information from these signals and is available to the reviewer during the review process even though some of this information isn't available to reviewers outside of the review process.

As an admin you're able to review the recommendations (approve / deny) and justification summaries. For details see, [Access Review Agent logs and metrics (Preview)](access-review-agent-logs-metrics.md). Note the agent recommendations can differ from the recommendations shown on the My Access portal and Access Review experience in the Microsoft Entra admin center.

## Getting started
### Setting up the Access Review Agent
1. With an account that has at least **all** the following roles, sign in to the [Microsoft Entra admin center](https://entra.microsoft.com):
   - [Identity Governance  Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator)
   - [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator)
   - [Security Copilot Contributor](/copilot/security/authentication#assign-security-copilot-access)
1. From the new home page, select **Go to agents** from the agent notification card.
   - You can also select **Agents** from the left navigation menu.
   :::image type="content" source="media/access-review-agent/start-access-review-agent.png" alt-text="Screenshot of starting the Access Review Agent.":::
1. Select **View details** on the Access Review Agent tile.
    
1. Select **Start agent** to begin your first run. 
   - Avoid using an account with a role activated through PIM.
   - A message that says "*The agent is starting its first run*" appears in the upper-right corner.
   - The first run might take a few minutes to complete.

### Enable the access review agent for existing access reviews

After the Access Review Agent is started, you must flag access reviews to be processed by the Access Review Agent. The Access Review Agent is able to process both new, and existing, access reviews. The following sections walk you through flagging access review to be processed by the Access Review Agent.

#### Enable the access review agent for existing group and application access reviews

To update an existing access review to be processed by the Access Review Agent, perform the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Access reviews**.

1. Select the access review you want the agent to support.

1. On the access review overview page, select **Settings** under Manage if it's a one time review, or **Settings** under Series if it's a recurring review.

1. Under **Advanced Settings**, check the box on the setting that says **Access Review Agent (Preview)**.

1. Select **Save**. 

#### Enable the Access Review Agent for existing access package assignment reviews

To update an existing access review to be processed by the Access Review Agent, perform the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Entitlement management** > **Access package**.

1. Select the access package you want the agent to support.

1. On the access package overview page, select **Policies**, then select the policy you want to update and select **Edit**.

1. On the edit policy page, select **Lifecycle**.

1. On the lifecycle tab, select Advanced Access Review settings and check the **Enable** box on the setting that says **Access Review Agent (Preview)**.

1. Select **Save**.    

### Ensure reviewers can use the Access Review Agent

Reviewers access the Access Review Agent through a [Microsoft Teams App](https://teams.microsoft.com/l/app/b99caf01-1dd7-43cf-981a-0de444e783f3). If your organizations' [Microsoft Teams org-wide app settings](/microsoftteams/manage-apps#manage-org-wide-app-settings) allow Microsoft applications no action is required. If your organization has disabled Microsoft apps in the Microsoft Teams org-wide app settings your organizations' Microsoft Teams administrator must explicitly approve the app.

You must also ensure that all reviewers have at least the [Security Copilot Contributor](/copilot/security/authentication#assign-security-copilot-access) role so that they can use the agent to complete their reviews. This is required because the natural language conversation in Microsoft Teams is opening a Microsoft Security Copilot session behind the scenes. Participating reviewers access the agentic experience via Microsoft Teams, but with the role assignment they'll be entitled to access the [Security Copilot portal](https://securitycopilot.microsoft.com/) or the Security Copilot experience in other Microsoft Security administrative portals. If reviewers access Security Copilot outside of Microsoft Teams, their data access with Security Copilot is still subject to [default user permissions](../fundamentals/users-default-permissions.md).

## Using the Access Review Agent as a reviewer

With the Access Review Agent started, reviewers assigned proper permissions, and with the app available to them, your reviewers are now ready to complete their reviews with the help of the agent. The Access Review Agent can be accessed directly within Microsoft Teams ([direct link](https://teams.microsoft.com/l/app/b99caf01-1dd7-43cf-981a-0de444e783f3)). The access review email notifications sent to reviewers will also include a direct link to Microsoft Teams.

1. Open your Microsoft Teams application signed in as the user assigned as a reviewer.

1. Select the [Access Review Agent](https://teams.microsoft.com/l/app/b99caf01-1dd7-43cf-981a-0de444e783f3) link to open the agent

1. On the Apps page, search **Access Review Agent**, and select **Add**.
    :::image type="content" source="media/access-review-agent/access-review-agent-teams.png" alt-text="Screenshot of the Access Review Agent application in Microsoft Teams.":::
1. Once the agent is added, select **Open**.
1. When open, you can select the available prompt to start the chat with the agent
     :::image type="content" source="media/access-review-agent/access-review-agent-prompt.png" alt-text="Screenshot of the initial prompt in the access review agent chat.":::

## Settings

Once the agent is enabled, you can adjust a few settings. You can access the settings by doing the following in the Microsoft Entra admin center:

- From **Agents** > **Access Review Agent** > **Settings**.

### Trigger

The agent is configured to run every 24 hours based on when it's initially configured. You can run it at a specific time by toggling the **Trigger** setting off, and then back on when you want it to run.

   :::image type="content" source="media/access-review-agent/access-review-agent-trigger.png" alt-text="Screenshot of the Access Review Agent trigger.":::

> [!NOTE]
> If reviewers immediately respond to their access review email notifications, the agent might not have yet processed the review. Only after the agent runs is it able to assist with access reviews in Microsoft Teams. If you respond before the agent has processed the review,  the agent responds with the following message to the reviewer in Microsoft Teams: '*I don't see any pending reviews that I can help you with at this time. Because my capabilities are still expanding, I recommend you check the My Access Portal to see if you have any other pending reviews.*'. 

## Removing the agent 

If you no longer wish to use the Access Review Agent, select **Remove agent** from the top of the agent window. The existing agent activity and metrics are removed but recommendations and justifications for already processed reviews are retained by the agent in Microsoft Teams and continue to be able to assist reviewers with these reviews. To complete the removal, you should also unflag the access reviews previously flagged to be processed by the agent.

### Disable the access review agent for existing group and application access reviews

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Access Reviews**.

1. Select the access review that has agent support enabled.

1. On the access review overview page, select **Settings** under Manage if it's a one time review, or **Settings** under Series if it's a recurring review.

1. Under **Advanced Settings**, uncheck the box on the setting that says **Access Review Agent (Preview)**.

1. Select **Save**. 

### Disable the Access Review Agent for existing access package assignment reviews

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Entitlement management** > **Access package**.

1. Select the access package you want the agent to support.

1. On the access package overview page, select **Policies**, then select the policy you want to update and select **Edit**.

1. On the edit policy page, select **Lifecycle**.

1. On the lifecycle tab, check the **Disable** box on the setting that says **Access Review Agent (Preview)**.

1. Select **Save**.

### Revoke Security Copilot access

You might want to revoke the [Security Copilot Contributor](/copilot/security/authentication#assign-security-copilot-access) access of reviewers if no other scenario requires them to access Security Copilot.

## Identity and permissions
The agent runs with the identity of the administrator who configured the agent to gather insights and save recommendations. Final decisions as part of the Microsoft Teams conversation will be written with the reviewer’s identity.

### Providing feedback

Use the **Give Microsoft feedback** button at the top of the agent window to provide feedback to Microsoft about the agent.

## FAQs

####  Why is the agent in Microsoft Teams responding with 'It looks like the Access Review Agent either has not yet been enabled for your organization or has encountered unexpected issues. Please contact your IT department for assistance. In the meantime, you can complete your pending reviews in the My Access Portal'?

If the agent responds with this message, it's likely the agent setup such as starting the agent, assigning reviewers Security Copilot access, and enabling the agent for existing reviews, isn't completed. 

#### Why is the agent in Microsoft Teams responding with 'Things are a bit busy at the moment, and I couldn't process your request right now. Could you please try again in a little while? If you're in a hurry, the My Access Portal is always available.'?

The agent responds with this message if your tenant is out of provisioned and overage Security Copilot capacity.

## Related content

- [Access Review Agent logs and metrics (Preview)](access-review-agent-logs-metrics.md)
- [Review recommendations for Access reviews](review-recommendations-access-reviews.md)
- [Learn more about Microsoft Security Copilot](/copilot/security/microsoft-security-copilot)
