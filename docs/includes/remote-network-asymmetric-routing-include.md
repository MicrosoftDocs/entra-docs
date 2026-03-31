---
ms.author: jayrusso
author: HULKsmashGithub
ms.service: global-secure-access
ms.topic: include
ms.date: 03/31/2026
ms.custom: include file

---

<!-- REVIEW NOTE: [NEW CONTENT] Asymmetric routing guidance added for GA of internet support for remote networks (ADO #564642) -->

### Avoid asymmetric routing with remote networks

Global Secure Access maintains TCP connection state for all traffic flowing through its gateway. For connections to work correctly, the gateway must see the complete TCP handshake (SYN, SYN-ACK, ACK). If routing is asymmetric — meaning traffic in one direction flows through the Global Secure Access gateway but the return path bypasses it — the gateway sees only part of the handshake and drops the connection.

For example, if inbound RDP traffic to a virtual machine routes through Global Secure Access but the VM's response takes a different path, the gateway never sees the full TCP handshake. The client retransmits, eventually times out, and the connection fails.

#### Use Azure Bastion to avoid asymmetric routing

[Azure Bastion](/azure/bastion/bastion-overview) eliminates asymmetric routing for remote management scenarios like RDP and SSH. Bastion keeps all traffic within the Azure virtual network:

1. You connect to Azure Bastion over HTTPS (port 443) from your browser.
1. Bastion initiates the RDP or SSH session to the target VM using its private IP address.
1. The VM responds directly to Bastion within the virtual network.

Because all traffic between Bastion and the VM stays inside the virtual network (east-west traffic), it never passes through the Global Secure Access gateway. This symmetric routing preserves TCP state and avoids connection failures.

> [!TIP]
> For inbound remote management of Azure VMs on networks protected by Global Secure Access, use [Azure Bastion](/azure/bastion/bastion-overview) instead of direct RDP or SSH connections to avoid asymmetric routing issues.
