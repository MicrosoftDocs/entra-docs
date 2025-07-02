---
title: Learn about Security Service Edge (SSE) coexistence with Microsoft and Cisco.
description: Microsoft and Cisco’s Security Service Edge (SSE) coexistence solution guide.
author: kenwith
ms.author: kenwith
manager: dougeby
ms.topic: conceptual
ms.date: 02/21/2025
ms.service: global-secure-access
ms.subservice: entra-private-access 
ms.reviewer: shkhalid
ai-usage: ai-assisted
---

# Learn about Security Service Edge (SSE) coexistence with Microsoft and Cisco

Leverage Microsoft and Cisco’s Security Service Edge (SSE) solutions in a unified environment to harness a robust set of capabilities from both platforms and elevate your Secure Access Service Edge (SASE) journey. The synergy between these platforms empowers customers with enhanced security and seamless connectivity.

This document contains steps to deploy these solutions side by side, specifically, Microsoft Entra Private Access (with Private DNS feature enabled) and Cisco Umbrella for internet access and DNS-layer security.
 
## Configuration overview

In Microsoft Entra, you enable the Private Access traffic forwarding profile and disable the Internet Access and Microsoft 365 traffic forwarding profiles. You also enable and configure the Private DNS feature of Private Access. In Cisco, you capture Internet Access traffic.

> [!NOTE]
> The clients must be installed on a Windows 10 or Windows 11 Microsoft Entra joined device or Microsoft Entra hybrid joined device.

## Microsoft Entra Private Access configuration

Enable the Microsoft Entra Private Access traffic forwarding profile for your Microsoft Entra tenant. For more information about enabling and disabling profiles, see [Global Secure Access traffic forwarding profiles](concept-traffic-forwarding.md).

Install and configure the Global Secure Access Client on end-user devices. For more information about clients, see [Global Secure Access clients](concept-clients.md). To learn how to install the Windows client, see [Global Secure Access client for Windows](how-to-install-windows-client.md). 

Install and configure the Microsoft Entra private network connector. To learn how to install and configure the connector, see [How to configure connectors](how-to-configure-connectors.md).

> [!NOTE]
> Connector version v1.5.3829.0 or higher is required for Private DNS.

Configure Quick Access to your private resources and set up Private DNS and DNS suffixes. To learn how to configure Quick Access, see [How to configure Quick Access](how-to-configure-quick-access.md).

## Cisco configuration

Add domain suffixes from Microsoft Entra Quick Access and Microsoft Entra service FQDN in Domain Management in Internal domains list to bypass Cisco’s Umbrella DNS. Add Microsoft Entra service FQDN and IPs in Domain Management in External domains list to bypass Cisco’s Secure Web Gateway (SWG).
1. From Cisco Umbrella portal, go to **Deployments > Configuration > Domain Management**.
1. In **Internal Domains** section, add these and save. 
    - `*.globalsecureaccess.microsoft.com` 
        > [!NOTE]
        > Cisco Umbrella has an implied wildcard, so you can use `globalsecureaccess.microsoft.com`.
    - `<quickaccessapplicationid>.globalsecureaccess.local` 
        > [!NOTE]
        > `quickaccessapplicationid` is the application id of the quick access app you’ve configured.
    - DNS suffixes you’ve configured in the Quick Access application.
1. In the **External Domains & IPs** section, add these FQDN and IPs and save.
    -  `*.globalsecureaccess.microsoft.com, 150.171.19.0/24, 150.171.20.0/24, 13.107.232.0/24, 13.107.233.0/24, 150.171.15.0/24, 150.171.18.0/24, 151.206.0.0/16, 6.6.0.0/16`
        > [!NOTE] 
        > Cisco Umbrella has an implied wildcard, so you can use `globalsecureaccess.microsoft.com` for the FQDN.
1. Restart Cisco Umbrella and Cisco SWG client services or restart the machine where the clients are installed.

After both clients are installed and running side by side and configurations from admin portals are complete, go to the system tray to check that Global Secure Access and Cisco clients are enabled.

Verify configuration for Global Secure Access client.
1. Right click on the **Global Secure Access client > Advanced Diagnostics > Forwarding Profile** and verify that only Private Access rules are applied to this client.
1. In **Advanced Diagnostics > Health Check** ensure no checks are failing.

## Test traffic flow
Microsoft’s SSE configuration: Enable Microsoft Entra Private Access, disable Internet Access and Microsoft 365 traffic forwarding profiles.

Cisco SSE configuration: Internet Access traffic is captured. The Private Access traffic is excluded.

1. In the system tray, right-click the Global Secure Access client icon and then select **Advanced Diagnostics**. Select the **Traffic** tab and select **Start collecting**.
1. Access private resources you’ve configured with Entra Private Access such as SMB File share. Open `\\YourFileServer.yourdomain.com` by using the **Start/Run** menu from an explorer window.
1. In the system tray, right-click the Global Secure Access client and then select **Advanced Diagnostics**. In the **Network traffic** dialog box, select **Stop collecting**.
1. In the **Network traffic** dialog box, scroll to observe the traffic generated to confirm that Private Access traffic was handled by the Global Secure Access client.
1. You can also verify that the traffic is captured by Microsoft Entra by validating the traffic in the Global Secure Access traffic logs from Microsoft Entra admin center in **Global Secure Access > Monitor > Traffic logs**.
1. Access any websites from the browsers and validate that internet traffic is missing from Global Secure Access traffic logs and only captured in Cisco Umbrella.

## Next steps

- [What is Global Secure Access?](overview-what-is-global-secure-access.md)
