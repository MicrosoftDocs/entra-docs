---
title: Microsoft Entra Conditional Access optimization agent
description: Learn how the Microsoft Entra Conditional Access optimization agent with Microsoft Security Copilot can help secure your organization.
ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: lhuangnorth

ms.date: 08/12/2025

ms.update-cycle: 180-days
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.custom: security-copilot
ms.collection: msec-ai-copilot
---
# Microsoft Entra Conditional Access optimization agent with Microsoft Security Copilot

The Conditional Access optimization agent helps you ensure all users and applications are protected by Conditional Access policies. It recommends policies and changes based on best practices aligned with [Zero Trust](/security/zero-trust/deploy/identity) and Microsoft's learnings. 

The Conditional Access optimization agent evaluates policies such as requiring multifactor authentication (MFA), enforcing device based controls (device compliance, app protection policies, and domain-joined devices), and blocking legacy authentication and device code flow. The agent also evaluates all existing enabled policies to propose potential consolidation of similar policies. When the agent identifies a suggestion, you can have the agent update the associated policy with one click-remediation.

> [!IMPORTANT]
> The chat capability in the Conditional Access Optimization agent is currently in PREVIEW.
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Prerequisites

- You must have at least the [Microsoft Entra ID P1](overview.md#license-requirements) license.
- You must have available [security compute units (SCU)](/copilot/security/manage-usage).
   - On average, each agent run consumes less than one SCU.
- To activate the agent the first time, you need the [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator) or [Global Administrator](../role-based-access-control/permissions-reference.md#global-administrator).
- You can assign [Conditional Access Administrators](../role-based-access-control/permissions-reference.md#conditional-access-administrator) with Security Copilot access, which gives your Conditional Access Administrators the ability to use the agent as well.
   - For more information, see [Assign Security Copilot access](/copilot/security/authentication#assign-security-copilot-access)
- [Security Reader](../../identity/role-based-access-control/permissions-reference.md#security-reader) and [Global Reader](../../identity/role-based-access-control/permissions-reference.md#global-reader) roles can view the agent and any suggestions, but can't take any actions.
- [Conditional Access Administrator](../../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator), [Security Administrator](../../identity/role-based-access-control/permissions-reference.md#security-administrator), and [Global Administrator](../../identity/role-based-access-control/permissions-reference.md#global-administrator) roles can view the agent and take action on the suggestions.
- Device-based controls require [Microsoft Intune licenses](/intune/intune-service/fundamentals/licenses).
- Review [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security)

### Limitations

- Avoid using an account to set up the agent that requires role activation with Privileged Identity Management (PIM). Using an account that doesn't have standing permissions might cause authentication failures for the agent.
- Once agents are started, they can't be stopped or paused. It might take a few minutes to run.
- For policy consolidation, each agent run only looks at four similar policy pairs.
- The agent currently runs as the user who enables it.
- We recommend running the agent from the Microsoft Entra admin center.
- Scanning is limited to a 24 hour period.
- Suggestions from the agent can't be customized or overridden.
- The agent can review up to 300 users and 150 applications in a single run.

## How it works

The Conditional Access optimization agent scans your tenant for new users and applications from the last 24 hours and determines if Conditional Access policies are applicable. If the agent finds users or applications that aren't protected by Conditional Access policies, it provides suggested next steps, such as turning on or modifying a Conditional Access policy. You can review the suggestion, how the agent identified the solution, and what would be included in the policy.

Each time the agent runs, it takes the following steps. **The initial scanning steps do not consume any SCUs.**

1. The agent scans all Conditional Access policies in your tenant.
1. The agent checks for policy gaps and if any policies can be combined.
1. The agent reviews previous suggestions so it won't suggest the same policy again.

If the agent identifies something that wasn't previously suggested, it takes the following steps. **The agent action steps consume SCUs.**

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

1. Select **Start agent** to begin your first run. 
   - Avoid using an account with a role activated through PIM.
   - A message that says "The agent is starting its first run" appears in the upper-right corner.
   - The first run might take a few minutes to complete.

   :::image type="content" source="media/agent-optimization/start-agent.png" alt-text="Screenshot showing the Conditional Access Optimization start agent page." lightbox="media/agent-optimization/start-agent.png":::

When the agent overview page loads, any suggestions appear in the **Recent suggestions** box. If a suggestion was identified, you can review the policy, determine policy impact, and apply the changes if needed. For more information, see [Review and approve Conditional Access agent suggestions](agent-optimization-review-suggestions.md).

   :::image type="content" source="media/agent-optimization/review-suggestions.png" alt-text="Screenshot of agent summary and recent suggestions with the review suggestion buttons highlighted." lightbox="media/agent-optimization/review-suggestions.png":::

## Settings

Once the agent is enabled, you can adjust a few settings. You can access the settings from two places in the Microsoft Entra admin center:

- From **Agents** > **Conditional Access optimization agent** > **Settings**.
- From **Conditional Access** > select the **Conditional Access optimization agent** card under **Policy summary** > **Settings**.

### Agent capabilities

By default, the Conditional Access optimization agent can create new policies *in report-only mode*. You can change this setting so that an administrator must approve the new policy before it's created. The policy is still created in report-only mode, but only after admin approval. After reviewing the policy impact, you can turn on the policy directly from the agent experience or from Conditional Access.

### Trigger

The agent is configured to run every 24 hours based on when it's initially configured. You can run it at a specific time by toggling the **Trigger** setting off and then back on when you want it to run.

:::image type="content" source="media/agent-optimization/trigger-setting.png" alt-text="Screenshot of the trigger option in the Conditional Access Optimization agent settings." lightbox="media/agent-optimization/trigger-setting.png":::

### Microsoft Entra objects to monitor

Use the checkboxes under **Microsoft Entra objects to monitor** to specify what the agent should monitor when making policy recommendations. By default the agent looks for both new users and applications in your tenant over the previous 24 hour period.

### Agent capabilities

By default, the Conditional Access optimization agent can create new policies in report-only mode. You can change this setting so that an administrator must approve the new policy before it's created. The policy is still created in report-only mode, but only after admin approval. After reviewing the policy impact, you can turn on the policy directly from the agent experience or from Conditional Access.

### Phased rollout (preview)

When the agent creates a new policy in report-only mode, the policy is rolled out in phases, so you can control and monitor the effect of the new policy. Phased rollout is on by default.

You can change the number of days between each phase by either dragging the slider or entering a number of days in the text box. After making any changes, select the **Save** button at the bottom of the page. The number of days between each phase is the same for all phases. Make sure you're starting the phased rollout with enough time to monitor the impact before the next phase starts and so the rollout doesn't start on a weekend or holiday, in case you need to pause the rollout.

:::image type="content" source="media/agent-optimization/phased-rollout-settings.png" alt-text="Screenshot of the phased rollout settings in the Conditional Access Optimization agent settings." lightbox="media/agent-optimization/phased-rollout-settings.png":::

### Identity and permissions

There are several key points to consider regarding the identity and permissions of the agent:

- The agent runs under the identity and permissions of the *user who enabled the agent in your tenant*.
- Avoid using an account that requires elevation through PIM for just-in-time elevation. If that user hasn't elevated to the appropriate role when the agent runs, the run fails.
- The Security Administrator and Global Administrator roles have access to Security Copilot by default. You can assign Conditional Access Administrators with Security Copilot access. This authorization gives your Conditional Access Administrators the ability to use the agent as well. For more information, see [Assign Security Copilot access](/copilot/security/authentication#assign-security-copilot-access).
- The user who approves a suggestion to add users to a policy becomes an owner of a new group that adds the users to a policy. 
- The audit logs for actions taken by the agent are associated with the user who enabled the agent. You can find the name of the account that started the agent in the **Identity and permissions** section of the settings.

    :::image type="content" source="media/agent-optimization/identity-permissions.png" alt-text="Screenshot of the identity and permissions section in the Conditional Access Optimization agent settings." lightbox="media/agent-optimization/identity-permissions.png":::

### Custom instructions

You can tailor the policy to your needs using the optional **Custom Instructions** field. This setting allows you to provide a prompt to the agent as part of its execution. These instructions can be used to include or exclude specific users, groups, and roles. Custom instructions can be used to exclude objects from being considered by the agent altogether or added to the Conditional Access policy itself. Exceptions can be applied to specific policies, such as excluding a specific group from a policy, such as requiring MFA or mobile application management policies. 

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
