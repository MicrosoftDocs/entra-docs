---
title: 'What are agent identities (Agent IDs)?'
titleSuffix: Microsoft Entra Agent ID
description: Learn about agent IDs, specialized identity constructs that enable secure authentication and authorization for AI agents in enterprise environments.
author: omondiatieno
ms.author: jomondi
manager: mwongerapk
ms.service: entra-id
ms.topic: concept-article
ms.date: 10/07/2025
ms.reviewer: dastrock
#customer-intent: As a developer or IT administrator, I want to understand what agent IDs are and how they provide first-class identity constructs that differ from traditional identities, so that I can build customer trust and drive adoption through secure identity solutions for AI agents in my organization.
---

# What are agent identities (Agent IDs)?

Agent IDs are first-class identity accounts within Microsoft Entra ID that provide unique identification and authentication capabilities for AI agents. As organizations increasingly deploy autonomous AI systems, identity models designed for human users and applications prove insufficient. Agent IDs address this gap by providing a specialized identity construct built specifically for the unique requirements of AI agents operating at enterprise scale.

## Why agent IDs exist

The emergence of AI agents as autonomous enterprise systems introduces security and operational challenges that existing identity models cannot adequately address.  Agent IDs help to address certain security challenges posed by AI agents, such as:

- The need to distinguish operations performed by AI agents from operations performed by workforce, customer, or workload identities.
- Enabling AI agents to gain right-sized access across systems.
- Preventing AI agents from gaining access to the most critical security roles and systems.
- Scaling identity management to large numbers of AI agents that might be quickly created and destroyed.

## Agent IDs versus application identities

Application identities, typically represented as service principals in Microsoft Entra ID, were designed for services built and maintained by organizations. These identities carry the expectation of long-term stability, known ownership, and managed lifecycle.

Agents are often created dynamically through automation, user actions in tools like Copilot Studio, or API orchestration. An agent might exist for minutes during a specific task, or might be created and destroyed thousands of times per day as part of an automated workflow. Managing this level of dynamism with existing application identities creates operational complexity and security challenges.

Agent IDs embrace this dynamic nature while providing appropriate security controls. Organizations can create agent identities in bulk, apply consistent policies to all agents, and retire agents without leaving orphaned credentials or permission assignments behind. The identity model is designed for scale and ephemerality rather than permanence.

## Agent IDs versus human user identities

Human user identities are tied to authentication mechanisms humans use daily, such as passwords, multi-factor authentication, and passkeys. Human users have data associated with them like mailboxes, teams, and organizational hierarchy.

Agent IDs represent software systems, not human beings. They don't use human authentication mechanisms. However, certain scenarios require agents to appear and operate as if they were human users. For these scenarios, agent identities can be paired with agent users - special Microsoft Entra user accounts that maintain a one-to-one relationship with their paired agent identity. This distinction allows organizations to provide agents with a user identity when necessary for system compatibility, while still maintaining clear separation and appropriate security policies for AI-driven operations.

## What agent IDs enable

Agent IDs provide the foundation for secure, scalable AI agent deployment by enabling several key capabilities. Like other accounts, agent IDs are primarily a means to access apps, web services, and other systems in your organization. An AI agent can use agent IDs to:

- **Access web services**. Agents can request access tokens from Microsoft Entra, and use those tokens to access web services. Services can include Microsoft services such as Microsoft Graph, services built by your organization, and services purchased from third-party vendors.

- **Autonomous access**. Agents can act autonomously, using access rights given directly to the agent identity. Access rights can include Microsoft Graph permissions, Azure RBAC roles, Microsoft Entra directory roles, Microsoft Entra app roles, and more.

- **Delegated access**. Agents can act on behalf of human users, using access rights given to the user. The user has control over which rights are delegated to the agent identity.

- **Authenticate incoming messages**: Agents can accept requests from other clients, users, and agents. Those requests can be secured using access tokens issued by Microsoft Entra ID, allowing the agent to reliably identify the caller and make authorization decisions.

## Agent IDs in practice

Several Microsoft products already use agent IDs for authenticating AI agents. Two examples include:

- [**Entra Conditional Access optimization agent**](~/identity/conditional-access/agent-optimization.md): When this agent is enabled in your tenant, it's given an agent identity. The Microsoft Entra Conditional Access optimization agent then uses its agent identity to query Microsoft Entra systems and inspect the tenant's configuration. All queries made by the agent are recorded as having been performed by an AI agent. The agent's activity is subject to any security policies enforced for agent identities. You can view the agent's identity in the Microsoft Entra admin center in the **Agent identities** tab.

- **Agents built in Copilot Studio**: In organizations that use Copilot Studio, users can quickly create AI agents using Copilot Studio's low-code tools. Each time an AI agent is created, the agent gets an agent identity in the Microsoft Entra tenant. The user who created the agent is recorded as its sponsor. The agent can then use its agent identity to send/receive chat messages to users, and connect to various systems like SharePoint or Dataverse. Any authentication performed by these agents is logged in Microsoft Entra ID as AI agents and viewable through the Microsoft Entra admin center.
