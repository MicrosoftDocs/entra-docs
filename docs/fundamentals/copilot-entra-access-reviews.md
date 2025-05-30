---
title: 'Investigate Access Reviews With Microsoft Entra Copilot  '
description: Learn how to use Microsoft Entra Copilot to extract and analyse access review data
keywords: null
author: cilwerner
ms.author: cwerner
manager: pmwongera
ms.date: 05/30/2025
ms.topic: conceptual
ms.service: entra
ms.custom: microsoft-copilot
ms.collection: null
---

# Investigate access reviews in Microsoft Entra Copilot

> [!NOTE]
> 
> This article is a work in progress. It will be updated with more information, methods, and examples before GA.

Access reviews in Microsoft Entra ID enable organizations to manage group memberships, application access, and role assignments effectively. Using the capabilities of Microsoft Security Copilot, administrators can now interact with access reviews data using natural language, enabling fast and actionable insights that reduce manual effort and enhance governance. This integration allows admins to explore, track, and analyze access reviews at scale by asking questions.

Specifically, this feature helps administrators;:

- Understand who approved access
- Identify reviewers who took no decisions
- Investigate overrides of AI recommendations

This article describes how to use Microsoft Security Copilot to investigate access reviews in Microsoft Entra. Using this feature requires [Microsoft Entra ID P2 licenses](/entra/id-governance/access-reviews-overview#license-requirements) and a tenant with access reviews configured.

## Extract access reviews data

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least an [Identity Governance Administrator](/entra/identity/role-based-access-control/permissions-reference#identity-governance-administrator).
1. Navigate to **Identity Governance** > **Access reviews**.
1. {ADDME}

> [!NOTE]
> This space is being reserved for an image showing the Copilot experience in the Microsoft Entra admin center.

Use the following example prompts to extract access reviews data in Microsoft Entra:

| Use Case | Example Prompts |
|----------|-----------------|
| Explore current configured access reviews in the tenant | *Show me top 10 access reviews with schedule, status, and metadata* |
| Get detailed info on a specific access review | *Get access review details for Finance M365 Groups Q2* |
| View access review decisions for a specific instance | *Who approved or denied access in the Q2 finance review?* |
| Track reviews assigned to a specific reviewer | *List reviews where Alex Chen is the assigned reviewer* |
| Identify decisions that went against AI recommendations | *Which access review decisions overrode AI-suggested actions?* |
| View assigned reviewers for a specific access review | *Who are the reviewers for the Sales App Access Q2 review?* |

## See also

- [What are access reviews?](/entra/id-governance/access-reviews-overview)
- [Create and manage downloadable access review history report in Microsoft Entra access reviews](/entra/id-governance/access-reviews-downloadable-review-history)
- [Prepare for an access review of users' access to an application](/entra/id-governance/access-reviews-application-preparation)