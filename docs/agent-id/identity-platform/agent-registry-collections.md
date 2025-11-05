---
title: Agent registry collections
description: Learn about agent registry collections in Microsoft Entra ID, which provide secure logical groupings for organizing and managing enterprise AI agents.

author: SHERMANOUKO
ms.author: shermanouko
manager: pmwongera
ms.service: entra-id
ms.topic: concept-article
ms.date: 11/04/2025
ms.reviewer: jadedsouza

#customer-intent: As an IT administrator or security manager, I want to understand how agent registry collections work and how to organize agents into secure groupings, so that I can effectively govern agent discovery, access control, and security policies in my organization.
---

# Agent registry collections

The Microsoft Entra agent registry is the central metadata and management platform for enterprise AI agents within the Microsoft Entra ecosystem. Registry collections serve as logical groupings, or collections, designed to secure, categorize, and manage agents based on their attributes, operational status, and organizational context.

Collections are the fundamental organizing principle of the Microsoft Entra agent registry. They function as secure groupings that group agents and determine how they can discover and interact with each other. These groupings are based on trust, visibility, and security posture. The underlying framework uses Attribute-Based Access Control (ABAC) and an advanced container-based authorization model to enforce secure-by-default policies across all registry interactions.

## Collection types and assignment

Agents are categorized into collections based on secure-by-default policies that control their scopes, discoverability, and how they interact with each other. You can manually reassign an agent into one of the predefined collections. You can also create custom collections based on your needs. Agent ID registry has one predefined collection called **Global collection**. This collection contains all trusted agents with full discoverability across the tenant. Admins need to add agents to this collection in order for other users and agents to discover it globally.

## Agent registry policy enforcement

The ABAC model governs each registry collection, enabling fine-grained, attribute-driven access policies for agent interaction and discovery. Security controls are collection-centric; agents inherit permissions, access boundaries, and nondiscoverability by default, based on their collection assignment. The design ensures Zero Trust and defense-in-depth principles are intrinsically embedded from initial agent registration and detection.

## Baseline policy enforcement

A critical set of predefined baseline security policies are applied to agents based on their collection assignment. These policies are foundational and ensure immediate risk mitigation. Policies are applied at the collection level and inherited by all agents within that collection. It ensures consistent enforcement of security standards across the entire agent ecosystem. Collection policies limit what agents are able to discover based on their collection assignment.

### Discovery control policies

Discovery control type policies limit how agents can discover each other and resources based on their collection assignment. As an admin, you can control which agents are in a global or custom collection. Microsoft Entra works to block discoverability to risky agents through secure by default policies. By default, Microsoft Entra doesn't assign any agent to collections.

### Custom policies

The ability to define and apply custom policies tailored precisely to the unique security and compliance requirements of agents within custom collections. It moves beyond generic security to context-aware, adaptable policies enterprises demand. It also helps you to get your own custom policies in addition to the Registry's secure by default policies.
