---
title: How to configure Global Secure Access (preview) web content filtering
description: Learn how to configure web content filtering in Microsoft Entra Internet Access (preview).
author: kenwith    
ms.author: kenwith
manager: amycolannino
ms.topic: how-to
ms.date: 10/05/2023
ms.service: network-access
ms.custom: 
ms.reviewer: frankgomulka
---

# How to configure Global Secure Access (preview) web content filtering

Filtering web content is a critical component when implementing Internet access controls for a modern Security Service Edge (SSE) solution. 

Microsoft Entra Internet Access includes Web Content Filtering (WCF) as part of the Secure Web Gateway feature. Microsoft integrates filtering with Microsoft Entra ID and Microsoft Entra Conditional Access, which results in filter policies that are user-aware and easy to manage.

## Prerequisites

Ensure your tenant is signed up for Microsoft Entra Internet Access (preview).
Install the Global Secure Access client on end user devices.

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
1. Enter a name, select a web category, and then select **Add**.
1. Select **Next** to review the policy and then select **Create policy**.


## Create a policy profile to assign / link policies to a profile
Create a policy profile to assign, or link, policies with a profile.
1. 

## Create a Conditional Access policy
Create a Conditional Access policy for end users or groups and link it to the filtering profile.
1. 

## Test policy enforcement
Use a Windows device with the Global Secure Access client installed. Sign in as a user that is assigned the Internet traffic acquisition profile. Test that navigating to websites is allowed or restricted as expected.

To check if the client is acquiring Internet traffic, right-click on the Global Secure Access client icon in the task manager tray and open **Connection Diagnostics** > **Channels**. Ensure that the Internet channel is Present and Green. Also, check if the hostname acquisition and flows for the users Internet traffic are being acquired while browsing.

Navigate to an approved site and check if it loads properly. Next, navigate to a restricted site and confirm the site is blocked.

View Internet Access traffic logs in the Microsoft Entra admin center. Navigate to **Global Secure Access** > **Monitor** > **traffic logs**. It takes approximately 15 minutes for new entries to appear.


## Limitations
- There's currently no end-user notification on blocks, either from the client or the browser.
- Admins aren't allowed to configure their own Internet traffic acquisition profiles for the client.
    - The client traffic acquisition policy includes TCP ports 80/443 for all valid FQDNs only.
    - There is no support for UDP, no L3/4 filtering support, and standard ports are assumed for HTTP/S traffic.
- Only FQDN-based filtering is currently supported. URL based filtering isn't yet supported.
- "Remote Network" or "Branch" connectivity scenarios aren't supported.
- Users are'nt allowed to block access to all websites by default.

## Troubleshooting

## Next steps

- [Learn about the traffic dashboard](concept-traffic-dashboard.md)
