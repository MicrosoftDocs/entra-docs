---
title: Access Packages for Agent Identities in Microsoft Entra ID
titleSuffix: Microsoft Entra Agent ID
description: This article explains how access packages provide governance for agent identity access to resources.
author: SHERMANOUKO
ms.author: shermanouko
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.service: entra-id
ms.topic: concept-article

#customer-intent: As an IT admin, I want to configure access packages for agent identities so that I can ensure their access is intentional, auditable, and time-bound.
---

# Access packages for Agent identities in Microsoft Entra ID

Microsoft Entra entitlement management provides access packages as a governance mechanism. Access packages ensure that agent access assignments are intentional, auditable, and time-bound. Access packages represent a structured approach to managing agent identity permissions, contrasting with ad-hoc permission assignments that might lack appropriate governance controls. Access packages enable standardized access for many AI Agents with the same access needs, for example, a fleet of customer support AI Agents. Through access packages, organizations can establish consistent governance practices for agent identity, agent user, and service principal access to resources. For more information, see [Governing agent identities](/entra/id-governance/agent-id-governance-overview).

## Access request and approval process

To use access packages, the IT admin first configures an access package with the relevant resources, including Entra roles, group memberships, app role assignments, and OAuth permission grants. Then the admin configures in the access package the required policy settings. These settings define who can get access, who can request access, approvals, access expiration, and extension. When creating an access package assignment policy, in the **Who can get access** section, select **For users, service principals, and agent identities in your directory**, and then select the option of **All agents (preview)**.

> [!NOTE]
> If your agents aren't using Microsoft Entra agent IDs, then also create an access package assignment policy with the option **All Service principals (preview)** to allow service principals in your directory to be able to request this access package.

Agents can then be assigned access packages through three different request pathways.

- The agent identity itself can programmatically request an access package when needed for its operations, by creating an [accessPackageAssignmentRequest](/graph/api/entitlementmanagement-post-assignmentrequests?view=graph-rest-1.0&tabs=http).
- The agent's sponsor can request access on behalf of the agent ID, providing human oversight in the access request process. For more information, see [Request an access package on behalf of an agent identity (Preview)](/entra/id-governance/entitlement-management-request-behalf#request-an-access-package-on-behalf-of-an-agent-identity-preview).
- An administrator can [directly assign the agent identity or agent user to the access package](/entra/id-governance/entitlement-management-access-package-assignments#directly-assign-an-identity).

After submission, the access request is routed to designated approvers based on the access package configuration.

## Access assignment lifecycle

Once an approver accepts the access package assignment request, the agent identity receives time-bound access to the specified resources. The access is granted according to the resource roles defined in the access package. This package establishes a clear start and end date for the access the agent might need.

If a sponsor is set on the agent identity, as the expiry date approaches, the sponsor receives notifications about the pending expiration. The sponsor then has two options: they can request an extension of the access package (if permitted by policy), or they can allow the access package assignment to expire.

If the sponsor requests an extension, this request can trigger a new approval cycle, where approvers again confirm whether continued access is appropriate. If the sponsor takes no action, the access package assignment automatically expires on its end date, and the agent identity loses access to the target resources.

## Related content

- [Governing agent identities](/entra/id-governance/agent-id-governance-overview)
- [Create an access package in entitlement management](/entra/id-governance/entitlement-management-access-package-create)
