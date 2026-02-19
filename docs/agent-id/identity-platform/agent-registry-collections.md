---
title: Agent Registry collections
description: Learn about Agent Registry collections in Microsoft Entra ID, which provide secure logical groupings for organizing and managing enterprise AI agents.
titleSuffix: Microsoft Entra Agent ID
author: shlipsey3
ms.author: sarahlipsey
ms.service: entra-id
ms.topic: concept-article
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.reviewer: jadedsouza

#customer-intent: As an IT administrator or security manager, I want to understand how Agent Registry collections work and how to organize agents into secure groupings, so that I can effectively govern agent discovery, access control, and security policies in my organization.
---

# Agent Registry collections

Collections in the Microsoft Entra Agent Registry define how agents are logically organized and discovered during agent-to-agent collaboration. When an agent queries the registry, the system evaluates its metadata and returns only agents permitted for discovery based on their collection membership. Collections help organizations establish clear boundaries for discoverability and collaboration, defining how agents can be discovered within the Agent Registry.

Agents with or without an agent identity can be assigned as members of a collection.
- Agents *with* an agent identity can query the registry and discover other agents.
- Agents *without* an agent identity can be part of a collection and be discovered by other agents, but they can't perform discovery themselves.

In other words, agents without an agent identity can act only as target agents in collaboration scenarios. To function as a client agent and query the registry, an agent identity is required.

## Collections types

To help administrators manage agent discoverability, Microsoft Entra Agent Registry offers predefined and custom collections.

- **Global Collection**: Makes agents discoverable across the entire organization.
    - For example, an agent responsible for travel booking within the Global Collection can be discovered and invoked by other agents that have an agent identity and the appropriate [Agent Registry role](../identity-professional/reference-registry-roles.md).
- **Custom collection**: Created by administrators to apply discovery boundaries that align with business or policy needs.
    - For example, if human resources agents should only interact with payroll agents, an admin can create a "human resources department" collection so that only agents within that collection can discover and collaborate with each other.

## Agent collaboration policies

The Microsoft Entra Agent Registry follows the same [Zero Trust principles](/security/zero-trust/zero-trust-overview) as the rest of Microsoft Entra: verify explicitly, use least privilege access, and assume breach. Every agent interaction is governed by multiple policy enforcement layers to ensure secure and compliant communication. To learn how to apply these principles, see [Configure Zero Trust for agents](agent-registry-manage-collections.md).

- **Access policies**: Determine whether an agent can access Microsoft Entra-protected resources, such as other agents, authentication endpoints, or APIs protected by conditional access.
- **Discovery policies**: Define which agents can be discovered through the registry, using system and admin defined policies to determine how agents are discovered during collaboration.

### Agent discovery policies

Discovery policies define how agents are discovered within the registry. You can use system-defined policies provided by Microsoft or create admin-defined policies to suit your organization’s needs.

- **System-defined discovery policies**: System-defined policies apply automatically to Global Collection.
    - Agents in the Global Collection inherit the *Discoverable by All* policy.
    - This policy allows other agents with an agent identity to discover and collaborate with agents in the Global Collection.

- **Admin-defined discovery policies**: Admin-defined discovery policies let you control agent discoverability based on your business or departmental boundaries.
    - For example, you can restrict discovery to a specific department such as HR.

## FAQs

### Q: Do I need to manually move an agent into a collection? Can I do it in bulk?

Yes, In the initial preview release, moving agents into collections is a manual process. When you create a collection; however, you can add multiple agents at one time.

### Q: Is there a limit on the number of custom collections I can create?

No. There is no limit on the number of custom collections you can create.

### Q: Is there a limit on the number of agents in a collection?

Yes. During the preview, each collection supports up to 100 agents.

### Q: What’s the difference between Microsoft Entra Groups and Agent Registry collections?

Microsoft Entra Groups and Agent Registry collections serve different purposes in managing agents and users. The table below summarizes the key distinctions:

| Aspect | Microsoft Entra Groups | Agent Registry collections |
| --- | --- | --- |
| Purpose | Manage access control | Manage discovery and collaboration |
| Used for | People, devices, and agents | Agents |
| Scope | Applies across Microsoft 365 and Entra services | Applies within the Microsoft Entra Agent Registry |
| Analogy | “Who can enter the room” | “Who can be seen and communicated” |

### Q: Are collections a replacement for Microsoft Entra Groups?

No. Collections *complement* Microsoft Entra Groups. They serve different purposes and work together to enforce Zero Trust principles.
- Microsoft Entra Groups manage access control, defining who can sign in and what resources they can access across Microsoft 365 and Entra services.
- Collections in the Microsoft Entra Agent Registry manage discovery and collaboration among agents.

Groups answer, *Who can access what?*.

Collections answer, *Which agents can be discovered and collaborate with each other?*, ensuring secure, policy-driven visibility for agent interactions.

### Q: When should I use Collections vs. Groups?

| If you want to control… | Use… |
| --- | --- |
| Who can sign in or access data | Groups |
| Which agents can be discovered for collaboration | Collections |

### Q: What are quarantined collections?

Quarantined collections are a predefined collection in Microsoft Entra, created to limit discovery for agents. Agents in this collection can't discover other users or agents.

## Related content

- [What is the Microsoft Entra Agent Registry?](what-is-agent-registry.md)
- [Manage agent collections](agent-registry-manage-collections.md)