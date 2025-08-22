---
title: Security Service Edge (SSE) Coexistence With Microsoft and Cisco Umbrella
description: Microsoft and Cisco’s Security Service Edge (SSE) coexistence solution guide.
author: kenwith
ms.author: kenwith
manager: dougeby
ms.topic: conceptual
ms.date: 08/22/2025
ms.service: global-secure-access
ms.subservice: entra-private-access 
ms.reviewer: shkhalid
ai-usage: ai-assisted
---

# Security Service Edge (SSE) coexistence with Microsoft and Cisco Umbrella DNS protection

Learn how to deploy Global Secure Access and Cisco Umbrella, with DNS security only, in a unified environment. This guide provides step-by-step instructions for configuring both platforms to enhance security and connectivity as part of your Secure Access Service Edge (SASE) strategy.
The configurations outlined apply to both Cisco Umbrella and Cisco Secure Access DNS Defense. Detailed instructions for configuring each portal are provided.
> [!NOTE]
   > These scenarios feature DNS security only. If you want to include Cisco's Secure Web Gateway, see the coexistence configurations in the [Cisco Secure Access guide](how-to-cisco-secure-access-coexistence.md).
## Scenarios

This guide covers the following coexistence scenarios:

1. **[Microsoft Entra Internet Access and Microsoft Entra Microsoft Access with Umbrella DNS security](#1-internet-access-and-microsoft-access-with-umbrella-dns-security).**
In this scenario, Global Secure Access handles Internet and Microsoft traffic. Cisco Umbrella provides DNS security. Cisco Secure Web Gateway features should be disabled.
2. **[Internet Access, Microsoft Access, and Microsoft Entra Private Access with Cisco Umbrella DNS security.](#2-internet-access-microsoft-access-and-private-access-with-cisco-umbrella-dns-security)**
In this scenario, Global Secure Access handles Internet, Microsoft, and Private Access traffic. Cisco Umbrella handles DNS. Cisco Secure Web Gateway should be disabled.

 
## Prerequisites

- Cisco SWG features must be disabled for these configurations.
- Integration with Microsoft Entra ID is recommended for best user experience.

## Global Secure Access setup

To configure Global Secure Access:

1. **Enable or disable traffic forwarding profiles** for your Microsoft Entra tenant.  
    See [Global Secure Access traffic forwarding profiles](concept-traffic-forwarding.md).
2. **Install and configure the Microsoft Entra private network connector** for Private Access applications.  
    See [How to configure connectors](how-to-configure-connectors.md).
3. **Configure Quick Access** to private resources and set up Private DNS and DNS suffixes.  
    See [How to configure Quick Access](how-to-configure-quick-access.md).
4. **Install and configure the Global Secure Access client** on end-user devices.  
    See [Global Secure Access clients](concept-clients.md).

> [!NOTE]
> Private Network Connectors are required for Private Access applications.

## Cisco Umbrella setup

To configure Cisco Umbrella:

1. **Provision users and groups.**  
    Integration with Microsoft Entra ID is recommended. See Microsoft Entra ID SAML configuration guide for [Umbrella](https://learn.microsoft.com/en-us/entra/identity/saas-apps/cisco-umbrella-tutorial) or [Cisco Secure Access](https://docs.sse.cisco.com/sse-user-guide/docs/manage-users-and-groups).
2. **Create an policy to block a destination or content for testing.**
      For detailed information, see [Umbrella policies](https://docs.umbrella.com/deployment-umbrella/docs/create-and-apply-policies) or [Cisco Secure Access Internet Access Rules documentation](https://docs.sse.cisco.com/sse-user-guide/docs/manage-internet-access-rules).
3. **Deploy and install the Cisco Secure Client.**  
    
  > [!IMPORTANT]
  > Cisco released a Cisco Secure Client (CSC) feature to improve coexistence with Global Secure Access. These steps need to be performed after the initial installation, or re-installation, of CSC version 5.1.10.x (or later).
  > 1. Install Cisco Secure Client version 5.1.10.x.
  > 1. Open CMD prompt as an administrator and run these commands:
  > 1. `"%ProgramFiles(x86)%\Cisco\Cisco Secure Client\acsocktool.exe" -slwm 10`
  > 1. `net stop csc_vpnagent && net stop acsock && net start csc_vpnagent`

## Bypass configuration for coexistence

### Bypass Umbrella/Cisco Secure Access required IPs in Global Secure Access

1. In the Microsoft Entra admin center, go to **Global Secure Access > Connect > Traffic forwarding > Internet access profile**.
2. Under **Internet access policies**, select **View**.
3. Expand **Custom Bypass** and select **Add rule**.
4. Enter the following IPs:
    ```
    208.67.222.222, 208.67.220.220, 67.215.64.0/19, 146.112.0.0/16, 155.190.0.0/16, 185.60.84.0/22, 204.194.232.0/21, 208.67.216.0/21, 208.69.32.0/21
    ```
5. Select **Save**.

### Bypass Global Secure Access IPs and FQDNs in Umbrella/Cisco Secure Access

#### [Cisco Umbrella Portal](#tab/cisco-umbrella-portal)

1. Add domain suffixes and Microsoft Entra service FQDNs to the **Deployments > Configuration > Domain Management > Internal domains** list:
  ```
  *.globalsecureaccess.microsoft.com
  ```
  > [!NOTE]
  > Cisco Umbrella supports implied wildcards, so you can use `globalsecureaccess.microsoft.com`.

2. Add these Microsoft FQDNs (only required if Microsoft traffic forwarding profile is enabled):
    ```
    auth.microsoft.com, msftidentity.com, msidentity.com, onmicrosoft.com, outlook.com, protection.outlook.com, sharepoint.com, sharepointonline.com, svc.ms, wns.windows.com, account.activedirectory.windowsazure.com, accounts.accesscontrol.windows.net, admin.onedrive.com, adminwebservice.microsoftonline.com, api.passwordreset.microsoftonline.com, autologon.microsoftazuread-sso.com, becws.microsoftonline.com, ccs.login.microsoftonline.com, clientconfig.microsoftonline-p.net, companymanager.microsoftonline.com, device.login.microsoftonline.com, g.live.com, graph.microsoft.com, graph.windows.net, login-us.microsoftonline.com, login.microsoft.com, login.microsoftonline-p.com, login.microsoftonline.com, login.windows.net, logincert.microsoftonline.com, loginex.microsoftonline.com, nexus.microsoftonline-p.com, officeclient.microsoft.com, oneclient.sfx.ms, outlook.cloud.microsoft, outlook.office.com, outlook.office365.com, passwordreset.microsoftonline.com, provisioningapi.microsoftonline.com, spoprod-a.akamaihd.net
    ```
  3. Add the Quick Access FQDN. `<quickaccessapplicationid>.globalsecureaccess.local`
   
  > [!NOTE]
  > Replace `<quickaccessapplicationid>` with the application ID of your Quick Access app.

  4. Add DNS suffixes defined in your Private DNS or Enterprise App segments. For example, if your Private DNS suffix is `contoso.local` and you have a private app at `contoso.com`, add both suffixes.

5. In the **External Domains & IPs** section, add these Global Secure Access IPs and FQDN:
  ```
  *.globalsecureaccess.microsoft.com, 150.171.19.0/24, 150.171.20.0/24, 13.107.232.0/24, 13.107.233.0/24, 150.171.15.0/24, 150.171.18.0/24, 151.206.0.0/16, 6.6.0.0/16
  ```
6. Add these Microsoft IP addresses (only required if Microsoft traffic forwarding profile is enabled):
  ```
  132.245.0.0/16, 204.79.197.215/32, 150.171.32.0/22, 131.253.33.215/32, 23.103.160.0/20, 40.96.0.0/13, 52.96.0.0/14, 40.104.0.0/15, 13.107.128.0/22, 13.107.18.10/31, 13.107.6.152/31, 52.238.78.88/32, 104.47.0.0/17, 52.100.0.0/14, 40.107.0.0/16, 40.92.0.0/15, 150.171.40.0/22, 52.104.0.0/14, 104.146.128.0/17, 40.108.128.0/17, 13.107.136.0/22, 40.126.0.0/18, 20.231.128.0/19, 20.190.128.0/18, 20.20.32.0/19
  ```

7. Restart Cisco Umbrella client services or restart the machine where the clients are installed.

#### [Cisco Secure Access Portal](#tab/cisco-secure-access-portal)

1. Go to **Connect > End User Connectivity > Internet Security**.
2. In **Traffic Steering**, select **Add Destination > Bypass Secure Access**, add these FQDNs, and save:
  ```
  *.globalsecureaccess.microsoft.com
  ```
  > [!NOTE]
  > Cisco Secure Access has an implied wildcard, so you can use `globalsecureaccess.microsoft.com`.

3. Add these Microsoft FQDNs (only required if Microsoft traffic forwarding profile is enabled):
```
auth.microsoft.com, msftidentity.com, msidentity.com, onmicrosoft.com, outlook.com, protection.outlook.com, sharepoint.com, sharepointonline.com, svc.ms, wns.windows.com, account.activedirectory.windowsazure.com, accounts.accesscontrol.windows.net, admin.onedrive.com, adminwebservice.microsoftonline.com, api.passwordreset.microsoftonline.com, autologon.microsoftazuread-sso.com, becws.microsoftonline.com, ccs.login.microsoftonline.com, clientconfig.microsoftonline-p.net, companymanager.microsoftonline.com, device.login.microsoftonline.com, g.live.com, graph.microsoft.com, graph.windows.net, login-us.microsoftonline.com, login.microsoft.com, login.microsoftonline-p.com, login.microsoftonline.com, login.windows.net, logincert.microsoftonline.com, loginex.microsoftonline.com, nexus.microsoftonline-p.com, officeclient.microsoft.com, oneclient.sfx.ms, outlook.cloud.microsoft, outlook.office.com, outlook.office365.com, passwordreset.microsoftonline.com, provisioningapi.microsoftonline.com, spoprod-a.akamaihd.net
```
4. Add the Quick Access FQDN. `<quickaccessapplicationid>.globalsecureaccess.local`
   
  > [!NOTE]
  > Replace `<quickaccessapplicationid>` with the application ID of your Quick Access app.
  
  5. Add DNS suffixes defined in your Private DNS or Enterprise App segments. For example, if your Private DNS suffix is `contoso.local` and you have a private app at `contoso.com`, add both suffixes.

6. In **Traffic Steering**, select **Add Destination > Bypass web proxy only**, add these IPs and save:

  ```
    150.171.19.0/24, 150.171.20.0/24, 13.107.232.0/24, 13.107.233.0/24, 150.171.15.0/24, 150.171.18.0/24, 151.206.0.0/16, 6.6.0.0/16
  ```

7. Add these Microsoft IP addresses:
```
132.245.0.0/16, 204.79.197.215/32, 150.171.32.0/22, 131.253.33.215/32, 23.103.160.0/20, 40.96.0.0/13, 52.96.0.0/14, 40.104.0.0/15, 13.107.128.0/22, 13.107.18.10/31, 13.107.6.152/31, 52.238.78.88/32, 104.47.0.0/17, 52.100.0.0/14, 40.107.0.0/16, 40.92.0.0/15, 150.171.40.0/22, 52.104.0.0/14, 104.146.128.0/17, 40.108.128.0/17, 13.107.136.0/22, 40.126.0.0/18, 20.231.128.0/19, 20.190.128.0/18, 20.20.32.0/19
```

8. Restart Cisco Umbrella client services or restart the machine where the clients are installed.

---

## Configuration scenarios

### 1. Internet Access and Microsoft Access with Umbrella DNS security.


#### Steps

**Global Secure Access configuration:**
- Enable Internet Access and Microsoft Access forwarding profiles.
- Install and configure the Global Secure Access client for Windows or macOS.

**Cisco configuration:**
- Configure the required destinations bypasses. See instructions for [Umbrella portal](#tab-cisco-umbrella-portal) or [Cisco Secure Access portal](#tab-cisco-secure-access-portal).
- Disable the SWG for [Umbrella devices](https://docs.umbrella.com/umbrella-user-guide/docs/selective-enablement#disable-the-swg-module) or [Cisco Secure Access devices](https://docs.sse.cisco.com/sse-user-guide/docs/edit-roaming-devices-internet-security-settings#disable-the-internet-security-settings).

- Install and configure Cisco Secure Client software with the Umbrella module.

**Validation:**
- Ensure both clients are enabled and the Umbrella profile is `Active`.
- To verify rules are applied and health checks pass, use Advanced Diagnostics in the Global Secure Access client.
- Test traffic flow by accessing various sites and validating traffic logs in both platforms.
    1. In the system tray, right-click Global Secure Access Client > Advanced Diagnostics > Traffic tab > Start collecting.
    2. Access `bing.com`, `salesforce.com`, `yelp.com` in browsers.
    3. Verify Global Secure Access client **is** capturing traffic for these sites. We **do not** expect to see destination FQDN information for these sites in the traffic tab.
    4. In the Umbrella or Cisco Secure Access portal, validate DNS traffic to these sites **is** captured.
    5. Access `outlook.office365.com`, `<yourmicrosoftdomain>.sharepoint.com` in browsers.
    6. Verify Global Secure Access client **is** capturing traffic for these sites. We **do** expect to see destination FQDN information for these sites. 
    7. Access a site blocked by Cisco and validate that the Cisco block page is displayed.
    8. In Global Secure Access, stop collecting traffic and confirm correct traffic handling.

---

### 2. Internet Access, Microsoft Access, and Private Access with Cisco Umbrella DNS security.


#### Steps

**Global Secure Access configuration:**
- Enable Internet Access, Microsoft Access, and Private Access forwarding profiles.
- Install a private network connector.
- Configure Quick Access and Private DNS.
- Install and configure the Global Secure Access client for Windows or macOS.

**Cisco configuration:**
- Configure the required destinations bypasses. See instructions for [Umbrella portal](#tab/cisco-umbrella-portal) or [Cisco Secure Access portal](#tab/cisco-secure-access-portal).
- Disable the SWG for [Umbrella devices](https://docs.umbrella.com/umbrella-user-guide/docs/selective-enablement#disable-the-swg-module) or [Cisco Secure Access devices](https://docs.sse.cisco.com/sse-user-guide/docs/edit-roaming-devices-internet-security-settings#disable-the-internet-security-settings).
- Install and configure Cisco Secure Client software with the Umbrella module.

**Validation:**
- Ensure both clients are enabled and the Umbrella profile is `Active`.
- To verify rules are applied and health checks pass, use Advanced Diagnostics in the Global Secure Access client.
- Test traffic flow by accessing various sites and validating traffic logs in both platforms.
  1. In the system tray, right-click Global Secure Access Client > Advanced Diagnostics > Traffic tab > Start collecting.
  2. Access `bing.com`, `salesforce.com`, `yelp.com` in browsers.
  3. Verify Global Secure Access client **is** capturing traffic for these sites. We **don't** expect to see destination FQDN information for these sites in the traffic tab.
  4. In the Umbrella or Cisco Secure Access portal, validate DNS traffic to these sites **is** captured.
  5. Access `outlook.office365.com`, `<yourmicrosoftdomain>.sharepoint.com` in browsers.
  6. Verify Global Secure Access client **is** capturing traffic for these sites. We **do** expect to see destination FQDN information for these sites. 
  7. Access a site blocked by Cisco and validate that the Cisco block page is displayed.
  8. Access a Microsoft Entra private application (for example, SMB file share) and validate that Global Secure Access **is** capturing traffic and Cisco isn't.
  9. In Global Secure Access, stop collecting traffic and confirm correct traffic handling.



---

> [!NOTE]
> For troubleshooting health check failures, see [Troubleshoot the Global Secure Access client: Health check](troubleshoot-global-secure-access-client-diagnostics-health-check.md).

 

## Next steps

- [What is Global Secure Access?](overview-what-is-global-secure-access.md)

