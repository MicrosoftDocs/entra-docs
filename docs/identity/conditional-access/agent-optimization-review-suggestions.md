---
title: Review suggestions from the Conditional Access optimization agent
description: Learn how  to review and apply suggestions provided by the Security Copilot for Microsoft Entra optimization agent.
ms.author: sarahlipsey
author: shlipsey3

ms.date: 07/02/2025

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
---

# How to review and apply suggestions from the Conditional Access optimization agent

## Prerequisites

- You must have at least the [Microsoft Entra ID P1](overview.md#license-requirements) license.
- You must have available [security compute units (SCU)](/copilot/security/manage-usage).
   - On average, each agent run consumes less than one SCU.
- You can assign [Conditional Access Administrators](../role-based-access-control/permissions-reference.md#conditional-access-administrator) with Security Copilot access, which gives your Conditional Access Administrators the ability to use the agent as well.
   - For more information, see [Assign Security Copilot access](/copilot/security/authentication#assign-security-copilot-access)
- Review [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security)

### Limitations

- During the preview, avoid using an account to set up the agent that requires role activation with Privileged Identity Management (PIM). Using an account that doesn't have standing permissions might cause authentication failures for the agent.
- Once agents are started, they can't be stopped or paused. It might take a few minutes to run.
- For policy consolidation, each agent run only looks at four similar policy pairs.
- The agent currently runs as the user who enables it.
- In preview, you should only run the agent from the Microsoft Entra admin center.
- Scanning is limited to a 24 hour period.
- Suggestions from the agent can't be customized or overridden.

## Reviewing results

The agent might run and:

- Not identify any unprotected users or recommend any changes
- Suggest creating a new Conditional Access policy in report-only mode
- Suggest modifying an existing policy
- Suggest consolidating overlapping policies

When you select **Review suggestion**, you are provided a thorough overview of the suggestion, including the logic used to identify the suggestion and the potential impact of the policy.

### Policy impact

From the details panel that opens, select **Policy impact** to see a visualization of the potential impact of the policy.

:::image type="content" source="media/agent-optimization-review-suggestions/policy-impact-button.png" alt-text="Screenshot of the policy suggestion details with the policy impact button highlighted." lightbox="media/agent-optimization-review-suggestions/policy-impact-button.png":::

Adjust the filters and the display as needed. Select a point on the graph to see a sample of the data that would be affected by the policy. For example, for a policy to require multifactor authentication (MFA), the graph shows a sample of sign-in events where the Conditional Access policy wasn't applied. For more information, see [Policy impact](concept-conditional-access-report-only.md#reviewing-results).

### View agent's full activity

To see a detailed summary of the agent's activity and how it calculated the suggestion, select **View agent's full activity**. 

:::image type="content" source="media/agent-optimization-review-suggestions/view-agent-activity-link.png" alt-text="Screenshot of the policy suggestion details with the view agent's full activity link highlighted." lightbox="media/agent-optimization-review-suggestions/view-agent-activity-link.png":::

The **Summary of agent activity** is a natural language description of the activity that's illustrated in the **Agent activity map**. These details can help you understand the logic behind the suggestion so you can make an informed decision about whether to apply the suggestion. 

### Review and apply suggestions

The experience for reviewing and applying the suggestion depends on whether the agent suggests modifying an existing policy or creating a new policy. 

If the agent suggests modifying an existing policy:

- Select **Review policy changes** to see the details of the recommended change. This page lists the users, target resources, and other details of the policy that will change if you apply the suggestion.

    :::image type="content" source="media/agent-optimization-review-suggestions/require-multifactor-authentication-details.png" alt-text="Screenshot of the policy suggestion details to require MFA for all users." lightbox="media/agent-optimization-review-suggestions/require-multifactor-authentication-details-expanded.png":::

- Select **JSON view** from the **Review policy changes** page to see the policy in JSON format, with the changes highlighted. 

- Select **Approve suggested changes** or **Apply suggestion** to have the agent apply the changes to the policy.

If the agent suggests creating a new policy:

- Select **Apply suggestion** to have the agent apply the changes to the policy *in report-only mode*.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

> [!TIP]
> As a best practice organizations should exclude their break-glass accounts from policy to avoid being locked out due to misconfiguration.

> [!WARNING]
> Policies in report-only mode that require a compliant device might prompt users on macOS, iOS, and Android devices to select a device certificate during policy evaluation, even though device compliance isn't enforced. These prompts might repeat until the device is compliant. To prevent end users from receiving prompts during sign-in, exclude device platforms Mac, iOS, and Android from report-only policies that perform device compliance checks.