---
title: Access Packages for Agent Identities in Microsoft Entra ID
titleSuffix: Microsoft Entra Agent ID
description: This article explains how access packages provide governance for agent identity access to resources.
author: SHERMANOUKO
ms.author: shermanouko
manager: pmwongera
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.service: entra-id
ms.topic: concept-article

#customer-intent: As an IT admin, I want to configure access packages for agent identities so that I can ensure their access is intentional, auditable, and time-bound.
---

# Access packages for Agent identities in Microsoft Entra ID

Microsoft Entra entitlement management provides access packages as a governance mechanism. Access packages ensure that agent access assignments are intentional, auditable, and time-bound. Access packages represent a structured approach to managing agent identity permissions, contrasting with ad-hoc permission assignments that might lack appropriate governance controls. Access packages enable standardized access for many AI Agents with the same access needs, for example, a fleet of customer support AI Agents. Through access packages, organizations can establish consistent governance practices for all agent identity resource access.

## Access request and approval process

To use access packages, IT admin configures an access package with the required policy settings. These settings define who can get access, who can request access, approvals, access expiration, and extension. Agents can be assigned access packages through three different request pathways. 

- The agent identity itself can programmatically request an access package when needed for its operations.
- The agent's sponsor can request access on behalf of the agent ID, providing human oversight in the access request process.
- An administrator can assign the agent identity or agent user to the access package.

After submission, the access request is routed to designated approvers based on the access package configuration.

## Access assignment lifecycle

Once an approver accepts the access package assignment request, the agent identity receives time-bound access to the specified resources. The access is granted according to the resource roles defined in the access package. This package establishes a clear start and end date for the access the agent might need.

As the expiry date approaches, the sponsor receives notifications about the pending expiration. The sponsor then has two options: they can request an extension of the access package (if permitted by policy), or they can allow the access package assignment to expire.

If the sponsor requests an extension, this request can trigger a new approval cycle, where approvers again confirm whether continued access is appropriate. If the sponsor takes no action, the access package assignment automatically expires on its end date, and the agent identity loses access to the target resources.
