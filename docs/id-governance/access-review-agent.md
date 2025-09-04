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
Say goodbye to time-consuming research and the uncertainty of rushed decisions. The Access Review Agent works for your reviewers, automatically gathering insights and identifying potential risks. It then guides reviewers through the review process with simple summaries and proposed decisions, so they can make the final call with confidence and clarity.

:::image type="content" source="media/access-review-agent/access-review-agent-prompt.png" alt-text="Screenshot of the initial prompt in the access review agent chat.":::

## Prerequisites
- You must [Microsoft Entra ID Governance or Microsoft Entra Suite licenses](licensing-fundamentals.md).
- You must [Onboard to Security Copilot](/copilot/security/get-started-security-copilot#onboarding-to-security-copilot) with at least one [security compute unit (SCU)](/copilot/security/manage-usage) provisioned.
   - Completing an access review that includes 20 decisions consumes on average 1 SCU. This inlcudes the agent gathering insights and generating recommendations as well as the reviewer's natural language conversation in Microsoft Teams with the agent. The SCU consumption can vary based on the conversation length between the reviewer and agent.
- Admins must have at least **all** the following roles to setup and manage the agent in the Microsoft Entra admin center:
   - [Identity Governance  Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator)
   - [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator)
   - [Security Copilot Contributor](/copilot/security/authentication#assign-security-copilot-access)
- For reviewers to leverage the Access Review Agent in Microsoft Teams they must have an active access review assigned to them and have at least the [Security Copilot Contributor](/copilot/security/authentication#assign-security-copilot-access) role.
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
The Access Review Agent proactively scans access reviews, and assists reviewers in making informed decisions about the access for users in your environment. The agent, which reviewers communicate with directly via a [Microsoft Teams](/microsoftteams/teams-overview) chat, uses user context to help inform decisions. When providing review recommendations, the agent provides details that led to the recommendations, allowing reviewers to review the reasoning used and make their own decisions with the information provided.

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
1. With an account that has at least the [Security Copilot Contributor](/copilot/security/authentication#assign-security-copilot-access) role, sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) with both the [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator) and [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#lifecycle-workflows-administrator) roles, or with the [global administrator](../identity/role-based-access-control/permissions-reference.md#global-administrator) role.
1. From the new home page, select **Go to agents** from the agent notification card.
   - You can also select **Agents** from the left navigation menu.
   :::image type="content" source="media/access-review-agent/start-access-review-agent.png" alt-text="Screenshot of starting the Access Review Agent.":::
1. Select **View details** on the Access Review Agent tile.
    
1. Select **Start agent** to begin your first run. 
   - Avoid using an account with a role activated through PIM.
   - A message that says "*The agent is starting its first run*" appears in the upper-right corner.
   - The first run might take a few minutes to complete.

> [!NOTE]
> As both the agent admin, and reviewers, require at least the security copilot contributor role, it's recommended to assign this role to a group.

### Enable resources for use with the Access Review Agent

After the Access Review Agent is started, you must enable it on specific resources. The following sections walk you through enabling the Access Review Agent for use with different resources.

#### Enable the access review agent for existing group and application access reviews

The Access Review Agent is able to scan both new, and existing, access reviews. To Update an existing access review so that the agent scans it, do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Access reviews**.

1. Select the access review you want the agent to support.

1. On the access review overview page, select **Settings** under occurence if its a one time review, or **Settings** under Series if it is a recurring review.

1. Under **Advanced Settings**, check the **Enable** box on the setting that says **Access Review Agent (Preview)**.

1. Select **Save**. 

#### Enable the Access Review Agent for Access Package Assignments

To enable the agent to make recommendations on an existing access package, you'd do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Entitlement management** > **Access package**.

1. Select the access package you want the agent to support.

1. On the access package overview page, select **Policies**, then select the policy you want to update and select **Edit**.

1. On the edit policy page, select **Lifecycle**.

1. On the lifecycle tab, select Advanced Access Review settings and check the **Enable** box on the setting that says **Access Review Agent (Preview)**.

1. Select **Save**.    


### Ensure reviewers can use the Access Review Agent

The Access Review Agent is accessed through a published first-party [Microsoft Teams App](https://teams.microsoft.com/l/entity/b99caf01-1dd7-43cf-981a-0de444e783f3/conversations?tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47). Ensure that the app is [available to users within your organization](/microsoftteams/manage-apps#manage-org-wide-app-settings). Using the app also requires that reviewers use the [Microsoft Teams Public Preview](/microsoftteams/public-preview-doc-updates?tabs=new-teams-client).

With the app published and available, also ensure that all reviewers have at least the [Security Copilot Contributor](/copilot/security/authentication#assign-security-copilot-access) role so that they can use the agent to complete their reviews. This is required because the natural language conversation in Microsoft Teams is opening a Microsoft Security Copilot session behind the scenes. Participating reviewers access the agentic experience via Microsoft Teams, but with the role assignment they'll be entitled to access https://securitycopilot.microsoft.com/ or the Security Copilot experience in other Microsoft Security administrative portals. If reviewers access Security Copilot outside of Microsoft Teams, their data access with Security Copilot is still subject to [default user permissions](../fundamentals/users-default-permissions.md).

## Using the Access Review Agent as a reviewer

With the Access Review Agent started, reviewers assigned proper permissions, and with the app available to them, your reviewers are now ready to complete their reviews with the help of the agent. The Access Review Agent can be accessed directly from the Apps screen within Microsoft Teams, from a [direct link](https://teams.microsoft.com/l/entity/b99caf01-1dd7-43cf-981a-0de444e783f3/conversations?tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47), or from an email notification sent by an access review with the agent enabled when it's time for the review to be completed. The following steps walk you through accessing the agent directly from Microsoft Teams:

1. Open your Microsoft Teams application signed in as the user assigned as a reviewer.

1. Select **Apps**.

1. On the Apps page, search **Access Review Agent**, and select **Add**.
    :::image type="content" source="media/access-review-agent/access-review-agent-teams.png" alt-text="Screenshot of the Access Review Agent application in Microsoft Teams.":::
1. Once the agent is added, select **Open**.
1. When open, you can select the available prompt to start the chat with the agent
     :::image type="content" source="media/access-review-agent/access-review-agent-prompt.png" alt-text="Screenshot of the initial prompt in the access review agent chat.":::

From this chat, you're able to see decisions about your access reviews, the reasoning the agent made when making those decisions, and can reply so that the agent takes action based on your choices. 

## Settings

Once the agent is enabled, you can adjust a few settings. You can access the settings by doing the following in the Microsoft Entra admin center:

- From **Agents** > **Access Review Agent** > **Settings**.

### Trigger

The agent is configured to run every 24 hours based on when it's initially configured. You can run it at a specific time by toggling the **Trigger** setting off, and then back on when you want it to run.

   :::image type="content" source="media/access-review-agent/access-review-agent-trigger.png" alt-text="Screenshot of the Access Review Agent trigger.":::


## Removing the agent 

If you no longer wish to use the Access Review Agent, the following sections walk you through removing the agent from resources.


### Removing the agent from  an Access Review

When you remove the agent from accessing an access review, the existing data such as access review information and justifications for decisions are removed, but decisions made via conversations with the agent remains. You should disable the agent on the access reviews that had the agent enabled on them by doing the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Access Reviews**.

1. Select the access review that has agent support enabled.

1. On the access review overview page, select **Settings**.

1. Under **Advanced Settings**, check the **Disable** box on the setting that says **Access Review Agent (Preview)**.

1. Select **Save**. 

### Remove Agent From Access Package Assignments

To remove the agent from making recommendations on an existing access package assignment, you'd do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Browse to **ID Governance** > **Entitlement management** > **Access package**.

1. Select the access package you want the agent to support.

1. On the access package overview page, select **Policies**, then select the policy you want to update and select **Edit**.

1. On the edit policy page, select **Lifecycle**.

1. On the lifecycle tab, check the **Disable** box on the setting that says **Access Review Agent (Preview)**.

1. Select **Save**.    

### Providing feedback

Use the **Give Microsoft feedback** button at the top of the agent window to provide feedback to Microsoft about the agent.

## Related content

- [Access Review Agent logs and metrics (Preview)](access-review-agent-logs-metrics.md)
- [Review recommendations for Access reviews](review-recommendations-access-reviews.md)
- [Learn more about Microsoft Security Copilot](/copilot/security/microsoft-security-copilot)
