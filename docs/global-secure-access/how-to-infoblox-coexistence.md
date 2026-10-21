---
title: Configure Microsoft Entra Global Secure Access with Infoblox
description: Learn how to configure Microsoft Entra Private Access and Infoblox Threat Defense together for private application access and DNS security.
author: lirazbarak
ms.author: lirazb
ms.service: global-secure-access
ms.topic: how-to
ms.custom: msecd-doc-authoring-1030
ms.date: 10/21/2026
ai-usage: ai-assisted

#customer intent: As an IT admin, I want to configure Infoblox Threat Defense with Global Secure Access so that private application traffic and DNS security work together.
---

# Configure Microsoft Entra Global Secure Access with Infoblox Threat Defense

This article describes how to configure Microsoft Entra Global Secure Access with Infoblox Threat Defense so private application traffic and DNS security work together.

## Overview

In today's rapidly evolving digital landscape, organizations require robust and unified solutions to ensure secure and seamless connectivity. Microsoft and Infoblox offer complementary Secure Access Service Edge (SASE) and Threat Defense security capabilities that, when integrated, provide enhanced security and connectivity for diverse access scenarios.

This guide outlines how to configure and deploy Microsoft Entra solutions alongside Infoblox's Threat Defense offerings. By using the strengths of both platforms, you can optimize your organization's security posture while maintaining high-performance connectivity for private applications, Microsoft 365 traffic, and internet access.

## Prerequisites

Before you begin:

- Set up Microsoft Entra Private Access and Infoblox Threat Defense DNS security.
- Configure the Global Secure Access fully qualified domain name (FQDN) and IP bypasses for coexistence.

## Prepare Microsoft Entra Private Access

Configure Microsoft Entra Private Access so Global Secure Access can handle private application traffic.

1. Enable the [Microsoft Entra Private Access traffic forwarding profile](how-to-manage-private-access-profile.md).
1. Install a [Private Network Connector](how-to-configure-connectors.md) for Microsoft Entra Private Access.

    > [!NOTE]
    > Private Network Connectors are required for Microsoft Entra Private Access applications.

1. Configure Global Secure Access Enterprise Applications and Quick Access for your private resources, and set up Private DNS and DNS suffixes. For more information, see [How to configure Quick Access](how-to-configure-quick-access.md).
1. Install and configure the [Global Secure Access client for Windows](how-to-install-windows-client.md) or [Global Secure Access client for macOS](how-to-install-macos-client.md).

## Create Infoblox Threat Defense Internal Domains

