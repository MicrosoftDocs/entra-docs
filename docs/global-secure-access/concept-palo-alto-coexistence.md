---
title: Learn about Security Service Edge (SSE) coexistence with Microsoft and Palo Alto Networks.
description: Microsoft and Palo Alto Network’s Security Service Edge (SSE) coexistence solution guide.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: conceptual
ms.date: 07/02/2024
ms.service: global-secure-access
ms.subservice: entra-private-access 
ms.reviewer: shkhalid
---

# Learn about Security Service Edge (SSE) coexistence with Microsoft and Palo Alto Networks

Microsoft’s Security Service Edge solution provides a robust set of capabilities to increase security and improve performance of your Microsoft 365 products. Some of these capabilities include: 

- Prevent data moving to untrusted tenants.
- Verify users and conditions before giving access to the network.
- Revoke access to Microsoft 365 products when conditions change by using continuous access evaluation.
- Apply location-based conditional access, risk detection, and enhanced activity logs by taking advantage of source IP restoration.
- Protect Microsoft 365 apps against token infiltration and anonymous access.

These capabilities are unique to Microsoft Entra Internet Access for Microsoft 365. You can use these features for Microsoft 365 and use Palo Alto Networks Security Service Edge (SSE) solution at the same time. As a result, you harness a robust set of capabilities from both platforms to elevate your SSE journey. The synergy between these platforms empowers you with enhanced security and seamless connectivity. 

This document contains steps to deploy the two solutions side by side. Specifically, Microsoft Entra Internet Access for Microsoft 365 applications such as Exchange Online and SharePoint Online, and Palo Alto Networks SSE for all other web traffic.
 
## Configuration overview

In Microsoft Entra, you enable the Microsoft 365 traffic forwarding profile and disable the Internet Access and Private Access traffic forwarding profiles. Only Microsoft 365 traffic is captured. In Palo Alto Networks, you capture Internet Access traffic and exclude Microsoft 365 traffic.

> [!NOTE]
> The clients must be installed on a Windows 10 or Windows 11 Entra joined device or Microsoft Entra hybrid joined.

## Microsoft Entra Internet Access for Microsoft 365 configuration

Enable the Microsoft 365 traffic forwarding profile for your Microsoft Entra tenant. For more information about enabling and disabling profiles, see [Global Secure Access traffic forwarding profiles](concept-traffic-forwarding.md).

Install and configure the Global Secure Access client on end-user devices. For more information about clients, see [Global Secure Access clients](concept-clients.md). To learn how to install the Windows client, see [Global Secure Access client for Windows](how-to-install-windows-client.md).

## Palo Alto Networks configuration

Bypass Microsoft Entra service Fully Qualified Domain Name (FQDN) and Internet Protocol (IP) addresses in tunnel settings for Global Protect client: 

1. In the Strata Cloud Manager portal, go to **Workflows** > **Prisma Access Setup** > **GlobalProtect** > **GlobalProtect App** > **Tunnel Settings**. 
1. In the **Split Tunneling** section, exclude traffic by adding the domain and routes: `*.globalsecureaccess.microsoft.com`, `150.171.19.0/24`, `150.171.20.0/24`, `13.107.232.0/24`, `13.107.233.0/24`, `150.171.15.0/24`, `150.171.18.0/24`, `151.206.0.0/16`, `6.6.0.0/16`. 
1. Navigate to **Workflows** > **Prisma Access Setup** > **GlobalProtect** > **GlobalProtect App**. Select **Push Config** and select **Push** on the top right side of your screen. 
1. Verify that the configuration pushed to the Global Protect client. Navigate to **Manage** > **Operations** > **Push Status**. 

Install the Palo Alto Networks Global Protect client. For more information on installing the Palo Alto Networks Global Protect client, see [https://docs.paloaltonetworks.com/globalprotect/6-2/globalprotect-app-user-guide/globalprotect-app-for-windows](https://docs.paloaltonetworks.com/globalprotect/6-2/globalprotect-app-user-guide/globalprotect-app-for-windows).

To set up the Global Protect client there are a lot of options like tying in Microsoft Entra ID to create your accounts. To learn more about the options, see [Tutorial: Microsoft Entra single sign-on (SSO) integration with Palo Alto Networks - GlobalProtect](..//identity/saas-apps/palo-alto-networks-globalprotect-tutorial.md).

For the most basic setup, add a local user to the Global Protect from Palo Alto Networks’ Strata Cloud Manager. 

1. Browse to **Manage** > **Configuration** > **NGFW and Prisma Access**.  
1. Select **Configuration Scope** > **Global Protect** and then select **Identity Services** > **Local Users & Groups** > **Local Users**. Add a user and password for testing. 
1. After the client is installed, users enter the portal address and their credentials.  
1. After users sign in, the connection icon turns blue, and clicking on shows it in a connected state. 

Verify Clients’ Connectivity and Configuration: 
1. Go to the system tray to check that *Global Secure Access* and *Global Protect* clients are enabled.  
1. Verify the configuration for *Global Secure Access* client.
    1. Right-click on **Global Secure Access Client** > **Advanced Diagnostics** > **Forwarding Profile**. Verify that only Microsoft 365 rules are applied to this client. 
    1. In **Advanced Diagnostics** > **Health Check**. Ensure no checks are failing.

## Test traffic flow
Microsoft’s SSE configuration: Enable Microsoft 365 traffic forwarding profile, disable Internet Access and Private Access traffic forwarding profiles.


Palo Alto Networks’ SSE configuration: Internet Access traffic is captured. The Microsoft 365 traffic is excluded. 
1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. Select the **Traffic** tab and select **Start collecting**. 
1. Access these websites from the browsers: `salesforce.com`, `Instagram.com`.
1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access** > **Monitor** > **Traffic logs**. Validate traffic related to these sites is missing from the Global Secure Access traffic logs. 
1. Sign in to Palo Alto Networks’ Strata Cloud Manager and browse to **Incidents & Alerts** > **Log Viewer**. Validate traffic related to these sites is present in the logs. 
1. Access Outlook Online (`outlook.com`, `outlook.office.com`, `outlook.office365.com`), SharePoint Online (`<yourtenantdomain>.sharepoint.com`) and verify that the Microsoft Entra Internet Access Microsoft 365 access profile is capturing the traffic. Validate traffic in the Global Secure Access traffic logs. 
1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. In the network traffic dialog box, select **Stop collecting**.
1. In the network traffic dialog box, confirm that the Global Secure Access client **only** handles the Microsoft 365 traffic.
1. Validate traffic related to Outlook Online and SharePoint Online is missing from Palo Alto Networks’ Strata Cloud Manager in **Incidents & Alerts** > **Log Viewer**. 

## Troubleshooting
The Global Secure Access client is disconnected for a few minutes before it fully reconnects. The behavior occurs when the Global Secure Access client is already connected and the Global Protect client is turns on. The Global Protect client forces any existing tunnels/connections to reconnect as it starts up.

## Next steps

-[What is Global Secure Access?](overview-what-is-global-secure-access.md)
