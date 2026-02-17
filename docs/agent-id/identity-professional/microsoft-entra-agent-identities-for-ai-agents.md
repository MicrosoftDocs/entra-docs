---
title: What is Microsoft Entra Agent ID?
titleSuffix: Microsoft Entra Agent ID
description: Learn how Microsoft Entra Agent ID extends comprehensive security capabilities to agents with conditional access, identity protection, identity governance, and network security controls designed specifically for agent scenarios.
author: SHERMANOUKO
ms.author: shermanouko
ms.date: 11/10/2025
ms.custom: agent-id-ignite
ms.service: entra-id
ms.topic: concept-article
ms.reviewer: kylemar

#customer-intent: As an IT administrator or security professional, I want to understand how Microsoft Entra ID provides integrated security capabilities for agents, so that I can implement comprehensive protection across conditional access, identity protection, identity governance, and network controls.
---

# What is Microsoft Entra Agent ID?

[!INCLUDE [entra-agent-id-preview-note](../../includes/entra-agent-id-preview-note.md)]

As assistive and autonomous agents become more prevalent in organizations, new security, governance, and compliance challenges must be addressed. Microsoft Entra Agent ID extends the comprehensive security capabilities of Microsoft Entra to agents, enabling organizations to build, discover, govern, and protect agent identities. [Security for AI](security-for-ai.md) spans multiple Microsoft Entra features and is integrated through Microsoft Entra Agent ID and the [Microsoft agent identity platform for developers](../identity-platform/what-is-agent-id-platform.md).

This article explains how Microsoft Entra Agent ID extends security capabilities to agents through conditional access policies, identity protection, identity governance, network-level controls, and the agent identity platform.

:::image type="content" source="media/microsoft-entra-agent-identities-for-ai-agents/microsoft-entra-agent-identity-capabilities.png" alt-text="Diagram showing agent security capabilities offered by Microsoft Entra Agent ID.":::

[!INCLUDE [entra-agent-id-license-note](../../includes/entra-agent-id-license-note.md)]

## Conditional access for agents

Conditional access enables organizations to define and enforce adaptive policies that evaluate agent context and risk before granting access to resources. It's achieved by:

- Enforcing adaptive access control policies for all agent patterns across assistive, autonomous, and agent user types.
- Using real-time signals such as agent identities risk controlling agent access to resources, with Microsoft Managed Policies providing a secure baseline by blocking high-risk agents.
- Deploying conditional access policies at scale using custom security attributes, while still supporting fine-grained controls for individual agents.

For more information, see [Conditional Access](/entra/identity/conditional-access/agent-id).

## Identity governance for agents

Microsoft Entra Agent ID brings agent IDs into similar identity governance processes as users, enabling them to be managed at scale. You can establish controls for agent access lifecycle using features such as entitlement management access packages.

- Govern agent IDs at scale, from deployment to expiration.
- Ensure sponsors and owners are assigned and maintained for each agent ID, preventing orphaned agent IDs.
- Enforce that agent access to resources is intentional, auditable, and time-bound through access packages.

For more information, see [identity governance for agents](/entra/id-governance/agent-id-governance-overview).

## Identity protection for agents

Identity protection detects and blocks threats by flagging anomalous activities involving agents. Risk signals are used to enforce risk-based access policies and inform agent discoverability.

- Detect agent identity risk derived from user risk and based on agents' own actions, including unusual or unauthorized activities.
- Provide risk signals to conditional access to enforce risk-based policies and session management controls.
- Provide risk signals to the Agent Registry to inform agent discoverability and access, with automatic remediation of compromised agents using preconfigured policies.

For more information, see [identity protection for agents](/entra/id-protection/concept-risky-agents)

## Network controls for agents

Network controls enforce consistent network security policies across users and agents across any platform or application. Provide full network visibility to all agent actions, filter malicious web content, enable network-based security controls, and prevent data exfiltration.

- Log agent network activity to remote tools for audit and threat detection, and apply web categorization to control access to APIs and MCP servers.
- Restrict file uploads and downloads using file-type policies to minimize risk, and automatically block and alert on malicious destinations using threat intelligence-based filtering.
- Detect and block prompt injection attacks that attempt to manipulate agent behavior through malicious instructions.

For more information, see [Network controls for agents](/entra/global-secure-access/concept-secure-web-ai-gateway-agents).

## Microsoft Entra Agent identity platform for developers

The Microsoft Entra Agent identity platform enables you to assign identities to agents, autodiscover them across your organization, and manage all agent metadata in one place including capabilities, tasks, and protocols.

- Provides visibility into all organization agents with agent-to-agent discovery and authorization based on standard protocols such as MCP and A2A.
- Assign secure, scalable identities to every agent.​ Authenticates and authorizes agents based on standard protocols.
- Log and monitor agent activity for compliance.​

For more information, see [Microsoft Entra Agent Identity Platform](../identity-platform/what-is-agent-id-platform.md)
