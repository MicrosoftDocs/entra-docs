---
title: Microsoft Entra Agent ID design patterns
titleSuffix: Microsoft Entra Agent ID
description: Learn how to map your AI agent architecture to Microsoft Entra Agent ID, including blueprints, agent identities, and an agent's user account.
author: shlipsey3
ms.author: sarahlipsey
ms.topic: concept-article
ms.date: 04/03/2026
ms.custom: agent-id
ai-usage: ai-assisted
#customer intent: As an enterprise architect or developer, I want to understand how real-world agent deployment patterns map to Microsoft Entra Agent ID constructs so that I can design a secure, auditable, and scalable identity architecture for my AI agents.
---

# Microsoft Entra Agent ID design patterns

Microsoft Entra Agent ID introduces new identity constructs as well as new ways of thinking about existing authentication and authorization patterns. To better understand how these constructs fit together, it's helpful to look at common AI agent deployment patterns and how they map to Microsoft Entra Agent ID.

This article describes common AI agent deployment patterns and how they map to Microsoft Entra Agent ID. The article starts with a review of key identity concepts, describes permisssions and trust boundaries, and then walks through common deployment patterns.

For step-by-step decision guidance on how many blueprints and agent identities to create, see [Plan your agent identity architecture](plan-agent-identity-architecture.md).

[!INCLUDE [entra-agent-id-preview-note](../../includes/entra-agent-id-preview-note.md)]

## Key concepts

The following components are the foundation of Microsoft Entra Agent ID. If you're new to them, start with [Microsoft Entra Agent ID key concepts](../identity-platform/key-concepts.md) before continuing with this article.

### Identity constructs

