---
title: Microsoft Entra Conditional Access optimization agent
description: Learn how the Microsoft Entra Conditional Access optimization agent can help secure your organization.
ms.author: joflore
author: MicrosoftGuyJFlo

ms.date: 04/21/2025
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
- You must have at least Microsoft Entra ID P1.
- You must have available [security compute units (SCU)](/copilot/security/manage-usage). On average, each agent run consumes 3 SCUs.

### Limitations

- During the preview, avoid using an account to setup the agent that requires role activation with Privileged Identity Management. Using an account that doesn't have standing permissions may cause authentication failures for the agent.
- Once agents are started they can't be stopped or paused. It may take a few minutes to run.
- The agent currently runs as the user who enables it.
- In preview you should only run the agent from the Microsoft Entra admin center.

## Getting started

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator).
1. From the new home page, select **Try now** from the agent notification card, review the details, then select **Start agent** to begin your first run. 

   :::image type="content" source="media/agent-optimization/conditional-access-optimization-agent-try-now.png" alt-text="Screenshot" lightbox="media/agent-optimization/conditional-access-optimization-agent-try-now.png":::

1. When the agent overview page loads, you'll see the **Agent status**, **Triggers**, **Recent suggestions** and **Recent activity**

   :::image type="content" source="media/agent-optimization/conditional-access-optimization-agent-overview.png" alt-text="Screenshot" lightbox="media/agent-optimization/conditional-access-optimization-agent-overview.png":::

1. Selecting a suggestion provides you with more detail to back up the suggestion, along with the ability to review the changes in the policy viewer or in JSON format.

   :::image type="content" source="media/agent-optimization/conditional-access-optimization-agent-suggestion.png" alt-text="Screenshot" lightbox="media/agent-optimization/conditional-access-optimization-agent-suggestion.png":::

1. Newly created policies are created in report-only mode and exclude the user who executes the agent by default. Organizations should as a best practice exclude their break-glass accounts from policy to avoid being locked out due to misconfiguration.
   1. Policies created by the agent are tagged with **Conditional Access Optimization Agent** in the Conditional Access policies pane.

## Reviewing results

The agent might run and:

- Not identify any unprotected users or recommend any changes
- Suggest creation of a new Conditional Access policy in report-only mode
- Suggest adding newly created users to an existing polcy

## Remove agent

If you no longer wish to use the Conditional Access optimization agent, you can remove it using the **Settings** tab of the agent.

## Related content

[Conditional Access policy templates](concept-conditional-access-policy-common.md?tabs=secure-foundation#template-categories)
