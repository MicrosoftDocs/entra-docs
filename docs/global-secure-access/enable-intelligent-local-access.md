---
title: Enable Intelligent Local Network
description: Learn how to enable the Intelligent Local Access (ILA) capability for Microsoft Entra Private Access, which optimizes traffic flow for clients accessing Entra apps via private networks.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 11/18/2025
ms.author: jfields
author: jenniferf-skc
manager: dougeby
ms.reviewer: dhruvinshah
ai-usage: ai-assisted

# Customer intent: As an administrator, I want to enable the Intelligent Local Access (ILA) capability for Microsoft Entra Private Access, to optimize traffic flow for clients accessing Entra apps via private networks.
---

# Enable Intelligent Local Access

Intelligent Local Access capability can help optimize the traffic flow from Microsoft Entra clients to Microsoft Entra apps through private access when the client is on corporate/private network. This article explains how to enable the Intelligent Private Network for Microsoft Entra Private Access.

## Prerequisites

To configure a Global Secure Access Private Networks, you must have:

- [Global Secure Access Administrator](/entra/identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator) role or the [Privileged Role Administrator](/entra/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator) role.

- The product requires licensing. For details, see the licensing section of [What is Global Secure Access](/entra/global-secure-access/overview-what-is-global-secure-access). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).

## Private Access overview

Today, Entra Private Access (PA) sends all traffic, both application and authentication, over the SSE / Private Access service, regardless of the user's location. This process , represented by the green workflow in the diagram, results in network backhauling, which negatively impacts user experience by adding latency and slowing down the network significantly. With the Intelligent Local Access (ILA) feature, we aim to address this issue by enabling intelligent network routing. The Global Secure Access (GSA) client determines how traffic should be routed to private applications, ensuring a consistent security posture for employees, whether they are working remotely or on-premises. This adaptive local access significantly improves user experience by reducing latency and avoiding network hair pinning, represented by the blow workflow in the diagram.

:::image type="content" source="media/enable-intelligent-local-access/microsoft-entra-private-access-intelligent-local-access-workflow.png" alt-text="A diagram showing the workflow between Microsoft Entra Private Access and Intelligent Local Access." lightbox="media/enable-intelligent-local-access/microsoft-entra-private-access-intelligent-local-access-workflow.png":::

## Enable multi-Geo capability 

To enable the Intelligent local access for Microsoft Entra Private Access, complete these steps. This procedure involves creating Private networks and adding application to the private network.

1.  Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/).

2.  Browse to **Global Secure Access** **\> Connect \> Private networks**.

3.  Select **Add Private network**.

:::image type="content" source="media/enable-intelligent-local-access/add-private-network.png" alt-text="A screenshot of a computer AI-generated content may be incorrect." lightbox="media/enable-intelligent-local-access/add-private-network.png":::

4.  In the **Add Private network** panel that opens, define following:

    1.  Name - The friendly name of the network. 

    2.  DNS Servers - Server address(es) used for DNS resolution.

        1.  Internet Protocol version 4 (IPv4) address, such as 192.168.2.1, that identifies a DNS server on the network.

    3.  Fully qualified domain name

        1.  The fully qualified domain name (FQDN) that needs to be resolved. 

    4.  Enter the appropriate details for the selected Resolved to IP address type. Depending on what you select, fill in an appropriate value in the subsequent field **Resolved to IP address value**.

| Resolved to IP address type | Resolved to IP address value |
|---|---|
| **IP address** | Internet Protocol version 4 (IPv4) address, such as 192.168.2.1, that identifies a device on the network. |
| **IP address range (CIDR)** | Classless Inter-Domain Routing (CIDR) represents a range of IP addresses where an IP address is followed by a suffix that indicates the number of network bits in the subnet mask.<br><br>For example, 192.168.2.0/24 indicates that the first 24 bits of the IP address represent the network address, while the remaining 8 bits represents the host address.<br><br>Provide the starting address and network mask. |
| **IP address range (IP to IP)** | Range of IP addresses from start IP (such as 192.168.2.1) to end IP (such as 192.168.2.10).<br><br>Provide the IP address start and end. |

1.  Select **Target Resource**.

    1.  Private Access applications mapped to the Private network.

2.  Select **Create**.

:::image type="content" source="media/enable-intelligent-local-access/create-private-network.png" alt-text="A screenshot of a computer AI-generated content may be incorrect." lightbox="media/enable-intelligent-local-access/create-private-network.png":::

## Key Capabilities

- Enables seamless Zero Trust Network Access (ZTNA) for users anywhere with consistent policy enforcement, when they are local within the corporate network or when they are connecting remotely.

- Performance Optimization 
  - Reduces latency for on-prem users by avoiding unnecessary cloud routing.

- Granular Admin controls

  - Can be enabled per application.

  - Explicit local network detection can be configured with DNS server(s), FQDN to resolve, Resolved to IP Address(es).

- Traffic logs indicate whether traffic was tunneled or locally bypassed.

## Related links
[Understand Private Access](concept-private-access.md)