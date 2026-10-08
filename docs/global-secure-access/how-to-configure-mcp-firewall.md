---
title: Configure Global Secure Access MCP firewall to secure Model Context Protocol traffic
description: "Learn how to configure the Global Secure Access MCP firewall to inspect, audit, and enforce Allow or Block policies on Model Context Protocol traffic between AI agents and remote MCP servers."
ms.topic: how-to
ms.date: 08/06/2026
ms.reviewer: katabish
ms.custom: sfi-image-nochange
ai-usage: ai-assisted

#customer intent: As an IT admin, I want to configure the Global Secure Access MCP firewall so that I can inspect and control Model Context Protocol traffic between AI agents and remote MCP servers.

---

# Configure Global Secure Access MCP firewall to secure MCP traffic (preview)

As AI agents increasingly rely on external tools, APIs, and data sources to reason and act, the [Model Context Protocol (MCP)](https://modelcontextprotocol.io/) has emerged as the standard interface for communication between large language models (LLMs) and tools. This shift also introduces new security risks. MCP servers expose powerful capabilities—such as file access, database queries, and tool execution—that create a large attack surface if left unguarded. Without comprehensive controls, malicious or misconfigured agents can exfiltrate sensitive data, trigger unintended side effects, or impersonate trusted services.

The Global Secure Access MCP firewall is a network-based, identity-centric security control that provides centralized visibility, policy enforcement, and runtime protection for MCP traffic between AI agents and remote MCP servers. It extends the Global Secure Access Security Service Edge (SSE) capabilities—identity-based access, Conditional Access, and Continuous Access Evaluation —to the MCP protocol layer.

Global Secure Access can now inspect, audit, and enforce security policies on every MCP interaction—including tool invocations, resource access, prompt templates, and server metadata—without requiring changes to the MCP protocol specification, or to MCP client, host, or server implementations, bringing Zero Trust model for AI agents at a globally distributed edge.

> [!NOTE]
> The MCP firewall is currently in preview. This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here. For more information, see the [Microsoft Entra preview terms](https://azure.microsoft.com/support/legal/preview-supplemental-terms/).

This article explains how to create an MCP policy to inspect and control MCP traffic that flows through Global Secure Access.

## Supported scenarios

The MCP firewall inspects MCP traffic (JSON-RPC 2.0 over streamable HTTP and Server-Sent Events) and enforces **Allow** or **Block** decisions based on various conditions. It supports the following key scenarios:

- **Block all MCP traffic.** Disable all MCP communication across the tenant until you review and approve trusted MCP servers.

- **Allow or block MCP servers.** Create allow-lists or deny-lists of MCP servers based on server URL patterns.

- **Allow or block MCP primitives.** Selectively allow or block **Tools**, **Resources**, or **Prompt templates** on a per-server basis.

- **Allow or block specific methods and protocol versions.** Block MCP connection attempts over unencrypted HTTP or enforce protocol hygiene by blocking connections from outdated, potentially vulnerable MCP versions.

## Prerequisites

To configure the MCP firewall, you need the following prerequisites:

- A valid Microsoft Entra tenant.

- A valid Microsoft Entra Internet Access license. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).

- A user with the [Global Secure Access Administrator](reference-role-based-permissions.md#global-secure-access-administrator) role to configure Global Secure Access settings.

- A user with the [Conditional Access Administrator](reference-role-based-permissions.md#conditional-access-administrator) role to configure Conditional Access policies.

- The Global Secure Access client installed on a device (or virtual machine) that is Microsoft Entra joined or Microsoft Entra hybrid joined.

- [Transport Layer Security (TLS) inspection](how-to-transport-layer-security.md) enabled. TLS inspection is required because MCP messages travel in the encrypted payload of the traffic. Without TLS inspection, Global Secure Access can’t parse or enforce MCP policy.

## Initial configuration

To prepare your environment for MCP policies, complete the following initial setup steps:

1. [Enable the Internet Access traffic forwarding profile](how-to-manage-internet-access-profile.md#enable-the-internet-access-traffic-forwarding-profile) and ensure correct user assignments.

2. [Configure the TLS inspection policy](how-to-transport-layer-security.md) so that MCP traffic is decrypted for inspection.

3. Install and configure the Global Secure Access client:

    1. Install the Global Secure Access client on Windows or macOS.
       > [!IMPORTANT]
       > Before you continue, verify that the client’s internet traffic is routed through Global Secure Access.

    2. Select the **Global Secure Access** icon and select the **Troubleshooting** tab.
    3. Under **Advanced Diagnostics**, select **Run tool**.
    4. In the Global Secure Access Advanced Diagnostics window, select the **Forwarding Profile** tab.
    5. Verify that **Internet Access** rules are present in the **Rules** section. This configuration might take up to 15 minutes to apply to clients after you enable the Internet Access traffic profile in the Microsoft Entra admin center.

4. Confirm that the client can reach MCP servers that you plan to cover with MCP policies.

## Configure an MCP policy

To configure the MCP firewall, complete the following steps:

1. Create an MCP policy.

2. Link the MCP policy to a security profile.

3. Configure a Conditional Access policy.

### Create an MCP policy

1.  Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](reference-role-based-permissions.md#global-secure-access-administrator).
2.  Browse to **Global Secure Access** > **Secure** > **MCP policies (Preview)**.
3.  Select **+ Create policy**.
4.  On the **Basics** tab, enter the policy **Name** and **Description**.
5.  On the **Policy settings** tab, pick a **Default action** of Allow or Block.
6.  On the **Add rules** tab, add one or more rules. For each rule, enter the **Rule name**, **Priority, Description**, **Status**, and then configure the matching conditions.
7.  Configure **MCP protocol versions** to allow or block based on MCP version used for communication.

:::image type="content" source="media/how-to-configure-mcp-firewall/mcp-protocol-version.png" alt-text="Screenshot showing MCP protocol version." lightbox="media/how-to-configure-mcp-firewall/mcp-protocol-version.png":::

8.  You may also configure specific **MCP methods**, **Transport protocol**, and **Protected resource metadata**.
9.  Configure **MCP server primitives** based on your requirements:

  - **Block all MCP traffic.** Add a block rule with no server or primitive scoping to disable all MCP protocol traffic across the assigned users.

  - **Match on discovered MCP servers.** Scope the rule to a discovered MCP server based on Gen AI insights

    - Click on **View suggested MCP servers from recent activity**.

    - Pick one or more servers and tools from suggested MCP servers.

    - Select **Add servers and tools**.

  - **Match on known MCP servers.** Scope the rule to one or more known MCP servers by:

    - **Server URL** — enter the server URL, or a comma separated list.

    - Click on **Add server.**

  - **Match on discovered tools.** Discover and add the tools that a server exposes:

    - Add an MCP server URL. Select **Add server**.

    - Once the server is added, select **Discover**.

    - Tools available under this server are listed and a classification is auto applied.

    - You can granularly select the tools to be in scope for this rule.

    - Select a matching condition on the tool name for this rule to be applied.

:::image type="content" source="media/how-to-configure-mcp-firewall/mcp-discovered-tools.png" alt-text="Screenshot showing discovered tools." lightbox="media/how-to-configure-mcp-firewall/mcp-discovered-tools.png":::

  - **Add a primitive manually.** If an MCP server requires authentication or isn't reachable, tools, resources, or prompts can be added manually as well.

    - Add an MCP server URL. Select **Add server**.

    - Select **Add Manually.**

    - Choose the primitive **type** from **Tool, Resource, or Prompt.**

    - Provide a **Name** and **Description.**

    - Select **Add**.

    - Select a matching condition on the tool name for this rule to be applied.

:::image type="content" source="media/how-to-configure-mcp-firewall/mcp-manual-tools.png" alt-text="Screenshot showing manual option." lightbox="media/how-to-configure-mcp-firewall/mcp-manual-tools.png":::

10. Set the **Action** to **Allow** or **Block**.
11. Click **Add**.
12. Select **Next** when all rules are added.
13. On the **Review** tab, review your settings.
14. Click **Create** to create the policy.

> [!TIP]
> To discover which MCP servers and tools are in use in your organization before you author rules, review MCP traffic in **Global Secure Access** > **Monitor** > **Generative AI Insights**. Select an `initialize` response event to see a server’s reported tools and capabilities. For more information, see [How to view Model Context Protocol (MCP) traffic logs in Global Secure Access](how-to-view-model-context-protocol-logging.md).
> These insights also feed into the **View suggested MCP servers from recent activity** option above.


### Link the MCP policy to a security profile

1. Browse to **Global Secure Access** > **Secure** > **Security profiles**.

2. Select the security profile you want to modify.

3. Switch to the **Link policies** view.

4. Configure the link:

1. Select **+ Link a policy** > **Existing MCP policy**.

2. From the **Policy name** menu, select the MCP policy you created.

3. Keep the default values for **Position** and **State**.

4. Select **Add**.

5. Close the security profile.

### Configure a Conditional Access policy

To enforce the Global Secure Access security profile, create a Conditional Access policy with the following configuration:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

2. Browse to **Identity** > **Protection** > **Conditional Access**.

3. Select **+ Create new policy**.

4. Name the policy.

5. Select the users and groups to apply the policy to.

6. Set the **Target resources** to **All internet resources with Global Secure Access**.

7. Configure the **Network**, **Conditions**, and **Grant** sections according to your needs.

8. Under **Session**, select **Use Global Secure Access Security Profile** and select the security profile you created.

9. To create the policy, select **Create**.

For more information, see [Create and link a Conditional Access policy](how-to-configure-web-content-filtering.md#create-and-link-conditional-access-policy).

The MCP policy is successfully configured.

## Test the MCP policy

Test the configuration by using an MCP client or AI agent on a managed device with GSA to connect to an MCP server that matches your policy conditions. Verify that the policy allows or blocks the traffic as expected.

### Example 1: Block a specific tool on an MCP server

This example blocks a single tool while allowing the rest of an MCP server.

1. In your MCP policy, add a rule with the **Action** set to **Block**.

2. Under matching conditions, set the **Server URL** to the target MCP server and add a **Tool name** condition that matches the tool you want to block.

3. Link the policy to a security profile and enforce it with a Conditional Access policy, as described earlier.

4. On a managed device with the Global Secure Access client installed, use an MCP client or agent to connect to the server and invoke the blocked tool.

5. Verify that the tool call is blocked while other tools on the same server continue to work.

6. To confirm the block, review **Global Secure Access** > **Monitor** > **Traffic logs** and the MCP activity in **Generative AI Insights**.

### Example 2: Only allow approved MCP servers

This example blocks all connections while allowing an approved list of MCP servers.

1. In your MCP policy, add a default action of **Block**.

2. Create a rule with the **Action** set to **Allow**.

3. Under matching conditions, set the **Server URL** to the list of allowed MCP servers.

4. Link the policy to a security profile and enforce it with a Conditional Access policy, as described earlier.

5. On a managed device with the Global Secure Access client installed, use an MCP client or agent to connect to the server.

6. Verify that connections only to the specified servers are allowed. Connection to any other server gets blocked.

7. To confirm the block, review **Global Secure Access** > **Monitor** > **Traffic logs** and the MCP activity in **Generative AI Insights**.

## Monitoring and logging

### Review Global Secure Access traffic logs

To view the network-level traffic logs and confirm allow or block decisions:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../identity/role-based-access-control/permissions-reference.md#reports-reader).

2. Browse to **Global Secure Access** > **Monitor** > **Traffic logs**.

### Review MCP activity in Generative AI Insights

To review MCP sessions, tool invocations, and discovered servers:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader).

2. Browse to **Global Secure Access** > **Monitor** > **Generative AI Insights**.

3. Use the **Activity** filter and select **MCP** to view only MCP traffic events.

For details on the fields captured and how to interpret them, see [How to view Model Context Protocol (MCP) traffic logs in Global Secure Access](how-to-view-model-context-protocol-logging.md).

## Known limitations

- The MCP firewall inspects MCP traffic over streamable HTTP and Server-Sent Events transport only. MCP traffic over stdio or other non-HTTP transport isn’t supported.

- Only **remote** MCP servers are inspected. Local MCP servers that run on a device aren’t visible to Global Secure Access.

- JSON-RPC batches aren’t inspected.

- When specific tools, resources, or prompts are configured under MCP server primitives, these details are not rendered in the UI on subsequent retrieval of the rules. The details can be verified using Microsoft Graph API instead.

## Related content

- [How to view Model Context Protocol (MCP) traffic logs in Global Secure Access](how-to-view-model-context-protocol-logging.md)

- [Create content policies for network content filtering](how-to-network-content-filtering.md)

- [Configure Transport Layer Security inspection](how-to-transport-layer-security.md)
