---
title: Microsoft Entra Conditional Access optimization agent
description: Learn how the Microsoft Entra Conditional Access optimization agent with Microsoft Security Copilot can help secure your organization.
ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: lhuangnorth

ms.date: 09/30/2025

ms.update-cycle: 180-days
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.custom: security-copilot
ms.collection: msec-ai-copilot
---
# Microsoft Entra Conditional Access optimization agent

The Conditional Access optimization agent helps you ensure all users and applications are protected by Conditional Access policies. The agent can recommend new policies and update existing policies, based on best practices aligned with [Zero Trust](/security/zero-trust/deploy/identity) and Microsoft's learnings. The agent also creates policy review reports (Preview), which provide insights into spikes or dips that might indicate a policy misconfiguration.

The Conditional Access optimization agent evaluates policies such as requiring multifactor authentication (MFA), enforcing device based controls (device compliance, app protection policies, and domain-joined devices), and blocking legacy authentication and device code flow. The agent also evaluates all existing enabled policies to propose potential consolidation of similar policies. When the agent identifies a suggestion, you can have the agent update the associated policy with one click-remediation.

> [!IMPORTANT]
> The chat capability and policy reports in the Conditional Access optimization agent are currently in PREVIEW.
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Prerequisites

- You must have at least the [Microsoft Entra ID P1](overview.md#license-requirements) license.
- You must have available [security compute units (SCU)](/copilot/security/manage-usage).
   - On average, each agent run consumes less than one SCU.
- You must have the appropriate Microsoft Entra role.
   - [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator) is required to *activate the agent the first time*.
   - [Security Reader](../../identity/role-based-access-control/permissions-reference.md#security-reader) and [Global Reader](../../identity/role-based-access-control/permissions-reference.md#global-reader) roles can *view the agent and any suggestions, but can't take any actions*.
   - [Conditional Access Administrator](../../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) and [Security Administrator](../../identity/role-based-access-control/permissions-reference.md#security-administrator) roles can *view the agent and take action on the suggestions*.
   - You can assign [Conditional Access Administrators](../role-based-access-control/permissions-reference.md#conditional-access-administrator) with Security Copilot access, which gives your Conditional Access Administrators the ability to use the agent as well.
   - For more information, see [Assign Security Copilot access](/copilot/security/authentication#assign-security-copilot-access).
- Device-based controls require [Microsoft Intune licenses](/intune/intune-service/fundamentals/licenses).
- Review [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security).
   
### Limitations

- Avoid using an account to set up the agent that requires role activation with Privileged Identity Management (PIM). Using an account that doesn't have standing permissions might cause authentication failures for the agent.
- Once agents are started, they can't be stopped or paused. It might take a few minutes to run.
- For policy consolidation, each agent run only looks at four similar policy pairs.
- We recommend running the agent from the Microsoft Entra admin center.
- Scanning is limited to a 24 hour period.
- Suggestions from the agent can't be customized or overridden.
- The agent can review up to 300 users and 150 applications in a single run.

## How it works

The Conditional Access optimization agent scans your tenant for new users and applications from the last 24 hours and determines if Conditional Access policies are applicable. If the agent finds users or applications that aren't protected by Conditional Access policies, it provides suggested next steps, such as turning on or modifying a Conditional Access policy. You can review the suggestion, how the agent identified the solution, and what would be included in the policy.

Each time the agent runs, it takes the following steps. **These initial scanning steps do not consume any SCUs.**

1. The agent scans all Conditional Access policies in your tenant.
1. The agent checks for policy gaps and if any policies can be combined.
1. The agent reviews previous suggestions so it won't suggest the same policy again.

If the agent identifies something that wasn't previously suggested, it takes the following steps. **These agent action steps consume SCUs.**

1. The agent identifies a policy gap or a pair of policies that can be consolidated.
1. The agent evaluates any custom instructions you provided.
1. The agent creates a new policy in report-only mode or provides the suggestion to modify a policy, including any logic provided by the custom instructions.

> [!TIP]
> Two policies can be consolidated if they differ by no more than two conditions or controls.

The policy suggestions identified by the agent include:

- **Require MFA**: The agent identifies users who aren't covered by a Conditional Access policy that requires MFA and can update the policy.
- **Require device-based controls**: The agent can enforce device-based controls, such as device compliance, app protection policies, and domain-joined devices.
- **Block legacy authentication**: User accounts with legacy authentication are blocked from signing in.
- **Block device code flow**: The agent looks for a policy blocking device code flow authentication.
- **Risky users**: The agent suggests a policy to require secure password change for high risk users. Requires Microsoft Entra ID P2 license.
- **Risky sign-ins**: The agent suggests a policy to require multifactor authentication for high risk sign-ins. Requires Microsoft Entra ID P2 license.
- **Policy consolidation**: The agent scans your policy and identifies overlapping settings. For example, if you have more than one policy that has the same grant controls, the agent suggests consolidating those policies into one.
- **Deep analysis**: The agent looks at policies that correspond to key scenarios to identify outlier policies that have more than a recommended number of exceptions (leading to unexpected gaps in coverage) or no exceptions (leading to possible lockout). 

> [!IMPORTANT]
> The agent doesn't make any changes to existing policies unless an administrator explicitly approves the suggestion.
>
> All *new* policies suggested by the agent are created in report-only mode. 

## Getting started

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator).
1. From the new home page, select **Go to agents** from the agent notification card.
   - You can also select **Agents** from the left navigation menu.

   :::image type="content" source="media/agent-optimization/go-to-agents.png" alt-text="Screenshot of the Microsoft Entra admin center showcasing the new Security Copilot agents experience." lightbox="media/agent-optimization/go-to-agents.png":::

1. Select **View details** on the Conditional Access Optimization Agent tile.

   :::image type="content" source="media/agent-optimization/view-details.png" alt-text="Screenshot of the Conditional Access agent tile with the view details button highlighted." lightbox="media/agent-optimization/view-details.png":::

1. Select **Start agent** to begin your first run. Avoid using an account with a role activated through PIM.

   :::image type="content" source="media/agent-optimization/start-agent.png" alt-text="Screenshot showing the Conditional Access Optimization start agent page." lightbox="media/agent-optimization/start-agent.png":::

When the agent overview page loads, any suggestions appear in the **Recent suggestions** box. If a suggestion was identified, you can review the policy, determine policy impact, and apply the changes if needed. For more information, see [Review and approve Conditional Access agent suggestions](agent-optimization-review-suggestions.md).

   :::image type="content" source="media/agent-optimization/review-suggestions.png" alt-text="Screenshot of agent summary and recent suggestions with the review suggestion buttons highlighted." lightbox="media/agent-optimization/review-suggestions.png":::

## Settings

Once the agent is enabled, you can adjust a few settings. After making any changes, select the **Save** button at the bottom of the page. You can access the settings from two places in the Microsoft Entra admin center:

- From **Agents** > **Conditional Access optimization agent** > **Settings**.
- From **Conditional Access** > select the **Conditional Access optimization agent** card under **Policy summary** > **Settings**.

:::image type="content" source="media/agent-optimization/agent-settings.png" alt-text="Screenshot of the trigger option in the Conditional Access Optimization agent settings." lightbox="media/agent-optimization/agent-settings.png":::

### Agent capabilities

By default, the Conditional Access optimization agent can create new policies *in report-only mode*. You can change this setting so that an administrator must approve the new policy before it's created. The policy is still created in report-only mode, but only after admin approval. After reviewing the policy impact, you can turn on the policy directly from the agent experience or from Conditional Access.

### Trigger

The agent is configured to run every 24 hours based on when it's initially configured. You can change when the agent runs by toggling the **Trigger** setting off and then back on when you want it to run.

### Microsoft Entra objects to monitor

Use the checkboxes under **Microsoft Entra objects to monitor** to specify what the agent should monitor when making policy recommendations. By default the agent looks for both new users and applications in your tenant over the previous 24 hour period.

### Agent capabilities

By default, the Conditional Access optimization agent can create new policies in report-only mode. You can change this setting so that an administrator must approve the new policy before it's created. The policy is still created in report-only mode, but only after admin approval. After reviewing the policy impact, you can turn on the policy directly from the agent experience or from Conditional Access.

### Phased rollout

When the agent creates a new policy in report-only mode, the policy is rolled out in phases, so you can monitor the effect of the new policy. Phased rollout is on by default.

You can change the number of days between each phase by either dragging the slider or entering a number in the text box. The number of days between each phase is the same for all phases. Make sure you're starting the phased rollout with enough time to monitor the impact before the next phase starts and so the rollout doesn't start on a weekend or holiday, in case you need to pause the rollout.

:::image type="content" source="media/agent-optimization/phased-rollout-settings.png" alt-text="Screenshot of the phased rollout settings in the Conditional Access Optimization agent settings." lightbox="media/agent-optimization/phased-rollout-settings.png":::

### Identity and permissions

There are several key points to consider regarding the identity and permissions of the agent:

- The agent runs under the identity and permissions of the *user who enabled the agent in your tenant*.
- Avoid using an account that requires elevation through PIM for just-in-time elevation. If that user hasn't elevated to the appropriate role when the agent runs, the run fails.
- Security Administrator has access to Security Copilot by default. You can assign Conditional Access Administrators with Security Copilot access. This authorization gives your Conditional Access Administrators the ability to use the agent as well. For more information, see [Assign Security Copilot access](/copilot/security/authentication#assign-security-copilot-access).
- The user who approves a suggestion to add users to a policy becomes an owner of a new group that adds the users to a policy. 
- The audit logs for actions taken by the agent are associated with the user who enabled the agent. You can find the name of the account that started the agent in the **Identity and permissions** section of the settings.

   :::image type="content" source="media/agent-optimization/identity-permissions.png" alt-text="Screenshot of the identity and permissions section in the Conditional Access Optimization agent settings." lightbox="media/agent-optimization/identity-permissions.png":::

### ServiceNow integration

Organizations that use the [ServiceNow plugin for Security Copilot](/copilot/security/plugin-servicenow) can now have the Conditional Access optimization agent create ServiceNow incidents for each new suggestion the agent generates. This allows IT and security teams to track, review, and approve or reject agent suggestions within existing ServiceNow workflows. At this time, only change requests (CHG) are supported.

To use the ServiceNow integration, your organization must have the [ServiceNow plugin](/copilot/security/plugin-servicenow) configured.

:::image type="content" source="media/agent-optimization/agent-service-now-integration-setting.png" alt-text="Screenshot of the ServiceNow integration settings." lightbox="media/agent-optimization/agent-service-now-integration-setting.png":::

When the ServiceNow plugin is turned on in the Conditional Access optimization agent settings, each new suggestion from the agent creates a ServiceNow incident. The incident includes details about the suggestion, such as the type of policy, the users or groups affected, and the rationale behind the recommendation. The integration also provides a feedback loop: The agent monitors the state of the ServiceNow incident and can automatically implement the change when the incident is approved.

:::image type="content" source="media/agent-optimization/agent-service-now-integration-ticket.png" alt-text="Screenshot of the ServiceNow integration within an agent suggestion." lightbox="media/agent-optimization/agent-service-now-integration-ticket.png":::

### Custom instructions

You can tailor the policy to your needs using the optional **Custom Instructions** field. This setting allows you to provide a prompt to the agent as part of its execution. These instructions can be used to:

- Include or exclude specific users, groups, and roles
- Exclude objects from being considered by the agent or added to the Conditional Access policy 
- Apply exceptions to specific policies, such as excluding a specific group from a policy, requiring MFA, or requiring mobile application management policies. 

You can enter either the name or the object ID in the custom instructions. Both values are validated. If you add the name of the group, the object ID for that group is automatically added on your behalf. Example custom instructions:

- "Exclude users in the "Break Glass" group from any policy that requires multifactor authentication."
- "Exclude user with Object ID dddddddd-3333-4444-5555-eeeeeeeeeeee from all policies"

A common scenario to consider is if your organization has lots of guest users that you don't want the agent to suggest adding to your standard Conditional Access policies. If the agent runs and sees new guest users that aren't covered by recommended policies, SCUs are consumed to suggest covering those guest users by policies that aren't necessary. To prevent guest users from being considered by the agent:

1. Create a dynamic group called "Guests" where `(user.userType -eq "guest")`.
1. Add a custom instruction, based on your needs.
    - "Exclude the "Guests" group from agent consideration."
    - "Exclude the "Guests" group from any mobile application management policies."

For more information about how to use custom instructions, check out the following video. 

> [!VIDEO 5879a0f7-3644-4e34-a8ce-b186b8e5f128]

Please note that some of the content in the video, such as the user interface elements, is subject to change as the agent is updated frequently.

## Intune integration

The Conditional Access Optimization Agent integrates with Microsoft Intune to monitor device compliance and application protection policies configured in Intune and identify potential gaps in Conditional Access enforcement. This proactive and automated approach ensures that Conditional Access policies remain aligned with organizational security goals and compliance requirements. The agent suggestions are the same as the other policy suggestions, except that Intune provides part of the signal to the agent.

Agent suggestions for Intune scenarios cover specific user groups and platforms (iOS or Android). For example, the agent identifies an active Intune app protection policy that targets the "Finance" group, but determines there isn't a sufficient Conditional Access policy that enforces app protection. The agent creates a report-only policy that requires users to access resources only through compliant applications on iOS devices.

To identify Intune device compliance and app protection policies, the agent must be running as a Global Administrator or Conditional Access Administrator AND Global Reader. Conditional Access Administrator is not sufficient on its own for the agent to produce Intune suggestions.

## Remove agent

If you no longer wish to use the Conditional Access optimization agent, select **Remove agent** from the top of the agent window. The existing data (agent activity, suggestions, and metrics) is removed but any policies created or updated based on the agent suggestions remain intact. Previously applied suggestions remain unchanged so you can continue to use the policies created or modified by the agent.

### Providing feedback

Use the **Give Microsoft feedback** button at the top of the agent window to provide feedback to Microsoft about the agent.

## FAQs

### When should I use the Conditional Access optimization agent vs Copilot Chat?

Both features provide different insights into your Conditional Access policies. The following table provides a comparison of the two features:

| Scenario | Conditional Access Optimization Agent | Copilot Chat |
|----------|---------------------------------------|--------------|
| **Generic Scenarios** |||
| Utilize tenant-specific configuration | ✅ |  |
| Advanced reasoning | ✅ |  |
| On-demand insights |  | ✅ |
| Interactive troubleshooting |  | ✅ |
| Continuous policy assessment | ✅ |  |
| Automated improvement suggestions | ✅ |  |
| Get guidance on CA best practices and configuration | ✅ | ✅ |
| **Specific Scenarios** |||
| Identify unprotected users or applications proactively | ✅ |  |
| Enforce MFA and other baseline controls for all users | ✅ |  |
| Continuous monitoring and optimization of CA policies | ✅ |  |
| One-click policy changes | ✅ |  |
| Review existing CA policies and assignments (Do policies apply to Alice?) | ✅ | ✅ |
| Troubleshoot a user's access (Why was Alice prompted for MFA?) |  | ✅ |

### I activated the agent but see "Fail" in the activity status. What's happening?

It's possible that the agent was enabled with an account that requires role activation with Privileged Identity Management (PIM). So when the agent attempted to run, it failed because the account didn't have the required permissions at that time. You're prompted to reauthenticate if PIM permission expired.
          
You can resolve this issue by removing the agent, then enabling the agent again with a user account that has standing permissions for Security Copilot access. For more information, see [Assign Security Copilot access](/copilot/security/authentication#assign-security-copilot-access).

## Related content

- [Review and approve agent suggestions](agent-optimization-review-suggestions.md)
- [Conditional Access policy templates](concept-conditional-access-policy-common.md?tabs=secure-foundation#template-categories)
- [Learn more about Microsoft Security Copilot](/copilot/security/microsoft-security-copilot)
