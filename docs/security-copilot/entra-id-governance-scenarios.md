---
title: Microsoft Security Copilot scenarios in Microsoft Entra ID Governance
description: Learn how to use Microsoft Security Copilot with Microsoft Entra ID Governance for identity lifecycle and access management scenarios.
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
# Customer intent: As an identity administrator, I want to learn about Microsoft Security Copilot scenarios for Microsoft Entra ID Governance so I can understand the capabilities and use cases.
---

# Microsoft Security Copilot scenarios in Microsoft Entra ID Governance

Identity administrators face increasing pressure to ensure proper access governance while managing complex identity lifecycles at scale. Microsoft Security Copilot transforms how you approach Microsoft Entra ID Governance by enabling natural language queries to quickly analyze access reviews, manage entitlement packages, monitor privileged access, and streamline lifecycle workflows.

In this article, learn about the Security Copilot scenarios available in Microsoft Entra ID Governance to enhance your identity lifecycle and access governance efforts.

## Microsoft Entra ID Governance scenarios supported by Microsoft Security Copilot

Security Copilot is integrated into the Microsoft Entra admin center and works seamlessly with Microsoft Entra ID Governance features. The following list provides an overview of Microsoft Entra ID Governance scenarios supported by Security Copilot:

| Scenario | Role | License  | Tenant |
|----------|------|----------|--------|
| [Access reviews](#access-reviews) | [Identity Governance Administrator](/entra/identity/role-based-access-control/permissions-reference#identity-governance-administrator) | [Microsoft Entra ID P2 license](/entra/id-protection/overview-identity-protection#license-requirements) | Any with access reviews configured |
| [Entitlement management](#entitlement-management) | [Identity Governance Administrator](/entra/identity/role-based-access-control/permissions-reference#identity-governance-administrator) | [Microsoft Entra ID P2 license](/entra/id-protection/overview-identity-protection#license-requirements) | Any with entitlement management configured |
| [Privileged Identity Management (PIM)](#privileged-identity-management-pim) | [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator) <br> [Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader) <br> [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader) | [Microsoft Entra ID P2 license](/entra/id-protection/overview-identity-protection#license-requirements) | Any with PIM configured |
| [Lifecycle workflows](#lifecycle-workflows) | [Lifecycle Workflows Administrator](/entra/identity/role-based-access-control/permissions-reference#lifecycle-workflows-administrator) | Microsoft Entra ID Governance license | Any with lifecycle workflows configured |

### Access reviews

Administrators can easily now extract and analyze access review data in Microsoft Entra ID Governance using Security Copilot. This integration empowers you to quickly explore, track, and gain insights from access reviews at scale—helping you make informed decisions and streamline your access governance processes.

This feature helps administrators;

- Understand who approved access
- Identify reviewers who took no decisions
- Investigate overrides of AI recommendations

Refer to the prompts and examples in [Governance and optimization with Microsoft Security Copilot](./entra-governance-optimization.md) to learn how to use Microsoft Security Copilot with access reviews for the following use-cases;

- [Access review exploration and management](./entra-governance-optimization.md#access-review-exploration-and-management)
- [Access review decision analysis](./entra-governance-optimization.md#access-review-decision-analysis)

For more information about access reviews, see;

- [What are access reviews?](/entra/id-governance/access-reviews-overview)
- [Prepare for an access review of users' access to an application](/entra/id-governance/access-reviews-application-preparation)

## Entitlement management

Entitlement management in Microsoft Entra ID enables organizations to manage identity and access lifecycle at scale, by automating workflows, access assignments, reviews, and expirations. Administrators can now interact with entitlement management data using natural language queries to get quick access to information. This includes access packages, policies, connected organizations, catalog resources, and customize curated data only previously available through custom scripting.

Refer to the prompts and examples in [Governance and optimization with Microsoft Security Copilot](./entra-governance-optimization.md) to learn how to use Microsoft Security Copilot with entitlement management for the following use-cases;

- [Catalog and access package management](./entra-governance-optimization.md#catalog-and-access-package-management)
- [User assignments and connected organizations](./entra-governance-optimization.md#user-assignments-and-connected-organizations)

For more information about entitlement management, see [What is entitlement management?](/entra/id-governance/entitlement-management-overview)

## Privileged Identity Management (PIM)

Using Security Copilot, privileged access can be managed and monitored more efficiently using natural language queries integrated with Microsoft Entra Privileged Identity Management (PIM). This approach provides instant insights into just-in-time role assignments, group memberships, and access to critical resources. AI-powered analysis enables quick identification of eligible or active PIM assignments, tracking of changes, and rapid response to potential risks—streamlining privileged access management and strengthening your security posture.

Refer to the prompts and examples in [Governance and optimization with Microsoft Security Copilot](./entra-governance-optimization.md) to learn how to use Microsoft Security Copilot with PIM for the following use-case;

- [PIM role assignment queries](./entra-governance-optimization.md#pim-role-assignment-queries)

For more information about Privileged Identity Management, see [What is Microsoft Entra Privileged Identity Management?](/entra/id-governance/privileged-identity-management/pim-configure)

## Lifecycle workflows

Microsoft Entra ID Governance applies the capabilities of Security Copilot to save identity administrators time and effort when configuring custom workflows to manage the lifecycle of users across JML scenarios. It also helps you to customize workflows more efficiently using natural language to configure workflow information including custom tasks, execute workflows, and get workflow insights.

Refer to the prompts and examples in [Manage employee lifecycle using Microsoft Security Copilot](./entra-lifecycle-workflows.md) to learn how to use Microsoft Security Copilot with lifecycle workflows for the following use-cases;

- [Create step-by-step guidance for a new lifecycle workflow](./entra-lifecycle-workflows.md#create-step-by-step-guidance-for-a-new-lifecycle-workflow)
- [Explore available workflow configurations](./entra-lifecycle-workflows.md#explore-available-workflow-configurations)
- [Analyze active workflow lists](./entra-lifecycle-workflows.md#analyze-active-workflow-list)
- [Troubleshoot a Lifecycle Workflow run](./entra-lifecycle-workflows.md#troubleshoot-a-lifecycle-workflow-run)
- [Compare versions of a lifecycle workflow](./entra-lifecycle-workflows.md#compare-versions-of-a-lifecycle-workflow)

For more information about lifecycle workflows, see [What are lifecycle workflows?](/entra/id-governance/what-are-lifecycle-workflows)

## Related content

- [Microsoft Security Copilot scenarios in Microsoft Entra ID](./entra-id-scenarios.md)
- [Microsoft Security Copilot scenarios in Microsoft Entra ID Protection](./entra-id-protection-scenarios.md)
- [Get started with Microsoft Security Copilot](/copilot/security/get-started-security-copilot)
- [Microsoft Security Copilot experiences](/copilot/security/experiences-security-copilot)