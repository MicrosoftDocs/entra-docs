---
# required metadata

title: Investigate risky users with Copilot in Microsoft Entra 
description: Use Microsoft Copilot in Microsoft Entra to quickly respond to identity threats by summarizing the risk level for a user and receiving insights relevant to the incident.
keywords:
author: rwike77
ms.author: ryanwi
manager: celestedg
ms.date: 03/26/2024
ms.topic: conceptual
ms.service: entra
ms.custom: microsoft-copilot

# Customer intent: As a SOC analyst or IT admin, I want to learn about risky user summarization in the Identity Protection UX so that I can quickly respond to identity threats.
---

# Respond to identity threats using risky user summarization

Microsoft Entra ID Protection applies the capabilities of [Microsoft Copilot for Microsoft Entra](/security-copilot/microsoft-security-copilot) to summarize a user's risk level, provide insights relevant to the incident at hand, and provide recommendations for rapid mitigation. Identity risk investigation is a crucial step to defend an organization. Copilot for Microsoft Entra helps reduce the time to resolution by providing IT admins and security operations center (SOC) analysts the right context to investigate and remediate identity risk and identity-based incidents. Risky user summarization provides admins and responders quick access to the most critical information in context to aid their investigation.

Respond to identity threats quickly:
- Risk summary: summarize in natural language why the user risk level was elevated.
- Recommendations: get guidance on how to mitigate and respond to these types of attacks, with quick links to help and documentation.

This article describes how to access the risky user summary capability of Identity Protection and Copilot for Microsoft Entra.  Using this feature requires [Microsoft Entra ID P2 licenses](/entra/id-protection/overview-identity-protection#license-requirements).

## Investigate risky users

To view and investigate a risky user:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader).
1. Navigate to **Protection** > **Identity Protection** and then to the [Risky users](https://aka.ms/entracopilotriskyuser) report.  
1. Select a user from the risky users report.

    :::image type="content" source="./media/copilot-entra-risky-user-summarization/risky-users-report.png" alt-text="Screenshot that shows the Identity Protection risky users report.":::

1. In the **Risky User Details** window, information appears in **Summarize**.  

    :::image type="content" source="./media/copilot-entra-risky-user-summarization/risky-user-details.png" alt-text="Screenshot that shows the Identity Protection risky user summarization details.":::

The risky user summary contains three sections:

- Summary by Copilot: summarizes in natural language why ID Protection flagged the user for risk.
- What to do: lists the next steps to investigate this incident and prevent future incidents.
- Help and documentation: lists resources for help and documentation.

In this example, suggested remediations are to: 

- Create sign-in risk and user risk based [conditional access policies](/entra/id-protection/howto-identity-protection-configure-risk-policies).  

Suggested help and documentation are:
- [What is risk in ID Protection?](/entra/id-protection/concept-identity-protection-risks)
- [Incident Response Playbooks](/security/operations/incident-response-playbooks)
- [Risk-based Access Policies](/entra/id-protection/concept-identity-protection-policies)

## Next steps

- Learn more about [risky users](/entra/id-protection/howto-identity-protection-investigate-risk#risky-users).

