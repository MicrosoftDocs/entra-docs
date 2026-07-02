---
title: Microsoft Entra Conditional Access Optimization Agent
description: Learn how the Microsoft Entra Conditional Access Optimization Agent with Microsoft Security Copilot can help secure your organization.
ms.reviewer: jodah

ms.date: 06/23/2026

ms.update-cycle: 180-days
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.custom: security-copilot, sfi-ga-nochange
ms.collection: msec-ai-copilot
---
# Microsoft Entra Conditional Access Optimization Agent

The Microsoft Entra Conditional Access Optimization Agent helps you ensure that all users, applications, and agent identities are protected by Conditional Access policies. The agent can recommend new policies and update existing policies, based on best practices aligned with [Zero Trust](/security/zero-trust/deploy/identity) and Microsoft's learnings. The agent also creates policy review reports (preview), which provide insights into spikes or dips that might indicate a policy misconfiguration.

The Conditional Access Optimization Agent evaluates policies such as:

- Requiring multifactor authentication (MFA).
- Enforcing device-based controls (device compliance, app protection policies, and domain-joined devices).
- Blocking legacy authentication and device code flow.

The agent also evaluates all existing enabled policies to propose potential consolidation of similar policies. When the agent identifies a suggestion, you can have the agent update the associated policy with one-click remediation.

> [!IMPORTANT]
> The ServiceNow integration and activity-based runs in the Conditional Access Optimization Agent are currently in preview. This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Prerequisites

