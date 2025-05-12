---
title: Global Secure Access remote network connectivity
description: Learn how remote network connectivity in Global Secure Access allows users to connect to your corporate network from a remote location, such as a branch office.
author: kenwith
ms.author: kenwith
manager: femila
ms.topic: conceptual
ms.date: 05/09/2025
ms.service: global-secure-access
ai-usage: ai-assisted
---

# Understand remote network connectivity

Global Secure Access supports two connectivity options: installing a client on end-user device and configuring a remote network, for example a branch location with a physical router. Remote network connectivity streamlines how your end-users and guests connect from a remote network without needing to install the Global Secure Access Client.

This article describes the key concepts of remote network connectivity along with common scenarios where it's useful.

## What is a remote network? 

Remote networks are remote locations or networks that require internet connectivity. For example, many organizations have a central headquarters and branch office locations in different geographic areas. These branch offices need access to corporate data and services. They need a secure way to talk to the data center, headquarters, and remote workers. The security of remote networks is crucial for many types of organizations.

Remote networks, such as a branch location, are typically connected to the corporate network through a dedicated Wide Area Network (WAN) or a Virtual Private Network (VPN) connection. Employees in the branch location connect to the network using customer premises equipment (CPE).

## Current challenges of remote network security 

**Bandwidth requirements have grown** – The number of devices requiring internet access increases exponentially. Traditional networks are difficult to scale. With the advent of Software as a Service (SaaS) applications like Microsoft 365, there are ever-growing demands of low latency and jitter-less communication that traditional technologies like Wide Area Network (WAN) and Multi-Protocol Label Switching (MPLS) struggle with. 

**IT teams are expensive** – Typically, firewalls are placed on physical devices on-premises, which requires an IT team for setup and maintenance. Maintaining an IT team at every branch location is expensive. 

**Evolving threats** – Malicious actors are finding new avenues to attack the devices at the edge of networks. Edge devices in branch offices or even home offices are often the most vulnerable point of attack.

## How does Global Secure Access remote network connectivity work? 

To connect a remote network to Global Secure Access, you set up an Internet Protocol Security (IPSec) tunnel between your on-premises equipment and the Global Secure Access endpoint. Traffic that you specify is routed through the IPSec tunnel to the nearest Global Secure Access endpoint. You can apply security policies in the Microsoft Entra admin center.

Global Secure Access remote network connectivity provides a secure solution between a remote network and the Global Secure Access service. It doesn't provide a secure connection between one remote network and another.
To learn more about secure remote network-to-remote network connectivity, see the [Azure Virtual WAN documentation](/azure/virtual-wan/).
 
## Why remote network connectivity is important for you? 
Maintaining security of a corporate network is increasingly difficult in a world of remote work and distributed teams. Security Service Edge (SSE) promises a world of security where customers can access their corporate resources from anywhere in the world without needing to back haul their traffic to headquarters.

## Common remote network connectivity scenarios

### I don’t want to install clients on thousands of devices on-premises. 
Generally, SSE is enforced by installing a client on a device. The client creates a tunnel to the nearest SSE endpoint and routes all internet traffic through it. SSE solutions inspect the traffic and enforce security policies. If your users aren't mobile and based in a physical branch location, then remote network connectivity for that branch location removes the pain of installing a client on every device. You can connect the entire branch location by creating an IPSec tunnel between the core router of the branch office and the Global Secure Access endpoint.

### I can't install clients on all the devices my organization owns.
Sometimes, clients can't be installed on all devices. Global Secure Access currently provides clients for Windows. But what about Linux, mainframes, cameras, printers, and other types of devices that are on premises and sending traffic to the internet? This traffic still needs to be monitored and secured. When you connect a remote network, you can set policies for all traffic from that location regardless of the device where it originated.

### I have guests on my network who don't have the client installed.  
Guest devices on your network might not have the client installed. To ensure that those devices adhere to your network security policies, you need their traffic routed through the Global Secure Access endpoint. Remote network connectivity solves this problem. No clients need to be installed on guest devices. All outgoing traffic from the remote network is going through security evaluation by default.  

### How much bandwidth will be allocated per tenant 

