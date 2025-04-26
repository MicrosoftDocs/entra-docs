---
title: Microsoft Entra Conditional Access optimization agent
description: Learn how the Microsoft Entra Conditional Access optimization agent can help secure your organization.
ms.author: joflore
author: MicrosoftGuyJFlo

ms.date: 04/25/2025
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
---
# Microsoft Entra Conditional Access optimization agent

The Conditional Access optimization agent helps you ensure all users are protected by policy. It recommends policies and changes based on best practices aligned with [Zero Trust](/security/zero-trust/deploy/identity) and Microsoft's learnings. 

In preview, the agent evaluates policies requiring multifactor authentication (MFA), enforces device based controls (device compliance, app protection policies, and Domain Joined Devices), and blocks legacy authentication and device code flow. 

The agent also evaluates all existing enabled policies to propose potential consolidation of similar policies.

## Prerequisites

- You must be assigned the [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator) or [Global Administrator](../role-based-access-control/permissions-reference.md#global-administrator) role during the preview.
- You must have at least [Microsoft Entra ID P1](overview.md#license-requirements).
- You must have available [security compute units (SCU)](/copilot/security/manage-usage). On average, each agent run consumes less than one SCU.
- Device-based controls require [Microsoft Intune licenses](/intune/intune-service/fundamentals/licenses).

### Limitations

- During the preview, avoid using an account to set up the agent that requires role activation with Privileged Identity Management. Using an account that doesn't have standing permissions might cause authentication failures for the agent.
- Once agents are started, they can't be stopped or paused. It might take a few minutes to run.
- The agent is configured to run every 24 hours based on when it's initially configured. Toggling the trigger to off under the settings page of the agent and back on at a specific time reconfigures the agent to run at that time.
- For policy consolidation, each agent run only looks at four similar policy pairs
- The agent currently runs as the user who enables it.
- In preview, you should only run the agent from the Microsoft Entra admin center.

## Getting started

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator).
1. From the new home page, select **Go to agents** from the agent notification card. 

   :::image type="content" source="media/agent-optimization/conditional-access-optimization-agent-try-now.png" alt-text="Screenshot of the Microsoft Entra admin center showcasing the new Security Copilot agents experience." lightbox="media/agent-optimization/conditional-access-optimization-agent-try-now.png":::

1. Select **View details** under the Conditional Access Optimization Agent, then select **Start agent** to begin your first run. 

   :::image type="content" source="media/agent-optimization/conditional-access-optimization-start-agent.png" alt-text="Screenshot showing the Conditional Access Optimization Agent configuration page." lightbox="media/agent-optimization/conditional-access-optimization-start-agent.png":::

1. When the agent overview page loads, you see most recent and next scheduled runtimes, performance highlights, recent suggestions, and recent activity.

   :::image type="content" source="media/agent-optimization/conditional-access-optimization-agent-overview.png" alt-text="Screenshot showing the Conditional Access Optimization Agent enabled in an organization." lightbox="media/agent-optimization/conditional-access-optimization-agent-overview.png":::

1. Selecting a suggestion provides you with more detail to back up the suggestion, along with the ability to review the changes in the policy viewer or in JSON format.
1. Newly created policies are created in report-only mode. As a best practice organizations should exclude their break-glass accounts from policy to avoid being locked out due to misconfiguration.

> [!TIP]
> Policies created by the agent are tagged with **Conditional Access Optimization Agent** in the Conditional Access policies pane.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

## Reviewing results

The agent might run and:

- Not identify any unprotected users or recommend any changes
- Suggest creation of a new Conditional Access policy in report-only mode
- Suggest adding newly created users to an existing policy

### Providing feedback

Use the **Give Microsoft feedback** button at the top of the agent window to provide feedback to Microsoft about the agent.

## Remove agent

If you no longer wish to use the Conditional Access optimization agent, you can remove it using the **Remove agent** button at the top of the agent window.

## Related content

- [Conditional Access policy templates](concept-conditional-access-policy-common.md?tabs=secure-foundation#template-categories)
- [Learn more about Microsoft Security Copilot](/copilot/security/microsoft-security-copilot)
