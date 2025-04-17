---
title: How to manage the Internet Access profile
description: Learn how to manage the Internet Access traffic forwarding profile for Microsoft Entra Internet Access.
author: kenwith
ms.author: kenwith
manager: femila
ms.topic: how-to
ms.date: 02/21/2025
ms.service: global-secure-access
ms.subservice: entra-internet-access 
ms.reviewer: katabish
ai-usage: ai-assisted

# Customer intent: As an IT admin, I need to enable and manage the Internet Access traffic forwarding profile so that internet access I configured can forward traffic according to the profile.
---

# How to manage the Internet Access traffic forwarding profile

The Internet Access traffic forwarding profile routes internet traffic through the Global Secure Access client. Enabling this traffic forwarding profile allows remote workers to connect to the internet in a controlled and secure way. With the features of Microsoft Entra Internet Access, you can control which internet sites can be accessed. You can also configure which traffic to exclude from Global Secure Access based on IP addresses, IP address ranges, IP subnets, and Fully Qualified Domain Names (FQDNs).

## Prerequisites

To enable the Internet Access forwarding profile for your tenant, you must have:

- A [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator) role in Microsoft Entra ID.
- The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).

## Internet Access traffic forwarding profile policies

View the policies that relate to the Internet Access traffic forwarding profile. There are three policies by default. To view them:
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Connect** > **Traffic forwarding**.
1. Select the **View** link in the Internet Access policies section.

The default Internet Access policies include:
- **Custom Bypass** Contains user-defined traffic/endpoints that are *excluded* from the Internet traffic profile. In other words, you define the traffic that the profile shouldn't acquire. You might typically exclude traffic such as your VPN endpoints, private IP ranges, and squat IP ranges, and endpoints that leverage a network Access Control List (ACL). 
- **Default Bypass** Contains predefined traffic that the Internet traffic profile doesn't acquire. For example, private IP ranges. You can't change rules in this policy.
- **Default Acquire** Defines traffic that gets acquired by the Internet traffic profile. Currently, it’s all internet traffic on ports 80, 443 over Transmission Control Protocol (TCP). The policy takes lowest precedence after all bypass rules are evaluated. You can't change rules in this policy.

Example of adding a custom bypass policy:
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Connect** > **Traffic forwarding**.
1. In the Internet Access traffic forwarding profile area, in the **Internet Access policies** section, select the **View** link 
1. Expand the **Custom Bypass** policy.
1. Select **Add rule**.
1. Choose a destination type, such as Fully Qualified Domain Name (FQDN). You can add multiple comma-separated destination values. Don't add whitespace. For example, `contoso.com,fabrikam.com` or `10.0.0.1/32,10.0.0.2/32`. Ports, protocol, and action are always fixed and can't be changed.
1. Enter a valid destination.
1. Select **Save**.

> [!NOTE]
> Traffic is evaluated from top to bottom, which means it only gets acquired by the Internet traffic profile if it’s not being bypassed in one of the bypass rules.

## User and group assignments
You can scope the Internet Access profile to specific users and groups.

To learn more about user and group assignment, see [How to assign and manage users and groups with traffic forwarding profiles](how-to-manage-users-groups-assignment.md).

## Enable the Internet Access traffic forwarding profile

To enable the Microsoft Entra Internet Access forwarding profile to forward user traffic:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Connect** > **Traffic forwarding**.
1. Set policies on the traffic profile. For example, set a custom bypass rule to exclude specific traffic.
1. Enable the **Internet access profile**. Internet traffic starts forwarding from all client devices to Microsoft's Security Service Edge (SSE) proxy, where you configure granular security policies.
    > [!NOTE]
    > When you enable the Internet Access forwarding profile, you should also enable the Microsoft traffic forwarding profile for optimal routing of Microsoft traffic. You enable the **Microsoft traffic profile** by selecting the profile checkbox on the same page where you enable the Internet Access traffic forwarding profile. To learn more about the Microsoft traffic forwarding profile, see [How to enable and manage the Microsoft profile](how-to-manage-microsoft-profile.md).

## Validate the Internet Access traffic forwarding profile
A rule added to a policy takes 10-20 minutes to appear in the client on a user's computer. If the rule doesn't appear after this time, disable and then re-enable the Internet Access traffic forwarding profile. 

To validate the traffic forwarding profile, traffic forwarding policies, and rules:
1. In the system tray, right click the Global Secure Access client and select **Advanced diagnostics**.
1. Open a web browser and navigate to a destination on the internal network. Confirm that traffic isn't being captured.
1. Open a web browser and navigate to a destination that is bypassed. Confirm that traffic isn't being captured.
1. Open a web browser and navigate to a public destination that is acquired by the profile. Confirm the traffic is being acquired under the **Internet channel**.




## Next steps
- [Learn about traffic forwarding](concept-traffic-forwarding.md)
- [Configure Global Secure Access web content filtering](how-to-configure-web-content-filtering.md)
- [Install and configure the Global Secure Access Client on end-user devices](how-to-install-windows-client.md)
