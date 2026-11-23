---
title: AI agent discovery in Global Secure Access (preview)
description: Learn how Global Secure Access uses network traffic to discover managed, shadow, and unclassified AI agents, and investigate their activity.
ms.topic: concept-article
ms.date: 11/22/2026
ms.reviewer: kerenSemel
ai-usage: ai-assisted

#customer intent: As a security admin, I want to discover the AI agents that reach the internet from my environment, including custom and unclassified agents, so I can see who uses them and decide which agents to control.
---

# AI agent discovery in Global Secure Access (preview)

AI agent discovery in Microsoft Entra Global Secure Access gives security teams a network-level view of the AI agents that run in their organization. Global Secure Access analyzes the network traffic that agents generate. It builds an inventory of managed and shadow agents and attributes each agent's activity to the users and devices that ran it.

Discovery covers two kinds of agent activity: local agents that run on endpoints whose traffic Global Secure Access acquires, and cloud agents that run in Microsoft Copilot Studio. Unclassified agent discovery extends this coverage to agentic traffic that doesn't match a known agent type, including custom-built agents.

> [!IMPORTANT]
> AI agent discovery, including unclassified agent discovery, is in preview. This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here. For more information, see the [Microsoft Entra preview terms](https://azure.microsoft.com/support/legal/preview-supplemental-terms/).

## Why AI agent discovery matters

AI agents act autonomously or on behalf of users. They access data, call APIs, and reach external services without direct user interaction. As organizations adopt Copilot, third-party agents, and custom-built agents, much of this activity runs without IT visibility. Without that visibility, security teams can't answer basic questions:

- Which agents run in our environment?
- Who uses each agent, and on which devices?
- Which model providers and Model Context Protocol (MCP) servers does each agent connect to?

AI agent discovery helps you answer these questions:

- **Surface every agent that reaches the internet.** The inventory includes managed agents, shadow agents, and agentic traffic from agents that aren't in any catalog.
- **Attribute activity.** See the user and device that initiated each agent's traffic.
- **Distinguish managed from unmanaged agents.** See which agents your organization already governs.
- **Reveal destinations and traffic volume.** See which external endpoints each agent connects to and how much data it sends and receives.

## How AI agent discovery works

Users run local AI agents and tools, such as command-line assistants, desktop clients, and integrated development environment (IDE) extensions. These agents connect to model providers, MCP servers, and other internet destinations. When this traffic flows through Global Secure Access, the service inspects it to identify AI agent activity. Global Secure Access already sits inline in the network path, so discovery doesn't require new agents, sensors, or endpoint changes.

Global Secure Access analyzes only the traffic that it acquires. To discover local agents, deploy the Global Secure Access client. Local agent type discovery is available only on Windows devices. For the required client and Microsoft Defender versions, see [Prerequisites](#prerequisites).

From this traffic, Global Secure Access builds the agent inventory. The inventory includes the source user and device, destinations, transaction counts, and bytes transferred. Global Secure Access identifies the following types of agents:

- **Shadow local agents**: Known agents from the agent catalog that aren't registered in your directory.
- **Cloud agents (Copilot Studio agents)**: Agents that run in Microsoft Copilot Studio rather than on a user's device. When the Copilot Studio integration with Global Secure Access is enabled, their network activity flows through Global Secure Access. Each Copilot Studio agent has its own agent ID.
- **Agentic traffic (unclassified agents)**: Agentic activity that Global Secure Access can't map to a known agent type. Detection is based on network behavior rather than a fixed catalog, so Global Secure Access can identify agents outside the Microsoft Agent 365 catalog, including custom-built agents.

AI agent discovery in Global Secure Access is aligned with [local AI agent discovery in Microsoft Defender](/defender-endpoint/discover-local-ai-agents). Agents that Global Secure Access discovers on the network complement the agents that Defender detects on your endpoints. Microsoft Agent 365 provides a unified view of the agents that both products discover.

## Unclassified agent discovery

Catalog-based discovery identifies only the local agents that it recognizes. It doesn't cover custom-built agents or agents outside the Microsoft Agent 365 catalog. Unclassified agent discovery closes this gap. It combines Global Secure Access network traffic signals with AI-based detection to identify agent activity directly from the traffic.

Some traffic shows agentic behavior, such as calls to an MCP server or a large language model (LLM), but doesn't match a known agent type. Global Secure Access shows this traffic in the inventory as agentic traffic.

Unclassified agent discovery gives you visibility into custom and third-party agent activity that catalog-based discovery misses. It's also the foundation for governing and controlling this activity with Global Secure Access.

## Prerequisites

To discover AI agents, you need:

- A Microsoft Entra tenant with a Global Secure Access license. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md).
- At least the [Global Secure Access Log Reader](reference-role-based-permissions.md#global-secure-access-log-reader) role to view discovered agents.
- For local agents: The [Global Secure Access client](how-to-install-windows-client.md) installed on the endpoint. The [Internet Access traffic forwarding profile](how-to-manage-internet-access-profile.md) and [Transport Layer Security (TLS) inspection](how-to-transport-layer-security.md) must be enabled.
- For local agent type discovery: Windows devices that run [Global Secure Access client](how-to-install-windows-client.md) version 2.34.222.0 or later, and Microsoft Defender Antivirus platform version 4.18.26090.9 (2609) or later. The devices must meet the [prerequisites for local AI agent discovery in Microsoft Defender for Endpoint](/defender-endpoint/discover-local-ai-agents#prerequisites). Local agent type discovery isn't available on other operating systems.
- For Copilot Studio agents: The [Global Secure Access integration with Copilot Studio](how-to-secure-web-ai-gateway-agents.md#enable-network-controls-for-copilot-studio-agents) enabled.

## View discovered agents

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Global Secure Access Log Reader](reference-role-based-permissions.md#global-secure-access-log-reader).
1. Browse to **Global Secure Access** > **Agents** > **Discovered agents**.

   You can also open this page from the **AI Agent Discovery** widget on the **Global Secure Access** > **Overview** dashboard.

The **AI agent discovery** page shows local and cloud agent activity in one inventory. It opens with a summary of your environment:

- **Total agents**: All AI agents discovered on the network.
- **Managed**: Agents that are governed through Microsoft Agent 365.
- **Unmanaged**: Discovered agents that aren't governed yet, including shadow agents.

Each row in the inventory represents an agent type, such as OpenClaw, GitHub Copilot CLI, or a Copilot Studio agent. The inventory has the following columns:

| Column | Description |
|---|---|
| **Agent** | The identified agent type, for example, OpenClaw, GitHub Copilot CLI, Cursor, or Ollama Desktop. |
| **Agent type ID** | The unique identifier of the agent type. |
| **Platform** | Where the agent runs. **clientPlatform** indicates a local agent on an endpoint. **aiAgentPlatform** indicates a cloud agent, such as a Copilot Studio agent. |
| **Is managed** | Whether the agent is governed through Microsoft Agent 365. |
| **Transactions** | The number of network transactions attributed to the agent type. Select the value to open the traffic logs filtered to this agent type. |
| **Agents** | The number of individual agents of this type that have an agent ID, such as Copilot Studio agents. Select the value to open the **Agents** tab of the details pane. |
| **Users** | The number of distinct users who ran the agent. Select the value to open the **Users** tab of the details pane. |
| **Devices** | The number of distinct devices that the agent ran on. Select the value to open the **Devices** tab of the details pane. |
| **Destinations** | The number of unique destinations that the agent connected to. Select the value to open the **Destinations** tab of the details pane. |
| **Sent bytes** | The volume of data that the agent sent. |
| **Received bytes** | The volume of data that the agent received. |
| **Last access** | When the agent was most recently seen on the network. |
| **First access** | When the agent was first seen on the network. |

### Distinguish local and cloud agents

Use the **Platform** column to tell local agent activity from cloud agent activity:

| Platform value | Agent type | Examples |
|---|---|---|
| **clientPlatform** | Local agents that run on endpoints and send traffic through the Global Secure Access client. | GitHub Copilot CLI, Cursor, Ollama Desktop, Claude Code |
| **aiAgentPlatform** | Cloud agents that run in Microsoft Copilot Studio and send traffic through the Copilot Studio integration with Global Secure Access. | Copilot Studio agents |

To focus on one type of agent, filter or sort the inventory by **Platform**.

### Filter and export the inventory

To narrow the list, use **Search**, the **Last access** time range, **Timezone**, and **Add filter**. To change the visible columns, select **Columns**. To export the inventory, select **Download**. To update the data, select **Refresh**.

## Investigate an agent's activity

From the inventory, you can drill into an agent type to see who uses it, on which devices, and where it sends traffic.

### Open the details pane

In the inventory row for an agent type, select the value in the **Agents**, **Users**, **Devices**, or **Destinations** column. A details pane opens on the matching tab. Each tab has a **Search** box and shows the number of items.

| Tab | What it shows | Columns |
|---|---|---|
| **Agents** | The individual agents of this type that have an agent ID, such as Copilot Studio agents. | Agent ID, Agent name, Agent type name, Agent type ID, Virtual ID, Traffic type, Last activity |
| **Users** | Each user who ran the agent. | User principal name, User ID, Traffic type, Transactions, Last access |
| **Devices** | Each device that the agent ran on. | Device ID, Operating system, Traffic type, Last access |
| **Destinations** | Each endpoint that the agent connected to. | FQDN, IP, Traffic type, Transactions, Last access |

:::image type="content" source="media/concept-ai-agent-discovery/agent-details-users.png" alt-text="Screenshot of the details pane for the OpenClaw agent type with the Users tab selected, showing one user with traffic type, transactions, and last access time.":::

### View agent traffic logs

To inspect the individual transactions for an agent type, select the value in the **Transactions** column. The traffic logs open, filtered to that agent type.

Use this information to assess an agent's risk before you apply controls.

## Protect discovered agents

After you review discovered agents, you can move from visibility to control:

- To start applying network controls to AI agents, select **Enable GSA Security Policies** on the **AI agent discovery** page. Network controls for agents are available with Microsoft Agent 365 in Microsoft Entra.
- To see more detail about agent connections, review the agent traffic logs and the MCP servers that agents use.

## Related content

- [Shadow AI discovery in Global Secure Access](concept-shadow-ai-discovery.md)
- [How to view Model Context Protocol (MCP) traffic logs in Global Secure Access](how-to-view-model-context-protocol-logging.md)
- [Configure Global Secure Access MCP firewall to secure MCP traffic](how-to-configure-mcp-firewall.md)
- [Configure Secure Web and AI Gateway for Microsoft Copilot Studio agents](how-to-secure-web-ai-gateway-agents.md)
- [Global Secure Access network traffic logs](how-to-view-traffic-logs.md)
- [Discover local AI agents with Microsoft Defender for Endpoint](/defender-endpoint/discover-local-ai-agents)
