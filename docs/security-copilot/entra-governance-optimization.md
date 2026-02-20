---
title: Identity Governance and optimization with Microsoft Security Copilot
description: Use Microsoft Security Copilot in the Microsoft Entra admin center to improve security posture, manage access reviews, entitlement management, and privileged identity management.
author: cilwerner
ms.author: cwerner
manager: pmwongera
ms.reviewer: ptyagi
ms.date: 09/23/2025
ms.update-cycle: 180-days
ms.topic: how-to
ms.service: entra
ms.custom: security-copilot
ms.collection: msec-ai-copilot
# Customer intent: As an IT administrator, I want to learn how to use Microsoft Security Copilot for governance and optimization so I can improve security posture and manage access lifecycle.
---

# Identity Governance and optimization with Microsoft Security Copilot

Microsoft Security Copilot empowers administrators to implement comprehensive governance and continuously optimize their Microsoft Entra environment using natural language queries. This capability helps you improve security posture through recommendations, manage access lifecycle through reviews and entitlement management, and secure privileged access through just-in-time controls.

This article describes how an IT administrator could prepare for their annual governance and compliance audit by using Microsoft Security Copilot governance and optimization skills for the following use cases in the Microsoft Entra admin center;

- [Validate access through access reviews](#validate-access-through-access-reviews)
- [Manage structured access through entitlement management](#manage-structured-access-through-entitlement-management)
- [Secure privileged access through privileged identity management](#secure-privileged-access-through-privileged-identity-management)

Use the prompts and examples in this article to compile your findings into actionable insights and reports for reviews and audits by your team or management.

## Prerequisites

- A tenant with Security Copilot enabled. Refer to [Get started with Microsoft Security Copilot](/copilot/security/get-started-security-copilot#option-2-provision-capacity-in-azure) for more information.
- The following roles and licenses are required for different governance and optimization use cases. 

    | Use case | Role(s) | License | Tenant |
    |----------|---------|---------|--------|
    | Access reviews  | [Identity Governance Administrator](/entra/identity/role-based-access-control/permissions-reference#identity-governance-administrator) | [Microsoft Entra ID P2](/entra/id-protection/overview-identity-protection#license-requirements) | Tenant with access reviews configured |
    | Entitlement management | [Identity Governance Administrator](/entra/identity/role-based-access-control/permissions-reference#identity-governance-administrator) | [Microsoft Entra ID P2](/entra/id-protection/overview-identity-protection#license-requirements) | Any tenant |
    | Privileged Identity Management| [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator), [Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader), [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader) | [Microsoft Entra ID P2](/entra/id-protection/overview-identity-protection#license-requirements) | Tenant with PIM configured |
    
## Launch Security Copilot in Microsoft Entra

[!INCLUDE [Launch Security Copilot in Microsoft Entra](./includes/access-entra-copilot.md)]

>[!NOTE]
> If an action is blocked by insufficient permissions, a recommended role is displayed. You can use the following prompt in the Security Copilot chat to activate the required role. This is dependent on having an eligible role assignment that provides the necessary access.
>
> - *Activate the {required role} so that I can perform {the desired task}.*

## Validate access through access reviews

To begin your assessment, you can analyze the current state of access reviews in your organization. Access reviews ensure that users have appropriate access to resources, and that access permissions are regularly validated for compliance to ensure that access is removed when no longer needed. You can extract and analyze access review data to explore, track, and analyze access reviews at scale, understand approval patterns, and identify reviewers who need attention.

### Access review exploration and management

Start by exploring your current access reviews and retrieving information about specific review instances to understand the scope and status of reviews in your organization. Use the following prompts to get the information you need:

- *Show me the top 10 pending access reviews.*
- *Get access review details for Finance Microsoft 365 Groups Q2.*
- *Who are the reviewers for the Sales App Access Q2 review?*

### Access review decision analysis

Analyze access review decisions to understand approval patterns, identify reviewers who need attention, and investigate where AI recommendations were overridden. This can help you identify the effectiveness of your access review processes and identify areas for improvement. Use the following prompts to get the information you need:

- *Who approved or denied access in the Q2 finance review?*
- *List reviews where Alex Chen is the assigned reviewer*
- *Which access review decisions overrode AI-suggested actions?*

## Manage structured access through entitlement management

Now, you can assess your entitlement management configuration to ensure that access packages and policies are properly structured and managed. Get quick access to information about access packages, policies, connected organizations, and catalog resources to manage identity and access lifecycle at scale through automated workflows.

### Catalog and access package management

You can explore your entitlement management structure, including catalogs and access packages, to understand how resources are organized and configured. Use the following prompts to get the information you need:

- *What resources are in catalog "XYZ"?*
- *How many catalogs are in the tenant?*
- *Which access packages are in catalog "XYZ"?*
- *How many access packages are in the tenant?*
- *What resource role scopes are in access package "XYZ"?*
- *Find all access packages where the name contains "Sales"?*

### User assignments and connected organizations

You can review the access package assignments and external organization relationships to ensure proper governance of both internal users and external partners who have access to your organization's resources. Use the following prompts to get the information you need:

- *What access package assignments does "User" have?*
- *Who are the external users of connected organization "XYZ"?*
- *Who are the sponsors for connected organization "XYZ"?*
- *What custom extensions does catalog "XYZ" have?*

## Secure privileged access through privileged identity management

Finally, you can review privileged identity management (PIM) configurations to ensure that just-in-time (JIT) access mechanisms and high-risk roles are properly managed and monitored.

### PIM role assignment queries

Examine current and eligible privileged role assignments to understand PIM configurations, that JIT access is being used effectively, and identify any potential risks associated with privileged access. Use the following prompts to get the information you need:

- *Which PIM roles are currently assigned to "User"?*
- *Which PIM eligible roles are assigned to "User"?*
- *Which PIM active roles are assigned to "User"?*
- *Who has PIM eligible assignment of {Specific Role}?*
- *Who has PIM active assignment of a {Specific role}?*

## Deactivate your role

After completing your tasks with Microsoft Security Copilot, ensure that you deactivate any elevated roles you activated during your session to maintain security best practices. Use the following prompt to deactivate your role:

- *I am done with my investigation or {desired task}, deactivate my access.*

## See also

- Learn more about [access reviews in Microsoft Entra ID](/entra/id-governance/access-reviews-overview)
- Learn more about [entitlement management in Microsoft Entra ID](/entra/id-governance/entitlement-management-overview)
- Learn more about [Privileged Identity Management in Microsoft Entra ID](/entra/id-governance/privileged-identity-management/pim-configure)