---
title: Configure Microsoft and Zscaler for a Unified SASE Solution
description: "Learn how to configure Microsoft and Zscaler SSE for unified SASE solutions to enhance security and connectivity in your organization."
#customer intent: As a network administrator, I want to configure Microsoft and Zscaler SSE for unified SASE solutions so that I can enhance security and connectivity in my organization.  
author: kenwith
ms.author: kenwith
manager: femila
ms.topic: how-to
ms.date: 04/30/2025
ms.service: global-secure-access
ms.subservice: entra-private-access
ms.reviewer: shkhalid
ai-usage: ai-assisted
ms.custom:
  - ai-gen-docs-bap
  - ai-gen-title
  - ai-seo-date:04/16/2025
  - ai-gen-description
---

# Learn about Security Service Edge (SSE) coexistence with Microsoft and Zscaler
In today's rapidly evolving digital landscape, organizations require robust, and unified solutions to ensure secure and seamless connectivity. Microsoft and Zscaler offer complementary Secure Access Service Edge (SASE) capabilities that, when integrated, provide enhanced security and connectivity for diverse access scenarios.

This guide outlines how to configure and deploy Microsoft Entra solutions alongside Zscaler's Security Service Edge (SSE) offerings. By using the strengths of both platforms, you can optimize your organization's security posture while maintaining high-performance connectivity for private applications, Microsoft 365 traffic, and internet access.

1. **Microsoft Entra Private Access with Zscaler Internet Access**

    In this scenario, Global Secure Access handles private application traffic. Zscaler only captures Internet traffic. Therefore, the Zscaler Private Access module is disabled from the Zscaler portal.

2. **Microsoft Entra Private Access with Zscaler Private Access and Zscaler Internet Access**

    In this scenario, both clients handle traffic for separate private applications. Global Secure Access handles private applications in Microsoft Entra Private Access. Private applications in Zscaler use the Zscaler Private Access module. Zscaler Internet Access handles Internet traffic.


3. **Microsoft Entra Microsoft Access with Zscaler Private Access and Zscaler Internet Access**

    In this scenario, Global Secure Access handles all Microsoft 365 traffic. Zscaler Private Access handles Private application traffic and Zscaler Internet Access handles Internet traffic.

4. **Microsoft Entra Internet Access and Microsoft Entra Microsoft Access with Zscaler Private Access**

    In this scenario, Global Secure Access handles Internet and Microsoft 365 traffic. Zscaler only captures Private application traffic. Therefore, the Zscaler Internet Access module is disabled from the Zscaler portal.

## Prerequisites

To configure Microsoft and Zscaler for a unified SASE solution, start by setting up Microsoft Entra Internet Access and Microsoft Entra Private Access. Next, configure Zscaler Private Access and Zscaler Internet Access. Finally, make sure to establish the required FQDN and IP bypasses to ensure smooth integration between the two platforms.
- Set up Microsoft Entra Internet Access and Microsoft Entra Private Access. These products make up the Global Secure Access solution.
- Set up Zscaler Private Access and Internet Access
- Configure the Global Secure Access FQDN and IP bypasses

### Microsoft Global Secure Access

To set up Microsoft Entra Global Secure Access and test all scenarios in this documentation:
- Enable and disable different Microsoft Global Secure Access traffic forwarding profiles for your Microsoft Entra tenant. For more information about enabling and disabling profiles, see [Global Secure Access traffic forwarding profiles](concept-traffic-forwarding.md).
- Install and configure the Microsoft Entra private network connector. To learn how to install and configure the connector, see [How to configure connectors](how-to-configure-connectors.md).
    > [!NOTE]
    > Private Network Connectors are required for Microsoft Entra Private Access applications.
- Configure Quick Access to your private resources and set up Private Domain Name System (DNS) and DNS suffixes. To learn how to configure Quick Access, see [How to configure Quick Access](how-to-configure-quick-access.md).
- Install and configure the Global Secure Access client on end-user devices. For more information about clients, see [Global Secure Access clients](concept-clients.md). To learn how to install the Windows client, see [Global Secure Access client for Windows](how-to-install-windows-client.md). For macOS, see [Global Secure Access Client for macOS](how-to-install-macos-client.md).

