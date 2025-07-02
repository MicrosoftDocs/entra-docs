---
title: Microsoft Entra Conditional Access optimization agent
description: Learn how the Microsoft Entra Conditional Access optimization agent with Microsoft Security Copilot can help secure your organization.
ms.author: joflore
author: MicrosoftGuyJFlo

ms.date: 06/09/2025

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
---
# Microsoft Entra Conditional Access optimization agent with Microsoft Security Copilot


The Conditional Access optimization agent helps you ensure all users are protected by policy. It recommends policies and changes based on best practices aligned with [Zero Trust](/security/zero-trust/deploy/identity) and Microsoft's learnings. 

In preview, the Conditional Access optimization agent evaluates policies such as requiring multifactor authentication (MFA), enforcing device based controls (device compliance, app protection policies, and domain-joined devices), and blocking legacy authentication and device code flow.

The agent also evaluates all existing enabled policies to propose potential consolidation of similar policies.

## Prerequisites

- You must have at least the [Microsoft Entra ID P1](overview.md#license-requirements) license.
- You must have available [security compute units (SCU)](/copilot/security/manage-usage).
   - On average, each agent run consumes less than one SCU.
- To activate the agent the first time, you need the [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator) or [Global Administrator](../role-based-access-control/permissions-reference.md#global-administrator) role during the preview.
- You can assign [Conditional Access Administrators](../role-based-access-control/permissions-reference.md#conditional-access-administrator) with Security Copilot access, which gives your Conditional Access Administrators the ability to use the agent as well.
   - For more information, see [Assign Security Copilot access](/copilot/security/authentication#assign-security-copilot-access)
- Device-based controls require [Microsoft Intune licenses](/intune/intune-service/fundamentals/licenses).
- Review [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security)

### Limitations

- During the preview, avoid using an account to set up the agent that requires role activation with Privileged Identity Management (PIM). Using an account that doesn't have standing permissions might cause authentication failures for the agent.
- Once agents are started, they can't be stopped or paused. It might take a few minutes to run.
- For policy consolidation, each agent run only looks at four similar policy pairs.
- The agent currently runs as the user who enables it.
- In preview, you should only run the agent from the Microsoft Entra admin center.
- Scanning is limited to a 24 hour period.
- Suggestions from the agent can't be customized or overridden.

## Conditional Access optimization agent key features

The Conditional Access optimization agent scans your tenant for new users and applications and determines if Conditional Access policies are applicable. In preview, the key features include:

- **Require MFA**: The agent identifies users who aren't covered by a Conditional Access policy that requires MFA and can update the policy.
- **Require device-based controls**: The agent can enforce device-based controls, such as device compliance, app protection policies, and domain-joined devices.
- **Block legacy authentication**: User accounts with legacy authentication are blocked from signing in.
- **Policy consolidation**: The agent scans your policy and identifies overlapping settings. For example, if you have more than one policy that has the same grant controls, the agent suggests consolidating those policies into one.
- **Block device code flow**: The agent looks for a policy blocking device code flow authentication.
- **One-click remediation**: When the agent identifies a suggestion, you can select **Apply suggestion** to have the agent update the associated policy with one click.

## Getting started

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator).
1. From the new home page, select **Go to agents** from the agent notification card then select **View details** under the Conditional Access Optimization Agent.

   :::image type="content" source="media/agent-optimization/conditional-access-optimization-agent-try-now.png" alt-text="Screenshot of the Microsoft Entra admin center showcasing the new Security Copilot agents experience." lightbox="media/agent-optimization/conditional-access-optimization-agent-try-now.png":::

1. Select **Run agent** to begin your first run. 

   :::image type="content" source="media/agent-optimization/agent-optimization-start-agent.png" alt-text="Screenshot showing the Conditional Access Optimization Agent configuration page." lightbox="media/agent-optimization/agent-optimization-start-agent.png":::

1. When the agent overview page loads, any suggestions appear at the top. You can also see the recent activity 
and performance highlights.

   :::image type="content" source="media/agent-optimization/agent-optimization-overview-activity.png" alt-text="Screenshot showing recent activity of the Conditional Access optimization agent." lightbox="media/agent-optimization/agent-optimization-overview-activity.png":::

1. Select **Review suggestion** to see the details of the suggestion. Next steps on this page include the following options:
   - **Apply suggestion**: The agent can apply the suggested changes to the policy with one click.
   - **Review policy changes**: Review the policy changes before applying them.
   - **Policy impact**: Displays a visualization of the potential impact of the policy. For more information, see [Policy impact](concept-conditional-access-report-only.md#reviewing-results).

   :::image type="content" source="media/agent-optimization/agent-optimization-require-mfa-details.png" alt-text="Screenshot of the details of a policy suggestion." lightbox="media/agent-optimization/agent-optimization-require-mfa-details.png":::

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

> [!TIP]
> - Policies created by the agent are tagged with **Conditional Access Optimization Agent** in the Conditional Access policies pane.
> - Newly created policies are created in report-only mode. As a best practice organizations should exclude their break-glass accounts from policy to avoid being locked out due to misconfiguration.

## Reviewing results

The agent might run and:

- Not identify any unprotected users or recommend any changes
- Suggest creation of a new Conditional Access policy in report-only mode
- Suggest adding newly created users to an existing policy

> [!WARNING]
> Policies in report-only mode that require a compliant device might prompt users on macOS, iOS, and Android devices to select a device certificate during policy evaluation, even though device compliance isn't enforced. These prompts might repeat until the device is compliant. To prevent end users from receiving prompts during sign-in, exclude device platforms Mac, iOS, and Android from report-only policies that perform device compliance checks.

### Providing feedback

Use the **Give Microsoft feedback** button at the top of the agent window to provide feedback to Microsoft about the agent.

## Settings

Once the agent is enabled, you can adjust a few settings. You can access the settings from two places in the Microsoft Entra admin center:

- From **Agents** > **Conditional Access optimization agent** > **Settings**.
- From **Conditional Access** > select the **Conditional Access optimization agent** card under **Policy summary** > **Settings**.

### Trigger

The agent is configured to run every 24 hours based on when it's initially configured. You can run it at a specific time by toggling the **Trigger** setting off and then back on when you want it to run.

:::image type="content" source="media/agent-optimization/agent-optimization-trigger-toggle.png" alt-text="Screenshot of the trigger option in the Conditional Access Optimization agent settings." lightbox="media/agent-optimization/agent-optimization-trigger-toggle.png":::

### Objects

Use the checkboxes under **Objects** to specify what the agent should monitor when making policy recommendations. By default the agent looks for both new users and applications in your tenant over the previous 24 hour period.

### Identity and permissions

The agent runs under the identity and permissions of the *user who enabled the agent in your tenant*. Because of this requirement, you should avoid using an account that requires elevation like those that use PIM for just-in-time elevation.

The Security Administrator and Global Administrator roles also have access to Security Copilot by default.

You can assign Conditional Access Administrators with Security Copilot access. This authorization gives your Conditional Access Administrators the ability to use the agent as well. For more information, see [Assign Security Copilot access](/copilot/security/authentication#assign-security-copilot-access).

### Custom instructions

You can tailor the policy to your needs using the optional **Custom Instructions** field. This setting allows you to provide a prompt to the agent as part of its execution. For example: "The user "Break Glass" should be excluded from policies created." Custom instructions can be used to include or exclude users, groups, and roles. This can be used to exclude them from consideration entirely or for a specific scenario and can also be used to add exceptions to the suggested policy. 

## Remove agent

If you no longer wish to use the Conditional Access optimization agent, you can remove it using the **Remove agent** button at the top of the agent window.

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
| Troubleshoot a user’s access (Why was Alice prompted for MFA?) |  | ✅ |

### I activated the agent but see "Fail" in the activity status. What's happening?

It's possible that the agent was enabled with an account that requires role activation with Privileged Identity Management (PIM). So when the agent attempted to run, it failed because the account didn't have the required permissions at that time. You are prompted to reauthenticate if PIM permission expired. You can resolve this issue by removing the agent, then enabling the agent again with a user account that has standing permissions for Security Copilot access. For more information, see [Assign Security Copilot access](/copilot/security/authentication#assign-security-copilot-access).

## Related content

- [Conditional Access policy templates](concept-conditional-access-policy-common.md?tabs=secure-foundation#template-categories)
- [Learn more about Microsoft Security Copilot](/copilot/security/microsoft-security-copilot)
