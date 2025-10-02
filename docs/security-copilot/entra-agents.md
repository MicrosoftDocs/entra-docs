---
title: Microsoft Entra Agents
description: Learn about Microsoft Entra agents, AI-powered automation tools that enhance identity and access management operations.
keywords:
author: shlipsey3
ms.author: sarahlipsey
manager: pmwongera
ms.date: 09/22/2025
ms.update-cycle: 180-days
ms.topic: overview
ms.service: entra
ms.custom: security-copilot
ms.collection: msec-ai-copilot
#Customer intent: As an IT administrator or security professional, I want to understand what Microsoft Entra agents are and how they can help automate identity and access management tasks.
---

# Microsoft Entra agents

Microsoft Entra agents can automate many identity and access management operations in your organization to help reduce manual workloads. These agents work seamlessly with [Microsoft Security Copilot](/copilot/security/microsoft-security-copilot) to automate repetitive tasks, provide suggestions, and help administrators focus on higher-value strategic work.

Microsoft Entra agents analyze your identity environment, apply best practices, and take automated actions to improve your identity and access security posture and operational efficiency. They integrate directly with Microsoft Entra services, using your organization's identity data and configuration to provide contextual, actionable insights.

## What are Microsoft Entra agents?

Microsoft Entra agents are AI-powered tools that operate in your organization's identity environment to automate and optimize identity and access management tasks. The agents are grounded in the concepts and tasks for a specific product area, like Conditional Access. These agents can:

- **Automate routine tasks** - Handle time-consuming, repetitive identity and access management operations
- **Provide suggestions** - Analyze your environment and suggest improvements based on Microsoft best practices and Zero Trust principles
- **Operate autonomously** - Run on schedules or triggers to continuously monitor and optimize your identity infrastructure
- **Integrate seamlessly** - Work within your organization's existing Microsoft Entra workflows
- **Learn and adapt** - Improve suggestions over time, based on your environment and feedback

Each agent works a little differently, but at their core, they first analyze your current environment within the boundaries of the agent's capabilities. If the agent identifies a gap, opportunity, or potential issue, it can take action on your behalf. Each agent provides the context, reasoning, and activity history for how it came up with the suggestion.

Administrators can configure the agent to run automatically or trigger the agent to run manually. 

## Available Microsoft Entra agents

The following agents are currently available for Microsoft Entra. Due to the fast pace at which these agents are released and updated, each agent might have features at various stages of availability. Preview features are added frequently.

### Access Review Agent

Empower your reviewers to make fast and accurate access decisions. The [Access Review Agent](../id-governance/access-review-agent.md) with [Microsoft Entra ID Governance](../id-governance/identity-governance-overview.md) delivers insights and recommendations so reviewers can complete their work through a simple conversation, right inside Microsoft Teams.

| Attribute           | Description |
|---------------------|------------ |
| Identity            | Runs with identity of the administrator who configured the agent. Final decisions as part of the Microsoft Teams conversation use the reviewer's identity. |
| Licenses            | [Microsoft Entra ID Governance or Microsoft Entra Suite](../id-governance/licensing-fundamentals.md) |
| Permissions         | Get details for access reviews<br>Read details and lifecycle workflow history for users, groups, apps, and access packages<br>Save access review suggestions and justifications |
| Plugins             | [Microsoft Entra](/entra/fundamentals/copilot-security-entra) |
| Products            | [Security Copilot](/copilot/security/microsoft-security-copilot)<br>[Access Reviews](../id-governance/access-reviews-overview.md) |
| Role-based access   | Both [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) and [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) are required to configure and use the agent |
| Trigger             | Runs every 24 hours or triggered manually |

### Conditional Access optimization agent

The [Conditional Access optimization agent](../identity/conditional-access/agent-optimization.md) ensures comprehensive user protection by analyzing your Conditional Access policies and recommending improvements. The agent evaluates your current policy configuration against Microsoft best practices and Zero Trust principles.

| Attribute           | Description |
|---------------------|------------ |
| Identity            | Runs with the identity of the administrator who configured the agent |
| Licenses            | [Microsoft Entra ID P1](licensing.md) |
| Permissions         | Review policy configuration<br>Create new policies in report-only mode<br>Suggest policy changes requiring approval |
| Plugins             | [Microsoft Entra](/entra/fundamentals/copilot-security-entra) |
| Products            | [Security Copilot](/copilot/security/microsoft-security-copilot)<br>[Microsoft Entra Conditional Access](/entra/identity/conditional-access/) |
| Role requirements   | [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) to configure the agent<br>[Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) to use the agent |
| Trigger             | Runs every 24 hours or triggered manually |

## Getting started with Microsoft Entra agents

### Prerequisites

- You must have available [security compute units (SCU)](/copilot/security/manage-usage).
    - In order to purchase security compute units, you need to have an Azure subscription. [Create your free Azure account](https://azure.microsoft.com/free).
- Review [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security)

### Setup process

1. Enable Security Copilot using the [Security Copilot setup guide](/copilot/security/get-started-security-copilot).
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) using the least privileged role required for the agent you want to configure.
1. Browse to **Agents** and select **View details** for the agent you want to configure.

## Agents in the Microsoft ecosystem

While this article focuses on Microsoft Entra agents, similar agents are available across other Microsoft security products. For more information, see [Microsoft Intune](/intune/intune-service/copilot/security-copilot-agents-intune), [Microsoft Defender](/defender-xdr/security-copilot-agents-defender), and [Microsoft Purview](/purview/copilot-in-purview-agents). 

## Related content

- [Microsoft Security Copilot in Microsoft Entra](copilot-security-entra.md)
- [Security Copilot scenarios in Microsoft Entra](copilot-entra-security-scenarios.md)
- [Microsoft Security Copilot agents overview](/copilot/security/agents-overview)
