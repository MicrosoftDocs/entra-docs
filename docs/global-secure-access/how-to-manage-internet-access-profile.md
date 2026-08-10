---
title: How to manage the Internet Access profile
description: Learn how to manage the Internet Access traffic forwarding profile for Microsoft Entra Internet Access.
ms.topic: how-to
ms.date: 08/02/2026
ms.subservice: entra-internet-access 
ms.reviewer: katabish
ai-usage: ai-assisted

# Customer intent: As an IT admin, I need to enable and manage the Internet Access traffic forwarding profile so that internet access I configured can forward traffic according to the profile.
---

# How to manage the Internet Access traffic forwarding profile

## Overview

The Internet Access traffic forwarding profile routes internet traffic through the Global Secure Access client and remote networks. Enabling this traffic forwarding profile allows users to connect to the internet in a controlled and secure way. You can configure which traffic to include or exclude from Global Secure Access based on IP addresses, IP address ranges, IP subnets, and Fully Qualified Domain Names (FQDNs). You can also deploy Global Secure Access side by side with another Secure Web Gateway (SWG) vendor by using the **Custom Acquire** policy to selectively acquire specific traffic, or the **Agentic Acquire** policy to acquire traffic from local AI agents (such as GitHub Copilot CLI or Claude CLI), while using other vendors for rest of the internet.

## Prerequisites

To enable the Internet Access forwarding profile for your tenant, you must have:

- A [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator) role in Microsoft Entra ID.
- The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).

## Internet Access traffic forwarding profile policies

View the policies that relate to the Internet Access traffic forwarding profile. There are six policies in total. To view them:
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Connect** > **Traffic forwarding**.
1. Select the **View** link in the Internet Access policies section.

The Internet Access policies include:
- **Custom Bypass** Contains user-defined traffic/endpoints that are *excluded* from the Internet traffic profile. In other words, you define the traffic that the profile shouldn't acquire. You might typically exclude traffic such as your VPN endpoints, squat IP ranges, and endpoints that leverage a network Access Control List (ACL).
- **Default Bypass** Contains predefined traffic that the Internet traffic profile doesn't acquire. For example, private IP ranges. You can't change rules in this policy.
- **Microsoft Traffic Bypass** Contains predefined Microsoft endpoints that are explicitly excluded from the Internet traffic profile and are instead acquired using Microsoft traffic profile. You can't change rules in this policy.
- **Custom Acquire** Contains user-defined traffic/endpoints that are explicitly *acquired* by the Internet traffic profile. Unlike the **Default Acquire** policy, which is limited to ports 80 and 443 over TCP, Custom Acquire lets you selectively acquire traffic for specific IP addresses, IP address ranges, IP subnets, and Fully Qualified Domain Names (FQDNs) on any ports and protocol (TCP or UDP) you specify. This lets you deploy Global Secure Access side by side with another Secure Web Gateway (SWG) vendor: Global Secure Access acquires the traffic you specify (for example, `chat.com`), while the other vendor covers the rest of your internet traffic.
- **Default Acquire** Contains predefined traffic that gets acquired by the Internet traffic profile. This includes internet traffic on ports 80, 443 over TCP. The policy takes lowest precedence after all bypass and custom acquire rules are evaluated. You can't change rules in this policy.
- **Agentic Acquire** A special policy that signals the Global Secure Access client to acquire all web traffic that originates from local AI agents running on the device, such as GitHub Copilot CLI, Claude CLI, and similar local agents. Enable it to deploy Global Secure Access for agentic (AI agent) protection side by side with another SWG vendor that covers user traffic. You can't change rules in this policy.

## How to add a custom bypass policy
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
2. Browse to **Global Secure Access** > **Connect** > **Traffic forwarding**.
3. In the Internet Access traffic forwarding profile area, in the **Internet Access policies** section, select the **View** link
4. Expand the **Custom Bypass** policy.
5. Select **Add rule**.
6. Choose a **destination type**: Fully Qualified Domain Name (FQDN), IP address, IP subnet, or IP range. You can add multiple comma-separated destination values. Don't add whitespace. For example, `chat.com,contoso.com` or `10.0.0.1/32,10.0.0.2/32`.
7. Enter a valid **destination** and specify the **ports** and **protocol** (TCP or UDP) to bypass.
8. Select **Save**.

## How to add a custom acquire policy
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/en-us/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
2. Browse to **Global Secure Access** > **Connect** > **Traffic forwarding**.
3. In the Internet Access traffic forwarding profile area, in the **Internet Access policies** section, select the **View** link.
4. Expand the **Custom Acquire** policy.
5. Select **Add rule**.
6. Choose a **destination type**: Fully Qualified Domain Name (FQDN), IP address, IP subnet, or IP range. You can add multiple comma-separated destination values. Don't add whitespace. For example, `chat.com,contoso.com` or `10.0.0.1/32,10.0.0.2/32`.
7. Enter a valid **destination** and specify the **ports** and **protocol** (TCP or UDP) to acquire.
8. Disable the **Default Acquire** policy using the toggle next to it. Click **OK** when prompted.
9. Select **Save**.

> [!NOTE]
> Traffic is evaluated from top to bottom, which means it only gets acquired by the Internet traffic profile if it’s not being bypassed in one of the bypass rules.

## How to enable agentic acquire policy
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/en-us/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
2. Browse to **Global Secure Access** > **Connect** > **Traffic forwarding**.
3. In the Internet Access traffic forwarding profile area, in the **Internet Access policies** section, select the **View** link.
4. For first time setup, click the **Create Agentic Acquire** button to create the policy. If policy is already created, use the toggle to enable it. Click **OK** when prompted.
5. Disable the **Custom Acquire** and **Default Acquire** policy using the toggles next to them. Click **OK** when prompted.

> [!NOTE]
> Agentic Acquire is only supported on Windows and Mac platforms. Minimum required client version for Windows is **2.31.125** and for Mac is **1.1.26030604**.

## User and group assignments
You can scope the Internet Access profile to specific users and groups.

For more information about user and group assignment, see [How to assign and manage users and groups with traffic forwarding profiles](how-to-manage-users-groups-assignment.md).

## Enable the Internet Access traffic forwarding profile

To enable the Microsoft Entra Internet Access forwarding profile to forward user traffic:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Connect** > **Traffic forwarding**.
1. Set policies on the traffic profile. For example, set a custom bypass rule to exclude specific traffic.
1. Enable the **Internet access profile**. Internet traffic starts forwarding from all client devices to Microsoft's Security Service Edge (SSE) proxy, where you configure granular security policies.
    > [!NOTE]
    > When you enable the Internet Access forwarding profile, you should also enable the Microsoft traffic forwarding profile for optimal routing of Microsoft traffic. You enable the **Microsoft traffic profile** by selecting the profile checkbox on the same page where you enable the Internet Access traffic forwarding profile. For more information about the Microsoft traffic forwarding profile, see [How to enable and manage the Microsoft profile](how-to-manage-microsoft-profile.md).

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
