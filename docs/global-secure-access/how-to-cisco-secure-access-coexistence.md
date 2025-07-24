---
title: Security Service Edge (SSE) Coexistence With Microsoft and Cisco Secure Access
description: Microsoft and Cisco’s Secure Access coexistence solution guide.
author: kenwith
ms.author: kenwith
manager: dougeby
ms.topic: conceptual
ms.date: 07/17/2025
ms.service: global-secure-access
ms.subservice: entra-private-access 
ms.reviewer: shkhalid
ai-usage: ai-assisted
---

# Security Service Edge (SSE) coexistence with Global Secure Access and Cisco Secure Access

Learn how to configure Security Service Edge (SSE) coexistence using Global Secure Access and Cisco Secure Access.

In today's digital landscape, organizations need robust, unified solutions for secure and seamless connectivity. Global Secure Access and Cisco Secure Access offer complementary Secure Access Service Edge (SASE) capabilities. When integrated, these platforms enhance security and connectivity for diverse access scenarios.

This guide outlines how to configure and deploy Global Secure Access solutions alongside Cisco Secure Access SSE offerings. By leveraging both platforms, you can optimize your organization's security posture while maintaining high-performance connectivity for private applications, Microsoft 365 traffic, and internet access.

## Coexistence configurations

### Configuration 1: Private Access with Cisco Secure Access Zero Trust Network Access (ZTNA), Domain Name System (DNS) Defense, and Secure Web Gateway (SWG)

In this scenario, both clients handle traffic for separate private applications. Private applications in Global Secure Access Private Access are managed by Global Secure Access, while private applications in Cisco Secure Access are managed by the Cisco Secure Client Zero Trust Network Access (ZTNA) module. Web and DNS traffic is protected by Secure Access Secure Web Gateway (SWG) and DNS Defense (Umbrella).

### Configuration 2: Microsoft Access with Cisco Secure Access ZTNA, DNS Defense, and SWG.

Global Secure Access manages all Microsoft 365 traffic. Private applications in Cisco Secure Access are handled by the Cisco Secure Client Zero Trust Network Access (ZTNA) module. Web and DNS traffic is protected by Secure Access Secure Web Gateway (SWG) and DNS Defense (Umbrella).

### Configuration 3: Internet Access and Microsoft Access with Cisco Secure Access Zero Trust Network Access (ZTNA)

Global Secure Access manages internet and Microsoft traffic. Cisco Secure Access handles only Private Access with the Cisco Secure Client Zero Trust Network Access (ZTNA) module.

### Configuration 4: Internet Access, Microsoft Access, and Private Access with Cisco Secure Access Zero Trust Network Access (ZTNA) and Domain Name System (DNS) Defense (Umbrella)

Global Secure Access manages internet access, Microsoft access, and some private access applications. Separate private applications are handled by Secure Access Zero Trust Network Access (ZTNA), and DNS Defense (Umbrella) provides DNS protection.
> [!NOTE]
  > There is currently an issue with macOS preventing coexistence between GSA and Cisco Secure Access ZTNA. This guide will be updated when the resolution is confirmed.
## Prerequisites

To configure Global Secure Access and Cisco Secure Access for a unified SASE solution:

1. Set up Global Secure Access Internet Access and Private Access.
2. Configure Cisco Secure Access Private Access, DNS Defense, and SWG.
3. Establish required FQDN and IP bypasses for integration between the platforms.

### Set up Global Secure Access

- Enable and disable different traffic forwarding profiles for your Entra tenant. See [Traffic forwarding profiles](concept-traffic-forwarding.md).
- Install and configure the private network connector. See [Configure connectors](how-to-configure-connectors.md).
- Configure Quick Access to private resources and set up private DNS and DNS suffixes. See [Configure Quick Access](how-to-configure-quick-access.md).
- Install and configure the Global Secure Access client on end-user devices. See [Global Secure Access clients](concept-clients.md).

