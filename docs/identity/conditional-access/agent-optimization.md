---
title: Microsoft Entra Conditional Access optimization agent
description: Learn how the Microsoft Entra Conditional Access optimization agent with Microsoft Security Copilot can help secure your organization.
ms.author: joflore
author: MicrosoftGuyJFlo

ms.date: 07/02/2025

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
---
# Microsoft Entra Conditional Access optimization agent with Microsoft Security Copilot

The Conditional Access optimization agent helps you ensure all users are protected by policy. It recommends policies and changes based on best practices aligned with [Zero Trust](/security/zero-trust/deploy/identity) and Microsoft's learnings. 

In preview, the Conditional Access optimization agent evaluates policies such as requiring multifactor authentication (MFA), enforcing device based controls (device compliance, app protection policies, and domain-joined devices), and blocking legacy authentication and device code flow. The agent also evaluates all existing enabled policies to propose potential consolidation of similar policies. When the agent identifies a suggestion, you can have the agent update the associated policy with one click-remediation.

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

## How it works

The Conditional Access optimization agent scans your tenant for new users and applications and determines if Conditional Access policies are applicable. If the agent finds users or applications that aren't protected by Conditional Access policies, it provides suggested next steps, such as creating or modifying a Conditional Access policy. You can review the suggestion, how the agent identified the solution, and what would be included in the policy.

In preview, the policy suggestions identified by the agent include:

- **Require MFA**: The agent identifies users who aren't covered by a Conditional Access policy that requires MFA and can update the policy.
- **Require device-based controls**: The agent can enforce device-based controls, such as device compliance, app protection policies, and domain-joined devices.
- **Block legacy authentication**: User accounts with legacy authentication are blocked from signing in.
- **Block device code flow**: The agent looks for a policy blocking device code flow authentication.
- **Policy consolidation**: The agent scans your policy and identifies overlapping settings. For example, if you have more than one policy that has the same grant controls, the agent suggests consolidating those policies into one.

> [!IMPORTANT]
> The agent only provides the suggestion. It doesn't create or modify policies unless an administrator explicitly approves the suggestion.
>
> All new policies suggested by the agent are created in report-only mode. 

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
   - Running the agent doesn't apply any changes.

   :::image type="content" source="media/agent-optimization/start-agent.png" alt-text="Screenshot showing the Conditional Access Optimization agent start agent page." lightbox="media/agent-optimization/start-agent.png":::

1. When the agent overview page loads, any suggestions appear in the **Recent suggestions** box. If a suggestion was identified, select **Review suggestion** to see the details, review the policy, determine policy impact, and apply the changes if needed. These options are covered in detail in the [Reviewing results](#reviewing-results) section.

   :::image type="content" source="media/agent-optimization/review-suggestions.png" alt-text="Screenshot of agent summary and recent suggestions with the review suggestion buttons highlighted." lightbox="media/agent-optimization/review-suggestions.png":::

## Reviewing results

The agent might run and:

- Not identify any unprotected users or recommend any changes
- Suggest creating a new Conditional Access policy in report-only mode
- Suggest modifying an existing policy
- Suggest consolidating overlapping policies

When you select **Review suggestion**, you're provided a thorough overview of the suggestion, including the logic used to identify the suggestion and the potential impact of the policy.

### Policy impact

From the details panel that opens, select **Policy impact** to see a visualization of the potential impact of the policy.

:::image type="content" source="media/agent-optimization/policy-impact-button.png" alt-text="Screenshot of the policy suggestion details with the policy impact button highlighted." lightbox="media/agent-optimization/policy-impact-button.png":::

Adjust the filters and the display as needed. Select a point on the graph to see a sample of the data that would be affected by the policy. For example, for a policy to require multifactor authentication (MFA), the graph shows a sample of sign-in events where the Conditional Access policy wasn't applied. For more information, see [Policy impact](concept-conditional-access-report-only.md#reviewing-results).

### View agent's full activity

To see a detailed summary of the agent's activity and how it calculated the suggestion, select **View agent's full activity**. 

:::image type="content" source="media/agent-optimization/view-agent-activity-link.png" alt-text="Screenshot of the policy suggestion details with the view agent's full activity link highlighted." lightbox="media/agent-optimization/view-agent-activity-link.png":::

The **Summary of agent activity** is a natural language description of the activity that's illustrated in the **Agent activity map**. These details can help you understand the logic behind the suggestion so you can make an informed decision about whether to apply the suggestion. 

### Review and apply suggestions

The experience for reviewing and applying the suggestion depends on whether the agent suggests modifying an existing policy or creating a new policy. 

If the agent suggests modifying an existing policy:

- Select **Review policy changes** to see the details of the recommended change. This page lists the users, target resources, and other details of the policy that will change if you apply the suggestion.

   :::image type="content" source="media/agent-optimization/require-multifactor-authentication-details.png" alt-text="Screenshot of the policy suggestion details to require multifactor authentication for all users." lightbox="media/agent-optimization/require-multifactor-authentication-details-expanded.png":::

- Select **JSON view** from the **Review policy changes** page to see the policy in JSON format, with the changes highlighted. 

- Select **Approve suggested changes** or **Apply suggestion** to have the agent apply the changes to the policy.

If the agent suggests creating a new policy:

- Select **Apply suggestion** to have the agent apply the changes to the policy *in report-only mode*.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

> [!TIP]
> As a best practice, organizations should exclude their break-glass accounts from policy to avoid being locked out due to misconfiguration.

> [!WARNING]
> Policies in report-only mode that require a compliant device might prompt users on macOS, iOS, and Android devices to select a device certificate during policy evaluation, even though device compliance isn't enforced. These prompts might repeat until the device is compliant. To prevent end users from receiving prompts during sign-in, exclude device platforms Mac, iOS, and Android from report-only policies that perform device compliance checks.

## Audit and policy logs 

Policies created or modified by the agent are tagged with **Conditional Access Optimization Agent** in the Conditional Access policies pane.

:::image type="content" source="media/agent-optimization/created-by-conditional-access-optimization-agent.png" alt-text="Screenshot of the details of a policy suggestion." lightbox="media/agent-optimization/created-by-conditional-access-optimization-agent-expanded.png":::

In the **Audit logs** the **Initiated by (actor)** field show the name of the user who started the agent.

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

The agent runs under the identity and permissions of the *user who enabled the agent in your tenant*. Because of this requirement, you should avoid using an account that requires elevation like those that use PIM for just-in-time elevation. The audit logs for actions taken by the agent are associated with the user who enabled the agent.

The Security Administrator and Global Administrator roles also have access to Security Copilot by default.

You can assign Conditional Access Administrators with Security Copilot access. This authorization gives your Conditional Access Administrators the ability to use the agent as well. For more information, see [Assign Security Copilot access](/copilot/security/authentication#assign-security-copilot-access).

### Custom instructions

You can tailor the policy to your needs using the optional **Custom Instructions** field. This setting allows you to provide a prompt to the agent as part of its execution. For example: "The user "Break Glass" should be excluded from policies created." Custom instructions can be used to include or exclude users, groups, and roles. This can be used to exclude them from consideration entirely or for a specific scenario and can also be used to add exceptions to the suggested policy. 

## Remove agent

If you no longer wish to use the Conditional Access optimization agent, select **Remove agent** from the top of the agent window. The existing data (agent activity, suggestions, and metrics) is removed but any policies created or updated based on the agent suggestions remain intact. Previously applied suggestions remain unchanged so you can continue to use the policies created or modified by the agent.

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
