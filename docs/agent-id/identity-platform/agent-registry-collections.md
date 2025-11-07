---
title: Agent Registry collections
description: Learn about Agent Registry collections in Microsoft Entra ID, which provide secure logical groupings for organizing and managing enterprise AI agents.
titleSuffix: Microsoft Entra Agent ID
author: shlipsey3
ms.author: sarahlipsey
manager: pmwongera
ms.service: entra-id
ms.topic: concept-article
ms.date: 11/07/2025
ms.reviewer: jadedsouza

#customer-intent: As an IT administrator or security manager, I want to understand how Agent Registry collections work and how to organize agents into secure groupings, so that I can effectively govern agent discovery, access control, and security policies in my organization.
---

# Agent Registry collections

Collections in the Microsoft Entra Agent Registry define how agents are logically organized and discovered during agent-to-agent collaboration. When an agent queries the registry, the system evaluates its metadata and returns only agents permitted for discovery based on their collection membership. This discoverability is governed by the collections the agents belong to. Collections were introduced to give organizations precise, dynamic, and secure control over which agents can be discovered and can collaborate with, supporting advanced security, compliance, and interoperability needs that traditional group-based access controls cannot address.

## How does it work?

Collections were introduced to manage agent discoverability and collaboration, which are governed by Attribute-Based Access Control (ABAC) and Role-Based Access Control (RBAC):
- **Control plane**: Admins configure which agents belong to which collections, set discovery boundaries, and assign roles and attributes using Role Assignment.
- **Data plane**: At runtime, the registry enforces these policies—evaluating agent metadata, collection membership, and ABAC attributes to determine which agents are discoverable and can interact.

This separation ensures that policy changes (control plane) are immediately reflected in agent discovery and collaboration (data plane), supporting dynamic collaboration and discovery. In simple terms, collections control *who can be discovered and collaborated with*.

> [!TIP]
> Groups manage access controls.
> Collections manage discovery and collaboration visibility.

### Agent collaboration

The Microsoft Entra Agent Registry follows the same [Zero Trust principles](/security/zero-trust/zero-trust-overview) as the rest of Microsoft Entra: verify explicitly, use least privilege access, and assume breach. Every agent interaction is governed by multiple policy enforcement layers to ensure secure and compliant communication.

- **Access policies**: Determine whether an agent can access Microsoft Entra-protected resources, such as authentication endpoints or APIs protected by Conditional Access.
- **Discovery policies**: Define which agents can be discovered through the registry.

These policies work together to:

- **Layered Security (Zero Trust)**: Discovery policies add a critical security layer by reducing the attack surface. If an agent isn’t discoverable, it can’t be targeted, even if access policies are misconfigured.
- **Privacy and Segmentation**: Sensitive or high-value agents can be hidden from discovery, ensuring only authorized agents or teams are aware of their existence.
- **Operational Simplicity**: By separating discovery from access, organizations can manage visibility and collaboration boundaries independently from resource permissions. This concept prevents policy sprawl and tangled configurations.
- **Compliance**: Discovery policies help enforce compliance requirements by ensuring only appropriate agents are visible to specific groups, departments, or external partners.

### Agent discoverability

Administrators can manage which agents are discoverable using predefined and custom collections.

- **Global collection**: Makes agents discoverable across the entire organization. 
- **Custom collection**: Allow admins to define discovery boundaries aligned with business or policy needs.

For example, if human resources agents should only interact with payroll agents, an admin can create an HR Department collection so that only agents within that collection can discover and collaborate with each other.

| Collection Type     | Discoverability                     |
|---------------------|------------------------------------|
| Global collection   | Discoverable by all agents         |
| Custom collection   | Discoverable by a defined subset of agents |

## Why do I need groups and collections?

While both collections and Microsoft Entra Groups help manage organizational boundaries, they serve different purposes.
For example:
- A finance agent calls the payroll agent to generate salaries (payroll agent is the server).
- The payroll agent then calls the tax agent for calculations (payroll agent is the client).

If you rely only on groups to organize these types of boundaries, access rights and discovery rules could quickly get tangled.

- **Microsoft Entra Groups**: Used for managing access for people and devices across Microsoft 365 and Microsoft Entra services.
- **Microsoft 365 Groups**: Used primarily for collaboration within applications such as Teams, Outlook, and SharePoint.
- **Security Groups**: Used to assign permissions and control access to applications, files, and other organizational resources.
- **Collections**: Used for managing agent discoverability and collaboration within the Agent Registry.

| Aspect | Groups | Collections |
| --- | --- | --- |
| Purpose | Manage access control | Manage discovery and collaboration |
| Used for | People, devices, agents | Agents |
| Scope | Applies across all Microsoft 365 and Microsoft Entra services | Applies within the Agent Registry and can be used by builder platforms (i.e, Copilot Studio, Azure AI Foundry) |
| Analogy | *Who can enter the house* | *Who can I discover within the house or split into different rooms* |

Collections exist to separate these concerns:
- **Microsoft Entra Groups**: Manage access
- **Collections**: Manage discovery and collaboration

| If you want to control… | Use… |
| --- | --- |
| Who can sign in or access data | Groups |
| Which agents can be discovered for collaboration | Collections |

## Related content

- [What is the Microsoft Entra Agent Registry?](what-is-agent-registry.md)
- [Manage agent collections](agent-registry-manage-collections.md)