---
title: Microsoft Entra security for AI overview
titleSuffix: Microsoft Entra Agent ID
description: Learn how Microsoft Entra provides identity-based security controls for AI agents, applications, and services through authentication, governance, and Zero Trust policy enforcement.
author: omondiatieno
ms.author: jomondi
ms.date: 03/04/2026
ms.service: entra-id
ms.topic: concept-article
ai-usage: ai-assisted

#customer-intent: As an IT administrator or security professional, I want to understand how Microsoft Entra secures AI systems at a high level, so that I can navigate to the right documentation for detailed implementation guidance.
---

# Microsoft Entra security for AI overview

AI agents—autonomous software systems that perceive their environment, make decisions, and take actions—expand organizational capabilities but introduce security challenges that differ from traditional application security. These capabilities require identity-based security controls that authenticate AI workloads, enforce access policies, and provide governance over nonhuman identities.

Microsoft Entra provides the identity control plane for securing AI systems. It extends identity capabilities to AI agents, applications, and services so that organizations can apply consistent authentication, authorization, and governance controls across human and nonhuman identities.

This article explains why AI systems need identity-based security, introduces the key Microsoft Entra capabilities that address these challenges, and links to detailed documentation for each area.

## Why AI systems need identity-based security

Organizations are deploying AI agents for increasingly diverse tasks, and each deployment model presents distinct security challenges:

- **Assistive agents** perform specific tasks on demand, such as analyzing customer data for sales recommendations or answering support questions with escalation to human representatives.

- **Autonomous agents** operate independently, making decisions and taking actions without human intervention, such as monitoring network logs for security operations or managing infrastructure deployments with autoscaling.

- **Agents' user accounts** function with human user characteristics, including persistent identities and access to organizational systems. Agents' user accounts might join teams, access documents, participate in meetings, and require mailbox and calendar access.

### Security challenges

Unlike applications that execute predetermined logic, AI agents make dynamic decisions and adapt behavior based on training data, input, and environment conditions. This adaptive behavior expands the organizational attack surface:

- **External accessibility**: Many AI agents interact with external users, third-party systems, or the public internet. This exposure creates potential pathways for adversaries to compromise agents and access organizational systems.

- **Permission escalation risk**: Agents are often provisioned with broad permissions to ensure capability. An agent analyzing financial data might receive access to all financial records, expense reports, and vendor contracts, which is broader than necessary for the specific task.

- **Autonomous decision-making**: Compromised agents that make autonomous decisions can take harmful actions. A supply chain agent with purchasing authority could place unauthorized orders. An infrastructure management agent could delete critical systems.

- **Prompt injection attacks**: AI agents are vulnerable to attacks that don't affect traditional applications. Prompt injection attacks manipulate agent behavior by inserting malicious instructions into data processed by the agent.

- **Agent-to-agent propagation**: Agents that interact with other agents can propagate compromise. If an orchestration agent is compromised, it can potentially target other agents to perform malicious actions.

Organizations must also demonstrate that AI systems operate within governance frameworks, comply with privacy regulations, and maintain audit trails documenting agent actions and decisions.

### Agent sprawl

Agent proliferation creates a governance challenge termed "agent sprawl", which is the uncontrolled expansion of agents across an organization without adequate visibility, management, or lifecycle controls. Agent sprawl emerges when business units create agents without formal IT oversight (shadow AI), when agents created for temporary purposes remain in production indefinitely, and when agent permissions exceed actual requirements and are never reviewed.

Uncontrolled agent sprawl leads to increased security risk from over-privileged agents with unclear ownership, compliance challenges when auditors expect governance over AI systems, and incident response difficulties when organizations can't quickly identify compromised agents.

### Agent security scenarios

Agent security challenges manifest differently depending on the agent's purpose and deployment context:

| Scenario | Description | Security challenge | Risk |
|----------|-------------|-------------------|------|
| **User-initiated agent** | Agents act on behalf of users, inheriting user capabilities and access rights. | Prevent agents from misusing inherited permissions; maintain user control and enable access revocation. | Compromised agents might perform unauthorized actions as the user, such as accessing files, sending communications, or manipulating data. |
| **Autonomous agent** | Agents operate with their own identities and permissions, independent of users. | Grant only necessary permissions for intended tasks; prevent agents from exceeding authorized scope. | Compromised agents might operate without constraint, placing unauthorized orders, modifying data, or accessing sensitive information. |
| **Agent's user account** | An agent's user account enables the agent to function as a human user with persistent identity, mailbox, and access to collaborative systems. | Maintain appropriate permission scope; prevent compromised agents from using team access to spread malware or manipulate decisions. | Compromised agents might access documents, participate in meetings under false pretenses, or send communications as trusted team members. |
| **Agent-to-agent** | Agents interact with other agents, such as an orchestration agent that delegates tasks to specialized agents. | Establish authenticated agent communication; ensure agents interact only with legitimate agents; maintain audit trails of interactions. | Unsecured communication allows adversaries to inject malicious agents or intercept or manipulate agent interactions. |

