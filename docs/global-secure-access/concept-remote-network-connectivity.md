---
title: Global Secure Access remote network connectivity
description: Learn how remote network connectivity in Global Secure Access allows users to connect to your corporate network from a remote location, such as a branch office.
ms.topic: concept-article
ms.reviewer: abhijeetsinha
ms.date: 04/01/2026
ai-usage: ai-assisted
---

# Understand remote network connectivity

## Overview

Global Secure Access supports two connectivity options: installing a client on an end-user device and configuring a remote network, such as a branch location with a physical router. Remote network connectivity streamlines how your end-users and guests connect from a remote network without needing to install the Global Secure Access Client.

This article describes the key concepts of remote network connectivity along with common scenarios where it's useful.

## What is a remote network? 

Remote networks are remote locations or networks that require internet connectivity. For example, many organizations have a central headquarters and branch office locations in different geographic areas. These branch offices need access to corporate data and services. They need a secure way to communicate with the data center, headquarters, and remote workers. The security of remote networks is crucial for many types of organizations.

Typically, you connect remote networks, such as a branch location, to the corporate network through a dedicated Wide Area Network (WAN) or a Virtual Private Network (VPN) connection. Employees in the branch location connect to the network by using customer premises equipment (CPE).

## Current challenges of remote network security 

**Bandwidth requirements have grown** – The number of devices requiring internet access is increasing exponentially. Traditional networks are difficult to scale. With the advent of Software as a Service (SaaS) applications like Microsoft 365, there are ever-growing demands for low latency and jitter-free communication that traditional technologies like Wide Area Network (WAN) and Multi-Protocol Label Switching (MPLS) struggle with. 

**IT teams are expensive** – Typically, you place firewalls on physical devices on-premises, which requires an IT team for setup and maintenance. Maintaining an IT team at every branch location is expensive. 

**Evolving threats** – Malicious actors continue to find new avenues to attack the devices at the edge of networks. Edge devices in branch offices or even home offices are often the most vulnerable point of attack.

> [!TIP]
> For guidance on enhancing the resilience of remote networks, see [Best practices for Global Secure Access remote network resilience](remote-network-resilience.md).

## How does Global Secure Access remote network connectivity work? 

To connect a remote network to Global Secure Access, set up an Internet Protocol Security (IPsec) tunnel between your on-premises equipment and the Global Secure Access endpoint. Route the traffic you specify through the IPsec tunnel to the nearest Global Secure Access endpoint. You can apply security policies in the Microsoft Entra admin center.

Global Secure Access remote network connectivity provides a secure solution between a remote network and the Global Secure Access service. It doesn't provide a secure connection between one remote network and another.
For more information about secure remote network-to-remote network connectivity, see the [Azure Virtual WAN documentation](/azure/virtual-wan/).

## Supported traffic forwarding profiles

Remote networks support different traffic forwarding profiles for acquiring traffic. Traffic forwarding profiles control which traffic is routed through Global Secure Access. Security profiles, such as the baseline profile, control what policies are applied to that acquired traffic.

| Traffic forwarding profile | Global Secure Access client | Remote network |
|---|---|---|
| **Microsoft traffic** | ✅ Supported | ✅ Supported |
| **Internet Access** | ✅ Supported | ✅ Supported |
| **Private Access** | ✅ Supported | ❌ Not supported |

> [!IMPORTANT]
> You can assign the **Microsoft traffic** and **Internet Access** traffic forwarding profiles to remote networks. The **Private Access** traffic forwarding profile requires the Global Secure Access client installed on end-user devices. For more information, see [Assign a traffic profile to a remote network](how-to-assign-traffic-profile-to-remote-network.md) and [Understand traffic forwarding profiles](concept-traffic-forwarding.md).

After you acquire traffic through a forwarding profile, apply security policies to it by using security profiles. The [baseline security profile](how-to-apply-security-policies-remote-network.md) enforces policies at the tenant level for all traffic routed through Global Secure Access, including remote network traffic. User-aware security profiles linked to Conditional Access policies require the Global Secure Access client.

[!INCLUDE [remote-network-traffic-enforcement-include](../includes/remote-network-traffic-enforcement-include.md)]
 
## Why is remote network connectivity important for you? 
Maintaining security of a corporate network is increasingly difficult in a world of remote work and distributed teams. Security Service Edge (SSE) promises a world of security where customers can access their corporate resources from anywhere in the world without needing to backhaul their traffic to headquarters.

## Common remote network connectivity scenarios

### I don't want to install clients on thousands of devices on-premises. 
Generally, you enforce SSE by installing the client on a device. The client creates a tunnel to the nearest SSE endpoint and routes all internet traffic through it. SSE solutions inspect the traffic and enforce security policies. If your users aren't mobile and are based in a physical branch location, remote network connectivity for that branch location removes the pain of installing the client on every device. You can connect the entire branch location by creating an IPSec tunnel between the core router of the branch office and the Global Secure Access endpoint.

### I can't install clients on all the devices my organization owns.
Sometimes, you can't install the client on all devices. Global Secure Access currently provides clients for Windows, macOS, Android, and iOS. But what about Linux, mainframes, cameras, printers, and other types of devices that are on-premises and send traffic to the internet? You still need to monitor and secure this traffic. When you connect a remote network, you can set policies for all traffic from that location regardless of the device where it originated.

### I have guests on my network who don't have the client installed.  
Guest devices on your network might not have the client installed. To ensure that those devices adhere to your network security policies, you need their traffic routed through the Global Secure Access endpoint. Remote network connectivity solves this problem. You don't need to install the client on guest devices. All outgoing traffic from the remote network goes through security evaluation by default.  

