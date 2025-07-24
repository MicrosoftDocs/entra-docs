---
title: Security Service Edge (SSE) Coexistence With Microsoft and Cisco Umbrella and SWG
description: Microsoft and Cisco’s Security Service Edge (SSE) coexistence solution guide.
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

# Security Service Edge (SSE) coexistence with Microsoft and Cisco

Learn how to deploy Global Secure Access and Cisco Secure Access DNS Defense (formerly Cisco Umbrella DNS), with or without Secure Web Gateway (SWG), in a unified environment. This guide provides step-by-step instructions for configuring both platforms to enhance security and connectivity as part of your Secure Access Service Edge (SASE) strategy.

## Scenarios

This guide covers the following coexistence scenarios:

1. **[Microsoft Entra Internet Access and Microsoft Entra Microsoft Access with Umbrella DNS (Cisco Secure Access DNS Defense).](https://github.com/MicrosoftDocs/entra-docs-pr/pull/9086/files#Configuration1)**
In this scenario, Global Secure Access handles Internet and Microsoft 365 traffic. Cisco Secure Access DNS Defense provides DNS protections. Cisco Secure Web Gateway features should be disabled.
2. **[Microsoft Entra Internet Access, Microsoft Entra Microsoft Access, and Microsoft Entra Private Access with Cisco Umbrella DNS (CSA DNS Defense).](https://github.com/MicrosoftDocs/entra-docs-pr/pull/9086/files#Configuration2)**
In this scenario, Global Secure Access handles Internet, Microsoft 365, and Private Access traffic. Cisco Secure Access DNS Defense handles DNS. Cisco Secure Web Gateway should be disabled.

> [!NOTE]
  > There is currently an issue with macOS preventing coexistence between GSA and Umbrella. This guide will be updated when the resolution is confirmed.
## Prerequisites

- Both Cisco Secure Access SWG and Umbrella SWG features must be **disabled** for DNS-only configurations.
- SWG must be **enabled** for configurations that require web gateway functionality.
- Integration with Microsoft Entra ID is recommended for best user experience.

## Global Secure Access setup

To configure Global Secure Access:

1. **Enable or disable traffic forwarding profiles** for your Microsoft Entra tenant.  
    See [Global Secure Access traffic forwarding profiles](overview-what-is-global-secure-access.md).
2. **Install and configure the Entra private network connector** for Private Access applications.  
    See [How to configure connectors](how-to-configure-connectors.md).
3. **Configure Quick Access** to private resources and set up Private DNS and DNS suffixes.  
    See [How to configure Quick Access](how-to-configure-quick-access.md).
4. **Install and configure the Global Secure Access client** on end-user devices.  
    See [Global Secure Access clients](concept-clients.md).

## Cisco Secure Access setup

To configure Cisco Secure Access DNS Defense and SWG:

1. **Provision users and groups**.  
    Integration with Microsoft Entra ID is recommended. See [Microsoft Entra ID SAML configuration guide](https://docs.cisco.com/c/en/us/td/docs/security/secure-client/secure-client-5-0/configuration-guide/b_5-0_secure-client_config_guide/microsoft-entra-id-saml.html).
2. **Set up Internet Security**.  
    See [Manage Internet Security](https://docs.cisco.com/c/en/us/td/docs/security/secure-access/secure-access-1-0/configuration-guide/b_1-0_secure-access_config_guide/internet-security.html).
3. **Deploy and install the Cisco Secure Client**.  
    See [Cisco Secure Client documentation](https://docs.cisco.com/c/en/us/td/docs/security/secure-client/secure-client-5-0/administration-guide/b_5-0_secure-client_admin_guide.html).
    
    > [!IMPORTANT]
  > Cisco has released a Cisco Secure Client (CSC) feature to improve coexistence with Global Secure Access. These steps need to be performed after the initial installation of CSC version 5.1.10.x (or later).
   1. Install Cisco Secure Client version 5.1.10.x
   1. Open CMD prompt as an administrator and run these commands:
      1. "%ProgramFiles(x86)%\Cisco\Cisco Secure Client\acsocktool.exe" -slwm 10
      1. net stop csc_vpnagent && net stop acsock && net start csc_vpnagent
 
   These steps are only required during the initial installation or reinstallation of the Cisco Secure Client.
4. **Create an Internet Access rule* to block domains for testing.
      See [Cisco Secure Access Internet Access Rules documentation](https://docs.sse.cisco.com/sse-user-guide/docs/manage-internet-access-rules).

## Bypass configuration for coexistence

### Bypass Cisco Secure Access/Umbrella required IPs in Global Secure Access

1. In the Microsoft Entra admin center, go to **Global Secure Access > Connect > Traffic forwarding > Internet access profile**.
2. Under **Internet access policies**, select **View**.
3. Expand **Custom Bypass** and select **Add rule**.
4. Enter the following IPs:
    ```
    `208.67.222.222`, `208.67.220.220`, `67.215.64.0/19`, `146.112.0.0/16`, `155.190.0.0/16`, `185.60.84.0/22`, `204.194.232.0/21`, `208.67.216.0/21`, `208.69.32.0/21`, `104.24.0.0/14`, `162.158.0.0/15`
    ```
5. Select **Save**.

### Bypass Global Secure Access IPs and FQDNs in Cisco Secure Access

#### Cisco Umbrella Portal

- Add domain suffixes and Entra service FQDNs to the **Internal domains** list:
  ```
  `*.globalsecureaccess.microsoft.com`
  ```
  Cisco Umbrella supports implied wildcards, so you can use `globalsecureaccess.microsoft.com`.

- Add these Microsoft FQDNs:
  ```
  `auth.microsoft.com`, `msftidentity.com`, `msidentity.com`, `onmicrosoft.com`, `outlook.com`, `protection.outlook.com`, `sharepoint.com`, `sharepointonline.com`, `svc.ms`, `wns.windows.com`, `account.activedirectory.windowsazure.com`, `accounts.accesscontrol.windows.net`, `admin.onedrive.com`, `adminwebservice.microsoftonline.com`, `api.passwordreset.microsoftonline.com`, `autologon.microsoftazuread-sso.com`, `becws.microsoftonline.com`, `ccs.login.microsoftonline.com`, `clientconfig.microsoftonline-p.net`, `companymanager.microsoftonline.com`, `device.login.microsoftonline.com`, `g.live.com`, `graph.microsoft.com`, `graph.windows.net`, `login-us.microsoftonline.com`, `login.microsoft.com`, `login.microsoftonline-p.com`, `login.microsoftonline.com`, `login.windows.net`, `logincert.microsoftonline.com`, `loginex.microsoftonline.com`, `nexus.microsoftonline-p.com`, `officeclient.microsoft.com`, `oneclient.sfx.ms`, `outlook.cloud.microsoft`, `outlook.office.com`, `outlook.office365.com`, `passwordreset.microsoftonline.com`, `provisioningapi.microsoftonline.com`, `spoprod-a.akamaihd.net`, `<quickaccessapplicationid>.globalsecureaccess.local`
  ```
  > [!NOTE]
  > `quickaccessapplicationid` is the application ID of the Quick Access app you’ve configured.

- Add DNS suffixes configured in Quick Access or as FQDNs in Enterprise App Segments. For example, add `corp.local` and `contoso.com` if those are used.

- In the **External Domains & IPs** section, add these Global Secure Access IPs and FQDN:
  ```
  `*.globalsecureaccess.microsoft.com`, `150.171.19.0/24`, `150.171.20.0/24`, `13.107.232.0/24`, `13.107.233.0/24`, `150.171.15.0/24`, `150.171.18.0/24`, `151.206.0.0/16`, `6.6.0.0/16`
  ```
- Add these Microsoft IP addresses:
  ```
  `132.245.0.0/16`, `204.79.197.215/32`, `150.171.32.0/22`, `131.253.33.215/32`, `23.103.160.0/20`, `40.96.0.0/13`, `52.96.0.0/14`, `40.104.0.0/15`, `13.107.128.0/22`, `13.107.18.10/31`, `13.107.6.152/31`, `52.238.78.88/32`, `104.47.0.0/17`, `52.100.0.0/14`, `40.107.0.0/16`, `40.92.0.0/15`, `150.171.40.0/22`, `52.104.0.0/14`, `104.146.128.0/17`, `40.108.128.0/17`, `13.107.136.0/22`, `40.126.0.0/18`, `20.231.128.0/19`, `20.190.128.0/18`, `20.20.32.0/19`
  ```

- Restart Cisco Umbrella client services or restart the machine where the clients are installed.

#### Cisco Secure Access Portal

- Add Entra service FQDNs in Traffic Steering to the destination list to bypass Cisco Secure Access.
- Go to **Connect > End User Connectivity > Internet Security**.
- In **Traffic Steering**, click **Add Destination > Bypass Secure Access**, add these FQDNs and save:
  ```
  `*.globalsecureaccess.microsoft.com`
  ```
  > [!NOTE]
  > Cisco Secure Access has an implied wildcard, so you can use `globalsecureaccess.microsoft.com`.

- Add the same Microsoft FQDNs and DNS suffixes as above.
- In **Traffic Steering**, click **Add Destination > Bypass web proxy only**, add these IPs and save:
  ```
  `150.171.19.0/24`, `150.171.20.0/24`, `13.107.232.0/24`, `13.107.233.0/24`, `150.171.15.0/24`, `150.171.18.0/24`, `151.206.0.0/16`, `6.6.0.0/16`
  ```
- Add the same Microsoft IP addresses as above.
- Restart Cisco Umbrella client services or restart the machine where the clients are installed.

---

## Configuration scenarios

### 1. Microsoft Entra Internet Access and Microsoft Entra Microsoft Access with Umbrella DNS (Cisco Secure Access DNS Defense)


#### Steps

**Global Secure Access configuration:**
- Enable Internet Access and Microsoft Access forwarding profiles.
- Install and configure the Global Secure Access client for Windows.

**Cisco configuration:**
- Configure the required destinations to bypass Internet Security or Umbrella. See instructions above for [Cisco Secure Access portal](https://github.com/MicrosoftDocs/entra-docs-pr/pull/9086/files#BypassesCSAPortal) or [Umbrella portal](https://github.com/MicrosoftDocs/entra-docs-pr/pull/9086/files#BypassesUmbrellaPortal).
- Disable Cisco Secure Access SWG
1.	In the **Cisco Secure Access portal > Resources**
2.	**Roaming Devices > Desktop Operating Systems**
3.	Select the device > **Web Security** drop-down (on blue bar) > **Always Disable (override)**.

- Deploy and configure Cisco Secure Client software with the Umbrella module.

**Validation:**
- Ensure both clients are enabled and the Umbrella profile is `Active`.
- Use Advanced Diagnostics in the Global Secure Access client to verify rules are applied and health checks pass.
- Test traffic flow by accessing various sites and validating traffic logs in both platforms.
1. In the system tray, right-click Global Secure Access Client > Advanced Diagnostics > Traffic tab > Start collecting.
2. Access `bing.com`, `salesforce.com`, `yelp.com` in browsers.
3. Verify Global Secure Access client **is** capturing traffic for these sites.
   - We **do not** expect to see destination FQDN information for these sites in the traffic tab.
4. In the Cisco Secure Access portal, validate DNS traffic to these sites **is** captured.
5. Access `outlook.office365.com`, `<yourmicrosoftdomain>.sharepoint.com` in browsers.
6. Verify Global Secure Access client **is** capturing traffic for these sites.
   - We **do** expect to see destination FQDN information for these sites. 
7. Access a site blocked by Cisco and validate that the Cisco block page is displayed.
8. In Global Secure Access, stop collecting traffic and confirm correct traffic handling.

---

### 2. Microsoft Entra Internet Access, Microsoft Entra Microsoft Access, and Microsoft Entra Private Access with Cisco Umbrella DNS (CSA DNS Defense)


#### Steps

**Global Secure Access configuration:**
- Enable Internet Access, Microsoft Access, and Private Access forwarding profiles.
- Install a Private Network Connector.
- Configure Quick Access and Private DNS.
- Install and configure the Global Secure Access client for Windows.

**Cisco configuration:**
- Configure the required destinations to bypass Internet Security or Umbrella. See instructions above for [Cisco Secure Access portal](https://github.com/MicrosoftDocs/entra-docs-pr/pull/9086/files#BypassesCSAPortal) or [Umbrella portal](https://github.com/MicrosoftDocs/entra-docs-pr/pull/9086/files#BypassesUmbrellaPortal).
- Disable Cisco Secure Access SWG.
- Deploy and configure Cisco Secure Client software with the Umbrella module.

**Validation:**
- Ensure both clients are enabled and the Umbrella profile is `Active`.
- Use Advanced Diagnostics in the Global Secure Access client to verify rules are applied and health checks pass.
- Test traffic flow by accessing various sites and validating traffic logs in both platforms.
1. In the system tray, right-click Global Secure Access Client > Advanced Diagnostics > Traffic tab > Start collecting.
2. Access `bing.com`, `salesforce.com`, `yelp.com` in browsers.
3. Verify Global Secure Access client **is** capturing traffic for these sites.
   - We **do not** expect to see destination FQDN information for these sites in the traffic tab.
4. In the Cisco Secure Access portal, validate DNS traffic to these sites **is** captured.
5. Access `outlook.office365.com`, `<yourmicrosoftdomain>.sharepoint.com` in browsers.
6. Verify Global Secure Access client **is** capturing traffic for these sites.
   - We **do** expect to see destination FQDN information for these sites. 
7. Access a site blocked by Cisco and validate that the Cisco block page is displayed.
8. Access an Entra private application (e.g., SMB file share) and validate that Global Secure Access **is** capturing traffic and Cisco is not.
8. In Global Secure Access, stop collecting traffic and confirm correct traffic handling.

---

### 3.	Microsoft Entra Private Access and Umbrella DNS (Cisco Secure Access DNS Defense) with Secure Web Gateway


#### Steps

**Global Secure Access configuration:**
- Enable Private Access forwarding profiles.
- Install a Private Network Connector.
- Configure Quick Access and Private DNS.
- Install and configure the Global Secure Access client for Windows.

**Cisco configuration:**
- Configure the required destinations to bypass Internet Security or Umbrella. See instructions above for [Cisco Secure Access portal](https://github.com/MicrosoftDocs/entra-docs-pr/pull/9086/files#BypassesCSAPortal) or [Umbrella portal](https://github.com/MicrosoftDocs/entra-docs-pr/pull/9086/files#BypassesUmbrellaPortal).
- Deploy and configure Cisco Secure Client software with the Umbrella module.
- Ensure that Secure Web Gateway is enabled.
**Validation:**
- Ensure both clients are enabled and the Umbrella profile is `Active`.
- Use Advanced Diagnostics in the Global Secure Access client to verify rules are applied and health checks pass.
- Test traffic flow by accessing various sites and validating traffic logs in both platforms.
1. In the system tray, right-click Global Secure Access Client > Advanced Diagnostics > Traffic tab > Start collecting.
2. Access `bing.com`, `salesforce.com`, `outlook.office365.com` in browsers.
3. Verify Global Secure Access client **is not** capturing traffic for these sites.
4. In the Cisco Secure Access portal, validate traffic to these sites **is** captured.
8. Access an Entra private application (e.g., SMB file share) and validate that Global Secure Access **is** capturing traffic and Cisco **is not**.
8. In Global Secure Access, stop collecting traffic and confirm correct traffic handling.

---

### Global Secure Access Microsoft Access with Cisco Secure Access DNS Defense and Secure Web Gateway

In this scenario, Global Secure Access handles private application traffic. Cisco Secure Client provides DNS protection and SWG capabilities.

#### Steps

**Global Secure Access configuration:**
- Enable Microsoft Access traffic forwarding profile.
- Install and configure the Global Secure Access client for Windows.

**Cisco configuration:**
- Configure required destinations to bypass Internet Security or Umbrella.
- Deploy and configure Cisco Secure Client software with the Umbrella module.

**Validation:**
- Ensure both clients are enabled and the Umbrella profile is `Active`.
- Use Advanced Diagnostics in the Global Secure Access client to verify rules are applied and health checks pass.
- Test traffic flow by accessing various sites and validating traffic logs in both platforms.

---

> [!NOTE]
> For troubleshooting health check failures, see [Troubleshoot the Global Secure Access client: Health check](troubleshoot-global-secure-access-client-diagnostics-health-check.md).

 

## Next steps

- [What is Global Secure Access?](overview-what-is-global-secure-access.md)

