---
title: "Learn about Secure Web and AI Gateway for Microsoft Copilot Studio agents"
description: "Learn about the features and benefits of our Secure Web and AI Gateway for agents in Global Secure Access."
author: garrodonnell
ms.author: godonnell
ms.reviwer: fgomulka
ms.service: global-secure-access
ms.topic: concept-article   
ms.date: 11/03/2025
ai-usage: ai-assisted

#Customer intent: As an IT administrator, I want to understand how the Secure Web and AI Gateway for agents works in Global Secure Access so that I can effectively implement and manage it within my organization.
---

# Learn about Secure Web And AI Gateway for Microsoft Copilot Studio agents (preview)

[!INCLUDE [entra-agent-id-license-note](../includes/entra-agent-id-license-note.md)]

As organizations adopt autonomous and interactive AI agents to perform tasks previously handled by humans, administrators need visibility and control over agent network activity. Global Secure Access for agents provides network security controls for Microsoft Copilot Studio agents, enabling you to apply the same security policies to agents that you use for users.

With Global Secure Access for agents, you can regulate how agents use knowledge, tools, and actions to access external resources. You can apply network security policies including web content filtering, threat intelligence filtering, and network file filtering to agent traffic.

## How network security for Copilot Studio agents works

To enforce network security controls on Copilot Studio agents, you forward agent traffic to Global Secure Access's globally distributed proxy service. You enable traffic forwarding in the Power Platform Admin Center on a per-environment or per-environment-group basis.

Agent traffic forwarding applies to multiple traffic types, including:
- HTTP Node traffic
- Custom connectors
- MCP Server Connector

Once agent traffic is forwarded to Global Secure Access, you can apply security policies to the traffic. The service evaluates agent traffic against your configured security policies, similar to how it evaluates user traffic.

![Diagram showing agent traffic flowing through Global Secure Access to protected resources.](media/concept-secure-web-ai-gateway-agents/agent-traffic-flow.png)

## Security policies for agents

Security policies for agents are configured using the baseline profile in Global Secure Access. The baseline profile applies security policies at the tenant level, ensuring consistent security controls across all agent traffic.

## Next steps

- [Configure network security for Microsoft Copilot Studio agents](how-to-secure-web-ai-gateway-agents.md)
- [Learn about Global Secure Access](overview-what-is-global-secure-access.md)
- [Learn about traffic forwarding profiles](concept-traffic-forwarding.md)