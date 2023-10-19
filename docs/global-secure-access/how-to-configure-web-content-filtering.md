---
title: How to configure Global Secure Access (preview) web content filtering
description: Learn how to configure web content filtering in Microsoft Entra Internet Access (preview).
author: kenwith    
ms.author: kenwith
manager: amycolannino
ms.topic: how-to
ms.date: 10/19/2023
ms.service: network-access
ms.custom: 
ms.reviewer: frankgomulka
---

# How to configure Global Secure Access (preview) web content filtering

Filtering web content is a critical component when implementing Internet access controls for a modern Security Service Edge (SSE) solution. 

Microsoft Entra Internet Access includes Web Content Filtering (WCF) as part of the Secure Web Gateway feature. Microsoft integrates filtering with Microsoft Entra ID and Microsoft Entra Conditional Access, which results in filter policies that are user-aware and easy to manage.

## Prerequisites

- Ensure your tenant is signed up for Microsoft Entra Internet Access (preview).
- Install the Global Secure Access client on end user devices.
- Disable the Quick UDP Internet Connections (QUIC) protocol (443 UDP) on device as UDP traffic isn't supported. When you disable this protocol, the fallback is usually HTTPS (443 TCP).
- Check/Disable secure DNS. To tunnel network traffic based on rules of Fully Qualified Domain Name (FQDN) in the forwarding profile, DNS over HTTPS needs to be disabled. To learn more about disabling DNS over HTTPS in Windows, see [Configure the DNS client to support DoH](/windows-server/networking/dns/doh-client-support#configure-the-dns-client-to-support-doh).
- Disable built-in DNS client on Chrome and Edge.

## Enable traffic forwarding
Enable the Microsoft Entra Internet Access forwarding profile to forward user traffic. 
1. In the Microsoft Entra admin center, navigate to **Global Secure Access** > **Connect** > **Traffic forwarding**.
1. Select **Internet profile**.

## Create a web filtering policy
Create a web filtering policy that contains a grouping of rules.
1. In the Microsoft Entra admin center, navigate to **Global Secure Access** > **Web filtering policy**.
1. Select **Create policy**.
1. Enter a name and description for the policy and select **Next**.
1. Select **Add rule**.
1. Enter a name, select a [web category](reference-web-content-filtering-categories.md), and then select **Add**.1. Select **Next** to review the policy and then select **Create policy**.

## Create a policy profile to assign / link policies to a profile
Create a policy profile to assign, or link, policies with a profile.

> [!NOTE]
> To learn more about Microsoft Entra Conditional Access policy profiles, see [Building a Conditional Access policy](/azure/active-directory/conditional-access/concept-conditional-access-policies).

1. In the Microsoft Entra admin center, navigate to **Global Secure Access** > **Security profiles**.
1. Select **Create profile**.
1. Enter a name and description for the policy and select **Next**.
1. Select **Link a policy** and then select **Existing policy**.
1. Select the policy you already created and select **Add**.
1. Select **Next** to review the security profile and associated policy.
1. Select **Create a profile**.
1. Select **Refresh** to refresh the profiles page and view the new profile.

## Create a Conditional Access policy
Create a Conditional Access policy and set session controls for end users or groups and link it to the filtering profile. To learn more about sessions controls, see [Conditional Access: Session](/azure/active-directory/conditional-access/concept-conditional-access-session). 
1. In the Microsoft Entra admin center, navigate to **Identity** > **Protection** > **Conditional Access**.
1. Select **Create new policy**.
1. Enter a name and assign a user or group.
1. Select **Target resources** and then select **Global Secure Access (Preview)** from the drop-down menu to set what the policy applies to.
1. Select **Internet traffic** from the drop-down menu to set the traffic profile this policy applies to.
1. Select **Sessions**, select **Use Global Secure Access policy profile**, and then choose a web filtering profile.
1. Select **Select**.
1. In the **Enable policy** section, **Report-only** is the default.
1. Select **Create**.

## Test policy enforcement
Use a Windows device with the Global Secure Access client installed. Sign in as a user that is assigned the Internet traffic acquisition profile. Test that navigating to websites is allowed or restricted as expected.

To check if the client is acquiring Internet traffic, right-click on the Global Secure Access client icon in the task manager tray and open **Connection Diagnostics** > **Channels**. Ensure that the Internet channel is Present and Green. Also, check if the hostname acquisition and flows for the users Internet traffic are being acquired while browsing.

Navigate to an approved site and check if it loads properly. Next, navigate to a restricted site and confirm the site is blocked.

View Internet Access traffic logs in the Microsoft Entra admin center. Navigate to **Global Secure Access** > **Monitor** > **traffic logs**. It takes approximately 15 minutes for new entries to appear.


## Limitations
- There's currently no end-user notification on blocks, either from the client or the browser.
- Admins aren't allowed to configure their own Internet traffic acquisition profiles for the client.
    - The client traffic acquisition policy includes TCP ports 80/443 for all valid FQDNs only.
    - There's no support for UDP, no L3/4 filtering support, and standard ports are assumed for HTTP/S traffic.
- Only FQDN-based filtering is currently supported. URL based filtering isn't yet supported.
- "Remote Network" or "Branch" connectivity scenarios aren't supported.
- Users aren't allowed to block access to all websites by default.

## Next steps
- [Learn about the traffic dashboard](concept-traffic-dashboard.md)
