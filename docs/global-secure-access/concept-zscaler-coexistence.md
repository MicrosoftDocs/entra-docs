---
title: Learn about Security Service Edge (SSE) coexistence with Microsoft and Zscaler.
description: Microsoft and Zscaler’s Security Service Edge (SSE) coexistence solution guide.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: conceptual
ms.date: 04/29/2024
ms.service: global-secure-access
ms.subservice: entra-private-access 
ms.reviewer: shkhalid
---

# Learn about Security Service Edge (SSE) coexistence with Microsoft and Zscaler

Microsoft’s Security Service Edge solution provides a robust set of capabilities to increase security and improve performance of your Microsoft 365 products. Some of these capabilities include: 

- Prevent data moving to untrusted tenants.
- Verify users and conditions before giving access to the network.
- Revoke access to Microsoft 365 products when conditions change by using continuous access evaluation.
- Apply location-based conditional access, risk detection, and enhanced activity logs by taking advantage of source IP restoration.
- Protect Microsoft 365 apps against token infiltration and anonymous access.

These capabilities are unique to Microsoft Entra Internet Access for Microsoft 365. You can use these features for Microsoft 365 and use Zscaler Security Service Edge (SSE) solution at the same time. As a result, you harness a robust set of capabilities from both platforms to elevate your SSE journey. The synergy between these platforms empowers you with enhanced security and seamless connectivity. 

This document contains steps to deploy the two solutions side by side. Specifically, Microsoft Entra Internet Access for Microsoft 365 applications such as Exchange Online and SharePoint Online, and Zscaler SSE for all other web traffic.
 
## Configuration overview

Two configurations are covered in this article. 

In the first configuration, you enable the Microsoft 365 and Internet Access traffic forwarding profiles. You disable the Private Access traffic forwarding profile. The Global Secure Access client captures Microsoft 365 and Internet traffic. The Zscaler client captures Private Access traffic.

> [!NOTE]
> The client must be installed on a Windows 10 or Windows 11 Entra joined device.

In the second configuration, you enable the Microsoft 365 forwarding profile and disable the Internet Access and Private Access traffic forwarding profiles. The Global Secure Access client captures Microsoft 365 traffic. The Zscaler client captures Internet Access traffic.

> [!NOTE]
> The clients must be installed on Windows 10 or Windows 11 Entra joined device or a macOS Monterey device registered to Entra with Intune Company Portal. 

## Microsoft Entra Internet Access and Microsoft Entra Private Access configuration

Configure the traffic forwarding profiles for your Microsoft Entra tenant. For more information about enabling and disabling profiles, see [Global Secure Access (preview) traffic forwarding profiles](concept-traffic-forwarding.md).

For the first configuration, enable the Microsoft 365 and Internet Access traffic forwarding profiles. For the second configuration, enable the Microsoft 365 traffic forwarding profile only.

Install and configure the Global Secure Access Client on end-user devices. For more information about clients, see [Global Secure Access clients](concept-clients.md).

## Zscaler configuration 1

