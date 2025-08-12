---
title: Security Service Edge (SSE) Coexistence With Microsoft and Cisco Secure Access
description: Microsoft and Cisco’s Secure Access coexistence solution guide.
author: kenwith
ms.author: kenwith
manager: dougeby
ms.topic: conceptual
ms.date: 07/29/2025
ms.service: global-secure-access
ms.subservice: entra-private-access 
ms.reviewer: shkhalid
ai-usage: ai-assisted
---

# Security Service Edge (SSE) coexistence with Global Secure Access and Cisco Secure Access

Learn how to configure Security Service Edge (SSE) coexistence using Global Secure Access and Cisco Secure Access.

In today's digital landscape, organizations need robust, unified solutions for secure and seamless connectivity. Global Secure Access and Cisco Secure Access offer complementary Secure Access Service Edge (SASE) capabilities. When integrated, these platforms enhance security and connectivity for diverse access scenarios.

This guide outlines how to configure and deploy Global Secure Access solutions alongside Cisco Secure Access SSE offerings. By using both platforms, you can optimize your organization's security posture while maintaining high-performance connectivity for private applications, Microsoft 365 traffic, and internet access.

## Coexistence configurations

### Configuration 1: Microsoft Entra Private Access with Cisco Secure Internet Access

In this scenario, Global Secure Access handles private application traffic. Cisco Secure Client provides DNS protection and SWG capabilities.

### Configuration 2: Private Access with Cisco Secure Internet Access and Cisco Secure Private Access

In this scenario, both clients handle traffic for separate private applications. Global Secure Access handles private applications in Global Secure Access Private Access, while the Cisco Secure Client - Zero Trust Network Access (ZTNA) module handles private applications in Cisco Secure Private Access. Web and DNS traffic is protected by Cisco Secure Internet Access.

### ### Configuration 3: Microsoft Access with Cisco Secure Internet Access and Cisco Secure Private Access

Global Secure Access manages all Microsoft 365 traffic. The Cisco Secure Client - Zero Trust Network Access (ZTNA) module handles private applications in Cisco Secure Private Access. Web and DNS traffic is protected by Cisco Secure Internet Access.

### ### Configuration 4: Internet Access and Microsoft Access with Cisco Secure Access Secure Private Access

Global Secure Access manages internet and Microsoft traffic. Cisco Secure Access handles only Private Access with the Cisco Secure Client - Zero Trust Network Access (ZTNA) module.
> [!NOTE]
  > There's currently an issue with macOS preventing coexistence between Global Secure Access and Cisco Secure Access ZTNA.
## Prerequisites

To configure Global Secure Access and Cisco Secure Access for a unified SASE solution:

1. Set up Global Secure Access Internet Access and Private Access.
2. Configure Cisco Secure Access Private Access, DNS Defense, and SWG.
3. Establish required FQDN and IP bypasses for integration between the platforms.

### Set up Global Secure Access

- Enable and disable different traffic forwarding profiles for your Microsoft Entra tenant. See [Traffic forwarding profiles](concept-traffic-forwarding.md).
- Install and configure the private network connector. See [Configure connectors](how-to-configure-connectors.md).
- Configure Quick Access to private resources and set up private DNS and DNS suffixes. See [Configure Quick Access](how-to-configure-quick-access.md).
- Install and configure the Global Secure Access client on end-user devices. See [Global Secure Access clients](concept-clients.md).

> [!NOTE]
> Private Network Connectors are required for Private Access applications.

### Set up Cisco Secure Access

