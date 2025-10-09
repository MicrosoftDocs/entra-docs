---
title: Security Service Edge (SSE) Coexistence With Microsoft and Cisco Secure Access
description: Microsoft and Cisco’s Secure Access coexistence solution guide.
author: kenwith
ms.author: kenwith
manager: dougeby
ms.topic: conceptual
ms.date: 10/06/2025
ms.service: global-secure-access
ms.subservice: entra-private-access 
ms.reviewer: shkhalid
ai-usage: ai-assisted
---

# Security Service Edge (SSE) coexistence with Microsoft and Cisco Secure Access

Learn how to configure Security Service Edge (SSE) coexistence using Global Secure Access and Cisco Secure Access.

In today's digital landscape, organizations need robust, unified solutions for secure and seamless connectivity. Global Secure Access and Cisco Secure Access offer complementary Secure Access Service Edge (SASE) capabilities. When integrated, these platforms enhance security and connectivity for diverse access scenarios.

This guide outlines how to configure and deploy Global Secure Access solutions alongside Cisco Secure Access SSE offerings. By using both platforms, you can optimize your organization's security posture while maintaining high-performance connectivity for private applications, Microsoft 365 traffic, and internet access.

## Scenarios

This guide covers the following coexistence scenarios:

1.  **[Microsoft Entra Private Access with Cisco Secure Internet Access](#1-microsoft-entra-private-access-with-cisco-secure-internet-access).**
In this scenario, Global Secure Access handles private application traffic. Cisco Secure Internet Access provides DNS security and SWG capabilities.

2.  **[Microsoft Entra Private Access with Cisco Secure Internet Access and Cisco Secure Private Access](#2-microsoft-entra-private-access-with-cisco-secure-internet-access-and-cisco-secure-private-access).**
In this scenario, both clients handle traffic for separate private applications. Global Secure Access handles private applications in Microsoft Entra Private Access, while the Cisco Secure Client - Zero Trust Access module handles private applications in Cisco Secure Private Access. Web and DNS traffic is protected by Cisco Secure Internet Access.

3.  **[Microsoft Entra Microsoft Access with Cisco Secure Internet Access and Cisco Secure Private Access](#3-microsoft-entra-microsoft-access-with-cisco-secure-internet-access-and-cisco-secure-private-access).**
Global Secure Access manages all Microsoft 365 traffic. The Cisco Secure Client - Zero Trust Access module handles private applications in Cisco Secure Private Access. Web and DNS traffic is protected by Cisco Secure Internet Access.

4.  **[Microsoft Entra Internet Access and Microsoft Access with Cisco Secure Private Access](#4-microsoft-entra-internet-access-and-microsoft-access-with-cisco-secure-private-access).**
Global Secure Access manages internet and Microsoft traffic. Cisco Secure Access handles only Private Access with the Cisco Secure Client - Zero Trust Access module.
## Prerequisites

To configure Global Secure Access and Cisco Secure Access for a unified SASE solution:

- Set up Global Secure Access (Microsoft Entra Internet Access and Microsoft Entra Private Access).
- Configure Cisco Secure Internet Access and Secure Private Access.
- Establish required FQDN and IP bypasses for integration between the platforms.

## Global Secure Access setup

1. **Enable and disable different traffic forwarding profiles** for your Microsoft Entra tenant. See [Traffic forwarding profiles](concept-traffic-forwarding.md).
1. **Install and configure the private network connector** for Private Access applications. See [Configure connectors](how-to-configure-connectors.md).
1. **Configure Quick Access** to private resources and set up private DNS and DNS suffixes. See [Configure Quick Access](how-to-configure-quick-access.md).
1. **Install and configure the Global Secure Access client** on end-user devices. See [Global Secure Access clients](concept-clients.md).

> [!NOTE]
> Private Network Connectors are required for Private Access applications.

## Cisco Secure Access setup

1. **Set up a resource connector** for private applications. See Cisco documentation for [managing resource connectors and connector groups](https://docs.sse.cisco.com/sse-user-guide/docs/manage-resource-connectors-and-connector-groups).
1. **Provision users and groups**. Integration with Microsoft Entra ID provides the best user experience. See Cisco documentation for [Microsoft Entra ID SAML configuration](https://docs.sse.cisco.com/sse-user-guide/docs/configure-azure-for-saml).
1. **Add private resources and create access policies**. See Cisco documentation for [managing private access rules](https://docs.sse.cisco.com/sse-user-guide/docs/manage-private-access-rules).
1. **Set up internet security and configure bypasses** for coexistence. See Cisco documentation for [managing internet security](https://docs.sse.cisco.com/sse-user-guide/docs/manage-internet-security).
1. **Install and configure the Cisco Secure Client**. See Cisco documentation for [downloading and installing the client for Windows and macOS](https://docs.sse.cisco.com/sse-user-guide/docs/manual-installation-of-cisco-secure-client-windows-and-macos).

> [!IMPORTANT]
> Cisco released a Cisco Secure Client (CSC) feature to improve coexistence with Global Secure Access. These steps need to be performed after the initial installation, or re-installation (not required to run again when upgrading), of CSC version 5.1.10.x (or later).
> 1. Install Cisco Secure Client version 5.1.10.x.
> 1. Open CMD prompt as an administrator and run these commands:
> 1. `"%ProgramFiles(x86)%\Cisco\Cisco Secure Client\acsocktool.exe" -slwm 10`
> 1. `net stop csc_vpnagent && net stop acsock && net start csc_vpnagent`

## Bypass configuration for coexistence

### Bypass Cisco Secure Access/Umbrella required IPs and FQDN in Global Secure Access

1. In the Microsoft Entra admin center, go to **Global Secure Access > Connect > Traffic forwarding > Internet access profile**.
2. Under **Internet access policies**, select **View**.
3. Expand **Custom Bypass** and select **Add rule**.
4. Enter the following IPs:
    `208.67.222.222, 208.67.220.220, 67.215.64.0/19, 146.112.0.0/16, 155.190.0.0/16, 185.60.84.0/22, 204.194.232.0/21, 208.67.216.0/21, 208.69.32.0/21`
5. Add a rule for the destination: `*.zpc.sse.cisco.com`
6. Select **Save**.

### Bypass Global Secure Access IPs and FQDNs in Cisco Secure Access/Umbrella

#### [Cisco Secure Access Portal](#tab/cisco-secure-access-portal)

1. In the Cisco Secure Access portal, go to **Connect > End User Connectivity > Internet Security**.
2. In the **Traffic Steering** section, select **Add Destination > Bypass Secure Access**, add the following FQDN, and save: `*.globalsecureaccess.microsoft.com`
    > [!NOTE]
    > Cisco Secure Access has an implied wildcard, so you can use `globalsecureaccess.microsoft.com`.
3. Add these Microsoft 365 FQDNs (only required if Microsoft traffic forwarding profile is enabled):
    `auth.microsoft.com, msftidentity.com, msidentity.com, onmicrosoft.com, outlook.com, protection.outlook.com, sharepoint.com, sharepointonline.com, svc.ms, wns.windows.com, account.activedirectory.windowsazure.com, accounts.accesscontrol.windows.net, admin.onedrive.com, adminwebservice.microsoftonline.com, api.passwordreset.microsoftonline.com, autologon.microsoftazuread-sso.com, becws.microsoftonline.com, ccs.login.microsoftonline.com, clientconfig.microsoftonline-p.net, companymanager.microsoftonline.com, device.login.microsoftonline.com, g.live.com, graph.microsoft.com, graph.windows.net, login-us.microsoftonline.com, login.microsoft.com, login.microsoftonline-p.com, login.microsoftonline.com, login.windows.net, logincert.microsoftonline.com, loginex.microsoftonline.com, nexus.microsoftonline-p.com, officeclient.microsoft.com, oneclient.sfx.ms, outlook.cloud.microsoft, outlook.office.com, outlook.office365.com, passwordreset.microsoftonline.com, provisioningapi.microsoftonline.com, spoprod-a.akamaihd.net`
4. Add the Quick Access FQDN (only required if you use Private Access with Quick Access). `<quickaccessapplicationid>.globalsecureaccess.local`
    > [!NOTE]
    > Replace `<quickaccessapplicationid>` with the application ID of your Quick Access app.
5. Add DNS suffixes defined in your Private DNS or Enterprise App segments (only required if Private Access traffic forwarding profile is enabled). For example, if your Private DNS suffix is `contoso.local` and you have a private app at `contoso.com`, add both suffixes.
6. In the Traffic Steering section, select **Add Destination > Bypass web proxy only**, add these IPs, and save: `150.171.19.0/24, 150.171.20.0/24, 13.107.232.0/24, 13.107.233.0/24, 150.171.15.0/24, 150.171.18.0/24, 151.206.0.0/16, 6.6.0.0/16`
7. Add these Microsoft 365 IP addresses (only required if Microsoft traffic forwarding profile is enabled):
    `132.245.0.0/16, 204.79.197.215/32, 150.171.32.0/22, 131.253.33.215/32, 23.103.160.0/20, 40.96.0.0/13, 52.96.0.0/14, 40.104.0.0/15, 13.107.128.0/22, 13.107.18.10/31, 13.107.6.152/31, 52.238.78.88/32, 104.47.0.0/17, 52.100.0.0/14, 40.107.0.0/16, 40.92.0.0/15, 150.171.40.0/22, 52.104.0.0/14, 104.146.128.0/17, 40.108.128.0/17, 13.107.136.0/22, 40.126.0.0/18, 20.231.128.0/19, 20.190.128.0/18, 20.20.32.0/19`
8. Restart Cisco Umbrella client services or restart the machine where the clients are installed.

#### [Cisco Umbrella Portal](#tab/cisco-umbrella-portal)

1. Add domain suffixes and Microsoft Entra service FQDNs to the **Internal domains** list: `*.globalsecureaccess.microsoft.com`
    > [!NOTE]
    > Cisco Umbrella supports implied wildcards, so you can use `globalsecureaccess.microsoft.com`.
2. Add these Microsoft 365 FQDNs (only required if Microsoft traffic forwarding profile is enabled):
    `auth.microsoft.com, msftidentity.com, msidentity.com, onmicrosoft.com, outlook.com, protection.outlook.com, sharepoint.com, sharepointonline.com, svc.ms, wns.windows.com, account.activedirectory.windowsazure.com, accounts.accesscontrol.windows.net, admin.onedrive.com, adminwebservice.microsoftonline.com, api.passwordreset.microsoftonline.com, autologon.microsoftazuread-sso.com, becws.microsoftonline.com, ccs.login.microsoftonline.com, clientconfig.microsoftonline-p.net, companymanager.microsoftonline.com, device.login.microsoftonline.com, g.live.com, graph.microsoft.com, graph.windows.net, login-us.microsoftonline.com, login.microsoft.com, login.microsoftonline-p.com, login.microsoftonline.com, login.windows.net, logincert.microsoftonline.com, loginex.microsoftonline.com, nexus.microsoftonline-p.com, officeclient.microsoft.com, oneclient.sfx.ms, outlook.cloud.microsoft, outlook.office.com, outlook.office365.com, passwordreset.microsoftonline.com, provisioningapi.microsoftonline.com, spoprod-a.akamaihd.net`
3. Add the Quick Access FQDN (only required if you use Private Access with Quick Access). `<quickaccessapplicationid>.globalsecureaccess.local`   
    > [!NOTE]
    > Replace `<quickaccessapplicationid>` with the application ID of your Quick Access app.
4. Add DNS suffixes defined in your Private DNS or Enterprise App segments (only required if Private Access traffic forwarding profile is enabled). For example, if your Private DNS suffix is `contoso.local` and you have a private app at `contoso.com`, add both suffixes.
5. In the **External Domains & IPs** section, add these Global Secure Access IPs and FQDN: `*.globalsecureaccess.microsoft.com, 150.171.19.0/24, 150.171.20.0/24, 13.107.232.0/24, 13.107.233.0/24, 150.171.15.0/24, 150.171.18.0/24, 151.206.0.0/16, 6.6.0.0/16`
6. Add these Microsoft 365 IP addresses (only required if Microsoft traffic forwarding profile is enabled):
  `132.245.0.0/16, 204.79.197.215/32, 150.171.32.0/22, 131.253.33.215/32, 23.103.160.0/20, 40.96.0.0/13, 52.96.0.0/14, 40.104.0.0/15, 13.107.128.0/22, 13.107.18.10/31, 13.107.6.152/31, 52.238.78.88/32, 104.47.0.0/17, 52.100.0.0/14, 40.107.0.0/16, 40.92.0.0/15, 150.171.40.0/22, 52.104.0.0/14, 104.146.128.0/17, 40.108.128.0/17, 13.107.136.0/22, 40.126.0.0/18, 20.231.128.0/19, 20.190.128.0/18, 20.20.32.0/19`
7. Restart Cisco Umbrella client services or restart the machine where the clients are installed.

---

## Configuration scenarios

### 1. Microsoft Entra Private Access with Cisco Secure Internet Access

**Global Secure Access configuration**

1. Enable Private Access forwarding profile.
1. Install a private network connector.
1. Configure Quick Access and private DNS.
1. Install and configure the Global Secure Access client for Windows or macOS.

**Cisco Secure Access configuration**

1. Configure required destinations to bypass Internet Security. For instructions, see [Bypass Global Secure Access IPs and FQDNs in Cisco Secure Access / Umbrella](#bypass-global-secure-access-ips-and-fqdns-in-cisco-secure-accessumbrella) and select the tab for **Cisco Secure Access portal** or **Umbrella portal**.
1. Deploy and configure Cisco Secure Client with Umbrella module.

**Validation**
1. Ensure both clients are enabled and the Umbrella profile is `Active`.
1. To verify rules are applied and health checks pass, use Advanced Diagnostics in the Global Secure Access client.
1. Test traffic flow by accessing various sites and validating traffic logs in both platforms.
    1. In the system tray, right-click Global Secure Access Client > Advanced Diagnostics > Traffic tab > Start collecting.
    2. Access `bing.com`, `salesforce.com`, `outlook.office365.com` in browsers.
    3. Verify Global Secure Access client **isn't** capturing traffic for these sites.
    4. In the Cisco Secure Access portal, validate traffic to these sites **is** captured.
    5. Access private applications via Global Secure Access (for example, SMB file share).
    6. Validate the SMB file share traffic is captured in Global Secure Access logs and isn't shown in Cisco logs.
    7. Stop collecting traffic and confirm correct traffic handling.

### 2. Microsoft Entra Private Access with Cisco Secure Internet Access and Cisco Secure Private Access

**Global Secure Access configuration**

1. Enable Private Access forwarding profile.
1. Install a private network connector.
1. Configure Quick Access and private DNS.
1. Install and configure the Global Secure Access client for Windows or macOS.

**Cisco Secure Access configuration**

1. Configure required destinations to bypass Internet Security. For instructions, see [Bypass Global Secure Access IPs and FQDNs in Cisco Secure Access / Umbrella](#bypass-global-secure-access-ips-and-fqdns-in-cisco-secure-accessumbrella) and select the tab for **Cisco Secure Access portal** or **Umbrella portal**.
1. Deploy and configure Cisco Secure Client with Zero Trust Access and Umbrella modules.
1. Add private resources and create access policies.

**Validation**
1. Ensure both clients are enabled and the Umbrella profile is `Active`.
1. To verify rules are applied and health checks pass, use Advanced Diagnostics in the Global Secure Access client.
1. Test traffic flow by accessing various sites and validating traffic logs in both platforms.
    1. In the system tray, right-click Global Secure Access Client > Advanced Diagnostics > Traffic tab > Start collecting.
    2. Access `bing.com`, `salesforce.com`, `outlook.office365.com` in browsers.
    3. Verify Global Secure Access client **isn't** capturing traffic for these sites.
    4. In the Cisco Secure Access portal, validate traffic to these sites **is** captured.
    5. Access private applications via Global Secure Access (for example, SMB file share).
    6. Access private resources via Cisco Secure Private Access (for example, RDP session).
    7. Validate the SMB file share traffic is captured in Global Secure Access logs and isn't shown in Cisco logs.
    8. Validate the RDP traffic is captured in Cisco logs and isn't shown in Global Secure Access logs.
    9. Stop collecting traffic and confirm correct traffic handling.
 
### 3. Microsoft Entra Microsoft Access with Cisco Secure Internet Access and Cisco Secure Private Access

**Global Secure Access configuration**

1. Enable Microsoft Access forwarding profile.
1. Install and configure the Global Secure Access client for Windows or macOS.

**Cisco Secure Access configuration**

1. Configure required destinations to bypass Internet Security, including other Microsoft IPs and FQDNs. For instructions, see [Bypass Global Secure Access IPs and FQDNs in Cisco Secure Access / Umbrella](#bypass-global-secure-access-ips-and-fqdns-in-cisco-secure-accessumbrella) and select the tab for **Cisco Secure Access portal** or **Umbrella portal**.
1. Deploy and configure Cisco Secure Client with Zero Trust Access and Umbrella modules.
1. Add private resources and access policies.

**Validation**
1. Ensure both clients are enabled and the Umbrella profile is `Active`.
1. To verify rules are applied and health checks pass, use Advanced Diagnostics in the Global Secure Access client.
1. Test traffic flow by accessing various sites and validating traffic logs in both platforms.
    1. Start collecting traffic in Global Secure Access client.
    2. Access `bing.com`, `salesforce.com` in browsers.
    3. Verify Global Secure Access client **isn't** capturing traffic for these sites.
    4. In the Cisco Secure Access portal, validate traffic to these sites **is** captured.
    5. Access `outlook.office365.com`, `<yourtenantdomain>.sharepoint.com`.
    6. Validate Global Secure Access traffic logs show these sites; Cisco Secure Access doesn't.
    7. Access private resources via Cisco Secure Private Access.
    8. Validate traffic logs in both portals.
    9. Stop collecting traffic and confirm Global Secure Access only captured Microsoft traffic.

### 4. Microsoft Entra Internet Access and Microsoft Access with Cisco Secure Private Access

**Global Secure Access configuration**

1. Enable Internet Access and Microsoft Access forwarding profiles.
1. Install and configure the Global Secure Access client for Windows or macOS.
1. Add a custom bypass for Cisco Secure Access: `*.zpc.sse.cisco.com`.

**Cisco Secure Access configuration**

1. Configure required destinations to bypass Internet Security, including other Microsoft IPs and FQDNs.  For instructions, see [Bypass Global Secure Access IPs and FQDNs in Cisco Secure Access / Umbrella](#bypass-global-secure-access-ips-and-fqdns-in-cisco-secure-accessumbrella) and select the tab for **Cisco Secure Access portal** or **Umbrella portal**.
1. Deploy and configure Cisco Secure Client with Zero Trust Access module.
1. Add private resources and access policies.

> [!NOTE]
> For this scenario, Cisco Secure Access only handles private traffic. The Umbrella module is not installed.

**Validation**
1. Ensure both clients are enabled.
1. To verify rules are applied and health checks pass, use Advanced Diagnostics in the Global Secure Access client.
1. Test traffic flow by accessing various sites and validating traffic logs in both platforms.
    1. Start collecting traffic in Global Secure Access client.
    2. Access `bing.com`, `salesforce.com`, `outlook.office365.com`.
    3. Verify Global Secure Access client captures traffic for these sites.
    4. In the Cisco Secure Access portal, validate traffic to these sites **isn't** captured.
    5. Access private resources via Cisco Secure Private Access.
    6. Validate traffic logs in both portals.
    7. Stop collecting traffic and confirm Global Secure Access **didn't** handle private application traffic.

> [!NOTE]
> For troubleshooting health check failures, see [Troubleshoot the Global Secure Access client: Health check](troubleshoot-global-secure-access-client-diagnostics-health-check.md).

## Next steps

- [What is Global Secure Access?](overview-what-is-global-secure-access.md)

