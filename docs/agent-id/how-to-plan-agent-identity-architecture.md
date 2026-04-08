---
title: Plan your agent identity architecture
titleSuffix: Microsoft Entra Agent ID
description: Use this decision guide to choose the right identity type, operation pattern, and blueprint and agent identity structure for your AI agents in Microsoft Entra Agent ID.
author: shlipsey3
ms.author: sarahlipsey
ms.topic: concept-article
ms.date: 04/03/2026
ms.custom: agent-id
ai-usage: ai-assisted
#customer intent: As a developer or enterprise architect building AI agents, I want to determine which identity type, operation pattern, and blueprint structure to use so that I can design a secure and scalable agent identity architecture for my scenario.
---

# Plan your agent identity architecture

Before you integrate your AI agent with Microsoft Entra Agent ID, you need to make a series of design decisions. This guide walks you through each decision in order:

1. **Which identity type** your agent needs.
1. **Which operation pattern** your agent uses, including how it acquires tokens and what context it acts in.
1. **How many blueprints** your system requires.
1. **How many agent identities** to create per blueprint.

Work through these decisions in order, because earlier choices shape later ones. Some single-agent deployments might only need the first two steps. For examples of how these decisions map to real-world agent architectures, see [Agent ID design patterns](concept-agent-id-design-patterns.md).

[!INCLUDE [entra-agent-id-preview-note](../includes/entra-agent-id-preview-note.md)]

## Step 1: Choose an identity type

Microsoft Entra ID provides several identity types that an AI agent might use. For most AI agents, **agent identity** is the right choice. Configure the **agent's user account** in addition to an agent identity when the agent must access systems that require a user object. Service principals and regular user accounts aren't recommended for AI agents.

| Identity type | Use when... | Key characteristics |
|---|---|---|
| **Agent identity** | ...the agent acts on its own behalf or on behalf of users | Enforced sponsorship, distinct audit log entries, and blueprint-managed credentials |
| **Agent's user account** | ...the agent needs access to a resource that requires a user object, such as an Exchange mailbox or Teams channel | User account paired 1:1 with an agent identity, with a UPN, manager, and other user properties |
| **Service principal** (not recommended for agent workloads) | ...the workload runs scripted, predictable operations without autonomous decision-making | Classic application identity without agent-specific governance, transparency controls, or lifecycle management |

### Why not a service principal?

Service principals are designed for deterministic, static workloads. Microsoft Entra Agent ID provides agent-specific capabilities that aren't available for service principals, such as:

- A dedicated identity type with explicit entries in sign-in and audit logs, providing traceability and transparency that's hard to achieve with generic service principals.
- Platform-level restrictions on certain high-privilege authorizations, which reduce the blast radius of a compromised agent.
- Enforced sponsorship, so every agent identity has an accountable business owner assigned at creation.
- Blueprint-managed credentials and lifecycle: you create, rotate, and delete agent identities through their parent blueprint, not individually.
- Support for ephemeral agent identities that are created at runtime with inheritable permissions already granted through the blueprint, and deleted when the task completes.

For a detailed comparison, see [Agent identities, service principals, and applications](identity-platform/agent-service-principals.md).

### Why not a regular user account?

Don't use a regular Microsoft Entra user account for an AI agent. User accounts are designed for human sign-in patterns, and assigning them to agents causes problems across every Zero Trust enforcement layer:

- **Conditional Access** policies such as compliant device requirements, multifactor authentication, and terms of use conditions fail for agents because these controls are designed for human interactions.
- **Microsoft Entra ID Protection** uses machine learning tuned for human sign-in behavior. Routing AI agent traffic through user accounts degrades detections for both humans and agents.
- **Identity governance** processes such as joiner-mover-leaver workflows, access packages, and access reviews aren't designed for agent lifecycle patterns and might incorrectly remove agent access.
- Your agents would appear in the Global Address List, Teams, and SharePoint alongside human employees, making it harder to distinguish AI agents from people.

## Step 2: Choose an operation pattern

An agent's operation pattern determines how it acquires tokens and what context it acts in. Microsoft Entra Agent ID supports two primary patterns: autonomous and interactive.

