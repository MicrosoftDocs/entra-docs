---
title: Global Secure Access traffic forwarding profiles
description: Learn about how traffic forwarding profiles for Global Secure Access streamline how you route traffic through your network.
author: kenwith
ms.author: kenwith
manager: dougeby
ms.topic: article
ms.date: 02/21/2025
ms.service: global-secure-access
ms.reviewer: katabish
ai-usage: ai-assisted
---

# Global Secure Access traffic forwarding profiles

You use traffic forwarding profiles in Global Secure Access to apply policies to the network traffic that your organization wants to secure and manage. Network traffic is evaluated against the traffic forwarding policies you configure. The profiles are applied and the traffic goes through the service to the appropriate apps and resources. 

This article describes the traffic forwarding profiles and how they work.

## Traffic forwarding

**Traffic forwarding** enables you to configure the type of network traffic to tunnel through the Microsoft Entra Private Access and Microsoft Entra Internet Access services. You set up profiles to manage how specific types of traffic are managed. 

When traffic comes through Global Secure Access, the service evaluates the type of traffic first through the **Microsoft access profile**,  then through the **Private access profile**, and finally through the **Internet access profile**. Any traffic that doesn't match these three profiles isn't forwarded to Global Secure Access. 

For each traffic forwarding profile, you can configure:

- Which users receive the traffic forwarding profile and how your users connect to the service
- Which traffic to forward to the service
- What Conditional Access policies to apply

## Microsoft traffic

The Microsoft traffic forwarding profile includes Microsoft Entra ID/ Microsoft Graph, SharePoint Online, Exchange Online, and other Microsoft apps. Traffic forwarding policies are grouped based on the workload - for example, Exchange Online. You can choose to either forward the traffic from each group to Global Secure Access, or to bypass it.

Microsoft traffic is forwarded to the service through either [remote network connectivity](concept-remote-network-connectivity.md), such as branch office location, or through the [Global Secure Access client](how-to-install-windows-client.md).

[Learn more about the Microsoft traffic profile](concept-microsoft-traffic-profile.md)

### Licensing

Microsoft traffic profile requires the following licenses:

- Microsoft Entra ID P1 or P2 (prerequisite).

## Private access

With the Private Access profile, you can route traffic to your private resources. This traffic forwarding profile requires configuring Quick Access, which includes the fully qualified domain names (FQDNs) and IP addresses of the private apps and resources you want to forward to the service. 

Private access traffic can be forwarded to the service by connecting through the [Global Secure Access desktop client](how-to-install-windows-client.md).

### Licensing

Private Access profile requires the following licenses:

- Microsoft Entra ID P1 or P2 (prerequisite).
- Microsoft Entra Private Access or Microsoft Entra Suite.

## Internet access

With the internet access profile, you can route traffic to the public internet, including traffic to SaaS apps. This traffic forwarding profile consists of a prepopulated list of regular expressions for fully qualified domain names (FQDNs) and IP addresses representing the public internet. 

> [!NOTE]
> Internet access profile does not include internet destinations that are available in the Microsoft traffic profile. For complete coverage, we recommend that you enable the Microsoft traffic profile together with the Internet access profile.

Internet access traffic can be forwarded to the service by connecting through the [Global Secure Access desktop client](how-to-install-windows-client.md).

### Licensing

Internet access profile requires the following licenses:

- Microsoft Entra ID P1 or P2 (prerequisite).
- Microsoft Entra Internet Access or Microsoft Entra Suite.

## Next steps

- [Learn more about the Microsoft traffic profile](concept-microsoft-traffic-profile.md)
- [Manage the Microsoft traffic profile](how-to-manage-microsoft-profile.md)
- [Manage the Internet access traffic profile](how-to-manage-internet-access-profile.md)
- [Manage the Private access traffic profile](how-to-manage-private-access-profile.md)
- [Configure Quick Access](how-to-configure-quick-access.md)
