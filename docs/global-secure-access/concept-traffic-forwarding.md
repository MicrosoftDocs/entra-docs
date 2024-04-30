---
title: Global Secure Access (preview) traffic forwarding profiles
description: Learn about how traffic forwarding profiles for Global Secure Access (preview) streamline how you route traffic through your network.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: conceptual
ms.date: 06/09/2023
ms.service: global-secure-access
ms.reviewer: katabish
---

# Global Secure Access (preview) traffic forwarding profiles

With the traffic forwarding profiles in Global Secure Access (preview), you can apply policies to the network traffic that your organization needs to secure and manage. Network traffic is evaluated against the traffic forwarding policies you configure. The profiles are applied and the traffic goes through the service to the appropriate apps and resources. 

This article describes the traffic forwarding profiles and how they work.

## Traffic forwarding

**Traffic forwarding** enables you to configure the type of network traffic to tunnel through the Microsoft Entra Private Access and Microsoft Entra Internet Access services. You set up profiles to manage how specific types of traffic are managed. 

When traffic comes through Global Secure Access, the service evaluates the type of traffic first through the **Microsoft 365 access profile**,  then through the **Private access profile**, and finally through the **Internet access profile**. Any traffic that doesn't match these three profiles isn't forwarded to Global Secure Access. 

For each traffic forwarding profile, you can configure three main details:

- Which traffic to forward to the service
- What Conditional Access policies to apply
- How your end-users connect to the service

## Microsoft 365

The Microsoft 365 traffic forwarding profile includes SharePoint Online, Exchange Online, and Microsoft 365 apps. All of the destinations for these apps are automatically included in the profile. Within each of the three main groups of destinations, you can choose to forward that traffic to Global Secure Access or bypass the service. 

Microsoft 365 traffic is forwarded to the service through either [remote network connectivity](concept-remote-network-connectivity.md), such as branch office location, or through the [Global Secure Access client](how-to-install-windows-client.md).

## Private access

With the Private Access profile, you can route traffic to your private resources. This traffic forwarding profile requires configuring Quick Access, which includes the fully qualified domain names (FQDNs) and IP addresses of the private apps and resources you want to forward to the service. 

Private access traffic can be forwarded to the service by connecting through the [Global Secure Access desktop client](how-to-install-windows-client.md).

## Internet access

With the Internet access profile, you can route traffic to the public internet, including traffic to SaaS apps. This traffic forwarding profile consists of a pre-populated list of regular expressions for fully qualified domain names (FQDNs) and IP addresses representing the public internet. 

Internet access traffic can be forwarded to the service by connecting through the [Global Secure Access desktop client](how-to-install-windows-client.md).

[!INCLUDE [Public preview important note](./includes/public-preview-important-note.md)]

## Next steps

- [Manage the Microsoft 365 traffic profile](how-to-manage-microsoft-365-profile.md)
- [Manage the Private access traffic profile](how-to-manage-private-access-profile.md)
- [Configure Quick Access](how-to-configure-quick-access.md)
