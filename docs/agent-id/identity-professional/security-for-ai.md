---
title: Security for AI agents with Microsoft Entra Agent ID
description: Understand why security is critical for AI agents. Learn about the challenges they introduce, the concept of agent sprawl, and how Microsoft is addressing AI security across the enterprise.
author: SHERMANOUKO
ms.author: shermanouko
ms.date: 11/10/2025
ms.service: entra-id
ms.topic: concept-article
ms.reviewer: kylemar

#customer-intent: As an IT administrator or security professional, I want to understand the security challenges posed by AI agents and how Microsoft Entra ID addresses them, so that I can implement comprehensive security controls and governance for AI agents across my organization.
---

# Security for AI agents with Microsoft Entra Agent ID

AI agents—autonomous software systems that perceive their environment, make decisions, and take actions—expand organizational capabilities but introduce security challenges that differ from traditional application security. This introduction explains why AI security matters, the challenges AI agents present, the concept of agent sprawl, and how Microsoft provides security mechanisms for AI agents in enterprise environments.

## Types of AI agents

Organizations are increasingly deploying AI agents for diverse tasks:

- Assistive agents perform specific, well-defined tasks on demand. Examples include agents that analyze customer data for sales recommendations, answer support questions with escalation to human representatives, or analyze market data for financial reporting.

- Autonomous agents operate independently, making decisions and taking actions without human intervention. Examples include agents that monitor network logs for security operations, manage infrastructure deployments with autoscaling, or generate and publish routine communications.

- Agent users are agents designed to function with human user characteristics, including persistent identities and access to organizational systems. Agent users might join teams, access documents, participate in meetings, and require mailbox and calendar access like human users.

These deployment models present distinct security and governance challenges.

## Agent applications security challenges

Unlike applications that execute predetermined logic, AI agents make dynamic decisions and adapt behavior based on training data, input, and environment conditions. This adaptive behavior requires different security considerations than static application logic.

### Increased attack surface

AI agents expand organizational attack surface in several ways:

- External accessibility: Many AI agents interact with external users, third-party systems, or the public internet. This exposure creates potential pathways for adversaries to compromise agents and access organizational systems.

- Permission escalation risk: Agents are often provisioned with broad permissions to ensure capability to complete assigned tasks. An agent analyzing financial data might receive access to all financial records, expense reports, and vendor contracts—broader than necessary for the specific analytical task.

- Autonomous decision-making: Agents that make autonomous decisions can take harmful actions if compromised. A supply chain agent with purchasing authority could place unauthorized orders. An infrastructure management agent with administrative privileges could delete critical systems.

- Attack vectors: AI agents are vulnerable to attacks that don't affect traditional applications. Prompt injection attacks manipulate agent behavior by inserting malicious instructions into data processed by the agent.

- Agent interaction: Agents that interact with other agents can propagate compromise. If an orchestration agent is compromised, it can potentially target other agents to perform malicious actions.

### Compliance and audit issues

Organizations must demonstrate that AI systems operate within governance frameworks and that they can account for AI-driven decisions and actions. It includes:

- Regulatory requirements: Regulations require oversight of how AI systems are monitored, controlled, and aligned with organizational policies.

- Data privacy: When agents access personal data, organizations must comply with privacy regulations like GDPR and CCPA. It requires visibility into data access patterns and the ability to demonstrate appropriate authorization.

- Audit trails: Organizations must maintain logs documenting agent actions, data accessed, and decisions made. Audit trails are necessary for incident investigation and regulatory compliance.

- Governance and oversight: Organizations must identify deployed agents, document their purpose and permissions, and demonstrate agents operate within governance frameworks.

## Agent sprawl

Agent proliferation creates a governance challenge termed "agent sprawl"—the uncontrolled expansion of agents across an organization without adequate visibility, management, or lifecycle controls.

### How agent sprawl develops

Agent sprawl emerges through several patterns:

- Shadow AI: Business units create agents to automate tasks without formal approval or IT oversight. A marketing team creates a content analysis agent, a sales team deploys a lead scoring agent, and a finance team creates an expense processing agent. Each addresses a local need but operates outside organization-wide visibility or governance.

- Rapid proliferation: Once created, agents are often deployed across departments, regions, or business units. Different instances might operate with different permissions or configurations, creating inconsistency and governance challenges.