Configure single sign-on (SSO) authentication for Zscaler Private Access (ZPA). For more information on configuring SSO, see [https://help.zscaler.com/zpa/configuration-guide-microsoft-azure-ad](https://help.zscaler.com/zpa/configuration-guide-microsoft-azure-ad).

Configure and deploy Zscaler app connectors. For more information on Zscaler app connectors, see [https://help.zscaler.com/zpa/app-connector-management/app-connectors](https://help.zscaler.com/zpa/app-connector-management/app-connectors).

1. Navigate to **ZPA admin portal** > **Configuration & Control** > **Private Infrastructure** > **App Connector Management** > **App Connectors** > **Add App Connector**.
1. Deploy App Connector on your supported platform by following the respective guide. 
1. Verify that the deployed App Connector is running and healthy. 

Configure Zscaler application segments. For more information on Zscaler application segments, see [https://help.zscaler.com/zpa/configuring-application-segments](https://help.zscaler.com/zpa/configuring-application-segments).

1. Navigate to **Resource Management** > **Application Management** > **Application Segments** > **Add Application Segment**.
1. Add Name, IP/FQDN of your private application, ports, and Segment Group.
1. Create an access policy to allow access to your private application (By default, ZPA blocks access to applications and segment groups for users until you configure policy rules that explicitly allow access). Navigate to **Policy** > **Access Policy** > **Add Rule**.

### Install Zscaler client and add forwarding and app profiles

Download Zscaler client from the Zscaler Client Connector App Store in the Zscaler Client Connector Portal.
1. Navigate to **ZPA admin portal** > **Client Connector** > **Administration** > **Client Connector App Store** > **New Releases** > **General Availability**.
1. Select Platform as Windows and download the executable (EXE) or Microsoft Software Installer (MSI) package.
1. Enable build.

Add Forwarding Profile from the Client Connector Portal.
1. Navigate to **ZPA admin portal** > **Client Connector** > **Administration** > **Forwarding Profile** > **Add Forwarding Profile**. 
1. Add a **Profile Name** such as *PF Driver Tunnel*.
1. Select **Packet Filter Based** in **Tunnel Driver Type**.

Add App Profile from the Client Connector Portal.
1. Navigate to **ZPA admin portal** > **Client Connector** > **App Profile** > **Platform** > **Windows** > **Add Windows Policy**. 
1. Add **Name**, set **Rule Order** such as **1**, select **Enable**, select **User(s)** to apply this policy, and select the **Forwarding Profile**. For example, select **PF Driver Tunnel**.
1. Scroll down and add these Microsoft SSE service Internet Protocol (IP) addresses and Fully Qualified Domain Names (FQDNs) in  
“HOSTNAME OR IP ADDRESS BYPASS FOR VPN GATEWAY” field. IPs: `150.171.19.0/24`, `150.171.20.0/24`, `13.107.232.0/24`, `13.107.233.0/24`, `150.171.15.0/24`, `150.171.18.0/24`, `151.206.0.0/16`, `6.6.0.0/16`. FQDNs: `internet.edgediagnostic.globalsecureaccess.microsoft.com`, `m365.edgediagnostic.globalsecureaccess.microsoft.com`, `private.edgediagnostic.globalsecureaccess.microsoft.com`, `aps.globalsecureaccess.microsoft.com`, `<tenantid>.internet.client.globalsecureaccess.microsoft.com`, `<tenantid>.m365.client.globalsecureaccess.microsoft.com`, `<tenantid>.private.client.globalsecureaccess.microsoft.com`.
 
After the client is installed, users are prompted to sign in. After users sign in, the connection icon turns blue and by right clicking the icon and opening Zscaler client will show the Authentication status as Authenticated and Service Status as ON. 

Open the system tray to check that Global Secure Access and Zscaler clients are enabled.  

Verify configurations for clients.
1. Right-click on **Global Secure Access Client** > **Advanced Diagnostics** > **Forwarding Profile** and verify that Microsoft 365 and Internet Access rules are applied to this client. 
1. Navigate to **Advanced Diagnostics** > **Health Check** and ensure no checks are failing.
1. Right-click on **Zscaler Client** > **Open Zscaler** > **More**. Verify **App Policy** matches configurations in the earlier steps. Validate that it's up to date or update it.
1. Navigate to **Zscaler Client** > **Private Access**. Verify **Service Status** is `ON` and **Authentication Status** is `Authenticated`.   

### Test traffic flow

1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. Select the **Traffic** tab and select **Start collecting**. 
1. Access these websites from the browsers: `bing.com`, `salesforce.com`, `Instagram.com`, Outlook Online (`outlook.com`, `outlook.office.com`, `outlook.office365.com`), SharePoint Online (`<yourtenantdomain>.sharepoint.com`).
1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access (Preview)** > **Monitor** > **Traffic logs**. Validate traffic related to these sites is captured in the Global Secure Access traffic logs. 
1. Access your private application. For example, using Secure Shell (SSH).
1. Sign in to ZPA Admin Console and browse to Dashboard > Applications and Dashboard > Users or Analytics > Diagnostics > Logs. Validate traffic related to the private application is present in the Dashboard or traffic logs.
1. Validate traffic related to Microsoft 365 and Internet Traffic such as Instagram.com, Outlook Online, and SharePoint Online is missing from ZPA logs in Analytics > Diagnostics > Logs. 
1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. In the network traffic dialog box, select **Stop collecting**.
1. Scroll to observe that the Global Secure Access client **isn't** capturing traffic from the private application. Also, observe that the Global Secure Access client **is** capturing traffic for Microsoft 365 and other internet traffic. 

## Zscaler configuration 2

Configure Zscaler Internet Access. To learn more about configuring Zscaler, see [https://help.zscaler.com/zia/step-step-configuration-guide-zia](https://help.zscaler.com/zia/step-step-configuration-guide-zia).

Configure user authentication and provisioning methods such as Security Assertion Markup Language (SAML) for authentication and System for Cross-domain Identity Management (SCIM) for provisioning.

Download Zscaler client from the Zscaler Client Connector App Store in the Zscaler Client Connector Portal.
1. Navigate to **ZPA admin portal** > **Client Connector** > **Administration** > **Client Connector App Store** > **New Releases** > **General Availability**.
1. Select Platform as Windows or macOS and download the EXE or MSI package.
1. Enable build.

Add Forwarding Profile from the Client Connector Portal.
1. Navigate to **ZPA admin portal** > **Client Connector** > **Administration** > **Forwarding Profile** > **Add Forwarding Profile**. 
1. Add a **Profile Name** such as `ZIA Tunnel 2.0`.
1. Select **Packet Filter Based** in **Tunnel Driver Type**.
1. Select forwarding profile action as **Tunnel**, and select tunnel version. For example, `Z-Tunnel 2.0`.

Add App Profile from the Client Connector Portal.
1. Navigate to **ZPA admin portal** > **Client Connector** > **App Profile** > **Platform** > **Windows** (or macOS) > **Add Windows Policy** (or macOS). 
1. Add **Name**, set **Rule Order** such as **1**, select **Enable**, select **User(s)** to apply this policy, and select the **Forwarding Profile**. For example, select **ZIA Tunnel 2.0**.
1. Scroll down and add these Microsoft SSE Service IPs and FQDNs in  
**HOSTNAME OR IP ADDRESS BYPASS FOR VPN GATEWAY** field. IPs: `150.171.19.0/24`, `150.171.20.0/24`, `13.107.232.0/24`, `13.107.233.0/24`, `150.171.15.0/24`, `150.171.18.0/24`, `151.206.0.0/16`, `6.6.0.0/16`. FQDNs: `internet.edgediagnostic.globalsecureaccess.microsoft.com`, `m365.edgediagnostic.globalsecureaccess.microsoft.com`, `private.edgediagnostic.globalsecureaccess.microsoft.com`, `aps.globalsecureaccess.microsoft.com`, `<tenantid>.internet.client.globalsecureaccess.microsoft.com`, `<tenantid>.m365.client.globalsecureaccess.microsoft.com`, `<tenantid>.private.client.globalsecureaccess.microsoft.com`.
 
After the client is installed, users are prompted to sign in. After users sign in, the connection icon turns blue and by right clicking the icon and opening Zscaler client will show the Authentication status as Authenticated and Service Status as ON. 

Go to the system tray to check that Global Secure Access and Zscaler clients are enabled.  

Verify configurations for clients.
1. Right-click on **Global Secure Access Client** > **Advanced Diagnostics** > **Forwarding Profile** and verify that Microsoft 365 and Internet Access rules are applied to this client. 
1. Navigate to **Advanced Diagnostics** > **Health Check** and ensure no checks are failing. IPV4 preferred check can be ignored. You can resolve the error by creating a registry key. For more information about the registry key and installing the client, see [Global Secure Access client for Windows (preview)](how-to-install-windows-client.md).
1. Right-click on **Zscaler Client** > **Open Zscaler** > **More**. Verify **App Policy** matches configurations in the earlier steps. Validate that it's up to date or update it.
1. Navigate to **Zscaler Client** > **Private Access**. Verify **Service Status** is `ON` and **Authentication Status** is `Authenticated`.   

### Test traffic flow

1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. Select the **Traffic** tab and select **Start collecting**. 
1. Access these websites from the browsers: `bing.com`, `salesforce.com`, `Instagram.com`.
1. In the system tray, right-click **Global Secure Access Client** and select **Advanced Diagnostics** > **Traffic tab**.
1. Scroll to observe that the Global Secure Access client isn't capturing traffic from these websites.
1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access (Preview)** > **Monitor** > **Traffic logs**. Validate traffic related to these sites is missing from the Global Secure Access traffic logs.
1. Sign in to Zscaler Internet Access (ZIA) admin portal and browse to **Analytics** > **Web Insights** > **Logs**. 
1. Validate traffic related to these sites is present in Zscaler logs. 
1. Access Outlook Online (`outlook.com`, `outlook.office.com`, `outlook.office365.com`), SharePoint Online (`<yourtenantdomain>.sharepoint.com`).  
1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. In the **Traffic** dialog box, select **Stop collecting**.
1. Scroll to confirm the Global Secure Access client handled Microsoft 365 traffic.
1. You can also validate that the traffic is captured in the Global Secure Access traffic logs. In the Microsoft Entra admin center, navigate to **Global Secure Access (Preview)** > **Monitor** > **Traffic logs**. 
1. Validate traffic related to Outlook Online and SharePoint Online is missing from Zscaler logs in **Analytics** > **Web Insights** > **Logs**. 

## Next steps

- [Configure Quick Access](how-to-configure-quick-access.md)
