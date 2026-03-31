---
ms.author: jayrusso
author: HULKsmashGithub
manager: dougeby
ms.service: global-secure-access
ms.topic: include
ms.date: 03/31/2026
ms.custom: include file

---

### Avoid asymmetric routing with remote networks

When an Azure VM is connected to a Global Secure Access remote network, you can't use RDP to connect to the VM using its public IP address. If you disconnect the remote network, RDP works again. This behavior is caused by asymmetric routing and is expected.

Here's why it happens: the VM has a public IP address, so inbound RDP traffic (the SYN packet) from your PC reaches the VM directly. However, because Global Secure Access advertises the entire internet address range over BGP, the VM's return traffic (the SYN-ACK) routes through the IPsec tunnel to the Global Secure Access gateway. The gateway receives a SYN-ACK for a session it never saw the SYN for, so it drops the packet. The client retransmits, eventually times out, and the connection fails. This effectively makes the VM's public IP address unusable for inbound connections.

> [!IMPORTANT]
> This asymmetric routing behavior applies to any inbound connection to a VM on a remote network, not just RDP. Any protocol where inbound traffic arrives directly at the VM's public IP but return traffic routes through the Global Secure Access gateway will fail.

### Workarounds

To avoid asymmetric routing issues with remote networks, use one of these workarounds:

#### Use Azure Bastion

[Azure Bastion](/azure/bastion/bastion-overview) eliminates asymmetric routing for remote management scenarios like RDP and SSH. With Bastion, your PC connects to the Bastion service over HTTPS, and Bastion initiates the RDP or SSH session to the VM using its private IP address. The VM responds directly to Bastion within the virtual network. Because both directions of the connection stay inside the virtual network, traffic never passes through the Global Secure Access gateway, and routing remains symmetric.

#### Use point-to-site (P2S) VPN with your VNG

If you configure a virtual network gateway (VNG) for [point-to-site (P2S) connectivity](/azure/vpn-gateway/point-to-site-about), your client device receives a private IP address from the VNG address pool using the [Azure VPN Client](/azure/vpn-gateway/point-to-site-vpn-client-certificate-windows-azure-vpn-client). All traffic to the VM flows through the VNG tunnel and returns the same way, keeping routing symmetric.