### Zscaler Private Access and Internet Access

To integrate Zscaler Private Access and Zscaler Internet Access with Microsoft Global Secure Access, make sure you complete the following prerequisites. These steps ensure smooth integration, better traffic management, and improved security.
- Configure Zscaler Internet Access. To learn more about configuring Zscaler, see [Step-by-Step Configuration Guide for ZIA](https://help.zscaler.com/zia/step-step-configuration-guide-zia).
- Configure Zscaler Private Access. To learn more about configuring Zscaler, see [Step-by-Step Configuration Guide for ZPA](https://help.zscaler.com/zpa/step-step-configuration-guide-zpa).
- Set up and configure Zscaler Client Connector forwarding profiles.  To learn more about configuring Zscaler, see [Configuring Forwarding Profiles for Zscaler Client Connector](https://help.zscaler.com/zscaler-client-connector/configuring-forwarding-profiles-zscaler-client-connector).
- Set up and configure Zscaler Client Connector app profiles with Global Secure Access bypasses.  To learn more about configuring Zscaler, see [Configuring Zscaler Client Connector App Profiles](https://help.zscaler.com/zscaler-client-connector/configuring-zscaler-client-connector-app-profiles).

### Global Secure Access service FQDNs and IPs bypasses

Configure the Zscaler Client Connector app profile to work with Microsoft Entra service Fully Qualified Domain Names (FQDNs) and Internet Protocol (IP) addresses. 

These entries need to be present in the app profiles for every scenario:
- IPs: `150.171.15.0/24`, `150.171.18.0/24`, `150.171.19.0/24`, `150.171.20.0/24`, `13.107.232.0/24`, `13.107.233.0/24`, `151.206.0.0/16`, `6.6.0.0/16`
- FQDNs: `internet.edgediagnostic.globalsecureaccess.microsoft.com`, `m365.edgediagnostic.globalsecureaccess.microsoft.com`, `private.edgediagnostic.globalsecureaccess.microsoft.com`, `aps.globalsecureaccess.microsoft.com`, `auth.edgediagnostic.globalsecureaccess.microsoft.com`, `<tenantid>.internet.client.globalsecureaccess.microsoft.com`, `<tenantid>.m365.client.globalsecureaccess.microsoft.com`, `<tenantid>.private.client.globalsecureaccess.microsoft.com`,
`<tenantid>.auth.client.globalsecureaccess.microsoft.com`, 
`<tenantid>.private-backup.client.globalsecureaccess.microsoft.com`, `<tenantid>.internet-backup.client.globalsecureaccess.microsoft.com`, `<tenantid>.m365-backup.client.globalsecureaccess.microsoft.com`, `<tenantid>.auth-backup.client.globalsecureaccess.microsoft.com`.
- Install and configure Zscaler Client Connector software.

## Configuration 1: Microsoft Entra Private Access with Zscaler Internet Access

In this scenario, Microsoft Entra Private Access handles private application traffic, while Zscaler Internet Access manages Internet traffic. The Zscaler Private Access module is disabled in the Zscaler portal. To configure Microsoft Entra Private Access, you need to complete several steps. First, enable the forwarding profile. Next, install the Private Network Connector. After that, set up Quick Access and configure Private DNS. Finally, install the Global Secure Access client. For Zscaler Internet Access, the configuration involves creating a forwarding profile and app profile, adding bypass rules for Microsoft Entra services, and installing the Zscaler Client Connector. Finally, the configurations are verified, and traffic flow are tested to ensure proper handling of private and Internet traffic by the respective solutions.

### Microsoft Entra Private Access configuration

For this scenario you need to:
- [Enable Microsoft Entra Private Access forwarding profile](https://github.com/MicrosoftDocs/entra-docs/blob/main/docs/global-secure-access/how-to-manage-private-access-profile.md#enable-the-private-access-traffic-forwarding-profile).
- Install a [Private Network Connector](how-to-configure-connectors.md) for Microsoft Entra Private Access.
- Configure [Quick Access and set up Private DNS](how-to-configure-quick-access.md).
- Install and configure the [Global Secure Access client for Windows](how-to-install-windows-client.md) or [macOS](how-to-install-macos-client.md).

### Zscaler Internet Access configuration

Perform in the Zscaler portal:
- Set up and configure [Zscaler Internet Access](https://help.zscaler.com/zia/step-step-configuration-guide-zia).
- Create a forwarding profile.
- Create an app profile.
- Install the Zscaler Client Connector

Add Forwarding Profile from the Client Connector Portal:
1. Navigate to **Zscaler Client Connector admin portal** > **Administration** > **Forwarding Profile** > **Add Forwarding Profile**.
1. Add a **Profile Name** such as `ZIA Only`.
1. Select **Packet Filter-Based** in **Tunnel Driver Type**.
1. Select forwarding profile action as **Tunnel** and select tunnel version. For example, `Z-Tunnel 2.0`
1. Scroll down to **Forwarding profile action for ZPA**.
1. Select **None** for all options in this section.

Add App Profile from the Client Connector Portal:
1. Navigate to **Zscaler Client Connector admin portal** > **App Profiles** > **Windows (or macOS)** > **Add Windows Policy (or macOS)**.
1. Add **Name**, set **Rule Order** such as **1**, select **Enable**, select **User(s)** to apply this policy, and select the **Forwarding Profile**. For example, select **ZIA Only**.
1. Scroll down and add the Microsoft SSE service Internet Protocol (IP) addresses and Fully Qualified Domain Names (FQDNs) in the [Global Secure Access service FQDNs and IPs bypasses section](#global-secure-access-service-fqdns-and-ips-bypasses), to “**HOSTNAME OR IP ADDRESS BYPASS FOR VPN GATEWAY**” field.

Go to the system tray to check that Global Secure Access and Zscaler clients are enabled.

Verify configurations for clients:
1. Right-click on **Global Secure Access Client** > **Advanced Diagnostics** > **Forwarding Profile** and verify that Private access and Private DNS rules are applied to this client.
1. Navigate to **Advanced Diagnostics** > **Health Check** and ensure no checks are failing.
1. Right-click on **Zscaler Client** > **Open Zscaler** > **More**. Verify **App Policy** matches configurations in the earlier steps. Validate that it's up to date or update it.
1. Navigate to **Zscaler Client** > **Internet Security**. Verify **Service Status** is `ON` and Authentication Status is `Authenticated`.
1. Navigate to **Zscaler Client** > **Private Access**. Verify **Service Status** is `DISABLED`.

> [!NOTE]
> For information troubleshooting health check failures, see [Troubleshoot the Global Secure Access client diagnostics - Health check](troubleshoot-global-secure-access-client-diagnostics-health-check.md).

 Test traffic flow:
1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. Select the **Traffic** tab and select **Start collecting**.
1. Access these websites from the browser: `bing.com`, `salesforce.com`, `Instagram.com`.
1. In the system tray, right-click **Global Secure Access Client** and select **Advanced Diagnostics** > **Traffic** tab.
1. Scroll to observe that the Global Secure Access client **isn't** capturing traffic from these websites.
1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access** > **Monitor** > **Traffic logs**. Validate traffic related to these sites is missing from the Global Secure Access traffic logs.
1. Sign in to Zscaler Internet Access (ZIA) admin portal and browse to **Analytics** > **Web Insights** > **Logs**. Validate traffic related to these sites is present in Zscaler logs.
1. Access your private application set up in Microsoft Entra Private Access. For example, access a File Share via Server Message Block (SMB).
1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access** > **Monitor** > **Traffic logs**.
1. Validate traffic related to File Share **is** captured in the Global Secure Access traffic logs.
1. Sign in to Zscaler Internet Access (ZIA) admin portal and browse to **Analytics** > **Web Insights** > **Logs**. Validate traffic related to the private application isn't present in the Dashboard or traffic logs.
1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. In the **Traffic** dialog box, select **Stop collecting**.
1. Scroll to confirm the Global Secure Access client handled only private application traffic.

## Configuration 2: Microsoft Entra Private Access with Zscaler Private Access and Zscaler Internet Access

In this scenario, both clients handle traffic for separate private applications. Global Secure Access handles private applications in Microsoft Entra Private Access. Private applications in Zscaler use the Zscaler Private Access module. Zscaler Internet Access handles Internet traffic.

### Microsoft Entra Private Access configuration 2

For this scenario, you need to:
- [Enable Microsoft Entra Private Access forwarding profile](https://github.com/MicrosoftDocs/entra-docs/blob/main/docs/global-secure-access/how-to-manage-private-access-profile.md#enable-the-private-access-traffic-forwarding-profile).
- Install a [Private Network Connector](how-to-configure-connectors.md) for Microsoft Entra Private Access.
- Configure [Quick Access and set up Private DNS](how-to-configure-quick-access.md).
- Install and configure the [Global Secure Access client for Windows](how-to-install-windows-client.md) or [macOS](how-to-install-macos-client.md).

### Zscaler Private Access and Zscaler Internet Access configuration 2

Perform the steps in the Zscaler portal:
- Set up and configure both Zscaler Internet Access and Zscaler Private Access.
- Create a forwarding profile.
- Create an app profile.
- Install the Zscaler Client Connector.

Add Forwarding Profile from the Client Connector Portal:
1. Navigate to **Zscaler Client Connector admin portal** > **Administration** > **Forwarding Profile** > **Add Forwarding Profile**.
1. Add a **Profile Name** such as `ZIA and ZPA`.
1. Select **Packet Filter-Based** in **Tunnel Driver Type**.
1. Select forwarding profile action as Tunnel, and select tunnel version. For example, `Z-Tunnel 2.0`.
1. Scroll down to **Forwarding profile action for ZPA**.
1. Select Tunnel for all options in this section.

Add App Profile from the Client Connector Portal:
1. Navigate to **Zscaler Client Connector admin portal** > **App Profiles** > **Windows (or macOS)** > **Add Windows Policy (or macOS)**.
1. Add **Name**, set **Rule Order** such as **1**, select **Enable**, select **User(s)** to apply this policy, and select the **Forwarding Profile**. For example, select **ZIA and ZPA**.
1. Scroll down and add the Microsoft SSE service Internet Protocol (IP) addresses and Fully Qualified Domain Names (FQDNs) in the [Global Secure Access service FQDNs and IPs bypasses section](#global-secure-access-service-fqdns-and-ips-bypasses), to “**HOSTNAME OR IP ADDRESS BYPASS FOR VPN GATEWAY**” field.

Go to the system tray to check that Global Secure Access and Zscaler clients are enabled.
  
Verify configurations for clients:
1. Right-click on **Global Secure Access Client** > **Advanced Diagnostics** > **Forwarding Profile** and verify that Private access and Private DNS rules are applied to this client.
1. Navigate to **Advanced Diagnostics** > **Health Check** and ensure no checks are failing.
1. Right-click on **Zscaler Client** > **Open Zscaler** > **More**. Verify **App Policy** matches configurations in the earlier steps. Validate that it's up to date or update it.
1. Navigate to **Zscaler Client** > **Internet Security**. Verify **Service Status** is `ON` and Authentication Status is `Authenticated`.
1. Navigate to **Zscaler Client** > **Private Access**. Verify **Service Status** is `ON` and Authentication Status is `Authenticated`.

> [!NOTE]
> For information troubleshooting health check failures, see [Troubleshoot the Global Secure Access client diagnostics - Health check](troubleshoot-global-secure-access-client-diagnostics-health-check.md).

Test traffic flow:
1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. Select the **Traffic** tab and select **Start collecting**.
1. Access these websites from the browser: `bing.com`, `salesforce.com`, `Instagram.com`.
1. In the system tray, right-click **Global Secure Access Client** and select **Advanced Diagnostics** > **Traffic** tab.
1. Scroll to observe that the Global Secure Access client **isn't** capturing traffic from these websites.
1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access** > **Monitor** > **Traffic logs**. Validate traffic related to these sites is missing from the Global Secure Access traffic logs.
1. Sign in to Zscaler Internet Access (ZIA) admin portal and browse to **Analytics** > **Web Insights** > **Logs**.
1. Validate traffic related to these sites is present in Zscaler logs.
1. Access your private application set up in Microsoft Entra Private Access. For example, access a File Share via SMB.
1. Access your private application set up in Zscaler Private Access. For example, open an RDP session to a private server.
1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access** > **Monitor** > **Traffic logs**.
1. Validate traffic related to the SMB file share private app is captured and that traffic related to the RDP session **isn't** captured in the Global Secure Access traffic logs
1. Sign in to Zscaler Private Access (ZPA) admin portal and browse to **Analytics** > **Diagnostics** > **Logs**. Validate traffic related to the RDP session is present and that traffic related to the SMB file share **isn't** in the Dashboard or Diagnostic logs.
1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. In the **Traffic** dialog box, select **Stop collecting**.
1. Scroll to confirm the Global Secure Access client handled private application traffic for the SMB file share and didn't handle the RDP session traffic.

## Configuration 3: Microsoft Entra Microsoft Access with Zscaler Private Access and Zscaler Internet Access

In this scenario, Global Secure Access handles all Microsoft 365 traffic. Zscaler Private Access handles Private application traffic and Zscaler Internet Access handles Internet traffic.

### Microsoft Entra Microsoft Access configuration 3

For this scenario, you need to:
- [Enable Microsoft Entra Microsoft Access forwarding profile](https://github.com/MicrosoftDocs/entra-docs/blob/main/docs/global-secure-access/how-to-manage-microsoft-profile.md#enable-the-microsoft-traffic-profile).
- Install and configure the [Global Secure Access client for Windows](how-to-install-windows-client.md) or [macOS](how-to-install-macos-client.md).

### Zscaler Private Access and Zscaler Internet Access configuration 3

Perform in the Zscaler portal:
- Set up and configure Zscaler Private Access.
- Create a forwarding profile.
- Create an app profile.
- Install the Zscaler Client Connector.

Add Forwarding Profile from the Client Connector Portal:
1. Navigate to **Zscaler Client Connector admin portal** > **Administration** > **Forwarding Profile** > **Add Forwarding Profile**.
1. Add a **Profile Name** such as `ZIA and ZPA`.
1. Select **Packet Filter-Based** in **Tunnel Driver Type**.
1. Select forwarding profile action as Tunnel, and select tunnel version. For example, `Z-Tunnel 2.0`.
1. Scroll down to **Forwarding profile action for ZPA**.
1. Select Tunnel for all options in this section.

Add App Profile from the Client Connector Portal:
1. Navigate to **Zscaler Client Connector admin portal** > **App Profiles** > **Windows (or macOS)** > **Add Windows Policy (or macOS)**.
1. Add **Name**, set **Rule Order** such as **1**, select **Enable**, select **User(s)** to apply this policy, and select the **Forwarding Profile**. For example, select **ZIA and ZPA**.
1. Scroll down and add the Microsoft SSE service Internet Protocol (IP) addresses and Fully Qualified Domain Names (FQDNs) in the [Global Secure Access service FQDNs and IPs bypasses section](#global-secure-access-service-fqdns-and-ips-bypasses), to “**HOSTNAME OR IP ADDRESS BYPASS FOR VPN GATEWAY**” field.

Go to the system tray to check that Global Secure Access and Zscaler clients are enabled.  

Verify configurations for clients:
1. Right-click on **Global Secure Access Client** > **Advanced Diagnostics** > **Forwarding Profile** and verify that only Microsoft 365 rules are applied to this client.
1. Navigate to **Advanced Diagnostics** > **Health Check** and ensure no checks are failing.
1. Right-click on **Zscaler Client** > **Open Zscaler** > **More**. Verify **App Policy** matches configurations in the earlier steps. Validate that it's up to date or update it.
1. Navigate to **Zscaler Client** > **Internet Security**. Verify **Service Status** is `ON` and Authentication Status is `Authenticated`.
1. Navigate to **Zscaler Client** > **Private Access**. Verify **Service Status** is `ON` and Authentication Status is `Authenticated`.

> [!NOTE]
> For information troubleshooting health check failures, see [Troubleshoot the Global Secure Access client diagnostics - Health check](troubleshoot-global-secure-access-client-diagnostics-health-check.md).

Test traffic flow:
1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. Select the **Traffic** tab and select **Start collecting**.
1. Access these websites from the browser: `bing.com`, `salesforce.com`, `Instagram.com`.
1. In the system tray, right-click **Global Secure Access Client** and select **Advanced Diagnostics** > **Traffic** tab.
1. Scroll to observe that the Global Secure Access client **isn't** capturing traffic from these websites.
1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access** > **Monitor** > **Traffic logs**. Validate traffic related to these sites is missing from the Global Secure Access traffic logs.
1. Sign in to Zscaler Internet Access (ZIA) admin portal and browse to **Analytics** > **Web Insights** > **Logs**.
1. Validate traffic related to these sites is present in Zscaler logs.
1. Access your private application set up in Zscaler Private Access. For example, open an RDP session to a private server.
1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access** > **Monitor** > **Traffic logs**.
1. Validate traffic related to the RDP session **isn’t** in the Global Secure Access traffic logs
1. Sign in to Zscaler Private Access (ZPA) admin portal and browse to **Analytics** > **Diagnostics** > **Logs**. Validate traffic related to the RDP session is present in the Dashboard or Diagnostic logs.
1. Access Outlook Online (`outlook.com`, `outlook.office.com`, `outlook.office365.com`), SharePoint Online (`<yourtenantdomain>.sharepoint.com`).  
1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. In the **Traffic** dialog box, select **Stop collecting**.
1. Scroll to confirm the Global Secure Access client handled only Microsoft 365 traffic.
1. You can also validate that the traffic is captured in the Global Secure Access traffic logs. In the Microsoft Entra admin center, navigate to **Global Secure Access** > **Monitor** > **Traffic logs**.
1. Validate traffic related to Outlook Online and SharePoint Online is missing from Zscaler Internet Access logs in **Analytics** > **Web Insights** > **Logs**.

## Configuration 4: Microsoft Entra Internet Access and Microsoft Entra Microsoft Access and with Zscaler Private Access

In this scenario, Global Secure Access handles Internet and Microsoft 365 traffic. Zscaler only captures private application traffic. Therefore, the Zscaler Internet Access module is disabled from the Zscaler portal.

### Microsoft Entra Internet and Microsoft Access configuration 4

For this scenario, you need to configure:
- [Enable Microsoft Entra Microsoft Access forwarding profile](https://github.com/MicrosoftDocs/entra-docs/blob/main/docs/global-secure-access/how-to-manage-microsoft-profile.md#enable-the-microsoft-traffic-profile) and [Microsoft Entra Internet Access forwarding profile](https://github.com/MicrosoftDocs/entra-docs/blob/main/docs/global-secure-access/how-to-manage-internet-access-profile.md#prerequisites).
- Install and configure the [Global Secure Access client for Windows](how-to-install-windows-client.md) or [macOS](how-to-install-macos-client.md).
- Add an [Microsoft Entra Internet Access traffic forwarding profile policy custom bypass](https://github.com/MicrosoftDocs/entra-docs/blob/main/docs/global-secure-access/how-to-manage-internet-access-profile.md#internet-access-traffic-forwarding-profile-policies) to exclude ZPA service.

Adding a custom bypass for Zscaler in Global Secure Access:
1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access** > **Connect** > **Traffic forwarding** > **Internet access profile**. Under **Internet access policies** select **View**.
1. Expand **Custom Bypass** and select **Add rule**. 
1. Leave destination type `FQDN` and in **Destination** enter `*.prod.zpath.net`.
1. Select **Save**.

### Zscaler Private Access configuration 4

Perform the procedure in the Zscaler portal:
- Set up and configure Zscaler Private Access.
- Create a forwarding profile.
- Create an app profile.
- Install the Zscaler Client Connector.

Add Forwarding Profile from the Client Connector Portal:
1. Navigate to the **Zscaler Client Connector admin portal** > **Administration** > **Forwarding Profile** > **Add Forwarding Profile**.
1. Add a **Profile Name** such as `ZPA Only`.
1. Select **Packet Filter-Based** in **Tunnel Driver Type**.
1. Select forwarding profile action as **None**.
1. Scroll down to **Forwarding profile action for ZPA**.
1. Select Tunnel for all options in this section.

Add App Profile from the Client Connector Portal:
1. Navigate to **Zscaler Client Connector admin portal** > **App Profiles** > **Windows (or macOS)** > **Add Windows Policy (or macOS)**.
1. Add **Name**, set **Rule Order** such as **1**, select **Enable**, select **User(s)** to apply this policy, and select the **Forwarding Profile**. For example, select **ZPA Only**.
1. Scroll down and add the Microsoft SSE service Internet Protocol (IP) addresses and Fully Qualified Domain Names (FQDNs) in the [Global Secure Access service FQDNs and IPs bypasses section](#global-secure-access-service-fqdns-and-ips-bypasses), to “**HOSTNAME OR IP ADDRESS BYPASS FOR VPN GATEWAY**” field.

Open the system tray to check that Global Secure Access and Zscaler clients are enabled.
  
Verify configurations for clients:
1. Right-click on **Global Secure Access Client** > **Advanced Diagnostics** > **Forwarding Profile** and verify that Microsoft 365 and Internet Access rules are applied to this client.
1. Expand the Internet access rules > Verify that the custom bypass, `*.prod.zpath.net` exists in the profile.
1. Navigate to **Advanced Diagnostics** > **Health Check** and ensure no checks are failing.
1. Right-click on **Zscaler Client** > **Open Zscaler** > **More**. Verify **App Policy** matches configurations in the earlier steps. Validate that it's up to date or update it.
1. Navigate to **Zscaler Client** > **Private Access**. Verify **Service Status** is `ON` and Authentication Status is `Authenticated`.
1. Navigate to **Zscaler Client** > **Internet Security**. Verify **Service Status** is `DISABLED`.

> [!NOTE]
> For information troubleshooting health check failures, see [Troubleshoot the Global Secure Access client diagnostics - Health check](troubleshoot-global-secure-access-client-diagnostics-health-check.md).

Test traffic flow:
1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. Select the **Traffic** tab and select **Start collecting**.
1. Access these websites from the browser: `bing.com`, `salesforce.com`, `Instagram.com`, Outlook Online (`outlook.com`, `outlook.office.com`, `outlook.office365.com`), SharePoint Online (`<yourtenantdomain>.sharepoint.com`).
1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access** > **Monitor** > **Traffic logs**. Validate traffic related to these sites is captured in the Global Secure Access traffic logs.
1. Access your private application set up in Zscaler Private Access. For example, using Remote Desktop (RDP).
1. Sign in to Zscaler Private Access (ZPA) admin portal and browse to **Analytics** > **Diagnostics** > **Logs**. Validate traffic related to the RDP session is present in the Dashboard or Diagnostic logs.
1. Sign in to Zscaler Internet Access (ZIA) admin portal and browse to **Analytics** > **Web Insights** > **Logs**. Validate traffic related to Microsoft 365 and Internet Traffic such as Instagram.com, Outlook Online, and SharePoint Online is missing from ZIA logs.
1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. In the **Traffic** dialog box, select **Stop collecting**.
1. Scroll to observe that the Global Secure Access client **isn't** capturing traffic from the private application. Also, observe that the Global Secure Access client **is** capturing traffic for Microsoft 365 and other internet traffic.
