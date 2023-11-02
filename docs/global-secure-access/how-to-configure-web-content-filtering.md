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

Web content filtering empowers you to implement granular Internet access controls for your organization based on website categorization.

Microsoft Entra Internet Access's first Secure Web Gateway (SWG) features include web content filtering based on domain names. Microsoft integrates granular filtering policies with Microsoft Entra ID and Microsoft Entra Conditional Access, which results in filtering policies that are user-aware, context-aware, and easy to manage.

The web filtering feature is currently limited to user- and context-aware Fully Qualified Domain Name (FQDN)-based web category filtering and FQDN filtering.

## Prerequisites

- Ensure your tenant is signed up for Microsoft Entra Internet Access (preview).
- Install the Global Secure Access client on end user devices.
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
1. Enter a name, select a [web category](reference-web-content-filtering-categories.md), and then select **Add**.
1. Select **Next** to review the policy and then select **Create policy**.

## Create a security profile to assign / link policies to a profile
Create a security profile to assign, or link, policies with a profile.

> [!NOTE]
> To learn more about Microsoft Entra Conditional Access security profiles, see [Building a Conditional Access policy](/azure/active-directory/conditional-access/concept-conditional-access-policies).

1. In the Microsoft Entra admin center, navigate to **Global Secure Access** > **Security profiles**.
1. Select **Create profile**.
1. Enter a name and description for the policy and select **Next**.
1. Select **Link a policy** and then select **Existing policy**.
1. Select the policy you already created and select **Add**.
1. Select **Next** to review the security profile and associated policy.
1. Select **Create a profile**.
1. Select **Refresh** to refresh the profiles page and view the new profile.

## Link your security profile to a Conditional Access policy
Create a Conditional Access policy and set session controls for end users or groups and link it to the filtering profile. To learn more about session controls, see [Conditional Access: Session](/azure/active-directory/conditional-access/concept-conditional-access-session). 
1. In the Microsoft Entra admin center, navigate to **Identity** > **Protection** > **Conditional Access**.
1. Select **Create new policy**.
1. Enter a name and assign a user or group.
1. Select **Target resources** and then select **Global Secure Access (Preview)** from the drop-down menu to set the target resources the policy applies to.
1. Select **Internet traffic** from the drop-down menu to set the traffic profile this policy applies to.
1. Select **Sessions**, select **Use Global Secure Access security profile**, and then choose a web filtering profile.
1. Select **Select**.
1. In the **Enable policy** section, **Report-only** is the default.
1. Select **Create**.

## End user policy enforcement

To check if the client is acquiring Internet traffic, right-click on the Global Secure Access client icon in the task manager tray and open **Connection Diagnostics** > **Channels**. Ensure that the Internet channel is Present and Green. Also, check if the hostname acquisition and flows for the users Internet traffic are being acquired while browsing.

Use a Windows device with the Global Secure Access client installed. Sign in as a user that is assigned the Internet traffic acquisition profile. Test that navigating to websites is allowed or restricted as expected.

Navigate to an approved site and check if it loads properly. Next, navigate to a restricted site and confirm the site is blocked.

> [!NOTE]
> The current block experience includes a "Connection Reset" browser error for HTTPS traffic and a "DeniedTraffic" browser error for HTTP traffic.

View Internet Access traffic logs in the Microsoft Entra admin center. Navigate to **Global Secure Access** > **Monitor** > **traffic logs**. It takes approximately 15 minutes for new entries to appear.


## Limitations
- There's currently no end-user notification on blocks, either from the client or the browser.
- No admin configurable traffic acquisition profile.
    - The client traffic acquisition policy includes TCP over IPv4 for ports 80/443 for all valid FQDNs only.
- Only FQDN-based filtering is currently supported. URL based filtering isn't yet supported.
- "Remote Network" or "Branch" connectivity scenarios aren't supported.
- Traffic acquisition profile only acquires HTTP/S TCP over ports 80/443 via FQDN. In other words, no IP-based acquisition.
- No support for UDP traffic acquisition / handling (including QUIC).
- No support for L3/4 filtering.
- No captive portal support.
- No TLS termination (it is in EAP).

## Next steps
- [Learn about the traffic dashboard](concept-traffic-dashboard.md)