Create Internal Domain lists to bypass Infoblox DNS for Global Secure Access and private application FQDNs. For more information, see [Configuring Internal Domains](https://docs.infoblox.com/space/BloxOneThreatDefense/35437388/Configuring+Internal+Domains).

1. In the Infoblox portal, go to **Configure** > **Security** > **Internal Domains**, and select **Create Internal Domain**.
1. Create an Internal Domain list named `MSFT GSA`. Add `globalsecureaccess.microsoft.com`, and then select **Save & Close**.
1. Create another Internal Domain list for the FQDNs of your private application app segments in the Microsoft Entra portal. For example, if a private application for a Remote Desktop Protocol (RDP) server uses the FQDN `termsrv.example.com`, add that FQDN to the list.
1. Add the FQDNs for your private applications, such as `termsrv.example.com` and `smb.example.com`, and save the list as `Private Apps`.

## Create an Infoblox Threat Defense category filter

Create a category filter to test Infoblox category filtering alongside Global Secure Access. For more information, see the Infoblox [Filters documentation](https://docs.infoblox.com/space/BloxOneThreatDefense/35469571/Filters).

1. In the Infoblox portal, go to **Configure** > **Security** > **Policies** > **Filters**.
1. Select **Create Filter** > **Create Category Filter**.
1. Enter a name, such as `Block Real Estate`, select a category, such as **Real Estate**, and then select **Save & Close**.

Use this filter when you configure the security policy.

## Configure an Infoblox Endpoint Group and security policy

Create an Endpoint Group that uses the Internal Domain lists, then create a security policy to apply the category filter to that group. For more information, see [Creating Endpoint Groups](https://docs.infoblox.com/space/BloxOneThreatDefense/35473957/Creating+Endpoint+Groups) and [Configuring Security Policies](https://docs.infoblox.com/space/BloxOneThreatDefense/35371559/Configuring+Security+Policies).

> [!NOTE]
> If you have multiple policy rules, make sure the category filter rule order enforces the filter. Also make sure the security policy precedence doesn't prevent users from receiving the correct Infoblox policy for coexistence.

1. In the Infoblox portal, go to **Configure** > **Security** > **Endpoints**.
1. Select **Endpoint Groups** > **Create**.
1. Name the Endpoint Group, such as `GSA endpoints`, and expand **Internal Domain Lists**.
1. Select **Add**, select `MSFT GSA` and `Private Apps`, and then select **Save & Close**. Leave the other settings at their defaults.
1. Go to **Configure** > **Security** > **Policies**, and select **Create Security Policy**.
1. Enter a name for the policy, such as `GSA policy`.
1. On the **Network Scope** page, select **Add Source** > **Endpoint Groups**.
1. Select `GSA endpoints` from **Available Endpoint Groups**, and select the arrow to move it to the **Selected** section.
1. On the **Policy Rules** page, select **Add Rule** > **Category Filter**.
1. Select **Object** > `Block Real Estate` > **Select**.
1. Set **Action** to **Block**, set **Default Redirect**, and select **Finish**.

1. Install the Infoblox BloxOne Endpoint software on end-user devices. For more information, see [Managing Endpoint](https://docs.infoblox.com/space/BloxOneThreatDefense/35374260/Managing+Endpoint). For standalone installation instructions for Windows and macOS, see [Standalone Deployment](https://docs.infoblox.com/space/BloxOneThreatDefense/35436945/Standalone+Deployment).
1. Check the system tray to make sure the Global Secure Access and Infoblox clients are enabled.

## Verify the client configuration and traffic flow

Verify the client configuration and test traffic to confirm that Global Secure Access handles private application traffic and Infoblox handles DNS activity for internet sites.

1. Right-click the **Global Secure Access Client**, select **Advanced Diagnostics** > **Forwarding Profile**, and verify that Private Access and Private DNS rules are applied to the client.
1. In **Advanced Diagnostics**, select **Health Check** and make sure no checks are failing.
1. Select the Infoblox Endpoint system tray icon and verify that the status is **Protected**.

    > [!NOTE]
    > For information about troubleshooting health check failures, see [Troubleshoot the Global Secure Access client: Health check](troubleshoot-global-secure-access-client-diagnostics-health-check.md).

1. In the system tray, right-click **Global Secure Access Client**, select **Advanced Diagnostics**, select the **Traffic** tab, and select **Start collecting**.
1. In a browser, access `bing.com`, `salesforce.com`, and `Instagram.com`.
1. In **Advanced Diagnostics**, select the **Traffic** tab and verify that the Global Secure Access client isn't capturing traffic from these websites.
1. In the Microsoft Entra admin center, go to **Global Secure Access** > **Monitor** > **Traffic logs**. Verify that traffic for these sites is missing from the Global Secure Access traffic logs.
1. In the Infoblox portal, go to **Monitor** > **Reports** > **Security** > **DNS Activity**. Verify that traffic for these sites is present in Infoblox logs.
1. Access a private application configured in Microsoft Entra Private Access, such as a file share over Server Message Block (SMB).
1. In the Microsoft Entra admin center, go to **Global Secure Access** > **Monitor** > **Traffic logs**. Verify that traffic for the file share is captured in the Global Secure Access traffic logs.
1. In the Infoblox portal, go to **Monitor** > **Reports** > **Security** > **DNS Activity**. Verify that traffic for the private application isn't present in the traffic logs.
1. In the system tray, right-click **Global Secure Access Client**, select **Advanced Diagnostics**, and in the **Traffic** dialog box, select **Stop collecting**.
1. Verify that the Global Secure Access client handled only private application traffic.
