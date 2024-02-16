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
ms.service: entra
ms.custom: microsoft-copilot

# Customer intent: As a SOC analyst or IT admin, I want to learn about risky user summarization in the Identity Protection UX so that I can quickly respond to identity threats.
---

# Respond to identity threats using risky user summarization

Microsoft Entra ID Protection applies the capabilities of [Microsoft Copilot for Microsoft Entra](/security-copilot/microsoft-security-copilot) to summarize a user's risk level, provide insights relevant to the incident at hand, and provide recommendations for rapid mitigation. Identity risk investigation is a crucial step to defend an organization. Copilot for Microsoft Entra helps reduce the time to resolution by combining signals and data from multiple sources.

IT admins and security operations center (SOC) analysts can easily gain the right context to investigate and remediate identity risk and identity-based incidents through Microsoft Copilot.  With risky user summarization, these recommendations provide admins and responders quick access to important information and recommendations to aid their investigation.

Respond to identity threats quickly:
- Risk summary: summarize in natural language why the user risk level was elevated.
- Recommendations: get customized recommendations for how to mitigate against those types of attacks, with quick links to help and documentation.

This article describes how to access the risky user summarizing capability of Identity Protection and Copilot for Microsoft Entra.

## Investigate risky users

To view and investigate a user’s risky sign-ins:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a XYZ.
1. Navigate to **Protection** > **Identity Protection** and then to the [Risky users](https://aka.ms/entracopilotriskyuser) report.  
1. Select a user from the risky users report.

    :::image type="content" source="./media/copilot-entra-risky-user-summarization/risky-users-report.png" alt-text="Screenshot that shows the Identity Protection risky users report.":::

1. In the **Risky User Details** window, information appears in **Summarize**.  

:::image type="content" source="./media/copilot-entra-risky-user-summarization/risky-user-details.png" alt-text="Screenshot that shows the Identity Protection risky user summarization details.":::

The risky user summary contains three sections:

- Summary by Copilot: summarizes in natural language why the user risk level was elevated.
- What to do: lists actionable insights tailored to the incident at hand to resolve the risk.
- Help and documentation: lists customized recommendation for how to mitigate against those types of attacks, with quick links to help and documentation.

In this example, suggested remediations are to: 

- Create a sign-in risk based policy and user risk based [conditional access policies](/entra/id-protection/howto-identity-protection-configure-risk-policies).  

Suggested help and documentation are:
- [What is risk in ID Protection?](/entra/id-protection/concept-identity-protection-risks)
- [Incident Response Playbooks](/security/operations/incident-response-playbooks)
- [Risk-based Access Policies](/entra/id-protection/concept-identity-protection-policies)

## Next steps

- Learn more about [risky users](/entra/id-protection/howto-identity-protection-investigate-risk#risky-users).