- You must have at least the [Microsoft Entra ID P1](../identity/conditional-access/overview.md#license-requirements) license.
- You must have available [security compute units (SCUs)](/copilot/security/manage-usage). On average, each agent run consumes less than one SCU.
- You must have the appropriate Microsoft Entra role.
  - A [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) role is required to *activate the agent the first time*.
  - [Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader) and [Global Reader](../identity/role-based-access-control/permissions-reference.md#global-reader) roles can *view the agent and any suggestions, but can't take any action*.
  - [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) and [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) roles can *view the agent and take action on the suggestions*.
  - You can assign [Conditional Access Administrators](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) with Microsoft Security Copilot access, which gives your Conditional Access Administrators the ability to use the agent.
  - For more information about roles, see [Assign Security Copilot access](/copilot/security/authentication#assign-security-copilot-access).
- Device-based controls require [Microsoft Intune licenses](/intune/intune-service/fundamentals/licenses).
- Review [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security).

### Limitations

- After the agent starts, you can't stop or pause the run. It might take a few minutes to run.
- For policy consolidation, each agent run evaluates 40 similar policy pairs.
- We recommend running the agent from the Microsoft Entra admin center.
- Scanning is limited to a 24-hour period.
- You can't customize or override suggestions from the agent.
- The agent can review up to 300 users and 150 applications in a single run.

## How it works

The Conditional Access Optimization Agent scans your tenant for new users, applications, and agent identities from the last 24 hours and determines if Conditional Access policies are applicable. If the agent finds users, applications, or agent identities that Conditional Access policies don't cover, it provides suggested next steps.

A next step might be turning on or modifying a Conditional Access policy. You can review the suggestion, how the agent identified the solution, and what the policy would include.

Each time the agent runs, it takes the following steps. *These initial scanning steps don't consume any SCUs.*

1. The agent scans all Conditional Access policies in your tenant.
1. The agent checks for policy gaps and if any policies can be combined.
1. The agent reviews previous suggestions so that it won't suggest the same policy again.

If the agent identifies something that it didn't previously suggest, it takes the following steps. *These agent action steps consume SCUs.*

1. The agent identifies a policy gap or a pair of policies that can be consolidated.
1. The agent evaluates any custom instructions that you provided.
1. The agent creates a new policy in report-only mode or provides the suggestion to modify a policy, including any logic in the custom instructions.

> [!NOTE]
> Security Copilot requires that at least one SCU is provisioned in your tenant. That SCU is billed each month, even if you don't consume any SCUs. Turning off the agent doesn't stop the monthly billing for the SCU.

The policy suggestions from the agent include:

- **Require MFA**: The agent identifies users who aren't covered by a Conditional Access policy that requires MFA and can update the policy.
- **Require device-based controls**: The agent can enforce device-based controls, such as device compliance, app protection policies, and domain-joined devices.
- **Block legacy authentication**: User accounts with legacy authentication are blocked from signing in.
- **Block device code flow**: The agent looks for a policy that blocks device code flow.
- **Risky users**: The agent suggests a policy to require secure password change for high-risk users. Requires a Microsoft Entra ID P2 license.
- **Risky sign-ins**: The agent suggests a policy to require multifactor authentication for high-risk sign-ins. Requires a Microsoft Entra ID P2 license.
- **Risky agents**: The agent suggests a policy to block authentication for high-risk sign-ins. Requires a Microsoft Entra ID P2 license.
- **Agent-assisted flows (preview)**: The agent suggests a policy to block high-risk agent-assisted flows. Requires a Microsoft Entra ID P2 license.
- **Policy consolidation**: The agent scans your policy and identifies overlapping settings. For example, if you have more than one policy that has the same grant controls, the agent suggests consolidating those policies into one.
- **Deep analysis**: The agent evaluates policies that correspond to key scenarios to identify outlier policies that have more than a recommended number of exceptions (leading to unexpected gaps in coverage) or no exceptions (leading to possible lockout).
- **Deep analysis MFA gap analysis**: This analysis identifies users who aren't protected by any Conditional Access policy that requires MFA or authentication strengths. The agent evaluates both enabled and report-only policies across your entire tenant to calculate how many users fall outside MFA coverage. Common causes include users excluded from policies, missing from required groups, or falling through gaps between overlapping policies. The analysis also provides a sample of impacted users, prioritized by recent sign-in activity, so you can investigate the highest-risk gaps first.
- **Least-privileged access for agent identities (preview)**: The agent identifies agent identities with unused or overprivileged Microsoft Graph permissions. It then recommends least-privilege enforcement, such as removing unused permissions or replacing broad permissions with more specific ones.

> [!IMPORTANT]
> The agent doesn't make any changes to existing policies unless an administrator explicitly approves the suggestion.
>
> All *new* policies that the agent suggests are created in report-only mode.
>
> Two policies can be consolidated if they differ by no more than two conditions or controls.

## Getting started

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator).

1. On the new home page, select **Go to agents** from the agent notification card.

   You can also select **Security Copilot agents** from the left menu.

   :::image type="content" source="media/conditional-access-agent-optimization/go-to-agents.png" alt-text="Screenshot of the Microsoft Entra admin center that shows the new Security Copilot agents experience." lightbox="media/conditional-access-agent-optimization/go-to-agents.png":::

1. On the **Conditional Access Optimization Agent** tile, select **View details**.

   :::image type="content" source="media/conditional-access-agent-optimization/view-details.png" alt-text="Screenshot of the Conditional Access agent tile with the button for viewing details highlighted." lightbox="media/conditional-access-agent-optimization/view-details.png":::

1. Select **Start agent** to begin your first run.

   :::image type="content" source="media/conditional-access-agent-optimization/start-agent.png" alt-text="Screenshot that shows the button for starting an agent on the Conditional Access Optimization Agent pane." lightbox="media/conditional-access-agent-optimization/start-agent.png":::

On the **Overview** tab for the agent, any suggestions appear in the **Recent suggestions** box. You can then review the policy, determine policy impact, and apply the changes if needed. For more information, see [Review and apply suggestions from the Conditional Access Optimization Agent](./conditional-access-agent-optimization-review-suggestions.md).

:::image type="content" source="media/conditional-access-agent-optimization/review-suggestions.png" alt-text="Screenshot of an agent summary and recent suggestions, with buttons for reviewing suggestions highlighted." lightbox="media/conditional-access-agent-optimization/review-suggestions.png":::

## Settings

The agent includes several powerful settings to expand the capabilities while making them unique to your organization. You can configure the following capabilities on the **Settings** tab. For more information, see [Conditional Access Optimization Agent settings](conditional-access-agent-optimization-settings.md).

- Allow the agent to run automatically, every 24 hours.
- Enable [activity-based runs](conditional-access-agent-optimization-settings.md#trigger) to trigger the agent when relevant tenant changes occur (preview).
- Set the agent to check for changes to users and applications.
- Allow the agent to create policies in report-only mode.
- Allow the agent to [send notifications](conditional-access-agent-optimization-settings.md#notifications) through Microsoft Teams.
- Allow the agent to create [phased rollout plans](conditional-access-agent-optimization-phased-rollout.md).
- Enable [integration with ServiceNow](conditional-access-agent-optimization-settings.md#servicenow-integration-preview) for automatic ticket creation.
- Provide [knowledge sources](conditional-access-agent-optimization-settings.md#knowledge-sources) to the agent for organization-specific suggestions.

## Built-in integrations

The Conditional Access Optimization Agent can make policy suggestions for organizations that use Intune for device management and Global Secure Access for network access.

### Intune integration

The Conditional Access Optimization Agent integrates with Intune to:

- Monitor device compliance and application protection policies configured in Intune.
- Identify potential gaps in Conditional Access enforcement.

This proactive and automated approach ensures that Conditional Access policies remain aligned with organizational security goals and compliance requirements. The agent suggestions are the same as the other policy suggestions, except that Intune provides part of the signal to the agent.

Agent suggestions for Intune scenarios cover specific user groups and platforms (iOS or Android). For example, the agent identifies an active Intune policy for app protection that targets the Finance group, but it determines that no sufficient Conditional Access policy enforces app protection. The agent creates a report-only policy that requires users to access resources only through compliant applications on iOS devices.

To identify Intune device compliance and app protection policies, the agent must be running as a Global Administrator or Conditional Access Administrator *and* Global Reader. The Conditional Access Administrator role isn't sufficient on its own for the agent to produce Intune suggestions.

### Global Secure Access integration

Microsoft Entra Internet Access and Microsoft Entra Private Access (collectively known as Global Secure Access) integrate with the Conditional Access Optimization Agent to provide suggestions specific to your organization's network access policies. The suggestion **Turn on new policy to enforce Global Secure Access network access requirements** helps you align your Global Secure Access policies that include network locations and protected applications.

With this integration, the agent identifies users or groups that aren't covered by a Conditional Access policy to require access to corporate resources only through approved Global Secure Access channels. This policy requires users to connect to corporate resources by using the organization's secure Global Secure Access network before accessing corporate apps and data. Users who connect from unmanaged or untrusted networks are prompted to use the Global Secure Access client or web gateway. You can review sign-in logs to verify compliant connections.

### Microsoft Defender integration

Microsoft Defender integrates with the Conditional Access Optimization Agent to help turn recurring identity attack patterns into Conditional Access posture improvements. Instead of reacting to individual incidents, Defender analyzes identity-relevant signals across investigations and alerts, then aggregates them over a fixed time window. This aggregation surfaces repeated techniques and targeted user cohorts reacting to individual incidents.
 
For each consolidated pattern, Defender produces a structured threat insight that gives the agent context to evaluate posture. Defender provides threat context only; it doesn't include remediation logic or decide which Conditional Access policy to change.
 
The agent evaluates each insight against the tenant's existing Conditional Access policies to determine whether posture hardening is warranted. To minimize policy sprawl, the agent can recommend modifying an existing policy or creating a new report-only policy when no suitable policy exists. Recommendations include rationale and affected-user context so admins can review the change before approving it. If existing coverage already addresses the risk, the agent suppresses the recommendation.
 
Recommendations generated from Defender threat insights appear in the list with a **Linked to Defender** alert tag. The recommendation details include a Defender insight section with the context that contributed to it, and depending on your Microsoft Defender permissions, you can navigate to the related alerts or incidents. An admin always reviews and approves Defender-driven recommendations before any policy change takes effect.

## Agent removal

If you no longer want to use the Conditional Access Optimization Agent, select **Remove agent** at the top of the agent window. The existing data (agent activity, suggestions, and metrics) is removed, but any policies created or updated based on the agent suggestions remain intact. Previously applied suggestions remain unchanged, so you can continue to use the policies that the agent created or modified.

### Providing feedback

To provide feedback to Microsoft about the agent, use the **Give Microsoft feedback** button at the top of the agent window.

## FAQs

### When should I use the Conditional Access Optimization Agent vs. Copilot Chat?

The Conditional Access Optimization Agent and Microsoft Copilot Chat provide different insights into your Conditional Access policies. The following table compares the two features.

| Scenario | Conditional Access Optimization Agent | Copilot Chat |
| -------- | ------------------------------------- | ------------ |
| **Generic scenarios** | | |
| Tenant-specific configuration | ✅ | |
| Advanced reasoning | ✅ | |
| On-demand insights | | ✅ |
| Interactive troubleshooting | | ✅ |
| Continuous policy assessment | ✅ | |
| Automated improvement suggestions | ✅ | |
| Guidance on certificate authority (CA) best practices and configuration | ✅ | ✅ |
| **Specific scenarios** | | |
| Proactive identification of unprotected users or applications | ✅ | |
| Enforcement of MFA and other baseline controls for all users | ✅ | |
| Continuous monitoring and optimization of CA policies | ✅ | |
| One-click policy changes | ✅ | |
| Review of existing CA policies and assignments ("Do policies apply to Alice?") | ✅ | ✅ |
| Troubleshooting a user's access ("Why was Alice prompted for MFA?") | | ✅ |

### I activated the agent, but the activity status is Fail. What's happening?

It's possible that you activated the agent before Microsoft Ignite 2025 by using an account that required role activation with Privileged Identity Management (PIM). So when the agent attempted to run, it failed because the account didn't have the required permissions at that time. A Conditional Access Optimization Agent that was activated after November 17, 2025, no longer uses the identity of the user who activated it.

You can resolve this problem by migrating to [Microsoft Entra Agent ID](../agent-id/identity-professional/what-is-microsoft-entra-agent-id.md). Select **Create agent identity** from either the banner message on the agent page or the **Permissions** section of the agent settings.

## Related content

- [Review and approve agent suggestions](./conditional-access-agent-optimization-review-suggestions.md)
- [Conditional Access policy templates](../identity/conditional-access/concept-conditional-access-policy-common.md?tabs=secure-foundation#template-categories)
- [Learn more about Microsoft Security Copilot](/copilot/security/microsoft-security-copilot)
