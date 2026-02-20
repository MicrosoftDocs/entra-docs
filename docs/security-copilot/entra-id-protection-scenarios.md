---
title: Microsoft Security Copilot scenarios in Microsoft Entra ID Protection
description: Learn how to use Microsoft Security Copilot with Microsoft Entra ID Protection for identity risk scenarios.
author: cilwerner
ms.author: cwerner
manager: pmwongera
ms.reviewer: ptyagi
ms.date: 09/23/2025
ms.update-cycle: 180-days
ms.topic: concept-article
ms.service: entra
ms.custom: security-copilot
ms.collection: msec-ai-copilot
# Customer intent: As an identity administrator, I want to learn how to use Microsoft Security Copilot for Microsoft Entra ID Protection scenarios so I can investigate and remediate identity risks.
---

# Microsoft Security Copilot scenarios in Microsoft Entra ID Protection

Microsoft Security Copilot enhances Microsoft Entra ID Protection capabilities by providing AI-powered insights for identity risk investigation and remediation. This article describes how to use Microsoft Security Copilot with Microsoft Entra ID Protection to streamline identity risk management and improve your organization's security posture. Using this feature requires a tenant with Microsoft Security Copilot enabled.

## Microsoft Entra ID Protection scenarios supported by Microsoft Security Copilot

Security Copilot is integrated into the Microsoft Entra admin center and works seamlessly with Microsoft Entra ID Protection features. The following list provides an overview of the scenarios supported by Security Copilot:

| Scenario | Role(s) | License | Tenant |
|---|---|---|---|
| [Risky users](#risky-users) | [Identity Governance Administrator](/entra/identity/role-based-access-control/permissions-reference#identity-governance-administrator) | [Microsoft Entra ID P2 license](/entra/id-protection/overview-identity-protection#license-requirements) | Any |
| [Application risk](#application-risk) | [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator)<br>[Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator) | Workload Identity Premium or [Microsoft Entra ID P2 license](/entra/id-protection/overview-identity-protection#license-requirements) | Any with Risky Service Principal prompts |

### Risky users

Microsoft Entra ID Protection applies the capabilities of Security Copilot to [summarize a user's risk level](entra-risky-user-summarization.md), provide insights relevant to the incident at hand, and provide recommendations for rapid mitigation. Identity risk investigation is a crucial step to defend an organization. Security Copilot helps reduce the time to resolution by providing IT admins and security operations center (SOC) analysts the right context to investigate and remediate identity risk and identity-based incidents. Risky user summarization provides admins and responders quick access to the most critical information in context to aid their investigation.

You can add your own prompts in the Copilot window for the following use cases;

- [List or Identify Users Based on Risk](entra-risky-user-summarization.md#list-or-identify-users-based-on-risk)
- [User-Specific Risk Information](entra-risky-user-summarization.md#user-specific-risk-information)
- [User Risk History](entra-risky-user-summarization.md#user-risk-history)

:::image type="content" source="./media/copilot-entra-risky-user-summarization/risky-user-details.png" alt-text="Screenshot that shows the ID Protection risky user summarization details.":::

### Application risk

Identity administrators and security analysts can use Microsoft Security Copilot to quickly assess the risk level of applications from workload identities. By using natural language queries, you can easily discover the granted permissions, unused apps in your tenant, and the risk level of applications. This allows admins to take appropriate actions to mitigate risks and ensure the security of your organization's applications.

Refer to the prompts and examples in [Assess application risks using Microsoft Security Copilot in Microsoft Entra](./entra-investigate-risky-apps.md) to learn how to use Microsoft Security Copilot to assess application risk for the following use-cases;

- [Explore Microsoft Entra risky service principals](./entra-investigate-risky-apps.md#explore-microsoft-entra-risky-service-principals)
- [Explore Microsoft Entra service principals](./entra-investigate-risky-apps.md#explore-microsoft-entra-service-principals)
- [Explore Microsoft Entra applications](./entra-investigate-risky-apps.md#explore-microsoft-entra-applications)
- [View the permissions granted on a Microsoft Entra service principal](./entra-investigate-risky-apps.md#explore-microsoft-entra-risky-service-principals)
- [Explore unused Microsoft Entra applications](./entra-investigate-risky-apps.md#explore-unused-microsoft-entra-applications)
- [Explore Microsoft Entra Applications outside my tenant](./entra-investigate-risky-apps.md#explore-microsoft-entra-applications-outside-my-tenant)

## See also

- [Get started with Microsoft Security Copilot](/copilot/security/get-started-security-copilot)
- [Respond to identity threats using risky user summarization](./entra-risky-user-summarization.md)
- [Assess application risks using Security Copilot in Microsoft Entra](./entra-investigate-risky-apps.md)
- [Microsoft Security Copilot experiences](/copilot/security/experiences-security-copilot)