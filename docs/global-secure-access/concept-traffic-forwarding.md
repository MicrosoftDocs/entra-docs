---
title: Global Secure Access traffic forwarding profiles
description: Learn how Global Secure Access traffic forwarding profiles route traffic and how multiple Private Access profiles provide granular application and assignment control.
ms.topic: concept-article
ms.date: 09/20/2026
ms.reviewer: katabish
ai-usage: ai-assisted
---

# Global Secure Access traffic forwarding profiles

## Overview

You use traffic forwarding profiles in Global Secure Access to apply policies to the network traffic that your organization wants to secure and manage. Network traffic is evaluated against the traffic forwarding profiles you configure. The applicable profile is applied, and traffic is forwarded through the service to the appropriate applications and resources.

This article describes the traffic forwarding profiles and how they work.

## Traffic forwarding

**Traffic forwarding** enables you to configure the type of network traffic to tunnel through Microsoft Entra Private Access and Microsoft Entra Internet Access. You set up profiles to manage how specific types of traffic are handled.

When traffic comes through Global Secure Access, the service evaluates the traffic type first through the **Microsoft access profile**, then through the **Private access profile**, and finally through the **Internet access profile**. Traffic that doesn't match these profile types isn't forwarded to Global Secure Access.

For each traffic forwarding profile, you can configure:

- Which users and devices receive the profile.
- Which device platforms receive the profile.
- Which traffic is forwarded to the service.
- Which Conditional Access policies apply to the resources.

## Profile priority and assignment

You can assign traffic forwarding profiles to users, groups, devices, and device platforms. User and device assignments are evaluated together with device-platform assignments.

When multiple enabled profiles for the same traffic type apply to a user and device, only the applicable profile with the highest priority is used by the client.

For assignment details and examples, see [Assign users and devices to traffic forwarding profiles](how-to-manage-users-groups-assignment.md).

## Microsoft traffic

The Microsoft traffic forwarding profile includes Microsoft Teams, SharePoint Online, Exchange Online, and other Microsoft apps. Traffic forwarding policies are grouped based on the workload - for example, Exchange Online. You can choose to either forward the traffic from each group to Global Secure Access, or to bypass it.

Microsoft traffic is forwarded to the service through either [remote network connectivity](concept-remote-network-connectivity.md), such as branch office location, or through the [Global Secure Access client](how-to-install-windows-client.md).

[Learn more about the Microsoft traffic profile](concept-microsoft-traffic-profile.md)

### Licensing

Microsoft traffic profile requires the following licenses:

- Microsoft Entra ID P1 or P2 (prerequisite).

## Private access

Private Access traffic forwarding profiles route traffic to private resources through the Global Secure Access client. Private resource definitions come from Quick Access and Private Access enterprise applications.

Every tenant has a default Private Access profile. You can also create custom Private Access profiles to:

- Provide different application sets to different users or devices.
- Separate traffic acquisition by device platform, such as desktop and mobile platforms.
- Gradually deploy Private Access to selected users, groups, or devices.
- Exclude privileged or sensitive applications from a broadly assigned profile.

Each custom profile has its own acquisition rules, assignments, status, and priority. During preview, you can create up to 10 custom Private Access profiles.

Private access traffic is forwarded by the [Global Secure Access client](concept-clients.md).

### Licensing

Private Access profile requires the following licenses:

- Microsoft Entra ID P1 or P2 (prerequisite).
- Microsoft Entra Private Access or Microsoft Entra Suite.

## Internet access

With the internet access profile, you can route traffic to the public internet, including traffic to SaaS apps. This traffic forwarding profile consists of a prepopulated list of regular expressions for fully qualified domain names (FQDNs) and IP addresses representing the public internet. 

> [!NOTE]
> Internet access profile does not include internet destinations that are available in the Microsoft traffic profile. For complete coverage, enable the Microsoft traffic profile together with the Internet access profile.

Internet access traffic can be forwarded to the service by connecting through the [Global Secure Access desktop client](how-to-install-windows-client.md).

### Licensing

Internet Access profile requires the following licenses:

- Microsoft Entra ID P1 or P2 (prerequisite).
- Microsoft Entra Internet Access or Microsoft Entra Suite.

## Microsoft Entra traffic

The Microsoft Entra traffic profile is a dedicated system profile within Global Secure Access that handles all authentication and identity-related traffic for Microsoft Entra services. This profile operates independently of other traffic profiles (such as Private or Internet Access), ensuring that identity traffic is always acquired and protected, regardless of SKU or license assignment. As a system managed profile, admins don't see it in the portal.

Key characteristics:

- **Always on with any profile**: Microsoft Entra traffic automatically enables whenever any other traffic forwarding profile is active. You can't enable or disable it independently.
- **Highest policy priority**: Microsoft Entra traffic is prioritized in the client policy to ensure it's always processed first, leveraging mTLS and certificate-based authentication for secure tunneling.
- **No explicit assignment needed**: You don't need explicit user or branch assignment. Microsoft Entra traffic is included automatically with any active profile.
- **Comprehensive coverage**: The profile covers a defined set of FQDNs and IP ranges associated with Microsoft Entra authentication endpoints, including login, Graph API, and certificate validation services.

> [!NOTE]
> If you use Network conditions in Conditional Access policies, enable Conditional Access signaling for Microsoft Entra ID in Global Secure Access. See [Enable Global Secure Access signaling for Conditional Access](how-to-source-ip-restoration.md).

## Next steps

- [Learn more about the Microsoft traffic profile](concept-microsoft-traffic-profile.md)
- [Create a Private Access traffic forwarding profile](how-to-create-traffic-forwarding-profile.md)
- [Delete a Private Access traffic forwarding profile](how-to-delete-traffic-forwarding-profile.md)
- [Manage the Microsoft traffic profile](how-to-manage-microsoft-profile.md)
- [Manage the Internet access traffic profile](how-to-manage-internet-access-profile.md)
- [Manage Private Access traffic forwarding profiles](how-to-manage-private-access-profile.md)
- [Assign users and devices to traffic forwarding profiles](how-to-manage-users-groups-assignment.md)
- [Configure Quick Access](how-to-configure-quick-access.md)
