---
title: Security Service Edge (SSE) Coexistence With Microsoft and Netskope
description: Learn how to configure and deploy Microsoft Entra and Netskope Security Service Edge (SSE) solutions together for optimized security and connectivity across private applications, Microsoft 365, and internet access.
author: kenwith
contributors:
ms.topic: concept-article
ms.date: 06/09/2025
ms.author: kenwith
ms.reviewer: shkhalid
ai-usage: ai-assisted
---

# Security Service Edge (SSE) Coexistence With Microsoft and Netskope

Learn about Security Service Edge (SSE) coexistence with Microsoft and Netskope

In today's rapidly evolving digital landscape, organizations require robust, and unified solutions to ensure secure and seamless connectivity. Microsoft and Netskope offer complementary Secure Access Service Edge (SASE) capabilities that, when integrated, provide enhanced security and connectivity for diverse access scenarios.

This guide outlines how to configure and deploy Microsoft Entra solutions alongside Netskope's Security Service Edge (SSE) offerings. By using the strengths of both platforms, you can optimize your organization's security posture while maintaining high-performance connectivity for private applications, Microsoft 365 traffic, and internet access.

**[Configuration 1: Microsoft Entra Private Access with Netskope Internet Access](#configuration-1-microsoft-entra-private-access-with-netskope-internet-access)**

In the first scenario, Global Secure Access handles private application traffic. Netskope only captures Internet traffic.

**[Configuration 2: Microsoft Entra Private Access with Netskope Private Access and Netskope Internet Access](#configuration-2-microsoft-entra-private-access-with-netskope-private-access-and-netskope-internet-access)**

In the second scenario, both clients handle traffic for separate private applications. Global Secure Access handles private applications in Microsoft Entra Private Access. Private applications in Netskope Private Access are accessed through the Netskope client. Netskope handles Internet traffic.

**[Configuration 3: Microsoft Entra Microsoft Access with Netskope Private Access and Netskope Internet Access](#configuration-3-microsoft-entra-microsoft-access-with-netskope-private-access-and-netskope-internet-access)**

In the third scenario, Global Secure Access handles all Microsoft 365 traffic. Netskope handles private application and Internet traffic.

**[Configuration 4: Microsoft Entra Internet Access and Microsoft Entra Microsoft Access with Netskope Private Access](#configuration-4-microsoft-entra-internet-access-and-microsoft-entra-microsoft-access-and-with-netskope-private-access)**

In the fourth scenario, Global Secure Access handles Internet and Microsoft 365 traffic. Netskope only captures Private application traffic.

## Prerequisites

To configure Microsoft and Netskope for a unified SASE solution, start by setting up Microsoft Entra Internet Access and Microsoft Entra Private Access. Next, configure Netskope Private Access and Internet Access. Finally, make sure to establish the required Fully Qualified Domain Name (FQDN) and IP bypasses to ensure smooth integration between the two platforms.

- Set up Microsoft Entra Internet Access and Microsoft Entra Private Access. These products make up the Global Secure Access solution.

- Set up Netskope Private Access and Internet Access

- Configure the Global Secure Access FQDN and IP bypasses

## Microsoft Global Secure Access

To set up Global Secure Access and test all scenarios in this documentation:

- Enable and disable different Microsoft Global Secure Access traffic forwarding profiles for your Microsoft Entra tenant. For more information about enabling and disabling profiles, see [Global Secure Access traffic forwarding profiles](/entra/global-secure-access/concept-traffic-forwarding).

- Install and configure the Microsoft Entra private network connector. To learn how to install and configure the connector, see [How to configure connectors](/entra/global-secure-access/how-to-configure-connectors).

> [!NOTE]
> Private Network Connectors are required for Microsoft Entra Private Access applications.

- Configure Quick Access to your private resources and set up Private Domain Name System (DNS) and DNS suffixes. To learn how to configure Quick Access, see [How to configure Quick Access](/entra/global-secure-access/how-to-configure-quick-access).

- Install and configure the Global Secure Access client on end-user devices. For more information about clients, see [Global Secure Access clients](/entra/global-secure-access/concept-clients). To learn how to install the Windows client, see [Global Secure Access client for Windows](/entra/global-secure-access/how-to-install-windows-client). For macOS, see [Global Secure Access Client for macOS](/entra/global-secure-access/how-to-install-macos-client).

## Netskope Private Access and Internet Access

- Configure Netskope Private Apps. To learn more about configuring Netskope Private Access, see [Netskope One Private Access](https://docs.netskope.com/en/netskope-private-access) documentation.

- Configure Netskope Steering Configurations for Private and Internet Access. To learn more about configuring Netskope, see [Netskope Traffic Steering documentation](https://docs.netskope.com/en/creating-a-steering-configuration/). The steps for creating the required steering configurations for each scenario are listed.

- Setup and configure Netskope Real-time Protection Policies to allow access to Private Apps. For more information, see [Netskope Real-time Protection Policy for Private Apps](https://docs.netskope.com/en/create-a-real-time-protection-policy-for-private-apps/).

- Invite users to Netskope and send them an email containing links to the Netskope client install package. To invite users, navigate to the **Netskope portal** > **Settings** > **Security** **Cloud** **Platform** > **Users**.

## Netskope Location Profiles

Create network location profiles to bypass Microsoft SSE service Internet Protocol (IP) addresses and Microsoft 365 destination IPs.

Configure the `Microsoft SSE Service` policy:

1. Navigate to **Policies** > **Profiles** > **Network Location** > **New Network Location** > **Single Object**.
1. Add the routes and save them as `MSFT SSE Service`:  
    `150.171.19.0/24`, `150.171.20.0/24`, `13.107.232.0/24`, `13.107.233.0/24`, `150.171.15.0/24`, `150.171.18.0/24`, `151.206.0.0/16`, `6.6.0.0/16`.

Configure the `MSFT SSE M365` policy:

1. Repeat Steps 1 & 2 to Add Microsoft 365 IPs and save them as `MSFT SSE M365`:  
    `132.245.0.0/16`, `204.79.197.215/32`, `150.171.32.0/22`, `131.253.33.215/32`, `23.103.160.0/20`, `40.96.0.0/13`, `52.96.0.0/14`, `40.104.0.0/15`, `13.107.128.0/22`, `13.107.18.10/31`, `13.107.6.152/31`, `52.238.78.88/32`, `104.47.0.0/17`, `52.100.0.0/14`, `40.107.0.0/16`, `40.92.0.0/15`, `150.171.40.0/22`, `52.104.0.0/14`, `104.146.128.0/17`, `40.108.128.0/17`, `13.107.136.0/22`, `40.126.0.0/18`, `20.231.128.0/19`, `20.190.128.0/18`, `20.20.32.0/19`.

The `MSFT SSE Service` and `MSFT SSE M365` profiles are used in steering configurations.

## Configuration 1: Microsoft Entra Private Access with Netskope Internet Access

In this scenario, Global Secure Access handles private application traffic. Netskope only captures Internet traffic.

### Microsoft Entra Private Access configuration

For this scenario:

- [Enable Microsoft Entra Private Access forwarding profile](https://github.com/MicrosoftDocs/entra-docs/blob/main/docs/global-secure-access/how-to-manage-private-access-profile.md#enable-the-private-access-traffic-forwarding-profile).

- Install a [Private Network Connector](/entra/global-secure-access/how-to-configure-connectors) for Microsoft Entra Private Access.

- Configure [Quick Access and set up Private DNS](/entra/global-secure-access/how-to-configure-quick-access).

- Install and configure the [Global Secure Access client for Windows](/entra/global-secure-access/how-to-install-windows-client) or [macOS](/entra/global-secure-access/how-to-install-macos-client).

### Netskope Internet Access configuration

Netskope portal configuration

- Set up and configure [Netskope Steering Configuration](https://docs.netskope.com/en/steering-configuration/) to steer Web Traffic.

- Install the Netskope Client for [Windows](https://docs.netskope.com/en/netskope-client-for-windows), or [macOS](https://docs.netskope.com/en/netskope-client-for-macos).

#### Add Steering Configuration for Internet Access

1. Navigate to **Netskope portal** > **Settings** > **Security Cloud Platform** > **Steering Configuration** > **New Configuration**.

1. Add a Configuration Name such as `MSFTSSEWebTraffic`.

1. Choose a **User Group** or **OU** to apply the configuration to.

1. Under **Cloud, Web and Firewall** > **Web Traffic**

1. **Bypass exception traffic at** > **Client**

1. Under **Private Apps** > **None**.

1. Under **Borderless SD-WAN Apps** > **None**.

1. Set **Status** to **Disabled** and select **Save**.

1. Select the `MSFTSSEWebTraffic` configuration > **Exceptions** > **New Exception** > **Destination Locations**.

1. Select `MSFT SSE Service` (Instructions for creating this object are listed in the Netskope profiles section).

1. The action is **Bypass** > check the box for **Treat it like local IP address** > **Add**.

1. Select **New Exception** > **Domains** and add the Global Secure Access domain exception: \*.globalsecureaccess.microsoft.com > **Save**

1. Ensure that the `MSFTSSEWebTraffic` configuration is at the top of the list of steering configurations in your tenant. Then enable the configuration.

1. Go to the system tray to check that Global Secure Access and Netskope clients are enabled.

#### Verify configurations for clients

1. Right-click on **Global Secure Access Client** > **Advanced Diagnostics** > **Forwarding Profile** and verify that Private access and Private DNS rules are applied to this client.

1. Navigate to **Advanced Diagnostics** > **Health Check** and ensure no checks are failing.

1. Right-click on **Netskope Client** > **Configuration**. Verify **Steering Configuration** matches the name of the configuration. If not, select the **Update** link.

> [!NOTE]
> For information troubleshooting health check failures: [Troubleshoot the Global Secure Access client: Health check - Global Secure Access | Microsoft Learn](/entra/global-secure-access/troubleshoot-global-secure-access-client-diagnostics-health-check).


#### Test traffic flow

1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. Select the **Traffic** tab and select **Start collecting**.

1. Access these websites from the browsers: `bing.com`, `salesforce.com`, `Instagram.com`.

1. In the system tray, right-click **Global Secure Access Client** and select **Advanced Diagnostics** > **Traffic** **tab**.

1. Scroll to observe that the Global Secure Access client **isn't** capturing traffic from these websites.

1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access** > **Monitor** > **Traffic logs**. Validate traffic related to these sites is missing from the Global Secure Access traffic logs.

1. Sign in to Netskope portal and browse to **Skope IT** > **Events & Alerts** > **Page Events**. Validate traffic related to these sites **is** present in Netskope logs.

1. Access your private application set up in Microsoft Entra Private Access. For example, access a File Share via Server Message Block (SMB).

1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access** > **Monitor** > **Traffic logs**. Validate traffic related to File Share **is** captured in the Global Secure Access traffic logs.

1. Sign in to Netskope portal and browse to **Skope IT** > **Events & Alerts** > **Network Events**. Validate traffic related to the private application **is not** present in the traffic logs.

1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. In the **Traffic** dialog box, select **Stop collecting**.

1. Scroll to confirm the Global Secure Access client handled only private application traffic.

## Configuration 2: Microsoft Entra Private Access with Netskope Private Access and Netskope Internet Access

In this scenario, both clients handle traffic for separate private applications. The Global Secure Access client handles private applications in Microsoft Entra Private Access and the Netskope client handles private applications in Netskope Private Access. Netskope handles internet traffic.

> [!NOTE]
> Known limitation – When the macOS Global Secure Access client is connected before the Netskope client Global Secure Access functionality is disrupted.

### Microsoft Entra Private Access configuration

For this scenario:

- [Enable Microsoft Entra Private Access forwarding profile](https://github.com/MicrosoftDocs/entra-docs/blob/main/docs/global-secure-access/how-to-manage-private-access-profile.md#enable-the-private-access-traffic-forwarding-profile).

- Install a [Private Network Connector](/entra/global-secure-access/how-to-configure-connectors) for Microsoft Entra Private Access.

- Configure [Quick Access and set up Private DNS](/entra/global-secure-access/how-to-configure-quick-access).

- Install and configure the [Global Secure Access client for Windows](/entra/global-secure-access/how-to-install-windows-client).

### Netskope Private Access and Netskope Internet Access configuration

In the Netskope portal:

- Set up and configure [Netskope Steering Configuration](https://docs.netskope.com/en/steering-configuration/) to steer Web Traffic and Private Apps.

- Install the Netskope Client for [Windows](https://docs.netskope.com/en/netskope-client-for-windows).

- Create [Real-time Protection policy](https://docs.netskope.com/en/inline-policies/) to allow access to Private Apps.

- Install the [Netskope Private Access Publisher](https://docs.netskope.com/en/deploy-a-publisher).

#### Add Steering Configuration for Internet Access and Private Apps

1. Navigate to **Netskope portal** > **Settings** > **Security Cloud Platform** > **Steering Configuration**> **New Configuration**.

1. Add a **Configuration Name** such as `MSFTSSEWebAndPrivate`.

1. Choose a **User Group** or **OU** to apply the configuration to.

1. Under **Cloud, Web and Firewall** > **Web Traffic**

1. **Bypass exception traffic at** > **Client**

1. Under **Private Apps**, select **Specific Private Apps**.

1. On the next line > **Netskope will** > **Steer**

1. Under **Borderless SD-WAN Apps** > **None**.

1. Set **Status** to **Disabled** and select **Save**.

1. Select the `MSFTSSEWebAndPrivate` configuration > **Exceptions** > **New Exception** > **Destination Locations**.

1. Select `MSFT SSE Service` (Instructions for creating this object are listed in the Netskope profiles section).

1. The action is **Bypass** > check the box for **Treat it like local IP address** > Add.

1. Select **New Exception** > **Domains** and add the Global Secure Access domain exception: \*.globalsecureaccess.microsoft.com > **Save**.

1. Select **Add Steered Item**.

1. Select **Private App** and select the private applications for Netskope to steer > **Add**.

1. Ensure that the `MSFTSSEWebAndPrivate` configuration is at the top of the list of steering configurations in your tenant. Then enable the configuration.

#### Add Netskope Private App Real-time Protection Policy

1. Navigate to **Netskope Portal** > **Policies** > **Real-time Protection**.

1. Select **New** **Policy** > **Private** **App** **Access**.

1. In **Source**, select the **Users**, **Groups**, or **OUs** to grant access.

1. Add any required **Criteria**, like OS or Device Classification.

1. In **Destination** > **Private** **App** > select Private Apps to allow access to.

1. In **Profile & Action** > **Allow**.

1. Give the policy a name such as `Private Apps` and put it in the **Default** group.

1. Set **Status** to Enabled.
1. Go to the system tray to check that Global Secure Access and Netskope clients are enabled.

#### Verify configurations for clients

1. Right-click on **Global Secure Access Client** > **Advanced Diagnostics** > **Forwarding Profile** and verify that Private access and Private DNS rules are applied to this client.

1. Navigate to **Advanced Diagnostics** > **Health Check** and ensure no checks are failing.

1. Right-click on **Netskope Client** > **Configuration**. Verify **Steering Configuration** matches the name of the configuration created. If not, select the **Update** link.

> [!NOTE]
> For information troubleshooting health check failures: [Troubleshoot the Global Secure Access client: Health check - Global Secure Access | Microsoft Learn](/entra/global-secure-access/troubleshoot-global-secure-access-client-diagnostics-health-check).

#### Test traffic flow

1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. Select the **Traffic** tab and select **Start collecting**.

1. Access these websites from the browsers: `bing.com`, `salesforce.com`, `yelp.com`.

1. In the system tray, right-click **Global Secure Access Client** and select **Advanced Diagnostics** > **Traffic tab**.

1. Scroll to observe that the Global Secure Access client **isn't** capturing traffic from these websites.

1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access** > **Monitor** > **Traffic** **logs**. Validate traffic related to these sites is missing from the Global Secure Access traffic logs.

1. Sign in to Netskope portal and browse to **Skope IT** > **Events & Alerts** > **Page Events**. Validate traffic related to these sites **is** present in Netskope logs.

1. Access your private application set up in Microsoft Entra Private Access. For example, access a File Share via SMB.

1. Access your private application set up in Netskope Private Access. For example, open an RDP session to a private server.

1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access** > **Monitor** > **Traffic logs**.

1. Validate traffic related to the SMB file share private app **is** captured and that traffic related to the RDP session **isn't** captured in the Global Secure Access traffic logs.

1. Sign in to Netskope portal and browse to **Skope IT** > **Events & Alerts** > **Network Events**. Validate traffic related to the **RDP** session **is** present and that traffic related to the **SMB** file share **isn't** in the Netskope logs.

1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. In the **Traffic** dialog box, select **Stop collecting**.

1. Scroll to confirm the Global Secure Access client handled private application traffic for the SMB file share and didn't handle the RDP session traffic.

## Configuration 3: Microsoft Entra Microsoft Access with Netskope Private Access and Netskope Internet Access

In this scenario, Global Secure Access handles all Microsoft 365 traffic. Netskope Private Access handles Private application traffic and Netskope Internet Access handles Internet traffic.

> [!NOTE]
> Known limitation – When the macOS Global Secure Access client is connected before the Netskope client Global Secure Access functionality is disrupted.

### Microsoft Entra Microsoft Access configuration

For this scenario:

- [Enable Microsoft Entra Private Access forwarding profile](https://github.com/MicrosoftDocs/entra-docs/blob/main/docs/global-secure-access/how-to-manage-private-access-profile.md#enable-the-private-access-traffic-forwarding-profile).

- Install and configure the [Global Secure Access client for Windows](/entra/global-secure-access/how-to-install-windows-client).

### Netskope Private Access and Netskope Internet Access configuration

In the Netskope portal:

- Set up and configure [Netskope Steering Configuration](https://docs.netskope.com/en/steering-configuration/) to steer Web Traffic and Private Apps.

- Install the Netskope Client for [Windows](https://docs.netskope.com/en/netskope-client-for-windows).

- Create [Real-time Protection policy](https://docs.netskope.com/en/inline-policies/) to allow access to Private Apps.

- Install the [Netskope Private Access Publisher](https://docs.netskope.com/en/deploy-a-publisher).

#### Add Steering Configuration for Internet Access and Private Apps

1. Navigate to **Netskope portal** > **Settings** > **Security Cloud Platform** > **Steering Configuration**> **New Configuration**.

1. Add a **Configuration Name** such as `MSFTSSEWebAndPrivate-NoM365`.

1. Choose a User Group or OU to apply the configuration to.

1. Under **Cloud, Web and Firewall** > **Web Traffic.**

1. **Bypass exception traffic at** > **Client.**

1. Under **Private Apps**, select **Specific Private Apps**.

1. On the next line > **Netskope will** > **Steer.**

1. Under **Borderless SD-WAN Apps** > **None**.

1. Set **Status** to **Disabled** and select **Save**.

1. Select the `MSFTSSEWebAndPrivate-NoM365` configuration > **Exceptions** > **New Exception** > **Destination Locations**.
1. Select `MSFT SSE Service` and `MSFT SSE M365` (Instructions for creating this object are listed in the Netskope profiles section).

1. Select **Bypass** and **Treat it like local IP address** options.

1. Select **Exceptions** > **New Exception** > **Domains** and add these exceptions: `*.globalsecureaccess.microsoft.com`, `*.auth.microsoft.com`, `*.msftidentity.com`, `*.msidentity.com`, `*.onmicrosoft.com`, `*.outlook.com`, `*.protection.outlook.com`, `*.sharepoint.com`, `*.sharepointonline.com`, `*.svc.ms`, `*.wns.windows.com`, `account.activedirectory.windowsazure.com`, `accounts.accesscontrol.windows.net`, `admin.onedrive.com`, `adminwebservice.microsoftonline.com`, `api.passwordreset.microsoftonline.com`, `autologon.microsoftazuread-sso.com`, `becws.microsoftonline.com`, `ccs.login.microsoftonline.com`, `clientconfig.microsoftonline-p.net`, `companymanager.microsoftonline.com`, `device.login.microsoftonline.com`, `g.live.com`, `graph.microsoft.com`, `graph.windows.net`, `login-us.microsoftonline.com`, `login.microsoft.com`, `login.microsoftonline-p.com`, `login.microsoftonline.com`, `login.windows.net`, `logincert.microsoftonline.com`, `loginex.microsoftonline.com`, `nexus.microsoftonline-p.com`, `officeclient.microsoft.com`, `oneclient.sfx.ms`, `outlook.cloud.microsoft`, `outlook.office.com`, `outlook.office365.com`, `passwordreset.microsoftonline.com`, `provisioningapi.microsoftonline.com`, `spoprod-a.akamaihd.net`.

1. Select **Add Steered Item** > Select **Private App** and select the private applications for Netskope to steer > **Add**.

1. Ensure that the `MSFTSSEWebAndPrivate-NoM365` configuration is at the top of the list of steering configurations in your tenant. Then enable the configuration.

#### Add Netskope Private App Real-time Protection Policy

1. Navigate to **Netskope Portal** > **Policies** > **Real-time Protection**.

1. Select **New** **Policy** > **Private** **App** **Access**.

1. In **Source**, select the **Users**, **Groups**, or **OUs** to grant access.

1. Add any required **Criteria**, like OS or Device Classification.

1. In **Destination** > **Private** **App** > select Private Apps to allow access to.

1. In **Profile & Action** > **Allow**.

1. Give the policy a name such as `Private Apps` and put it in the **Default** group.

1. Set **Status** to Enabled.

Go to the system tray to check that Global Secure Access and Netskope clients are enabled.

#### Verify configurations for clients

1. Right-click on **Global Secure Access Client** > **Advanced Diagnostics** > **Forwarding Profile** and verify that only Microsoft 365 rules are applied to this client.

1. Navigate to **Advanced Diagnostics** > **Health Check** and ensure no checks are failing.

1. Right-click on **Netskope Client** > **Configuration**. Verify **Steering Configuration** matches the name of the configuration created. If not, select the **Update** link.

> [!NOTE]
> For information troubleshooting health check failures: [Troubleshoot the Global Secure Access client: Health check - Global Secure Access | Microsoft Learn](/entra/global-secure-access/troubleshoot-global-secure-access-client-diagnostics-health-check).

#### Test traffic flow

1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. Select the **Traffic** tab and select **Start collecting**.

1. Access these websites from the browsers: `bing.com`, `salesforce.com`, `yelp.com`.

1. In the system tray, right-click **Global Secure Access Client** and select **Advanced Diagnostics** > **Traffic tab**.

1. Scroll to observe that the Global Secure Access client **isn't** capturing traffic from these websites.

1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access** > **Monitor** > **Traffic logs**. Validate traffic related to these sites is missing from the Global Secure Access traffic logs.

1. Sign in to Netskope portal and browse to **Skope IT** > **Events & Alerts** > **Page Events**.

1. Validate traffic related to these sites **is** present in Netskope logs.

1. Access your private application set up in Netskope Private Access. For example, open an RDP session to a private server.

1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access** > **Monitor** > **Traffic logs**.

1. Validate traffic related to the RDP session **isn’t** in the Global Secure Access traffic logs.

1. Sign in to Netskope portal and browse to **Skope IT** > **Events & Alerts** > **Network Events**. Validate traffic related to the **RDP** session **is** present.

1. Access Outlook Online (`outlook.com`, `outlook.office.com`, `outlook.office365.com`), SharePoint Online (`<yourtenantdomain>.sharepoint.com`).

1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. In the **Traffic** dialog box, select **Stop collecting**.

1. Scroll to confirm the Global Secure Access client handled only Microsoft 365 traffic.

1. You can also validate that the traffic is captured in the Global Secure Access traffic logs. In the Microsoft Entra admin center, navigate to **Global Secure Access** > **Monitor** > **Traffic logs**.

1. Validate traffic related to Outlook Online and SharePoint Online is missing from Netskope portal in **Skope IT** > **Events & Alerts** > **Page Events**.

## Configuration 4: Microsoft Entra Internet Access and Microsoft Entra Microsoft Access and with Netskope Private Access

In this scenario Netskope only captures private application traffic. Global Secure Access handles all other traffic.

### Microsoft Entra Internet Access and Microsoft Access configuration

For this scenario:

- [Enable Microsoft Entra Microsoft Access](https://github.com/MicrosoftDocs/entra-docs/blob/main/docs/global-secure-access/how-to-manage-microsoft-profile.md#enable-the-microsoft-traffic-profile) and [Microsoft Entra Internet Access forwarding profiles](https://github.com/MicrosoftDocs/entra-docs/blob/main/docs/global-secure-access/how-to-manage-internet-access-profile.md#prerequisites).

- Install and configure the [Global Secure Access client for Windows](/entra/global-secure-access/how-to-install-windows-client) or [macOS](/entra/global-secure-access/how-to-install-macos-client).

- Add a Microsoft Entra Internet Access traffic forwarding profile custom bypass to exclude Netskope service FQDN and IPs.

#### Add a custom bypass for Netskope in Global Secure Access

1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access** > **Connect** > **Traffic forwarding** > **Internet access profile**.

1. Under **Internet access policies** > Select **View**.

1. Expand **Custom Bypass** > Select **Add rule**

1. Leave destination type **FQDN** and in Destination enter `*.goskope.com` > **Save**

1. Select **Add rule** again > **IP Range** > **Add** the IP ranges (each range is a new rule): `163.116.128.0..163.116.255.255`, `162.10.0.0..162.10.127.255`, `31.186.239.0..31.186.239.255`, `8.39.144.0..8.39.144.255`, `8.36.116.0..8.36.116.255`

1. Select **Save**.

### Netskope Private Access configuration

In the Netskope portal:

- Set up and configure [Netskope Steering Configuration](https://docs.netskope.com/en/steering-configuration/) to steer Web Traffic and Private Apps.

- Install the Netskope Client for [Windows](https://docs.netskope.com/en/netskope-client-for-windows), or [macOS](https://docs.netskope.com/en/netskope-client-for-macos).

- Create [Real-time Protection policy](https://docs.netskope.com/en/inline-policies/) to allow access to Private Apps.

- Install the [Netskope Private Access Publisher](https://docs.netskope.com/en/deploy-a-publisher).

#### Add Steering Configuration for Internet Access and Private Apps

1. Navigate to **Netskope portal** > **Settings** > **Security Cloud Platform** > **Steering Configuration**> **New Configuration**.

1. Add a **Configuration Name** such as `MSFTSSEPrivate`.

1. Choose a **User Group** or **OU** to apply the configuration to.

1. Under **Cloud, Web and Firewall** > **Web Traffic.**

1. **Bypass exception traffic at** > **Client.**

1. Under **Private Apps**, select **Specific Private Apps**.

1. On the next line > **Netskope will** > **Steer.**

1. Under **Borderless SD-WAN Apps** > **None**.

1. Set **Status** to **Disabled** and select **Save**.

1. Select the `MSFTSSEPrivate` configuration > **Exceptions** > **New Exception** > **Destination Locations** > Select `MSFT SSE Service` and `MSFT SSE M365` (Instructions for creating this object are listed in the Netskope profiles section).

1. Select **Bypass** and **Treat it like local IP address** options.

1. Select **Exceptions** > **New Exception** > **Domains** and add these exceptions: `*.globalsecureaccess.microsoft.com`, `*.auth.microsoft.com`, `*.msftidentity.com`, `*.msidentity.com`, `*.onmicrosoft.com`, `*.outlook.com`, `*.protection.outlook.com`, `*.sharepoint.com`, `*.sharepointonline.com`, `*.svc.ms`, `*.wns.windows.com`, `account.activedirectory.windowsazure.com`, `accounts.accesscontrol.windows.net`, `admin.onedrive.com`, `adminwebservice.microsoftonline.com`, `api.passwordreset.microsoftonline.com`, `autologon.microsoftazuread-sso.com`, `becws.microsoftonline.com`, `ccs.login.microsoftonline.com`, `clientconfig.microsoftonline-p.net`, `companymanager.microsoftonline.com`, `device.login.microsoftonline.com`, `g.live.com`, `graph.microsoft.com`, `graph.windows.net`, `login-us.microsoftonline.com`, `login.microsoft.com`, `login.microsoftonline-p.com`, `login.microsoftonline.com`, `login.windows.net`, `logincert.microsoftonline.com`, `loginex.microsoftonline.com`, `nexus.microsoftonline-p.com`, `officeclient.microsoft.com`, `oneclient.sfx.ms`, `outlook.cloud.microsoft`, `outlook.office.com`, `outlook.office365.com`, `passwordreset.microsoftonline.com`, `provisioningapi.microsoftonline.com`, `spoprod-a.akamaihd.net`.

1. Select **Add Steered Item** > Select **Private App** and select the private applications for Netskope to steer > **Add**.

1. Ensure that the `MSFTSSEPrivate` configuration is at the top of the list of steering configurations in your tenant. Then enable the configuration

#### Add Netskope Private App Real-time Protection Policy

1. Navigate to **Netskope Portal** > **Policies** > **Real-time Protection**.

1. Select **New** **Policy** > **Private** **App** **Access**.

1. In **Source**, select the **Users**, **Groups**, or **OUs** to grant access.

1. Add any required **Criteria**, like OS or Device Classification.

1. In **Destination** > **Private** **App** > select Private Apps to allow access to.

1. In **Profile & Action** > **Allow**.

1. Give the policy a name such as `Private Apps` and put it in the **Default** group.

1. Set **Status** to Enabled.

Go to the system tray to check that Global Secure Access and Netskope clients are enabled.

#### Verify configurations for clients

1. Right-click on **Global Secure Access Client** > **Advanced Diagnostics** > **Forwarding Profile** and verify that Microsoft Access and Internet Access rules are applied to this client.

1. Navigate to **Advanced Diagnostics** > **Health Check** and ensure no checks are failing.

1. Right-click on **Netskope Client** > **Configuration**. Verify **Steering Configuration** matches the name of the configuration created. If not, select the **Update** link.

> [!NOTE]
> For information troubleshooting health check failures: [Troubleshoot the Global Secure Access client: Health check - Global Secure Access | Microsoft Learn](/entra/global-secure-access/troubleshoot-global-secure-access-client-diagnostics-health-check).

#### Test traffic flow

1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. Select the **Traffic** tab and select **Start collecting**.

1. Access these websites from the browsers: `bing.com`, `salesforce.com`, `Instagram.com`, Outlook Online (`outlook.com`, `outlook.office.com`, `outlook.office365.com`), SharePoint Online (`<yourtenantdomain>.sharepoint.com`).

1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access** > **Monitor** > **Traffic logs**. Validate traffic related to these sites **is** captured in the Global Secure Access traffic logs.

1. Access your private application set up in Netskope Private Apps. For example, using Remote Desktop (RDP).

1. Sign in to Netskope portal and browse to **Skope IT** > **Events & Alerts** > **Network Events**. Validate traffic related to the **RDP** session **is** present and that traffic related to Microsoft 365 and Internet Traffic such as Instagram.com, Outlook Online, and SharePoint Online is missing from Netskope Portal.

1. In the system tray, right-click **Global Secure Access Client** and then select **Advanced Diagnostics**. In the network **traffic** dialog box, select **Stop collecting**.

1. Scroll to observe that the Global Secure Access client **isn't** capturing traffic from the private application. Also, observe that the Global Secure Access client is capturing traffic for Microsoft 365 and other internet traffic.
