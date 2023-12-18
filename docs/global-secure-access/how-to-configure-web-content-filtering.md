---
title: How to configure Global Secure Access (preview) Web content filtering
description: Learn how to configure Web content filtering in Microsoft Entra Internet Access (preview).
author: kenwith    
ms.author: kenwith
manager: amycolannino
ms.topic: how-to
ms.date: 11/03/2023
ms.service: network-access
ms.custom: 
ms.reviewer: frankgomulka
---

# How to configure Global Secure Access (preview) Web content filtering

Web content filtering empowers you to implement granular Internet access controls for your organization based on website categorization.

Microsoft Entra Internet Access's first Secure Web Gateway (SWG) features include Web content filtering based on domain names. Microsoft integrates granular filtering policies with Microsoft Entra ID and Microsoft Entra Conditional Access, which results in filtering policies that are user-aware, context-aware, and easy to manage. 

The web filtering feature is currently limited to user- and context-aware Fully Qualified Domain Name (FQDN)-based web category filtering and FQDN filtering.

## Prerequisites

- Administrators who interact with **Global Secure Access (preview)** features must have one or more of the following role assignments depending on the tasks they're performing.
  - The **Global Secure Access Administrator** role to manage the Global Secure Access preview features.
  - [Conditional Access Administrator](/azure/active-directory/roles/permissions-reference#conditional-access-administrator) or [Security Administrator](/azure/active-directory/roles/permissions-reference#security-administrator) to create and interact with Conditional Access policies. 
- Complete the [Get started with Global Secure Access](how-to-get-started-with-global-secure-access.md) guide. 
- [Install the Global Secure Access client](how-to-install-windows-client.md) on end user devices.
- You must disable DNS over HTTPS (Secure DNS) to tunnel network traffic based on the rules of the fully qualified domain names (FQDNs) in the traffic forwarding profile. For more information, see [Configure the DNS client to support DoH](/windows-server/networking/dns/doh-client-support#configure-the-dns-client-to-support-doh).
- Disable built-in DNS client on Chrome and Edge.
- UDP traffic isn't supported in the current preview. If you plan to tunnel Exchange Online traffic, disable the QUIC protocol (443 UDP). For more information, see [Block QUIC when tunneling Exchange Online traffic](how-to-install-windows-client.md#block-quic-when-tunneling-exchange-online-traffic).
- Review Web content filtering concepts, see [Web content filtering](concept-internet-access.md).

## High level steps

There are several steps to configuring web content filtering. Take note of where you need to configure a Conditional Access policy.

1. [Enable internet traffic forwarding.](#enable-internet-traffic-forwarding)
1. [Create a Web content filtering policy.](#create-a-web-content-filtering-policy)
1. [Create a security profile.](#create-a-security-profile)
1. [Link the security profile to a Conditional Access policy.](#create-and-link-conditional-access-policy)

## Enable internet traffic forwarding

To enable the Microsoft Entra Internet Access forwarding profile to forward user traffic:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Connect** > **Traffic forwarding**.
1. Enable the **Internet access profile**. Enabling the setting begins forwarding internet traffic from all client devices to Microsoft's Security Service Edge (SSE) proxy, where you can configure granular security policies.

## Create a Web content filtering policy

1. Browse to **Global Secure Access** > **Secure** > **Web content filtering policy**.
1. Select **Create policy**.
1. Enter a name and description for the policy and select **Next**.
1. Select **Add rule**.
1. Enter a name, select a [web category](reference-web-content-filtering-categories.md), and then select **Add**.
1. Select **Next** to review the policy and then select **Create policy**.

## Create a security profile

Security profiles are a grouping of filtering policies. You can assign, or link, security profiles with Microsoft Entra Conditional Access policies. One security profile can contain multiple filtering policies. And one security profile can be associated with multiple Conditional Access policies.

In this step, you create a security profile to group filtering policies. Then you assign, or link, the security profiles with a Conditional Access policy to make them user or context aware.

> [!NOTE]
> To learn more about Microsoft Entra Conditional Access policies, see [Building a Conditional Access policy](/azure/active-directory/conditional-access/concept-conditional-access-policies).

1. Browse to **Global Secure Access** > **Secure** > **Security profiles**.
1. Select **Create profile**.
1. Enter a name and description for the policy and select **Next**.
1. Select **Link a policy** and then select **Existing policy**.
1. Select the Web content filtering policy you already created and select **Add**.
1. Select **Next** to review the security profile and associated policy.
1. Select **Create a profile**.
1. Select **Refresh** to refresh the profiles page and view the new profile.

## Create and link Conditional Access policy

Create a Conditional Access policy for end users or groups and deliver your security profile through Conditional Access Session controls. Conditional Access is the delivery mechanism for user and context awareness for Internet Access policies. To learn more about session controls, see [Conditional Access: Session](/azure/active-directory/conditional-access/concept-conditional-access-session).

1. Browse to **Identity** > **Protection** > **Conditional Access**.
1. Select **Create new policy**.
1. Enter a name and assign a user or group.
1. Select **Target resources** and **Global Secure Access (Preview)** from the drop-down menu to set what the policy applies to.
1. Select **Internet traffic** from the drop-down menu to set the traffic profile this policy applies to.
1. Select **Session** > **Use Global Secure Access security profile** and choose a security profile.
1. Select **Select**.
1. In the **Enable policy** section, ensure **On** is selected.
1. Select **Create**.

## Verify end user policy enforcement

Use a Windows device with the Global Secure Access client installed. Sign in as a user that is assigned the Internet traffic acquisition profile. Test that navigating to websites is allowed or restricted as expected.

1. Right-click on the Global Secure Access client icon in the task manager tray and open **Advanced Diagnostics** > **Forwarding profile**. Ensure that the Internet access acquisition rules are present. Also, check if the hostname acquisition and flows for the users Internet traffic are being acquired while browsing.

1. Navigate to an allowed site and check if it loads properly.

1. Navigate to a blocked site and confirm the site is blocked.

1. Browse to **Global Secure Access** > **Monitor** > **Traffic logs** to confirm traffic if blocked or allowed appropriately. It takes approximately 15 minutes for new entries to appear.

> [!NOTE]
> The current blocking experience for all browsers and processes includes a "Connection Reset" browser error for HTTPS traffic and a "DeniedTraffic" browser error for HTTP traffic.

## Known limitations

- Currently, end-user notification on blocks, either from the client or the browser, aren't provided.
- Admins can't configure their own Internet traffic acquisition profiles for the client.
- The client traffic acquisition policy includes TCP ports 80/443.
- Currently assuming standard ports for HTTP/S traffic (ports 80 and 443).
- *microsoft.com is currently acquired by the Microsoft 365 access profile.
- IPv6 isn't supported on this platform yet.
- Hyper-V isn't supported on this platform yet.
- Remote network connectivity for branch offices is currently not supported.
- OSI Layer 3/4 (that is, network layer) filtering isn't supported yet.
- No captive portal support yet. This means that connecting to public WiFi via captive portal access may fail because these endpoints are currently acquired by the client.
- TLS Termination is in development.
- No URL path based filtering or URL categorization for HTTP and HTTPS traffic.
- Currently, an admin can create up to 100 web content filtering policies and up to 1,000 rules based on up to 8,000 total FQDNs. Admins can also create up to 256 security profiles.
  - These initial limits are placeholders until more features are added to this platform.

## Next steps

- [Learn about the traffic dashboard](concept-traffic-dashboard.md)
