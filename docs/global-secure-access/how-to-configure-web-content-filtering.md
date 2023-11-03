---
title: How to configure Global Secure Access (preview) web content filtering
description: Learn how to configure web content filtering in Microsoft Entra Internet Access (preview).
author: kenwith    
ms.author: kenwith
manager: amycolannino
ms.topic: how-to
ms.date: 11/02/2023
ms.service: network-access
ms.custom: 
ms.reviewer: frankgomulka
---

# How to configure Global Secure Access (preview) web content filtering

Web content filtering empowers you to implement granular Internet access controls for your organization based on website categorization.

Microsoft Entra Internet Access's first Secure Web Gateway (SWG) features include web content filtering based on domain names. Microsoft integrates granular filtering policies with Microsoft Entra ID and Microsoft Entra Conditional Access, which results in filtering policies that are user-aware, context-aware, and easy to manage. 

The web filtering feature is currently limited to user- and context-aware Fully Qualified Domain Name (FQDN)-based web category filtering and FQDN filtering.

## Prerequisites

- Ensure your tenant is onboarded to Microsoft Entra Internet Access (preview).
- Install the Global Secure Access client on end user devices.
- Check/Disable secure DNS. To tunnel network traffic based on rules of Fully Qualified Domain Name (FQDN) in the forwarding profile, DNS over HTTPS needs to be disabled. To learn more about disabling DNS over HTTPS in Windows, see [Configure the DNS client to support DoH](/windows-server/networking/dns/doh-client-support#configure-the-dns-client-to-support-doh).
- Disable built-in DNS client on Chrome and Edge.
- Review web content filtering concepts, see [Web content filtering](concept-internet-access.md).

## Enable internet traffic forwarding
Enable the Microsoft Entra Internet Access forwarding profile to forward user traffic. 
1. In the Microsoft Entra admin center, navigate to **Global Secure Access** > **Connect** > **Traffic forwarding**.
1. Enable the **Internet access  profile**. Enabling the setting begins forwarding internet traffic from all client devices.


## Create a web content filtering policy
1. In the Microsoft Entra admin center, navigate to **Global Secure Access** > **Web content filtering policy**.
1. Select **Create policy**.
1. Enter a name and description for the policy and select **Next**.
1. Select **Add rule**.
1. Enter a name, select a [web category](reference-web-content-filtering-categories.md), and then select **Add**.
1. Select **Next** to review the policy and then select **Create policy**.

## Create a security profile
Create a security profile to group filtering policies. Assign, or link, security profiles with a CA policy to make them user or context aware.

Security profiles are a grouping of filtering policies. You can assign, or link, security profiles with Microsoft Entra Conditional Access policies. One security profile can contain multiple filtering policies. And one security profile can be associated with multiple Conditional Access policies.

> [!NOTE]
> To learn more about Microsoft Entra Conditional Access security profiles, see [Building a Conditional Access policy](/azure/active-directory/conditional-access/concept-conditional-access-policies).

1. In the Microsoft Entra admin center, navigate to **Global Secure Access** > **Security profiles**.
1. Select **Create profile**.
1. Enter a name and description for the policy and select **Next**.
1. Select **Link a policy** and then select **Existing policy**.
1. Select the Web content filtering policy you already created and select **Add**.
1. Select **Next** to review the security profile and associated policy.
1. Select **Create a profile**.
1. Select **Refresh** to refresh the profiles page and view the new profile.

## Create and link Conditional Access policy
Create a Conditional Access policy and set session controls for end users or groups and link it to the filtering profile. Conditional Access is the delivery mechanism for user and context awareness for Internet Access policies. To learn more about sessions controls, see [Conditional Access: Session](/azure/active-directory/conditional-access/concept-conditional-access-session). 
1. In the Microsoft Entra admin center, navigate to **Identity** > **Protection** > **Conditional Access**.
1. Select **Create new policy**.
1. Enter a name and assign a user or group.
1. Select **Target resources** and then select **Global Secure Access (Preview)** from the drop-down menu to set what the policy applies to.
1. Select **Internet traffic** from the drop-down menu to set the traffic profile this policy applies to.
1. Select **Sessions**, select **Use Global Secure Access security profile**, and then choose a web filtering profile.
1. Select **Select**.
1. In the **Enable policy** section, **Report-only** is the default.
1. Select **Create**.

## End user policy enforcement
Use a Windows device with the Global Secure Access client installed. Sign in as a user that is assigned the Internet traffic acquisition profile. Test that navigating to websites is allowed or restricted as expected.

To check if the client is acquiring Internet traffic, right-click on the Global Secure Access client icon in the task manager tray and open **Connection Diagnostics** > **Channels**. Ensure that the Internet channel is Present and Connected (Green in color). Also, check if the hostname acquisition and flows for the users Internet traffic are being acquired while browsing.

Navigate to an approved site and check if it loads properly. Next, navigate to a restricted site and confirm the site is blocked.

View Internet Access traffic logs in the Microsoft Entra admin center. Navigate to **Global Secure Access** > **Monitor** > **traffic logs**. It takes approximately 15 minutes for new entries to appear.

> [!NOTE]
> The current block experience includes a "Connection Reset" browser error for HTTPS traffic and a "DeniedTraffic" browser error for HTTP traffic.

## Limitations
- There's currently no end-user notification on blocks, either from the client or the browser.
- Admins aren't able to configure their own Internet traffic acquisition profiles for the client.
    - The client traffic acquisition policy includes TCP ports 80/443. 
- Currently assuming standard ports for HTTP/S traffic.
- There's no support for UDP acquisition/handling.
- No support for L3/4 filtering.
- "Remote Network" or "Branch" connectivity scenarios aren't supported.
- No captive portal support.
- No TLS termination.
- No URL filtering or URL categorization.


## Next steps
- [Learn about the traffic dashboard](concept-traffic-dashboard.md)