The total bandwidth you are allocated is determined by the number of licenses purchased. Each Microsoft Entra ID P1 license, Microsoft Entra Internet Access license, or Microsoft Entra Suite license contributes to your total bandwidth. Bandwidth for remote networks can be assigned to IPsec tunnels in increments of 250 Mbps, 500 Mbps, 750 Mbps, or 1000 Mbps. This flexibility allows you to allocate bandwidth to different remote network locations according to your specific needs. For optimal performance, Microsoft recommends configuring at least two IPsec tunnels per location for high availability. The table below details the total bandwidth based on the number of licenses purchased. 

#### Initial bandwidth allocation

| # of licenses | Total Bandwidth (Mbps) |
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
- Minimum number of licenses to use remote network connectivity feature is 50. 
- The number of licenses is equal to the total number of licenses purchased (Entra ID P1 + Entra Internet Access /Entra Suite). After 10,000 licenses you get an additional 500 Mbps for every 500 licenses purchased (example 11,000 licenses = 36,000 Mbps). 
- Organizations crossing the 10,000-license mark often operate at an enterprise scale requiring more robust infrastructure. The jump to 35,000 Mbps ensures ample capacity to meet the demands of such deployments, supporting higher traffic volumes and providing the flexibility to expand bandwidth allocations as needed. 
- If more bandwidth is required, additional bandwidth is available for purchase in increments of 500 Mbps via the Remote Network Bandwidth SKU.


#### Examples of Allocated Bandwidth per tenant: 

**Tenant 1:**

- 1,000 Entra ID P1 licenses
- Allocated: 1,000 licenses, 3,500 Mbps

**Tenant 2:**

- 3,000 Entra ID P1 licenses
- 3,000 Internet Access licenses
- Allocated: 6,000 licenses, 11,000 Mbps

**Tenant 3:**

- 8,000 Entra ID P1 licenses
- 6,000 Entra Suite licenses
- Allocated: 14,000 licenses, 39,000 Mbps

#### Examples of Bandwidth distribution for Remote Networks 

**Tenant 1:**

Total Bandwidth: 3,500 Mbps

Allocation:

- Site A: 2 IPsec tunnels: 2 x 250 Mbps = 500 Mbps
- Site B: 2 IPsec tunnels: 2 x 250 Mbps = 500 Mbps
- Site C: 2 IPsec tunnels: 2 x 500 Mbps = 1,000 Mbps
- Site D: 2 IPsec tunnels: 2 x 750 Mbps = 1,500 Mbps

Remaining Bandwidth: None

**Tenant 2:**

Total Bandwidth: 11,000 Mbps

Allocation:

- Site A: 2 IPsec tunnels: 2 x 250 Mbps = 500 Mbps
- Site B: 2 IPsec tunnels: 2 x 500 Mbps = 1,000 Mbps
- Site C: 2 IPsec tunnels: 2 x 750 Mbps = 1,500 Mbps
- Site D: 2 IPsec tunnels: 2 x 1,000 Mbps = 2,000 Mbps
- Site E: 2 IPsec tunnels: 2 x 1,000 Mbps = 2,000 Mbps

Remaining Bandwidth: 4,000 Mbps

**Tenant 3:**

Total Bandwidth: 39,000 Mbps

Allocation:

- Site A: 2 IPsec tunnels: 2 x 250 Mbps = 500 Mbps
- Site B: 2 IPsec tunnels: 2 x 500 Mbps = 1,000 Mbps
- Site C: 2 IPsec tunnels: 2 x 750 Mbps = 1,500 Mbps
- Site D: 2 IPsec tunnels: 2 x 750 Mbps = 1,500 Mbps
- Site E: 2 IPsec tunnels: 2 x 1,000 Mbps = 2,000 Mbps
- Site F: 2 IPsec tunnels: 2 x 1,000 Mbps = 2,000 Mbps
- Site G: 2 IPsec tunnels: 2 x 1,000 Mbps = 2,000 Mbps

Remaining Bandwidth: 28,500 Mbps

## Next steps
- [List all remote networks](how-to-list-remote-networks.md)
- [Manage remote networks](how-to-manage-remote-networks.md)