The following identity constructs are used throughout the patterns described in this article:
- **[Agent identity blueprint](../identity-platform/agent-blueprint.md)**: The template and authentication foundation for one or more agent identities. It holds credentials and policies that apply to all agent identities created from it.
- **[Agent identity blueprint principal](../identity-platform/agent-blueprint.md#agent-identity-blueprint-principals)**: The Microsoft Entra object created when a blueprint is added to a tenant. It's what actually acquires tokens, creates agent identities, and appears in audit logs on behalf of the blueprint.
- **[Agent identity](../identity-platform/agent-identities.md)**: The runtime identity for a specific AI agent, with its own permissions on downstream resources.
- **[Agent's user account](../identity-platform/agent-users.md)**: An optional 1:1 account paired with an agent identity, needed only when the agent must access systems that require a user object.

### Permissions models

Blueprint-level permissions and agent identity-level permissions serve different purposes:

- **Blueprint permissions** represent the minimum permissions shared across all agent identities created from the blueprint. Use inheritable permissions on the blueprint when you want all agent identities to start with a common baseline.
- **Agent identity permissions** represent differentiated permissions for a specific agent. Use these permissions when different agents in the same system need different access to downstream resources.

For more information, see [Configure inheritable permissions for blueprints](configure-inheritable-permissions-blueprints.md) and [Authorization in Microsoft Entra Agent ID](authorization-agent-id.md).

### Trust boundary

A **trust boundary** refers to the shared risk surface where a single compromise is assumed to affect the entire perimeter. Agents running on separate platforms with separate service accounts, secrets, and network segments don't share a trust boundary.

A trust boundary is an application threat-modeling decision, not one that Microsoft Entra Agent ID defines for you.

## Deployment patterns

The following patterns are based on real-world agent deployments. Each describes the agent architecture, its identity structure, and relevant permission and governance considerations.

### Low-code singleton agent

A single agent that assists with a specific task, commonly built on a low-code or no-code platform like Microsoft Copilot Studio. The agent either always acts on behalf of a signed-in user (interactive) or always acts as itself (autonomous).

**Structure:** One blueprint → one agent identity

Although a blueprint with a single agent identity might seem redundant, the blueprint gives the agent consistent Conditional Access policies, monitoring, governance, and audit entries — the same infrastructure you need for multi-agent systems, with minimal setup.

**Permissions:** Grant permissions directly on the agent identity. The blueprint's inheritable permissions aren't typically needed for singleton cases.

**Agent's user account:** Not required unless the agent needs access to Exchange, Teams, or another system that requires a user object.

### Domain worker (sequential multi-agent)

Multiple agents work together in a tightly coupled, sequential workflow to serve a common domain goal. The agents typically share a codebase, run in the same runtime environment (for example, the same Kubernetes namespace or container), and have the same security posture. Each agent has distinct responsibilities and different access to downstream resources. This pattern maps to [sequential orchestration](/azure/architecture/ai-ml/guide/ai-agent-design-patterns#sequential-orchestration-example) in multi-agent design.

**Structure:** One blueprint → multiple agent identities (one per agent role)

Using a single blueprint is appropriate here because all agents share the same trust boundary. Each agent gets its own agent identity so that actions can be attributed to a specific agent in audit and sign-in logs, and each can hold different permissions on downstream resources.

*Example: A retail product management system has three agents — store inventory, product comparison, and supplier inventory. All three run in the same Kubernetes namespace and are built by the same team. They use one blueprint with three agent identities, each with permissions scoped to its own resources.*

**Permissions:** Set shared baseline permissions as inheritable on the blueprint. Assign role-specific permissions directly to each agent identity.

**Agent's user account:** Not typically required for domain worker agents.

### Concurrent orchestrator with domain workers

An orchestrator agent dynamically activates different domain workers based on the incoming task. The domain workers might run on different platforms, be operated by different teams, and cross trust boundaries. This pattern maps to [concurrent orchestration](/azure/architecture/ai-ml/guide/ai-agent-design-patterns#concurrent-orchestration) in multi-agent design.

**Structure:**
- Blueprint A → orchestrator agent identity
- Blueprint B → domain worker agent identities (one per role, cross-trust-boundary group)
- Blueprint C → another domain worker group, if operated by a separate team or platform

Because the domain workers cross trust boundaries — separate runtimes, secrets, or teams — they require separate blueprints. The blueprint's credentials are scoped to its trust domain, so a compromise in one domain doesn't affect peer agents.

**Ephemeral agent identities:** A variant of this pattern uses ephemeral agent identities. The orchestrator creates a temporary agent identity at runtime to facilitate a specific interaction (for example, coordinating with a maintenance subsystem), grants it permissions inherited from the blueprint, and deletes the identity when the session ends. This limits the blast radius to the duration of the task.

> [!NOTE]
> Ephemeral agent identity creation happens at runtime, which introduces nondeterministic latency. Evaluate this trade-off for latency-sensitive scenarios.

**Permissions:** Orchestrator and each domain worker group have their own permission sets, scoped to their respective blueprints and agent identities.

**Agent's user account:** Not typically required at the orchestrator or domain worker level, unless a specific domain worker must access a user-object-dependent resource.

### Per-user agents (small-n)

A separate agent identity is created for each user or organizational unit. For example, a SOC analyst agent might have one instance per cloud environment, or an audit agent might have one instance per department. The number of agent identities is moderate — tens to low hundreds — not one per directory user.

**Structure:** One blueprint → one agent identity per user, department, or environment

This pattern is appropriate when each agent instance needs different permissions, different auditing boundaries, or an independent lifecycle (for example, the agent for a department can be disabled without affecting others).

**Permissions:** Each agent identity holds permissions scoped to its user or organizational unit. Inheritable permissions from the blueprint set a minimum baseline, and each agent identity is granted additional permissions as needed.

**Agent's user account:** Consider pairing each agent identity with an agent's user account when each agent acts as a named representative for its user or department — for example, a dedicated sales agent that receives email on behalf of a territory.

### Digital worker (fully autonomous agent)

A fully autonomous agent acts as a digital employee, provisioned with resources typically reserved for human employees: an Exchange mailbox, OneDrive share, and Teams presence. This is the highest level of agent autonomy.

**Structure:** One blueprint → one agent identity → one agent's user account

Each digital worker requires its own agent's user account. The 1:1 relationship between agent identity and agent's user account is fixed — you can't share an agent's user account across multiple agent identities.

*Example: An AI sales representative with a real mailbox, listed in the Global Address List, that responds to email and is assigned a human manager in the org chart.*

**Permissions:** Grant the agent's user account the specific Exchange, Teams, and OneDrive permissions it needs. Grant the agent identity application-level permissions for systems that don't require a user object. For more information, see [Grant agent access to Microsoft 365](grant-agent-access-microsoft-365.md).

**Agent's user account:** Required. Create one agent's user account per digital worker agent identity.

## Patterns to avoid

### Scale-out replicas don't need separate agent identities

Running multiple instances of the same agent code (scale-out) doesn't require separate agent identities. Scale-out is a runtime concern: the blueprint acquires tokens as the agent identity, and multiple instances of the agent can all run under the same identity simultaneously. Creating a separate agent identity per replica adds directory objects and management overhead without any audit, access control, or accountability benefit.

### Memory and context management don't require separate agent identities

Agent memory is typically a shared data store (for example, Azure Cache for Redis or Azure AI Search) where data is filtered by session ID at retrieval time. Access to that data store is controlled by the agent identity's permissions, not by separate identities per session. Separate agent identities for memory isolation add complexity without a security benefit.

### Don't use scaled per-object agent identities in directory

Creating one agent identity per meeting, per document, or per ephemeral object at high volume isn't practical with directory-level identities today. For high-flux scenarios, use shared agent identities and rely on session or context identifiers at the application layer to distinguish interactions.

## Related content

- [Plan your agent identity architecture](plan-agent-identity-architecture.md)
- [Agent identity blueprints](../identity-platform/agent-blueprint.md)
- [Agent identities](../identity-platform/agent-identities.md)
- [Agent's user accounts](../identity-platform/agent-users.md)
- [Configure inheritable permissions for blueprints](configure-inheritable-permissions-blueprints.md)
- [Authorization in Microsoft Entra Agent ID](authorization-agent-id.md)
- [Grant agent access to Microsoft 365](grant-agent-access-microsoft-365.md)
