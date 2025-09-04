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

# Microsoft Entra Access Review Agent
Say goodbye to time-consuming research and the uncertainty of rushed decisions. The Access Review Agent works for your reviewers by automatically gathering insights and generating recommendations.It then guides reviewers through the review process in Microsoft Teams with natural language, with simple summaries and proposed decisions, so they can make the final call with confidence and clarity.

:::image type="content" source="media/access-review-agent/access-review-agent-prompt.png" alt-text="Screenshot of the initial prompt in the access review agent chat.":::

## Prerequisites
- You must [Microsoft Entra ID Governance or Microsoft Entra Suite licenses](licensing-fundamentals.md).
- You must [Onboard to Security Copilot](/copilot/security/get-started-security-copilot#onboarding-to-security-copilot) with at least one [security compute unit (SCU)](/copilot/security/manage-usage) provisioned.
   - Completing an access review that includes 20 decisions consumes on average 1 SCU. This inlcudes the agent gathering insights and generating recommendations as well as the reviewer's natural language conversation in Microsoft Teams with the agent. The SCU consumption can vary based on the conversation length between the reviewer and agent.
- Admins must have at least **all** the following roles to setup and manage the agent in the Microsoft Entra admin center:
   - [Identity Governance  Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator)
   - [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator)
   - [Security Copilot Contributor](/copilot/security/authentication#assign-security-copilot-access)
- For reviewers to leverage the Access Review Agent they must have access to Microsoft Teams and must have an active access review assigned to them and have at least the [Security Copilot Contributor](/copilot/security/authentication#assign-security-copilot-access) role.
- Review [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security)

### Limitations
- Avoid using an account to set up the agent that requires role activation with Privileged Identity Management (PIM). Using an account that doesn't have standing permissions can cause authentication failures for the agent.
- Once agents are started, they can't be stopped or paused. It might take a few minutes to run.
- The agent runs using the identity of the administrator who activated it for the first time to gather insights and save recommendations. Final decisions, as part of the Microsoft Teams conversation, is written with the reviewer’s identity.
- We recommend running the agent from the Microsoft Entra admin center.

## Supported Scenarios
The following tables show current Access Review Agent support based on review scenarios:
### Resources
|Review Scenario  |Supported  |
|---------|---------|
|Teams + Groups     |   :white_check_mark:       |
|Access package assignment     |    :white_check_mark:      |
|Application assignment        |   :white_check_mark:       |
|Azure resource roles          |    ❌                        |
|Microsoft Entra roles         |   ❌                         |
|Groups managed by Privileged Identity Management         |   ❌                         |
### Review Size
|Review Scenario  |Supported  |
|---------|---------|
|Up to 35 decisions (per review, not reviewer)     |  :white_check_mark:       |
|>35 decisions per review     |   ❌       |
### Review stages
|Review Scenario  |Supported  |
|---------|---------|
|Single Stage     |  :white_check_mark:       |
|Two Stages     |   ❌       |
|Three Stages     |   ❌       |
### Reviewer Settings
|Review Scenario  |Supported  |
|---------|---------|
|Specific     |   :white_check_mark:       |
|Group Owners     |  :white_check_mark:        |
|Managers     |  :white_check_mark:        |
|Self-review     |  ❌    |

## How it works
The Access Review Agent proactively scans access reviews, and assists reviewers in making informed decisions about the access for users in your environment. 

The agent, which reviewers communicate with directly via a [Microsoft Teams](/microsoftteams/teams-overview) chat, uses user context to help inform decisions. 

When providing review recommendations, the agent provides details that led to the recommendations, allowing reviewers to review the reasoning used and make their own decisions with the information provided.

Each time the agent runs, it takes the following steps. **The initial scanning steps do not consume any SCUs.**

1. The agent scans all access reviews in your tenant.
1. The agent analyzes the data, such as their activity, of users being reviewed.
1. The agent reviews previous access review decisions to help inform its recommendations.

If the agent identifies something that wasn't previously suggested, it takes the following steps. **These action steps consume SCUs.**

1. The agent evaluates access review durations, and recommends that the reviewer reviews the access review expiring earlier first.
1. The agent identifies that a user is no longer active and recommends revoking access.
1. The agent identifies that a user is still active and using resources, the access review agent recommends approving access.

The agent considers the following about a user when making review recommendations:

- **Activity**: If the user has signed in([SignInActivity](/graph/api/resources/signinactivity)) the past 30 days.
- **User-to-Group affiliation**: If the user has a [low affiliation](review-recommendations-access-reviews.md) with other users who has the access being requested.
- **Account enabled**: If the user's account is enabled(accountEnabled).
- **Employment status**: If the user's employment ended([employeeLeaveDateTime](/graph/tutorial-lifecycle-workflows-set-employeeleavedatetime))
- **Lifecycle workflow history**: If the user has had a mover workflow ran for them in the past 30 days
- **Previous reviews**: If the user being reviewed is part of a recurring review, decisions from previous review iterations or access package assignments are considered.

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

1. On the access review overview page, select **Settings** under Manage if its a one time review, or **Settings** under Series if it is a recurring review.

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

With the Access Review Agent started, reviewers assigned proper permissions, and with the app available to them, your reviewers are now ready to complete their reviews with the help of the agent. The Access Review Agent can be accessed directly within Microsoft Teams ([direct link](https://teams.microsoft.com/l/app/b99caf01-1dd7-43cf-981a-0de444e783f3)). The access review email notifications sent to reviewers will also inlcude a direct link to Microsoft Teams.

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
> If reviewers immediately action their access review email notifications the agent may have not yet processed the review, only after the agent's run it will be able to assist in Microsoft Teams. In this case the agent will respond with the following message to the reviewer in Microsoft Teams: 'I don't see any pending reviews that I can help you with at this time. Because my capabilities are still expanding, I recommend you check the My Access Portal to see if you have any other pending reviews.'. 

## Removing the agent 

If you no longer wish to use the Access Review Agent, select **Remove agent** from the top of the agent window. The existing agent activity and metrics are removed but recommendations and justifications for already processed reviews are retained the agent in Microsoft Teams will continue to be able to assists reviewers with these reviews. To complete the removal you should also unflag the access reviews prevously flagged to be processed by the agent.

### Disable the access review agent for existing group and application access reviews

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Access Reviews**.

1. Select the access review that has agent support enabled.

1. On the access review overview page, select **Settings** under Manage if its a one time review, or **Settings** under Series if it is a recurring review.

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

You may want to revoke the [Security Copilot Contributor](/copilot/security/authentication#assign-security-copilot-access) access of reviewers if no other scenario requires them to access Security Copilot.

### Providing feedback

Use the **Give Microsoft feedback** button at the top of the agent window to provide feedback to Microsoft about the agent.

## FAQs

###  Why is the agent in Microsoft Teams responding with 'It looks like the Access Review Agent either has not yet been enabled for your organization or has encountered unexpected issues. Please contact your IT department for assistance. In the meantime, you can complete your pending reviews in the My Access Portal'?

### Why is the agent in Microsoft Teams responding with 'Things are a bit busy at the moment, and I couldn't process your request right now. Could you please try again in a little while? If you're in a hurry, the My Access Portal is always available.'?

## Related content

- [Access Review Agent logs and metrics (Preview)](access-review-agent-logs-metrics.md)
- [Review recommendations for Access reviews](review-recommendations-access-reviews.md)
- [Learn more about Microsoft Security Copilot](/copilot/security/microsoft-security-copilot)
