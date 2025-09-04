---
title: Microsoft Security Copilot agents in Microsoft Entra
description: Learn about the available Microsoft Security Copilot agents in Microsoft Entra.
ms.author: joflore
author: MicrosoftGuyJFlo

ms.date: 08/12/2025
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: article
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

Get started with the [Conditional Access optimization agent](../identity/conditional-access/agent-optimization.md)

### Access Review Agent

Empower your reviewers to make fast, accurate access decisions. The [Access Review Agent](../id-governance/access-review-agent.md) delivers insights and recommendations so reviewers can complete their work through a simple conversation, right inside Microsoft Teams.

|Attribute  |Description  |
|---------|---------|
|Trigger     |   Runs every 24 hours or manually to gather insights and save recommendations.      |
|Permissions     | The agent reviews users currently in the scope of your access reviews, and makes suggestions on whether access should be approved or declined. The agent acts based on your selections.        |
|Identity     |   The agent will run with identity of the administrator who configured the agent to gather insights and save recommendations. Final decisions as part of the Microsoft Teams conversation will be written with the reviewer’s identity.       |
|Products     |  [Access Reviews](../id-governance/access-reviews-overview.md), [Security Copilot](/copilot/security/microsoft-security-copilot)       |
|Plugins     |   [Microsoft Entra](/entra/fundamentals/copilot-security-entra)       |
|Role-based access     | Requires both the [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) and [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) roles or the [Global Administrator](../identity/role-based-access-control/permissions-reference.md#global-administrator) role.        |

Get started with the [Access Review Agent](../id-governance/access-review-agent.md)

## Agents in the Microsoft ecosystem

While this article focuses on Microsoft Entra agents, similar agents are available across other Microsoft security products. For more information, see [Microsoft Intune](/intune/intune-service/copilot/security-copilot-agents-intune), [Microsoft Defender](/defender-xdr/security-copilot-agents-defender), and [Microsoft Purview](/purview/copilot-in-purview-agents). 

## Related content

- [Microsoft Security Copilot in Microsoft Entra](copilot-security-entra.md)
- [Security Copilot scenarios in Microsoft Entra](copilot-entra-security-scenarios.md)
- [Microsoft Security Copilot agents overview](/copilot/security/agents-overview)