## Secure identities for AI agents

AI agents require purpose-built identity constructs that differ from traditional application identities. [Microsoft Entra Agent ID](what-is-microsoft-entra-agent-id.md) provides an identity and security framework designed for AI agents.

:::image type="content" source="media/security-for-ai-overview/microsoft-entra-agent-identities-diagram.png" alt-text="Diagram showing illustration of security for AI landscape with Microsoft Entra Agent ID.":::

Microsoft Entra Agent ID enables organizations to:

- **Register and manage agents**: Create and manage agent identity blueprints as templates and agent identities as individual instances with parent-child relationships, enabling centralized metadata management and automatic organization into security collections.

- **Assign secure, scalable identities**: The [Microsoft Entra Agent identity platform](../identity-platform/what-is-agent-id-platform.md) enables you to assign identities to agents, autodiscover them across your organization, and manage all agent metadata in one place including capabilities, tasks, and protocols. It provides agent-to-agent discovery and authorization based on standard protocols such as MCP and A2A.

- **Log and monitor agent activity**: All authentication and actions performed by agents are logged in Microsoft Entra ID and viewable through the Microsoft Entra admin center for compliance and audit purposes.

For more information about agent identities as identity constructs, including how they differ from application and user identities, see [What are agent identities?](../identity-platform/what-are-agent-identities.md).

## Control AI access with Zero Trust

Microsoft Entra applies Zero Trust identity controls to AI identities through Conditional Access and Identity Protection.

### Conditional Access for agents

Conditional Access enables organizations to define and enforce adaptive policies that evaluate agent context and risk before granting access to resources:

- Enforce adaptive access control policies for all agent patterns across assistive, autonomous, and agent user account types.
- Use real-time signals such as agent identity risk to control agent access to resources, with Microsoft Managed Policies providing a secure baseline by blocking high-risk agents.
- Deploy Conditional Access policies at scale using custom security attributes, while still supporting fine-grained controls for individual agents.

For more information, see [Conditional Access for agents](/entra/identity/conditional-access/agent-id).

### Identity Protection for agents

Microsoft Entra ID Protection detects and blocks threats by flagging anomalous activities involving agents:

- Detect agent identity risk derived from user risk and based on agents' own actions, including unusual or unauthorized activities.
- Provide risk signals to Conditional Access to enforce risk-based policies and session management controls.
- Provide risk signals to inform agent discoverability and access, with automatic remediation of compromised agents using preconfigured policies.

For more information, see [Identity Protection for agents](/entra/id-protection/concept-risky-agents).

## Govern AI identities and permissions

As organizations deploy more AI agents, identity governance becomes critical to prevent agent sprawl and maintain compliance. Microsoft Entra ID Governance extends lifecycle management, access reviews, and entitlement management to agent identities:

- Govern agent identities at scale, from deployment to expiration.
- Ensure sponsors and owners are assigned and maintained for each agent identity, preventing orphaned agent identities.
- Enforce that agent access to resources is intentional, auditable, and time-bound through access packages.

For more information, see [Identity governance for agents](/entra/id-governance/agent-id-governance-overview).

For a general overview of Microsoft Entra ID Governance, see [What is Microsoft Entra ID Governance?](/entra/id-governance/identity-governance-overview).

## Secure AI services and automation

Many AI workloads run as applications, services, or automation pipelines rather than as interactive agents. These workloads need secure, credential-free authentication to access enterprise resources.

Microsoft Entra workload identities provide identity and access management for software workloads. Organizations can use managed identities and federated credentials to authenticate AI services without managing secrets.

For more information, see [What are workload identities?](/entra/workload-id/workload-identities-overview).

## Secure generative AI architectures

Enterprise generative AI architectures require identity controls at every layer, from the client application to the AI model and the data sources it accesses. Microsoft Entra enforces authentication, authorization, and governance controls across these architectural components.

Network-level controls through Global Secure Access enforce consistent network security policies across users and agents:

- Log agent network activity to remote tools for audit and threat detection, and apply web categorization to control access to APIs and MCP servers.
- Restrict file uploads and downloads using file-type policies to minimize risk, and automatically block and alert on malicious destinations using threat intelligence-based filtering.
- Detect and block prompt injection attacks that attempt to manipulate agent behavior through malicious instructions.

For more information, see [Secure Web and AI Gateway for agents](/entra/global-secure-access/concept-secure-web-ai-gateway-agents).

## Related content

- [What is Microsoft Entra Agent ID?](what-is-microsoft-entra-agent-id.md)
- [What is the Microsoft Entra Agent identity platform?](../identity-platform/what-is-agent-id-platform.md)