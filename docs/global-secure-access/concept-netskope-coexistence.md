---
title: Learn about Security Service Edge (SSE) coexistence with Microsoft and Netskope.
description: Microsoft and Netskope’s Security Service Edge (SSE) coexistence solution guide.
author: kenwith
ms.author: kenwith
manager: femila
ms.topic: conceptual
ms.date: 02/21/2025
ms.service: global-secure-access
ms.subservice: entra-private-access 
ms.reviewer: shkhalid
ai-usage: ai-assisted
---

# Learn about Security Service Edge (SSE) coexistence with Microsoft and Netskope

Microsoft’s Security Service Edge solution provides a robust set of capabilities to increase security and improve performance of your Microsoft 365 products. Some of these capabilities include: 

- Prevent data moving to untrusted tenants.
- Verify users and conditions before giving access to the network.
- Revoke access to Microsoft 365 products when conditions change by using continuous access evaluation.
- Apply location-based Conditional Access, risk detection, and enhanced activity logs by taking advantage of source IP restoration.
- Protect Microsoft 365 apps against token infiltration and anonymous access.

These capabilities are unique to Microsoft Entra Internet Access for Microsoft 365. You can use these features for Microsoft 365 and use Netskope Security Service Edge (SSE) solution at the same time. As a result, you harness a robust set of capabilities from both platforms to elevate your SSE journey. The synergy between these platforms empowers you with enhanced security and seamless connectivity. 

This document contains steps to deploy the two solutions side by side. Specifically, Microsoft Entra Internet Access for Microsoft 365 applications such as Exchange Online and SharePoint Online, and Netskope SSE for all other web traffic.
 
## Configuration overview

In Microsoft Entra, you enable the Microsoft 365 traffic forwarding profile and disable the Internet Access and Private Access traffic forwarding profiles. Only Microsoft 365 traffic is captured. In Netskope, you capture Internet Access traffic and exclude Microsoft 365 traffic.

> [!NOTE]
> The clients must be installed on a Windows 10 or Windows 11 Microsoft Entra joined device or Microsoft Entra hybrid joined device.

## Microsoft Entra Internet Access for Microsoft 365 configuration

Enable the Microsoft 365 traffic forwarding profile for your Microsoft Entra tenant. For more information about enabling and disabling profiles, see [Global Secure Access traffic forwarding profiles](concept-traffic-forwarding.md).

Install and configure the Global Secure Access Client on end-user devices. For more information about clients, see [Global Secure Access clients](concept-clients.md). To learn how to install the Windows client, see [Global Secure Access client for Windows](how-to-install-windows-client.md).

## Netskope configuration

Create network location profiles to bypass Microsoft 365 destination Internet Protocol (IP) addresses and Microsoft SSE service IPs.
1. Navigate to **Policies** > **Profiles** > **Network Location** > **New Network Location** > **Single Object**. 
1. Add the routes and save them as **MSFT SSE Service**:`150.171.19.0/24`, `150.171.20.0/24`, `13.107.232.0/24`, `13.107.233.0/24`, `150.171.15.0/24`, `150.171.18.0/24`, `151.206.0.0/16`, `6.6.0.0/16`.
1. Repeat steps 1 and 2 to add Microsoft 365 IPs and save them as **MSFT SSE M365**: `132.245.0.0/16`, `204.79.197.215/32`, `150.171.32.0/22`, `131.253.33.215/32`, `23.103.160.0/20`, `40.96.0.0/13`, `52.96.0.0/14`, `40.104.0.0/15`, `13.107.128.0/22`, `13.107.18.10/31`, `13.107.6.152/31`, `52.238.78.88/32`, `104.47.0.0/17`, `52.100.0.0/14`, `40.107.0.0/16`, `40.92.0.0/15`, `150.171.40.0/22`, `52.104.0.0/14`, `104.146.128.0/17`, `40.108.128.0/17`, `13.107.136.0/22`, `40.126.0.0/18`, `20.231.128.0/19`, `20.190.128.0/18`, `20.20.32.0/19`.
    > [!NOTE]
    > Additional Microsoft 365 traffic will be added later. Refer to [M365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges) for a complete list.
1. Navigate to **Policies** > **Profiles** and select **Apply Changes** on the top right side of your screen.

