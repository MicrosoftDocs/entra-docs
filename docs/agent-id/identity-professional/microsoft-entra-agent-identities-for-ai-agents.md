---
title: Microsoft Entra Agent ID Security for AI Agents
description: Learn how Microsoft Entra ID extends comprehensive security capabilities to AI agents. It includes Conditional Access, Identity Protection, ID Governance, and network security controls designed specifically for agentic scenarios.
author: SHERMANOUKO
ms.author: shermanouko
manager: pmwongera
ms.date: 10/24/2025
ms.service: entra-id
ms.topic: concept-article
ms.reviewer: dastrock

#customer-intent: As an IT administrator or security professional, I want to understand how Microsoft Entra ID provides integrated security capabilities for AI agents, so that I can implement comprehensive protection across Conditional Access, Identity Protection, governance, and network controls.
---

# Microsoft Entra agent ID security capabilities for AI Agents

Microsoft Entra agent ID extends security capabilities to AI agents through Conditional Access policies, Identity Protection, ID Governance, network-level controls, and the agent identity platform.

:::image type="content" source="media/microsoft-entra-agent-identities-for-ai-agents/microsoft-entra-agent-identity-capabilities.png" alt-text="Diagram that shows agent security capabilities offered by Microsoft Entra agent ID.":::

## Conditional Access for AI Agents

Conditional Access enables organizations to define and enforce adaptive policies that evaluate agent context and risk before granting access to resources. It's achieved by:

- Enforcing adaptive access control policies for all agent patterns across assistive, autonomous, and agent user types.
- Using real-time signals such as Agent ID risk controlling agent access to resources, with Microsoft Managed Policies providing a secure baseline by blocking high-risk agents.
- Deploying Conditional Access policies at scale using custom security attributes, while still supporting fine-grained controls for individual agents.

## ID Governance for agents

ID Governance brings agents into the same governance processes as users, enabling them to be managed at scale. Establish controls for agent lifecycle, access packages, and who can create and manage agents.

- Govern agent IDs at scale, from deployment to expiration.
- Ensure sponsors and owners are assigned and maintained for each agent ID, preventing orphaned agent IDs.
- Enforce that agent access to resources is intentional, auditable, and time-bound through access packages.

## Identity Protection for agents

Identity Protection detects and blocks threats by flagging anomalous activities involving agents. Risk signals are used to enforce risk-based access policies and inform agent discoverability.

- Detect agent identity risk derived from user risk and based on agents' own actions, including unusual or unauthorized activities.
- Provide risk signals to Conditional Access to enforce risk-based policies and session management controls.
- Provide risk signals to the Agent Registry to inform agent discoverability and access, with automatic remediation of compromised agents using preconfigured policies.

## Network Controls for agents

Network controls enforce consistent network security policies across users and agents across any platform or application. Provide full network visibility to all agent actions, filter malicious web content, enable network-based security controls, and prevent data exfiltration.

- Log agent network activity to remote tools for audit and threat detection, and apply web categorization to control access to APIs and MCP servers.
- Restrict file uploads and downloads using file-type policies to minimize risk, and automatically block and alert on malicious destinations using threat intelligence-based filtering.
- Detect and block prompt injection attacks that attempt to manipulate agent behavior through malicious instructions.

## Agent Identity Platform

The identity platform enables you to assign identities to AI agents, autodiscover them across your organization, and manage all agent metadata in one place including capabilities, tasks, and protocols.

- Provides visibility into all organization agents with agent-to-agent discovery and authorization based on standard protocols such as MCP and A2A.
- Assign secure, scalable identities to every AI agent.​ Authenticates and authorizes agents based on standard protocols.
- Log and monitor agent activity for compliance.​
