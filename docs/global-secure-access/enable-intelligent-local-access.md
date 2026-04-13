---
title: Enable Intelligent Local Network
description: Learn how to enable the Intelligent Local Access (ILA) capability for Microsoft Entra Private Access, which optimizes traffic flow for clients accessing Entra apps via private networks.
ms.topic: how-to
ms.date: 11/07/2025
ms.author: jfields
author: jenniferf-skc
ms.reviewer: dhruvinshah
ai-usage: ai-assisted

# Customer intent: As an administrator, I want to enable the Intelligent Local Access (ILA) capability for Microsoft Entra Private Access, to optimize traffic flow for clients accessing Entra apps via private networks.
---

# Enable Intelligent Local Access (preview)

Intelligent Local Access capability can help optimize the traffic flow from Microsoft Entra clients to Microsoft Entra Private Access apps when the client is on a corporate/private network. This article explains how to enable the Intelligent Private Network for Microsoft Entra Private Access.

## Prerequisites

To configure a Global Secure Access (GSA) Private Networks, you must have:

- [Global Secure Access Administrator](/entra/identity/role-based-access-control/permissions-reference#global-secure-access-administrator) role or the [Privileged Role Administrator](/entra/identity/role-based-access-control/permissions-reference#privileged-role-administrator) role.

- Product licensing. For details, see the licensing section of [What is Global Secure Access](/entra/global-secure-access/overview-what-is-global-secure-access). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).

## Private Access overview

Today, Entra Private Access (PA) sends all traffic, both application and authentication, over the SSE / Private Access service, regardless of the user's location. This process, represented by the green workflow in the following diagram, results in network backhauling, which negatively impacts user experience by adding latency and slowing down the network significantly. With the Intelligent Local Access (ILA) feature, we aim to address this issue by enabling intelligent network routing. The GSA client determines how traffic is routed to private applications. This feature ensures a consistent security posture for employees, whether they work remote or on-premises. This adaptive local access significantly improves user experience by reducing latency and avoiding network hair pinning, represented by the blue workflow in the following diagram.

:::image type="content" source="media/enable-intelligent-local-access/microsoft-entra-private-access-intelligent-local-access-workflow.png" alt-text="A diagram showing the workflow between Microsoft Entra Private Access and Intelligent Local Access." lightbox="media/enable-intelligent-local-access/microsoft-entra-private-access-intelligent-local-access-workflow.png":::

The GSA client uses DNS probes to determine if the client is inside the corporate network. Once the client identifies corpnet locations, you can define which Private Access applications should use ILA and bypass the traffic instead of sending it through the cloud backend

## Enable Intelligent local access capability 

To enable the Intelligent local access for Microsoft Entra Private Access, complete these steps. This procedure involves creating Private networks and adding application to the private network.

1.  Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/).

2.  Browse to **Global Secure Access** **\> Connect \> Private networks**.

3.  Select **Add Private network**.

:::image type="content" source="media/enable-intelligent-local-access/add-private-network.png" alt-text="A screenshot showing the UI screen where you can add a private network." lightbox="media/enable-intelligent-local-access/add-private-network.png":::

4.  In the **Add Private network** panel that opens, define following:

    1.  Name - The friendly name of the network. 

    2.  DNS Servers - Server address used for DNS resolution.

        1.  Internet Protocol version 4 (IPv4) address, such as 10.10.2.1, that identifies a DNS server on the network.

    3.  Fully qualified domain name

        1.  The fully qualified domain name (FQDN) that needs to be resolved. 

    4.  Enter the appropriate details for the selected Resolved to IP address type. Depending on what you select, fill in an appropriate value in the subsequent field **Resolved to IP address value**.

| Resolved to IP address type | Resolved to IP address value |
|---|---|
| **IP address** | Internet Protocol version 4 (IPv4) address, such as 10.10.2.1, that identifies a device on the network. |
| **IP address range (CIDR)** | Classless Inter-Domain Routing (CIDR) represents a range of IP addresses where an IP address is followed by a suffix that indicates the number of network bits in the subnet mask.<br><br>For example, 10.10.2.0/24 indicates that the first 24 bits of the IP address represent the network address, while the remaining 8 bits represents the host address.<br><br>Provide the starting address and network mask. |
| **IP address range (IP to IP)** | Range of IP addresses from start IP (such as 10.10.2.1) to end IP (such as 10.10.2.10).<br><br>Provide the IP address start and end. |

5.  Select **Target Resource**.

    1.  Select Quick Access or PA enterprise app which is locally bypassed when this private network is detected.

6.  Select **Create**.

:::image type="content" source="media/enable-intelligent-local-access/create-private-network.png" alt-text="A screenshot of the page where you create a private network." lightbox="media/enable-intelligent-local-access/create-private-network.png":::

## Verify ILA flow on the client

You can use the advanced diagnostic client in Global Secure Access to monitor the ILA network traffic.

Open **Advanced diagnostics** for client.
1. Select **Start Collecting** Network traffic.
1. Filter by Destination IP/FQDN for the end resource.
1. Ensure the default filter for **Action == Tunnel** is removed.
:::image type="content" source="media/enable-intelligent-local-access/advanced-diagnostics-network-traffic.png" alt-text="A screenshot of the Global Secure Access Advanced Diagnostics page showing Network traffic details." lightbox="media/enable-intelligent-local-access/advanced-diagnostics-network-traffic.png"::: 
1. Access the application.
1. Verify that the Connection Status is **Bypassed** and that Action is **Local** in the Network Traffic.
:::image type="content" source="media/enable-intelligent-local-access/network-traffic-connection-status-and-action-settings.png" alt-text="A screenshot of the Global Secure Access Advanced Diagnostics page showing Network traffic status and settings." lightbox="media/enable-intelligent-local-access/network-traffic-connection-status-and-action-settings.png"::: 

## Related links
[Understand Private Access](concept-private-access.md)