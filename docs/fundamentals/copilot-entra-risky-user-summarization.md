---
title: Investigate risky users with Copilot
description: Use Copilot in Microsoft Entra to quickly respond to identity threats by summarizing the risk level for a user and receiving insights relevant to the incident.
keywords: 
author: cilwerner
ms.author: cwerner
manager: pmwongera
ms.date: 11/07/2024
ms.update-cycle: 180-days
ms.topic: how-to
ms.service: entra
ms.custom: security-copilot
ms.collection: msec-ai-copilot
# Customer intent: As a SOC analyst or IT admin, I want to learn about risky user summarization in the Microsoft Entra ID Protection UX so that I can quickly respond to identity threats.
---

# Respond to identity threats using risky user summarization

Microsoft Entra ID Protection applies the capabilities of [Copilot in Microsoft Entra](/security-copilot/microsoft-security-copilot) to summarize a user's risk level, provide insights relevant to the incident at hand, and provide recommendations for rapid mitigation. Identity risk investigation is a crucial step to defend an organization. Copilot in Microsoft Entra helps reduce the time to resolution by providing IT admins and security operations center (SOC) analysts the right context to investigate and remediate identity risk and identity-based incidents. Risky user summarization provides admins and responders quick access to the most critical information in context to aid their investigation.

Respond to identity threats quickly:
- Risk summary: summarize in natural language why the user risk level was elevated.
- Recommendations: get guidance on how to mitigate and respond to these types of attacks, with quick links to help and documentation.

This article describes how to access the risky user summary capability of Microsoft Entra ID Protection and Copilot in Microsoft Entra. Using this feature requires [Microsoft Entra ID P2 licenses](/entra/id-protection/overview-identity-protection#license-requirements).

## Investigate risky users

To view and investigate a risky user:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader).
1. Navigate to **ID Protection** > [Risky users](https://aka.ms/entracopilotriskyuser).  
1. Select a user from the risky users report.

    :::image type="content" source="./media/copilot-entra-risky-user-summarization/risky-users-report.png" alt-text="Screenshot that shows the ID Protection risky users report.":::

1. In the **Risky User Details** window, information appears in **Summarize**.  

    :::image type="content" source="./media/copilot-entra-risky-user-summarization/risky-user-details.png" alt-text="Screenshot that shows the ID Protection risky user summarization details.":::

The risky user summary contains three sections:

- Summary by Copilot: summarizes in natural language why ID Protection flagged the user for risk.
- What to do: lists the next steps to investigate this incident and prevent future incidents.
- Help and documentation: lists resources for help and documentation.

In this example, suggested remediations are to: 

- Create sign-in risk and user risk based [Conditional Access policies](/entra/id-protection/howto-identity-protection-configure-risk-policies).  

Suggested help and documentation are:
- [What is risk in ID Protection?](/entra/id-protection/concept-identity-protection-risks)
- [Incident Response Playbooks](/security/operations/incident-response-playbooks)
- [Risk-based Access Policies](/entra/id-protection/concept-identity-protection-policies)

## Investigate risky users using Copilot

Launch Security Copilot from the **Copilot** button in the Microsoft Entra admin center. Use natural language questions or prompts to:

- List or identify users based on risk
- Extract user-specific risk information
- Summarize user risk history

### List or identify users based on risk

Using Microsoft Security Copilot, you can easily retrieve and summarize information about user risk status in your system.

For example:

- *List all users currently flagged as risky*
- *Show users who are currently at risk*
- *Identify users who have been marked as risky*
- *List all users who have been compromised*
- *Show users who are currently considered safe*
- *How many users are currently flagged as risky*
- *Provide a count of all risky users*

### User-specific risk information

Using Microsoft Security Copilot, you can focus in on a specific user and identify their risk level.

For example:

- *Determine if this user is currently high risk*
- *Display detailed risk information for this user*

### User risk history

Using Microsoft Security Copilot, you can retrieve past information about a user over time to establish their risk history.

- *Show the risk history for this user*
- *Has this user ever been flagged as risky*
- *Was this user previously at risk*

## Next steps

- Learn more about [risky users](/entra/id-protection/howto-identity-protection-investigate-risk#risky-users-report).