| Characteristic | Autonomous | Interactive |
|---|---|---|
| **User context** | No user present | User is signed in |
| **Permission type** | Application permissions | Delegated permissions |
| **Consent model** | Admin consent required | User or admin consent |
| **Token subject** | Agent identity | User (with agent as actor) |
| **Common scenarios** | Background processing, scheduled tasks, system-to-system | Chat assistants, user-facing copilots, agents acting on user data |
| **Access scope** | Broad, tenant-wide access | Scoped to the signed-in user's data |

Choose **autonomous** when your agent:
- Runs background or scheduled tasks.
- Processes data across multiple users.
- Performs system-to-system operations without a user present.

Choose **interactive** when your agent:
- Operates on behalf of a signed-in user.
- Needs access to that user's data, such as mail, calendar, or files.
- Must respect the user's own permission boundaries.

Some agents need both. For example, an agent might run a nightly background sync using the autonomous pattern and also respond to user chat messages using the interactive pattern. In this case, implement both OAuth flows and select the appropriate token based on the operation.

- For autonomous agents, see [Request agent tokens for autonomous agents](identity-platform/autonomous-agent-request-tokens.md).
- For interactive agents, see [Authenticate users in interactive agents](identity-platform/interactive-agent-authenticate-user.md).

## Step 3: Decide how many agent identity blueprints

An agent identity blueprint manages authentication for all the agent identities created from it. The blueprint holds the credentials used to acquire tokens on behalf of those agent identities. Because of this capability, a blueprint compromise can affect every agent identity under it. Choose your agent identity blueprint count based on your security boundaries.

**Default: use one blueprint per trust boundary.**

A trust boundary is the shared risk surface where a single compromise is assumed to affect the entire perimeter. Agents that share a runtime, secrets, file system, and network share a trust boundary and can share a blueprint.

| Decision factor | Same trust boundary → one blueprint | Different trust boundaries → multiple blueprints |
|---|---|---|
| **Authentication material** | The same credentials can be shared across all agents; credential rotation or compromise affects all agents together | Credentials must be cryptographically isolated; a credential compromise must not spread to peer agents |
| **Security boundary** | Agents run in the same trust boundary: same runtime, secrets, file system, and network | Agents cross trust domain boundaries: separate environments, runtimes, or isolation domains |

The following factors are *not* reasons to add more blueprints:

- **Blocking authentication**: You can disable a single agent identity or target it with a Conditional Access policy without adding a blueprint.
- **Audit separation**: Each agent identity produces its own sign-in and audit log entries under the parent blueprint.
- **Scale-out or replicas**: Running multiple instances of the same agent doesn't require multiple blueprints.
- **Memory or context separation**: Agent memory is typically a shared data store filtered by session ID at retrieval time, which doesn't require separate blueprints.

For more information about blueprints, see [Agent identity blueprints](identity-platform/agent-blueprint.md).

## Step 4: Decide how many agent identities per blueprint

**Default: use one agent identity per logical agent.** A distinct identity for each agent gives you the highest fidelity of audit trails, tracing, and access control.

| Decision factor | Multiple agent identities | Single agent identity |
|---|---|---|
| **Audit and attribution** | Actions must be attributable to a specific agent for investigation, compliance, or accountability | "The system" acting is sufficient; no need to distinguish which agent acted |
| **Lifecycle independence** | Agents are created, deleted, or revoked independently | Agents are created, deleted, and governed as one unit |
| **Role separation** | Agents have distinct responsibilities. For example, inventory lookup, product comparison, and supplier data | Agents are interchangeable |

The following factors are *not* reasons to add more agent identities:

- **Horizontal scale-out**: Running replicas or instances of the same agent code doesn't require separate identities. Scale-out is a runtime concern, not an identity concern.
- **Memory pools and context management**: Agent memory is typically a shared data store filtered by session ID at retrieval time. Separate identities aren't needed for memory or context isolation.

Multi-agent architectures where multiple agent identities are appropriate can include sequential pipelines with distinct agent roles and concurrent orchestrations with specialized domain workers. For more information, see [AI agent orchestration patterns](/azure/architecture/ai-ml/guide/ai-agent-design-patterns).

## Related content

- [Agent ID design patterns](concept-agent-id-design-patterns.md)
- [Agent identity blueprints](identity-platform/agent-blueprint.md)
- [Agent identities, service principals, and applications](identity-platform/agent-service-principals.md)