- Deploy and configure a resource connector for private applications. See Cisco documentation for [managing resource connectors and connector groups](https://docs.sse.cisco.com/sse-user-guide/docs/manage-resource-connectors-and-connector-groups).
- Set up users and groups. Integration with Microsoft Entra ID provides the best user experience. See Cisco documentation for [Microsoft Entra ID SAML configuration](https://docs.sse.cisco.com/sse-user-guide/docs/configure-azure-for-saml).
- Add private resources and create access policies. See Cisco documentation for [managing private access rules](https://docs.sse.cisco.com/sse-user-guide/docs/manage-private-access-rules).
- Set up and configure internet security. See Cisco documentation for [managing internet security](https://docs.sse.cisco.com/sse-user-guide/docs/manage-internet-security).
- Deploy and install the Cisco Secure Client. See Cisco documentation for [downloading and installing the client for Windows and macOS](https://docs.sse.cisco.com/sse-user-guide/docs/manage-internet-security).

> [!NOTE]
> Required Cisco Secure Client modules are listed in each configuration.

- Set up and configure destinations to bypass Secure Access Internet Security and allow coexistence with Global Secure Access.

## Cisco Secure Access bypasses

To bypass Cisco Secure Access, add Microsoft Entra service FQDNs in Traffic Steering to the destination list.

1. In the Cisco Secure Access portal, go to **Connect > End User Connectivity > Internet Security**.
2. In the **Traffic Steering** section, select **Add Destination > Bypass Secure Access**, add the following FQDNs, and save:

  ```
  *.globalsecureaccess.com
  ```

  > [!NOTE]
  > Cisco Secure Access has an implied wildcard, so you can use `globalsecureaccess.com`.

3. Add these FQDNs for Microsoft traffic forwarding profile:

  ```
  auth.microsoft.com, msftidentity.com, msidentity.com, onmicrosoft.com, outlook.com, protection.outlook.com, sharepoint.com, sharepointonline.com, svc.ms, wns.windows.com, account.activedirectory.windowsazure.com, accounts.accesscontrol.windows.net, admin.onedrive.com, adminwebservice.microsoftonline.com, api.passwordreset.microsoftonline.com, autologon.microsoftazuread-sso.com, becws.microsoftonline.com, ccs.login.microsoftonline.com, clientconfig.microsoftonline-p.net, companymanager.microsoftonline.com, device.login.microsoftonline.com, g.live.com, graph.microsoft.com, graph.windows.net, login-us.microsoftonline.com, login.microsoft.com, login.microsoftonline-p.com, login.microsoftonline.com, login.windows.net, logincert.microsoftonline.com, loginex.microsoftonline.com, nexus.microsoftonline-p.com, officeclient.microsoft.com, oneclient.sfx.ms, outlook.cloud.microsoft, outlook.office.com, outlook.office365.com, passwordreset.microsoftonline.com, provisioningapi.microsoftonline.com, spoprod-a.akamaihd.net
  ```

  ```
  <quickaccessapplicationid>.globalsecureaccess.local
  ```

  > [!NOTE]
  > Replace `<quickaccessapplicationid>` with the application ID of your Quick Access app.

  Add DNS suffixes configured in Quick Access or as FQDNs in Enterprise App Segments. For example, if your domains are `corp.local` and `contoso.com` then add them.

4. In the Traffic Steering section, select **Add Destination > Bypass web proxy only**, add these IPs, and save:

  ```
  150.171.19.0/24, 150.171.20.0/24, 13.107.232.0/24, 13.107.233.0/24, 150.171.15.0/24, 150.171.18.0/24, 151.206.0.0/16, 6.6.0.0/16
  ```

  Add these Microsoft IP addresses for Microsoft traffic forwarding profile:

  ```
  132.245.0.0/16, 204.79.197.215/32, 150.171.32.0/22, 131.253.33.215/32, 23.103.160.0/20, 40.96.0.0/13, 52.96.0.0/14, 40.104.0.0/15, 13.107.128.0/22, 13.107.18.10/31, 13.107.6.152/31, 52.238.78.88/32, 104.47.0.0/17, 52.100.0.0/14, 40.107.0.0/16, 40.92.0.0/15, 150.171.40.0/22, 52.104.0.0/14, 104.146.128.0/17, 40.108.128.0/17, 13.107.136.0/22, 40.126.0.0/18, 20.231.128.0/19, 20.190.128.0/18, 20.20.32.0/19
  ```

5. Restart Cisco Umbrella client services or restart the machine where the clients are installed.

## Configuration details

### Configuration 1: Microsoft Entra Private Access with Cisco Secure Access Internet Security and DNS protection


#### Global Secure Access configuration

- Enable Private Access forwarding profile.
- Install a Private Network Connector.
- Configure Quick Access and private DNS.
- Install and configure the Global Secure Access client for Windows or macOS.

#### Cisco Secure Access configuration

1. **Configure required destinations to bypass Internet Security.**
2. **Deploy and configure Cisco Secure Client** with Zero Trust Access and Umbrella modules.
3. **Add private resources and create access policies.**
4. **Verify client configurations:**
  - Right-click **Global Secure Access Client** > **Advanced Diagnostics** > **Forwarding Profile** to confirm Private Access and Private DNS rules.
  - Go to **Advanced Diagnostics** > **Health Check** and ensure all checks pass.
  - In **Cisco Secure Client**, confirm the Zero Trust Access and Umbrella modules are active.

> [!NOTE]
> For troubleshooting, see [Troubleshoot the Global Secure Access client: Health check](troubleshoot-global-secure-access-client-diagnostics-health-check.md).

#### Test traffic flow

1. In the system tray, right-click Global Secure Access Client > Advanced Diagnostics > Traffic tab > Start collecting.
2. Access `bing.com`, `salesforce.com`, `outlook.office365.com` in browsers.
3. Verify Global Secure Access client **isn't** capturing traffic for these sites.
4. In the Cisco Secure Access portal, validate traffic to these sites **is** captured.
5. Access private applications via Global Secure Access (for example, SMB file share).
6. Access private resources via Cisco Secure Access ZTNA (for example, RDP session).
7. Validate the SMB file share traffic is captured in Global Secure Access logs and isn't shown in Cisco logs.
8. Validate the RDP traffic is captured in Cisco logs and isn't shown in Global Secure Access logs.
8. Stop collecting traffic and confirm correct traffic handling.

### Configuration 2: Private Access with Cisco Secure Access ZTNA, DNS Defense, and SWG

#### Global Secure Access configuration

- Enable Private Access forwarding profile.
- Install a Private Network Connector.
- Configure Quick Access and private DNS.
- Install and configure the Global Secure Access client for Windows or macOS.

#### Cisco Secure Access configuration

1. **Configure required destinations to bypass Internet Security.**
2. **Deploy and configure Cisco Secure Client** with Zero Trust Access and Umbrella modules.
3. **Add private resources and create access policies.**
4. **Verify client configurations:**
  - Right-click **Global Secure Access Client** > **Advanced Diagnostics** > **Forwarding Profile** to confirm Private Access and Private DNS rules.
  - Go to **Advanced Diagnostics** > **Health Check** and ensure all checks pass.
  - In **Cisco Secure Client**, confirm the Zero Trust Access and Umbrella modules are active.

> [!NOTE]
> For troubleshooting, see [Troubleshoot the Global Secure Access client: Health check](troubleshoot-global-secure-access-client-diagnostics-health-check.md).
#### Test traffic flow

1. In the system tray, right-click Global Secure Access Client > Advanced Diagnostics > Traffic tab > Start collecting.
2. Access `bing.com`, `salesforce.com`, `outlook.office365.com` in browsers.
3. Verify Global Secure Access client **isn't** capturing traffic for these sites.
4. In the Cisco Secure Access portal, validate traffic to these sites **is** captured.
5. Access private applications via Global Secure Access (for example, SMB file share).
6. Access private resources via Cisco Secure Access ZTNA (for example, RDP session).
7. Validate the SMB file share traffic is captured in Global Secure Access logs and isn't shown in Cisco logs.
8. Validate the RDP traffic is captured in Cisco logs and isn't shown in Global Secure Access logs.
8. Stop collecting traffic and confirm correct traffic handling.

### Configuration 3: Microsoft Access with Cisco Secure Access ZTNA, DNS, and SWG

#### Global Secure Access configuration

- Enable Microsoft Access forwarding profile.
- Install and configure the Global Secure Access client for Windows.

#### Cisco Secure Access configuration

- Configure required destinations to bypass Internet Security, including other Microsoft IPs and FQDNs.
- Deploy and configure Cisco Secure Client with Zero Trust Access and Umbrella modules.
- Add private resources and access policies.
- Verify client configurations as in Configuration 1.

#### Test traffic flow

1. Start collecting traffic in Global Secure Access client.
2. Access `bing.com`, `salesforce.com` in browsers.
3. Verify Global Secure Access client **isn't** capturing traffic for these sites.
4. In the Cisco Secure Access portal, validate traffic to these sites **is** captured.
5. Access `outlook.office365.com`, `<yourtenantdomain>.sharepoint.com`.
6. Validate Global Secure Access traffic logs show these sites; Cisco Secure Access doesn't.
7. Access private resources via Cisco Secure Access ZTNA.
8. Validate traffic logs in both portals.
9. Stop collecting traffic and confirm Global Secure Access only captured Microsoft traffic.

### ### Configuration 4: Internet Access and Microsoft Access with Cisco Secure Access ZTNA

#### Global Secure Access configuration

- Enable **Internet Access** and **Microsoft Access** forwarding profiles.
- Install and configure the Global Secure Access client for Windows.
- Add a custom bypass for Cisco Secure Access:
  1. In the Global Secure Access admin center, go to **Connect > Traffic forwarding > Internet access profile > View**.
  2. Expand **Custom Bypass**.
  3. Add a rule for the destination: `*.zpc.sse.cisco.com`.

#### Cisco Secure Access configuration

- Deploy and configure Cisco Secure Client with Zero Trust Access module.
- Add private resources and access policies.

> [!NOTE]
> No Cisco Secure Access DNS Defense or SWG in this scenario; Umbrella module isn't installed.
#### Test traffic flow

1. Start collecting traffic in Global Secure Access client.
2. Access `bing.com`, `salesforce.com`, `outlook.office365.com`.
3. Verify Global Secure Access client captures traffic for these sites.
4. In the Cisco Secure Access portal, validate traffic to these sites isn't captured.
5. Access private resources via Cisco Secure Access ZTNA.
6. Validate traffic logs in both portals.
7. Stop collecting traffic and confirm Global Secure Access didn't handle private application traffic.

## Next steps

- [What is Global Secure Access?](overview-what-is-global-secure-access.md)

