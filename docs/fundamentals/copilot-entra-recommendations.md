---
title: Microsoft Entra Recommendations with Microsoft Security Copilot
description: Use Microsoft Security Copilot and Microsoft Entra skills to quickly investigate how to evolve your tenant to a secure and healthy state.
keywords:
author: cilwerner
ms.author: cwerner
manager: pmwongera
ms.date: 05/29/2025
ms.topic: conceptual
ms.service: entra
ms.custom: microsoft-copilot
# Customer intent: As a security administrator, I want to learn how to use Microsoft Security Copilot to investigate recommendations in Microsoft Entra so that I can evolve my tenant to a secure and healthy state.
---

# Microsoft Entra Recommendations with Microsoft Security Copilot

> [!NOTE]
> This article is a work in progress. It will be updated with more information, methods, and examples before GA.
> 
> The following roles can use this feature: Global Administrator, Application Administrator, IT Governance Administrator, Privileged Role Administrator, Identity Governance Administrator, Conditional Access Administrator, Security Administrator, Hybrid Identity Administrator, Authentication Policy Administrator, Authentication Administrator.

Recommendations in Microsoft Entra help you improve the status and security of your tenant by providing actionable insights and guidance. These recommendations cover various areas, including secure score, best practices, conditional access policies, and more. Using the capabilities of Microsoft Security Copilot, you can now interact with these recommendations using natural language, enabling your security team to quickly investigate how to evolve your tenant to a secure and healthy state. 

This article describes how to use Microsoft Security Copilot to investigate recommendations in Microsoft Entra. This feature is available using a free Microsoft Entra ID license, or a Microsoft Entra ID P1 or P2 license. It is also available in Microsoft Entra Workload ID. You also need to have a cloud tenant with recommendations for maximizing your license on it.

## Investigate recommendations in Microsoft Entra

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator).
1. Navigate to {ADDME}

> [!NOTE]
> This space is being reserved for an image showing the Copilot experience in the Microsoft Entra admin center.

You cab use the following example prompts to investigate recommendations in Microsoft Entra:

- *List all Entra recommendations*
- *Show me the Entra recommendations*
- *Show Entra recommendation "example” and its details*
- *Show the resources affected by an Entra recommendation*
- *Show resource "example” of Entra recommendation "example”*
- *List secure score recommendations*
- *List best practice recommendations*
- *List recommendations for conditional access policies*
- *Show Entra recommendations for a specific feature area*
- *List high-priority recommendations*
- *List recommendations with high priority*
- *List recommendations that are active*
- *List recommendations to improve app portfolio health*
- *List recommendations to reduce surface area risk*
- *List recommendations to improve security posture of my apps*
- *List recommendations for tenant configuration*
- *Show Entra recommendations by impact type*
- *Which enterprise applications have credentials about to expire?*
- *Show me service principals with credentials that are expiring soon*
- *Show me applications with credentials that are expiring soon*
- *Which of our apps are stale or unused in the tenant?*
- *List the unused apps.*

## See also

- [What is Microsoft Entra Recommendations?](/entra/id-governance/entitlement-management/recommendations-overview)