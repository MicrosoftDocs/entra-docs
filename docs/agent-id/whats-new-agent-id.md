---
title: What's new in Microsoft Entra Agent ID
description: Learn about new features and updates in Microsoft Entra Agent ID at general availability, including non-Microsoft integrations, migration guides, and enterprise governance.
author: shlipsey3
ms.author: sarahlipsey
ms.service: entra
ms.topic: whats-new
ms.date: 05/01/2026
ai-usage: ai-assisted

#customer-intent: As an IT admin or developer, I want to understand what's new in Microsoft Entra Agent ID at general availability so that I can take advantage of new features for securing AI agents in my organization.

---

# What's new in Microsoft Entra Agent ID

Microsoft Entra Agent ID is now generally available. This release brings first-class identity and access management to AI agents, enabling organizations to authenticate, authorize, govern, and protect agent identities at enterprise scale. Microsoft Entra Agent ID extends Zero Trust principles to AI workloads with purpose-built identity constructs, specialized OAuth flows, and comprehensive security controls.

This article summarizes the key capabilities and documentation currently available.

## Manage AI agents at scale

Microsoft Entra Agent ID introduces new identity constructs and authentication protocols designed specifically for AI agents. Notable updates include:

- [Key concepts](key-concepts.md) - New concepts added to further define core agent identity concepts and their relationships.
- [Administrative relationships](agent-owners-sponsors-managers.md) - Deeper definitions and clarified differences between owners, sponsors, and managers of agent identities, blueprints, and agents' user accounts. 
- [Design patterns](concept-agent-id-design-patterns.md) (New) - Common architectural patterns for agent identity deployments.
- [Best practices](best-practices-agent-id.md) (New) - Recommended approaches for agent identity management.
- [Plan your agent identity architecture](how-to-plan-agent-identity-architecture.md) (New) - Guidance for planning agent identity deployment at scale.
- [Create an agent identity blueprint](create-blueprint.md) and [Create an agent identity](create-delete-agent-identities.md) (Preview) - Use the new "wizard" to create agent identity blueprints and agent identities in the Microsoft Entra admin center.
- [AI-guided setup](agent-id-ai-guided-setup.md) (New) - Automate onboarding with an AI coding agent that walks you through blueprint creation, credential configuration, and agent identity provisioning.
- [Agent identity deletion](concept-agent-identity-deletion.md) (New) - Learn about the automated cascade cleanup process and soft-delete functionality for agent identities.
- [Authentication with the Auth SDK (sidecar)](authentication-with-auth-sdk-sidecar.md) (New) - Overview of the sidecar pattern for agent authentication.
- [Configure SDK for agent identities](microsoft-entra-sdk-for-agent-identities.md) - SDK configuration for token acquisition.
- [Run the sidecar for local development](sidecar-local-development.md) (New) - Local development setup for the Auth SDK.
- [Validate agent tokens in a downstream API](how-to-validate-agent-tokens-downstream-api.md) (New) - Token validation guidance for APIs that receive agent tokens.
- [Configure non-Microsoft agents with Agent ID](configure-third-party-agents.md) (New) - Integration patterns (sidecar and federation) for platforms like AWS, GCP, and n8n.
- [Secure an Amazon Bedrock agent](integrate-aws-bedrock-agent.md) (New) - Step-by-step guide for securing Bedrock agents with Agent ID.
- [Secure an n8n agent](integrate-n8n-agent.md) (New) - Deploy n8n on Azure with Agent ID integration.
- [Migrate custom app registrations](migrate-custom-app-registrations-to-agent-id.md) (New) - Move agents using standard app registrations to Agent ID.
- [Migrate Copilot Studio agents](migrate-copilot-studio-agents-to-agent-id.md) (New) - Move Microsoft Copilot Studio agents to Agent ID.

To simplify agent management across the enterprise, agent registry experiences are converging under [Microsoft Agent 365](/microsoft-365/admin/manage/agent-registry). This change gives customers one place to discover and manage all agents, while Microsoft Entra continues to provide the identity foundation through Agent ID. For more information, see [Agent Registry convergence with Microsoft Agent 365](agent-registry-convergence.md).

## Govern agent identities and lifecycle

Microsoft Entra ID Governance extends lifecycle and access management capabilities to agent identities:

- [Governing agent identities overview](../id-governance/agent-id-governance-overview.md) - Overview of how Microsoft Entra governs agent identity lifecycle and access.
- [Access packages for agent identities](agent-access-packages.md) - Govern agent access through policy-based access packages and permission assignment for both on-behalf-of (OBO) and autonomous (non-OBO) scenarios.
- [Sponsor lifecycle workflows](../id-governance/agent-sponsor-tasks.md) (New) - Automate sponsor maintenance and reassignment for agent blueprints and agent identities.
- [Manage your agent identities](manage-agent-identities-end-user.md) (New) - View and control agent identities you own or sponsor.
- [Agent identity sponsor templates](../id-governance/lifecycle-workflow-templates.md) (New) - Two new lifecycle workflow templates for notifying managers and cosponsors, and automatically transfer sponsorship when an agent identity sponsor changes roles or leaves the organization, to prevent orphaned agents.

## Protect agent access to resources

Conditional Access and ID Protection features extend Microsoft Entra Agent ID to help secure agent identities and their access to resources:

- [Conditional Access for agents](/entra/identity/conditional-access/agent-id) (Updated)- Improved guidance and detailed scenarios for Conditional Access policies, plus new templates for agent-specific policies.
- [Block access for high-risk agent identities](../identity/conditional-access/policy-agent-block-high-risk.md) (New) - Conditional Access template to block sign-ins from risky agent identities.
- [Autonomous agent access policy](../identity/conditional-access/policy-autonomous-agents.md) (New) - Conditional Access template for autonomous agents without user context.
- [On behalf of agent access policy](../identity/conditional-access/policy-on-behalf-of-agents.md) (New) - Conditional Access template for agents acting on behalf of users.

## Related content

- [Security for AI overview](security-for-ai-overview.md)
- [Microsoft Agent 365](/microsoft-agent-365/overview)
- [FAQ](faq.yml)
