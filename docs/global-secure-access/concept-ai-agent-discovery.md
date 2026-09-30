---
title: AI agent discovery in Global Secure Access (preview)
description: Learn how AI agent discovery in Global Secure Access provides network-level visibility into managed and shadow AI agents reaching the internet from your environment.
author: jenniferf-skc
ms.author: jfields
ms.topic: concept-article
ms.date: 06/02/2026
ms.reviewer: kerenSemel
ai-usage: ai-assisted

#customer intent: As a security admin, I want to discover all AI agents reaching the internet from my environment so I can identify managed and shadow agents and attribute their activity to a user, device, and process.
---

# AI agent discovery in Global Secure Access (preview)

AI agent discovery in Microsoft Entra Global Secure Access gives security teams a network-level view of AI agents reaching the internet from your environment — both managed and shadow — with attribution back to the user, device, and process that initiated the activity. Discovery covers local agents (both managed and unmanaged) running on endpoints where the Global Secure Access client is installed, and Microsoft Copilot Studio agents.

AI agent discovery uses the existing network inspection of Global Secure Access, so you get coverage without deploying anything new.

> [!IMPORTANT]
> AI agent discovery is currently in preview. For more information, see the [Microsoft Entra preview terms](https://azure.microsoft.com/support/legal/preview-supplemental-terms/).

## Why AI agent discovery matters

AI agents increasingly act autonomously or on behalf of users, accessing data, calling APIs, and reaching external services without direct user interaction. When agents run outside the visibility of identity and endpoint controls, security teams can't answer basic questions: Which agents are running in our environment? Who or what is using them? Are they sanctioned? What tools is each agent using? What APIs is the agent calling?

AI agent discovery helps you answer those questions by:

- **Surfacing every agent reaching the internet**, including managed agents you've sanctioned and shadow agents you haven't.
- **Attributing activity** back to the user, device, and process that initiated the agent's traffic.
- **Distinguishing managed from shadow agents** by using Microsoft Entra Agent ID to classify each discovered agent.
- **Revealing destinations and traffic volume** so you can see which external endpoints each agent is trying to access and how much network activity it generates.

## How AI agent discovery works

Global Secure Access inspects internet-bound network traffic to identify AI agent activity. Because Global Secure Access already sits inline in the network path, discovery doesn't require new agents, sensors, or endpoint changes.

The discovery process:

- **Inspects internet traffic** flowing through Global Secure Access from your users and devices.
- **Identifies AI agents**, including local agents running on endpoints with the Global Secure Access client and Microsoft Copilot Studio agents.
- **Classifies each agent** as managed or shadow (unmanaged) based on whether it's registered with Microsoft Entra Agent ID.
- **Attributes activity** to the originating user, device, and process so you can investigate and respond.

## What's included in the preview

The preview of AI agent discovery includes:

- **AI Agent Discovery widget** on the Global Secure Access overview dashboard. The widget summarizes the total number of agents, managed agents, shadow agents, and new agents detected in the last seven days.
- **AI Agent Discovery blade** with the aggregated agent inventory across the tenant.
- **Managed vs. unmanaged (shadow) classification** by using Microsoft Entra Agent ID.

## Managed vs. shadow agents

| Aspect | Managed agents | Shadow agents |
|---|---|---|
| Definition | AI agents registered with Microsoft Entra Agent ID and sanctioned by your organization. | AI agents reaching the internet from your environment that aren't registered or sanctioned. |
| Visibility | Tracked in your agent inventory with full identity and policy context. | Discovered through network traffic inspection only. |
| Examples | Sanctioned Microsoft Copilot Studio agents and registered local agents. | Unmanaged local agents such as OpenClaw or Ollama running on user devices. |

## Prerequisites

To discover AI agents, your environment must meet the following requirements:

- **Local agents**: The Global Secure Access client must be installed on the endpoint, with internet access forwarding policy and TLS inspection enabled.
- **Microsoft Copilot Studio agents**: The Microsoft Copilot Studio integration with Global Secure Access must be enabled.

## Access AI agent discovery

AI agent discovery insights are available in the Global Secure Access experience in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Log Reader](/azure/active-directory/roles/permissions-reference#global-secure-access-log-reader).
1. Browse to **Global Secure Access** > **Overview** to see the **AI Agent Discovery** widget summarizing total agents, managed agents, shadow agents, and new agents from the last seven days.
1. Select the widget, or browse to **Global Secure Access** > **AI Agent Discovery**, to open the AI Agent Discovery blade and review the aggregated agent inventory across your tenant.

## Related content

- [Shadow AI discovery in Global Secure Access](concept-shadow-ai-discovery.md)
- [What is application usage analytics?](overview-application-usage-analytics.md)
- [What is Global Secure Access?](overview-what-is-global-secure-access.md)
