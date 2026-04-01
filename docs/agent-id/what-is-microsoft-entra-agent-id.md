---
title: What is Microsoft Entra Agent ID?
titleSuffix: Microsoft Entra Agent ID
description: Learn about Microsoft Entra Agent ID, the identity and security framework that enables organizations to build, discover, govern, and protect AI agent identities at enterprise scale.
ms.date: 03/25/2026
ms.custom: agent-id-ignite
ms.topic: concept-article
ms.reviewer: kylemar
ai-usage: ai-assisted

#customer-intent: As an IT administrator or security professional, I want to understand what Microsoft Entra Agent ID is and what capabilities it provides, so that I can evaluate how it helps secure and manage AI agents in my organization.
---

# What is Microsoft Entra Agent ID?

Microsoft Entra Agent ID is an identity and security framework that extends Microsoft Entra capabilities to AI agents. As organizations deploy assistive, autonomous, and user-like agents, they need purpose-built identity constructs to authenticate, authorize, govern, and protect these nonhuman identities. Microsoft Entra Agent ID addresses these needs by providing a unified platform for managing agent identities at enterprise scale.

:::image type="content" source="media/what-is-microsoft-entra-agent-id/microsoft-entra-agent-identity-capabilities.png" alt-text="Diagram showing agent security capabilities offered by Microsoft Entra Agent ID.":::

[!INCLUDE [entra-agent-id-preview-note](../includes/entra-agent-id-preview-note.md)]

Microsoft Entra Agent ID brings together identity management, access protection, governance, and compliance for AI agents.

## Agent identity platform

The [Microsoft Entra Agent identity platform](identity-platform/what-is-agent-id-platform.md) enables developers to create and manage [agent identities](identity-platform/what-are-agent-identities.md)—specialized identity constructs built for AI agents. Agent identity blueprints serve as templates for creating individual agent identities with parent-child relationships, enabling consistent security policies across large numbers of agents. The platform supports standard protocols such as OAuth 2.0, MCP, and A2A for authentication and agent-to-agent communication.

## Security and governance for agents

Microsoft Entra Agent ID extends existing Microsoft Entra security and governance capabilities to agent identities. Agents receive the same identity-driven protections as users and workloads, including adaptive access policies, real-time risk detection, lifecycle management, and network-level controls. All agent authentication and activity is logged for compliance and audit.

For details on how these capabilities work for agents, see:

- [Microsoft Entra security for AI overview](security-for-ai-overview.md)
- [Conditional Access for agents](/entra/identity/conditional-access/agent-id)
- [Identity Protection for agents](/entra/id-protection/concept-risky-agents)
- [Identity governance for agents](/entra/id-governance/agent-id-governance-overview)
- [Secure Web and AI Gateway for agents](/entra/global-secure-access/concept-secure-web-ai-gateway-agents)
- [Sign-in and audit logs for agents](sign-in-audit-logs-agents.md)

## How to get started

[!INCLUDE [entra-agent-id-license-note](../includes/entra-agent-id-license-note.md)]

## Related content

- [Microsoft Entra security for AI overview](security-for-ai-overview.md)
- [What are agent identities?](identity-platform/what-are-agent-identities.md)
- [What is the Microsoft Entra Agent identity platform?](identity-platform/what-is-agent-id-platform.md)