### What is the bandwidth allocation for each tenant? 

The number of licenses you buy determines your total bandwidth allocation. Each Microsoft Entra ID P1 license, Microsoft Entra Internet Access license, and Microsoft Entra Suite license adds to your total bandwidth. You can assign bandwidth for remote networks to IPsec tunnels in increments of 250 Mbps, 500 Mbps, 750 Mbps, or 1,000 Mbps. This flexibility means you can allocate bandwidth to different remote network locations based on your specific needs. For best performance, Microsoft recommends configuring at least two IPsec tunnels per location for high availability. The following table shows the total bandwidth based on the number of licenses you purchase. 

#### Initial bandwidth allocation

| Number of licenses | Total Bandwidth (Mbps) |
|---------------|------------------------|
| 50 – 99       | 500 Mbps               |
| 100 – 499     | 1,000 Mbps             |
| 500 – 999     | 2,000 Mbps             |
| 1,000 – 1,499 | 3,500 Mbps             |
| 1,500 – 1,999 | 4,000 Mbps             |
| 2,000 – 2,499 | 4,500 Mbps             |
| 2,500 – 2,999 | 5,000 Mbps             |
| 3,000 – 3,499 | 5,500 Mbps             |
| 3,500 – 3,999 | 6,000 Mbps             |
| 4,000 – 4,499 | 6,500 Mbps             |
| 4,500 – 4,999 | 7,000 Mbps             |
| 5,000 – 5,499 | 10,000 Mbps            |
| 5,500 – 5,999 | 10,500 Mbps            |
| 6,000 – 6,499 | 11,000 Mbps            |
| 6,500 – 6,999 | 11,500 Mbps            |
| 7,000 – 7,499 | 12,000 Mbps            |
| 7,500 – 7,999 | 12,500 Mbps            |
| 8,000 – 8,499 | 13,000 Mbps            |
| 8,500 – 8,999 | 13,500 Mbps            |
| 9,000 – 9,499 | 14,000 Mbps            |
| 9,500 – 9,999 | 14,500 Mbps            |
| 10,000 +      | 35,000 Mbps +          |

**Table notes**
- You need at least 50 licenses to use the remote network connectivity feature. 
- The number of licenses is the total number of licenses you purchase (Microsoft Entra ID P1 + Microsoft Entra Internet Access / Microsoft Entra Suite). After 10,000 licenses, you get an extra 500 Mbps for every 500 licenses you buy (for example, 11,000 licenses = 36,000 Mbps). 
- Organizations that go beyond 10,000 licenses often operate at an enterprise scale and need more robust infrastructure. The jump to 35,000 Mbps ensures ample capacity to meet the demands of such deployments, supports higher traffic volumes, and provides the flexibility to expand bandwidth allocations as needed. 
- If you need more bandwidth, you can buy extra bandwidth in increments of 500 Mbps through the Remote Network Bandwidth SKU.

#### Examples of allocated bandwidth per tenant 

**Tenant one:**

- 1,000 Microsoft Entra ID P1 licenses
- Allocated: 1,000 licenses, 3,500 Mbps

**Tenant two:**

- 3,000 Microsoft Entra ID P1 licenses
- 3,000 Internet Access licenses
- Allocated: 6,000 licenses, 11,000 Mbps

**Tenant three:**

- 8,000 Microsoft Entra ID P1 licenses
- 6,000 Microsoft Entra Suite licenses
- Allocated: 14,000 licenses, 39,000 Mbps

#### Examples of bandwidth distribution for remote networks 

**Tenant one:**

Total bandwidth: 3,500 Mbps

Allocation:

- Site A: 2 IPsec tunnels: 2 x 250 Mbps = 500 Mbps
- Site B: 2 IPsec tunnels: 2 x 250 Mbps = 500 Mbps
- Site C: 2 IPsec tunnels: 2 x 500 Mbps = 1,000 Mbps
- Site D: 2 IPsec tunnels: 2 x 750 Mbps = 1,500 Mbps

Remaining bandwidth: None

**Tenant two:**

Total bandwidth: 11,000 Mbps

Allocation:

- Site A: 2 IPsec tunnels: 2 x 250 Mbps = 500 Mbps
- Site B: 2 IPsec tunnels: 2 x 500 Mbps = 1,000 Mbps
- Site C: 2 IPsec tunnels: 2 x 750 Mbps = 1,500 Mbps
- Site D: 2 IPsec tunnels: 2 x 1,000 Mbps = 2,000 Mbps
- Site E: 2 IPsec tunnels: 2 x 1,000 Mbps = 2,000 Mbps

Remaining bandwidth: 4,000 Mbps

**Tenant three:**

Total bandwidth: 39,000 Mbps

Allocation:

- Site A: 2 IPsec tunnels: 2 x 250 Mbps = 500 Mbps
- Site B: 2 IPsec tunnels: 2 x 500 Mbps = 1,000 Mbps
- Site C: 2 IPsec tunnels: 2 x 750 Mbps = 1,500 Mbps
- Site D: 2 IPsec tunnels: 2 x 750 Mbps = 1,500 Mbps
- Site E: 2 IPsec tunnels: 2 x 1,000 Mbps = 2,000 Mbps
- Site F: 2 IPsec tunnels: 2 x 1,000 Mbps = 2,000 Mbps
- Site G: 2 IPsec tunnels: 2 x 1,000 Mbps = 2,000 Mbps

Remaining bandwidth: 28,500 Mbps

## Next steps
- [List all remote networks](how-to-list-remote-networks.md)
- [Manage remote networks](how-to-manage-remote-networks.md)
- [Best practices for Global Secure Access remote network resilience](remote-network-resilience.md)