> [!NOTE]
> Private Network Connectors are required for Private Access applications.

### Set up Cisco Secure Access

- Deploy and configure a resource connector for private applications. See Cisco documentation for [managing resource connectors and connector groups](https://docs.sse.cisco.com/sse-user-guide/docs/manage-resource-connectors-and-connector-groups).
- Provision users and groups. Integration with Entra ID provides the best user experience. See Cisco documentation for [Entra ID SAML configuration](https://docs.sse.cisco.com/sse-user-guide/docs/configure-azure-for-saml).
- Add private resources and create access policies. See Cisco documentation for [managing private access rules](https://docs.sse.cisco.com/sse-user-guide/docs/manage-private-access-rules).
- Set up and configure internet security. See Cisco documentation for [managing internet security](https://docs.sse.cisco.com/sse-user-guide/docs/manage-internet-security).
- Deploy and install the Cisco Secure Client. See Cisco documentation for [downloading and installing the client for Windows and macOS](https://docs.sse.cisco.com/sse-user-guide/docs/manage-internet-security).

> [!NOTE]
> Required Cisco Secure Client modules are listed in each configuration.

- Set up and configure destinations to bypass Secure Access Internet Security and allow coexistence with Global Secure Access.

## Cisco Secure Access bypasses

Add Entra service FQDNs in Traffic Steering to the destination list to bypass Cisco Secure Access.

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

  Add DNS suffixes configured in Quick Access or as FQDNs in Enterprise App Segments. For example, add `corp.local` and `contoso.com` if those are your DNS suffixes.

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

### Configuration 1: Private Access with Cisco Secure Access ZTNA, DNS Defense, and SWG

#### Global Secure Access configuration

- Enable Private Access forwarding profile.
- Install a Private Network Connector.
- Configure Quick Access and private DNS.
- Install and configure the Global Secure Access client for Windows or macOS.

#### Cisco Secure Access configuration

- Configure required destinations to bypass Internet Security.
- Deploy and configure Cisco Secure Client with Zero Trust Access and Umbrella modules.
- Add private resources and access policies.
- Verify client configurations:
  - Right-click Global Secure Access Client > Advanced Diagnostics > Forwarding Profile to verify Private Access and Private DNS rules.
  - Advanced Diagnostics > Health Check: ensure no checks are failing.
  - Cisco Secure Client: validate Zero Trust Access and Umbrella are active.

> [!NOTE]
> For troubleshooting, see [Troubleshoot the Global Secure Access client: Health check](troubleshoot-global-secure-access-client-diagnostics-health-check.md).

#### Test traffic flow

1. In the system tray, right-click Global Secure Access Client > Advanced Diagnostics > Traffic tab > Start collecting.
2. Access `bing.com`, `salesforce.com`, `outlook.office365.com` in browsers.
3. Verify Global Secure Access client **isn't** capturing traffic for these sites.
4. In the Cisco Secure Access portal, validate traffic to these sites is captured.
5. Access private applications via Global Secure Access (e.g., SMB file share).
6. Access private resources via Cisco Secure Access ZTNA (e.g., RDP session).
7. Validate traffic logs in both portals.
8. Stop collecting traffic and confirm correct traffic handling.

### Configuration 2: Microsoft Access with Cisco Secure Access ZTNA, DNS, and SWG

#### Global Secure Access configuration

- Enable Microsoft Access forwarding profile.
- Install and configure the Global Secure Access client for Windows.

#### Cisco Secure Access configuration

- Configure required destinations to bypass Internet Security, including additional Microsoft IPs and FQDNs.
- Deploy and configure Cisco Secure Client with Zero Trust Access and Umbrella modules.
- Add private resources and access policies.
- Verify client configurations as in Configuration 1.

#### Test traffic flow

1. Start collecting traffic in Global Secure Access client.
2. Access `bing.com`, `salesforce.com` in browsers.
3. Verify Global Secure Access client isn't capturing traffic for these sites.
4. Cisco Secure Access portal: validate traffic to these sites is captured.
5. Access `outlook.office365.com`, `<yourtenantdomain>.sharepoint.com`.
6. Validate Global Secure Access traffic logs show these sites; Cisco Secure Access does not.
7. Access private resources via Cisco Secure Access ZTNA.
8. Validate traffic logs in both portals.
9. Stop collecting traffic and confirm correct traffic handling.

### Configuration 3: Internet Access and Microsoft Access with Cisco Secure Access ZTNA

#### Global Secure Access configuration

- Enable Internet Access and Microsoft Access forwarding profiles.
- Install and configure the Global Secure Access client for Windows.
- Add a custom bypass for Cisco Secure Access:
  - In Global Secure Access admin center, go to **Connect > Traffic forwarding > Internet access profile > View**.
  - Expand **Custom Bypass**, add rule for destination `*.zpc.sse.cisco.com`.

#### Cisco Secure Access configuration

- Deploy and configure Cisco Secure Client with Zero Trust Access module.
- Add private resources and access policies.

> [!NOTE]
> No Cisco Secure Access DNS Defense or SWG in this scenario; Umbrella module is not installed.

#### Test traffic flow

1. Start collecting traffic in Global Secure Access client.
2. Access `bing.com`, `salesforce.com`, `outlook.office365.com`.
3. Verify Global Secure Access client captures traffic for these sites.
4. Cisco Secure Access portal: validate traffic to these sites is not captured.
5. Access private resources via Cisco Secure Access ZTNA.
6. Validate traffic logs in both portals.
7. Stop collecting traffic and confirm correct traffic handling.

### Configuration 4: Internet Access, Microsoft Access, and Private Access with Cisco Secure Access ZTNA and DNS Defense (Umbrella)

#### Global Secure Access configuration

- Enable Internet Access, Microsoft Access, and Private Access forwarding profiles.
- Install and configure the Global Secure Access client for Windows.
- Add custom bypass for Cisco Secure Access:
  - In Global Secure Access admin center, go to **Connect > Traffic forwarding > Internet access profile > View**.
  - Expand **Custom Bypass**, add rules for:
   ```
   *.zpc.sse.cisco.com, 208.67.222.222, 208.67.220.220, 67.215.64.0/19, 146.112.0.0/16, 155.190.0.0/16, 185.60.84.0/22, 204.194.232.0/21, 208.67.216.0/21, 208.69.32.0/21
   ```
- Create a web content filtering policy (e.g., block Games category), assign to a security profile, and link with a Conditional Access policy.

#### Cisco Secure Access configuration

- Configure required destinations to bypass Umbrella (Secure DNS) and Secure Access Zero Trust.
- Deploy and configure Cisco Secure Client with Zero Trust Access and Umbrella modules.
- Disable Cisco Secure Access SWG:
  - In Cisco Secure Access portal > Resources > Roaming Devices > Desktop Operating Systems.
  - Select device > Web Security drop-down > Always Disable (override).
- Create an Internet Access block policy for a domain (e.g., `Zillow.com`).
- Add private resources and access policies.

#### Test traffic flow

1. Start collecting traffic in Global Secure Access client.
2. Access `bing.com`, `salesforce.com`, `outlook.office365.com`.
3. Verify Global Secure Access client captures traffic for these sites. DNS traffic is handled by Cisco.
4. Validate traffic logs in both portals.
5. Access private applications via Global Secure Access (e.g., SMB file share).
6. Access private resources via Cisco Secure Access ZTNA (e.g., RDP session).
7. Access `battle.net` and confirm Global Secure Access block page.
8. Access `Zillow.com` and confirm Cisco block page.
9. Stop collecting traffic and confirm correct traffic handling.

## Next steps

- [What is Global Secure Access?](overview-what-is-global-secure-access.md)

