---
title: Microsoft Entra agents
description: Learn about Microsoft Entra agents, AI-powered automation tools that enhance identity and access management operations.
keywords:
author: shlipsey3
ms.author: sarahlipsey
manager: pmwongera
ms.date: 08/22/2025
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

Microsoft Entra agents can:

- **Automate routine tasks** - Handle time-consuming, repetitive identity and access management operations
- **Provide suggestions** - Analyze your environment and suggest improvements based on Microsoft best practices and Zero Trust principles
- **Operate autonomously** - Run on schedules or triggers to continuously monitor and optimize your identity infrastructure
- **Integrate seamlessly** - Work within your organization's existing Microsoft Entra workflows
- **Learn and adapt** - Improve suggestions over time, based on your environment and feedback

## How Microsoft Entra agents work

Each agent works a little differently, but at their core, they first analyze your current environment within the boundaries of the agent's capabilities. If the agent identifies a gap, opportunity, or potential issue, it can take action on your behalf. Each agent provides the context, reasoning, and activity history for how it came up with the suggestion.

## Available Microsoft Entra agents

The following agents are currently available for Microsoft Entra. Due to the fast pace at which these agents are released and updated, each agent might have features at various stages of availability. Preview features are added frequently.

### Conditional Access optimization agent

The [Conditional Access optimization agent](../identity/conditional-access/agent-optimization.md) ensures comprehensive user protection by analyzing your Conditional Access policies and recommending improvements. The agent evaluates your current policy configuration against Microsoft best practices and Zero Trust principles.

**Key capabilities:**
- Identifies users and applications not covered by Conditional Access policies
- Recommends policies for multifactor authentication enforcement or device-based controls (compliance, app protection, domain-joined devices)
- Detects and helps block legacy authentication and device code flows
- Creates new policies in report-only mode for safe testing
- Builds a phased rollout plan for policy implementation

| Attribute           | Description |
|---------------------|------------ |
| Trigger             | Runs every 24 hours or can be triggered manually                                                                                                |
| Permissions         | Reviews policy configuration, creates new policies in report-only mode, suggests policy changes requiring approval                              |
| Identity            | Runs with the permissions of the administrator who configured the agent                                                                         |
| Products            | [Microsoft Entra Conditional Access](/entra/identity/conditional-access/), [Security Copilot](/copilot/security/microsoft-security-copilot)      |
| Plugins             | [Microsoft Entra](/entra/fundamentals/copilot-security-entra)                                                                                    |
| Role requirements   | [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) or [Global Administrator](../identity/role-based-access-control/permissions-reference.md#global-administrator) to configure the agent |

## Getting started with Microsoft Entra agents

### Prerequisites

- You must have at least the [Microsoft Entra ID P1](licensing.md) license.
- You must have available [security compute units (SCU)](/copilot/security/manage-usage).
    - In order to purchase security compute units, you need to have an Azure subscription. [Create your free Azure account](https://azure.microsoft.com/free).
- [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) or [Global Administrator](../identity/role-based-access-control/permissions-reference.md#global-administrator) automatically have the required permissions to configure agents.
- Review [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security)

### Setup process

1. Enable Security Copilot using the [Security Copilot setup guide](/copilot/security/get-started-security-copilot).
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator).
1. Browse to **Agents** and select **View details** for the agent you want to configure.

## Agents in the broader Microsoft ecosystem

While this article focuses on Microsoft Entra agents, similar agents are available across other Microsoft security products. For more information, see [Microsoft Intune](/intune/intune-service/copilot/security-copilot-agents-intune), [Microsoft Defender](/defender-xdr/security-copilot-agents-defender), and [Microsoft Purview](/purview/copilot-in-purview-agents). 

## Related content

- [Microsoft Security Copilot in Microsoft Entra](copilot-security-entra.md)
- [Security Copilot scenarios in Microsoft Entra](copilot-entra-security-scenarios.md)
- [Microsoft Security Copilot agents overview](/copilot/security/agents-overview)