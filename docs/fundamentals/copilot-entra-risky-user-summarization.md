---
# required metadata

title: Investigate risky users with Microsoft Copilot in Microsoft Entra 
description: Use Microsoft Copilot in Microsoft Entra to quickly respond to identity threats by summarizing the risk level for a user, receiving insights relevant to the incident, and getting customized mitigation recommendations for those types of attack.
keywords:
author: rwike77
ms.author: ryanwi
manager: celestedg
ms.date: 02/09/2024
ms.topic: conceptual
ms.service: active-directory
ms.subservice: fundamentals
ms.workload: identity

# Customer intent: As a SOC analyst or IT admin, I want to learn about risky user summarization in the Identity Protection UX so that I can quickly respond to identity threats.
---

# Respond to identity threats using risky user summarization

Microsoft Entra ID Protection applies the capabilities of [Microsoft Copilot for Microsoft Entra](/security-copilot/microsoft-security-copilot) to summarize a user's risk level, provide insights relevant to the incident at hand, and provide recommendations on how to mitigate those types of attacks to quickly remediate identity-based risks. Identity risk investigation is a crucial step for IT admins and incident response teams to successfully defend an organization against damage from a cyber threat. Investigations can often be time-consuming since it involves numerous steps.

IT admins and security operations center (SOC) analysts can easily gain the right context to investigate and remediate identity risk and identity-based incidents through Copilot Microsoft Entra's correlation capabilities and data processing and contextualization.  With risky user summarization, remediations, and recommendations, admins and responders can quickly get important information and recommendations to help in their investigation.

Respond to identity threats quickly:
- Risk summary: Summarize in natural language why the user risk level was elevated.
- Remediation: Receive actionable insights tailored to the incident at hand to resolve the risk alert.
- Recommendations: Get a customized recommendation for how to mitigate against those types of attacks, with quick links to help and documentation.

This article describes how to access the risky user summarizing capability of Identity Protection and Copilot for Microsoft Entra.

## Investigate risky users

To view and investigate a user’s risky sign-ins, sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) and go to the [risky users report](https://aka.ms/entracopilotriskyuser) in the **Identity Protection** page.  Select a user from the risky users report.

:::image type="content" source="./media/copilot-entra-risky-user-summarization/risky-users-report.png" alt-text="Screenshot that shows the Identity Protection risky users report.":::

In the **Risky User Details** window, select **Summarize**.  

:::image type="content" source="./media/copilot-entra-risky-user-summarization/risky-user-details.png" alt-text="Screenshot that shows the Identity Protection risky user summarization details.":::

The risky user summary contains three sections:

- Summary by Copilot: summarizes in natural language why the user risk level was elevated.
- What to do: lists actionable insights tailored to the incident at hand to resolve the risk.
- Help and documentation: lists customized recommendation for how to mitigate against those types of attacks, with quick links to help and documentation.

In this example, suggested remediations are to create a sign-in risk based policy and user risk based [conditional access policies](/entra/id-protection/howto-identity-protection-configure-risk-policies).  Suggested help and documentation are [What is risk in ID Protection?](/entra/id-protection/concept-identity-protection-risks), [Incident Response Playbooks](/security/operations/incident-response-playbooks), [Risk-based Access Policies](/entra/id-protection/concept-identity-protection-policies).

## Next steps

- Learn more about [risky users](/entra/id-protection/howto-identity-protection-investigate-risk#risky-users).