Create a Steering Configuration to steer all web app traffic to Netskope except Microsoft 365.
1. Navigate to **Settings** > **Security Cloud Platform** > **Traffic Steering** > **Steering Configuration** > **New Configuration**. 
1. Add a name, for example `MSFTSSEWebTraffic`, and assign a user group or Organizational Unit (OU).
1. Select **Web Traffic** for the kind of traffic to steer. Leave the configuration disabled and select **Save**. 
1. Navigate to **Exceptions** > **New Exception** > **Destination Locations** and select the newly created configuration.  
1. In this **Exception**, add **MSFT SSE Service** and **MSFT SSE M365** in **Destination Locations**. 
1. Select **Bypass** and **Treat it like local IP address** options. 
1. Next add exceptions for domains for **MSFT SSE service** and **MSFT M365**. Select **Exceptions** > **New Exception** > **Domains** and add these exceptions: `*.globalsecureaccess.microsoft.com`, `*.auth.microsoft.com`, `*.msftidentity.com`, `*.msidentity.com`, `*.onmicrosoft.com`, `*.outlook.com`, `*.protection.outlook.com`, 
`*.sharepoint.com`, `*.sharepointonline.com`, `*.svc.ms`, `*.wns.windows.com`, `account.activedirectory.windowsazure.com`, `accounts.accesscontrol.windows.net`, `admin.onedrive.com`, `adminwebservice.microsoftonline.com`, `api.passwordreset.microsoftonline.com`, `autologon.microsoftazuread-sso.com`, `becws.microsoftonline.com`, `ccs.login.microsoftonline.com`, `clientconfig.microsoftonline-p.net`, `companymanager.microsoftonline.com`, `device.login.microsoftonline.com`, `g.live.com`, `graph.microsoft.com`, `graph.windows.net`, `login-us.microsoftonline.com`, `login.microsoft.com`, `login.microsoftonline-p.com`, `login.microsoftonline.com`, `login.windows.net`, `logincert.microsoftonline.com`, `loginex.microsoftonline.com`, `nexus.microsoftonline-p.com`, `officeclient.microsoft.com`, `oneclient.sfx.ms`, `outlook.cloud.microsoft`, `outlook.office.com`, `outlook.office365.com`, `passwordreset.microsoftonline.com`, `provisioningapi.microsoftonline.com`, `spoprod-a.akamaihd.net`. 
1. Ensure that the **MSFT SSE** configuration is at the top of the list of steering configurations in your tenant. Then enable the configuration.

Set up the Netskope client. For more information about the Netskope client, see [https://docs.netskope.com/en/netskope-help/netskope-client](https://docs.netskope.com/en/netskope-help/netskope-client). 

For the most basic setup, add your email address to the Netskope Security Cloud Platform. 
1. Browse to **Settings** > **Security Cloud Platform** > **Netskope Client** > **Users**. 
1. Add the user’s email address. The user gets an email to set up the client. 
1. Open the system tray to check that Global Secure Access and Netskope clients are enabled.    
1. Right-click on **Global Secure Access Client** > **Advanced Diagnostics** > **Forwarding Profile**. Verify that only Microsoft 365 rules are applied to this client. 
1. Navigate to **Advanced Diagnostics** > **Health Check** and ensure no checks are failing.
1. Right-click on **Netskope Client** > **Client Configuration**. Verify steering config and traffic steering type match configurations in the earlier steps. Validate that configuration is up to date or update it.  

## Test traffic flow
Microsoft’s SSE configuration: Enable Microsoft 365 traffic forwarding profile, disable Internet Access and Private Access traffic forwarding profiles.

Netskope SSE configuration: Internet Access traffic is captured. The Microsoft 365 traffic is excluded.

1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. Select the **Traffic** tab and select **Start collecting**. 
1. Access these websites from the browsers: `bing.com`, `salesforce.com`, and `Instagram.com`.
1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access** > **Monitor** > **Traffic logs**. Validate traffic related to these sites is missing from the Global Secure Access traffic logs. 
1. Sign in to **Netskope Cloud Account** and browse to **Skope IT** > **Events** > **Page Events**. Validate traffic related to these sites is present in Netskope logs.
1. Access Outlook Online (`outlook.com`, `outlook.office.com`, `outlook.office365.com`), SharePoint Online (`<yourtenantdomain>.sharepoint.com`) and verify that the Microsoft Entra Internet Access Microsoft 365 access profile is capturing the traffic. Validate traffic in the Global Secure Access traffic logs. 
1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. In the network traffic dialog box, select **Stop collecting**.
1. In the network traffic dialog box, confirm that the Global Secure Access client **only** handles the Microsoft 365 traffic.
1. Validate traffic related to Outlook Online and SharePoint Online is missing from Netskope logs in **Skope IT** > **Events** > **Page Events**. 



## Next steps

- [What is Global Secure Access?](overview-what-is-global-secure-access.md)