- Inadequate lifecycle management: Agents created for temporary purposes often remain in production indefinitely. Project-specific agents continue running and accessing data long after their intended purpose ends.

- Permission creep: Agents typically receive permissions exceeding their actual requirements. Once provisioned, permissions are rarely reviewed or removed, resulting in over-privileged agents.

- Lost accountability: As agents proliferate, organizations lose track of creation responsibility, operational ownership, and intended purpose. This loss of accountability makes it difficult to identify agents operating outside policy or creating risk.

### Consequences of agent sprawl

Uncontrolled agent sprawl creates the following consequences:

- Security posture impact: Over-privileged agents with unclear ownership increase security risk. A compromised agent with broad permissions and no clear owner prevents effective response to detect the compromise or limit damage.

- Compliance risk: Auditors and regulators expect organizations to demonstrate governance and control over systems processing data or making decisions. Uncontrolled agent sprawl makes compliance demonstration difficult and creates regulatory risk.

- Operational inefficiency: Numerous agents running across an organization consume resources, potentially conflict with each other, duplicate efforts, and create technical debt.

- Data exposure: Agents with broad data access lacking adequate monitoring create risk of data exfiltration or unauthorized disclosure.

- Incident response challenges: When agent populations exceed management capability, organizations can't quickly identify and respond to compromised agents or determine incident scope.

## Agent security scenarios

Agent security challenges manifest in different ways depending on the agent's purpose and deployment context:

| Scenario    |  Description    | Security challenge  | Risk  |
|-------------|-----------------|---------------------|-------|
| **User-Initiated Agent**      | Agents act on behalf of users, inheriting user capabilities, and access rights. Example: A support agent can read customer cases, update status, and send communications.  | Prevent agents from misusing inherited permissions; maintain user control and enable access revocation. | Compromised agents might perform unauthorized actions as the user, such as accessing files, sending communications, or manipulating data.  |
| **Autonomous Agent**          | Agents operate with their own identities and permissions, independent of users. Example: A supply chain agent can query inventory, create orders, and modify supplier data.    | Grant only necessary permissions for intended tasks; prevent agents from exceeding authorized scope.  | Compromised agents might operate without constraint, placing unauthorized orders, modifying data, or accessing sensitive information.  |
| **Agent User**                | Agents function as human users with persistent identities, mailboxes, and access to collaborative systems. Example: An agent joins teams, accesses documents, and participates in meetings.  | Maintain appropriate permission scope; prevent compromised agents from using team access to spread malware or manipulate decisions.  | Compromised agents might access documents, participate in meetings under false pretenses, or send communications as trusted team members.  |
| **Agent-to-Agent**            | Agents interact with other agents. Example: An orchestration agent delegates tasks to specialized agents, requiring authentication and verification of designated tasks.  | Establish authenticated agent communication; ensure agents interact only with legitimate agents; maintain audit trails of interactions.  | Unsecured communication allows adversaries to inject malicious agents or intercept/manipulate agent interactions.  |

## Microsoft Entra Agent ID

Microsoft Entra Agent ID provides an identity and security framework designed to address the unique challenges of AI agents. The Microsoft agent identity platform consists of several integrated components that work together to provide identity management for AI agents. Microsoft Entra Agent ID enables you to: 

:::image type="content" source="media/security-for-ai/microsoft-entra-agent-identities-diagram.png" alt-text="Diagram showing illustration of security for AI landscape with Microsoft Entra Agent ID.":::

- Register and manage agents
    - Agent identities: Creates and manages agent identity blueprints as templates and agent identities as individual instances with parent-child relationships
    - Agent registry: Provides centralized metadata management, secure agent discovery, and automatic organization into security collections

- Govern agent identities and lifecycle
    - Identity governance for agent identities: Lifecycle management, access assignment, and compliance reporting for agent identities

- Protect agent access to resources 
    - Global Secure Access for agent identities: Network-level security and zero-trust access for agent communications
    - Conditional access for agent identities: Policy-based access controls and risk-based authentication for agents
    - Identity protection for agent identities: Real-time risk detection and automated response for agent activities

## Next steps

[Microsoft Entra Agent ID security capabilities for AI Agents](microsoft-entra-agent-identities-for-ai-agents.md)
