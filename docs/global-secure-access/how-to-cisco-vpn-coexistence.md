---
title: Security Service Edge (SSE) Coexistence With Microsoft and Cisco VPNs
description: Microsoft and Cisco VPNs coexistence solution guide.
ms.topic: how-to
ms.date: 10/06/2025
ms.subservice: entra-private-access
ms.reviewer: shkhalid
ai-usage: ai-assisted
---

# Security Service Edge (SSE) coexistence with Microsoft and Cisco VPNs

Organizations require robust, unified solutions to ensure secure and seamless connectivity. Microsoft Secure Access Service Edge (SASE) capabilities that, when integrated with Cisco Virtual Private Networks (VPN), provide enhanced security and connectivity for diverse access scenarios.

This guide outlines how to configure and deploy Microsoft Entra solutions alongside Cisco VPN offerings. By using both platforms, you can optimize your organization's security posture while maintaining high-performance connectivity for private applications, Microsoft 365 traffic, and internet access.

## Cisco remote access VPN platforms

This guide focuses on two Cisco remote access VPN platforms:

- **[Cisco Secure Access VPN-as-a-Service (VPNaaS)](#cisco-secure-access-vpnaas)** 
- **[Cisco Adaptive Security Appliance (ASA) Remote Access VPN](#cisco-asa-remote-access-vpn)**

## Cisco Secure Access VPNaaS

### Cisco Secure Access VPNaaS - scenarios
1.  **[Microsoft Entra Internet Access and Microsoft Access with Cisco Secure Access VPNaaS for private access](#1-microsoft-entra-internet-access-and-microsoft-access-with-cisco-secure-access-vpnaas-for-private-access).**
Global Secure Access handles internet and Microsoft traffic. Cisco Secure Access VPNaaS captures only private application traffic.

2.  **[Microsoft Entra Private Access, Internet Access, and Microsoft Access with Cisco Secure Access VPNaaS](#2-microsoft-entra-private-access-internet-access-and-microsoft-access-with-cisco-secure-access-vpn-for-private-access).**
Both clients handle traffic for separate private applications. Global Secure Access handles private applications in Microsoft Entra Private Access, while private applications hosted through Cisco Secure Access VPNaaS are accessed through Cisco Secure Client VPN. Global Secure Access handles internet and Microsoft traffic.

### Cisco Secure Access VPNaaS - prerequisites

To configure Microsoft and Cisco Secure Access VPNaaS for a unified SASE solution:

1. Set up Microsoft Entra Internet Access and Microsoft Entra Private Access. These products make up the Global Secure Access solution.
1. Establish connectivity to Cisco Secure Access VPNaaS.
1. Set up a Cisco remote access VPN profile.
1. Configure fully qualified domain name (FQDN) and IP bypasses (instructions below).

### Cisco Secure Access VPNaaS - Global Secure Access setup

1. Enable and disable different traffic forwarding profiles for your Microsoft Entra tenant. For more information, see [Global Secure Access traffic forwarding profiles](concept-traffic-forwarding.md).
1. Install and configure the Microsoft Entra private network connector. See [How to configure connectors](how-to-configure-connectors.md).
    > [!NOTE] 
    > Private network connectors are required for Microsoft Entra Private Access applications.
1. Configure Quick Access to private resources and set up private Domain Name System (DNS) and DNS suffixes. See [How to configure Quick Access](how-to-configure-quick-access.md).
1. Install and configure the Global Secure Access client on end-user devices. See [Global Secure Access clients](concept-clients.md). <a id="adding-a-custom-bypass"></a>
1. Add an Internet Access traffic forwarding profile custom bypass to exclude Cisco Secure Access VPNaaS service FQDN.
    1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access > Connect > Traffic forwarding > Internet access profile**.
    2. Under Internet access policies, select **View**.
    3. Expand **Custom Bypass** and select **Add rule**.
    4. Leave destination type as FQDN and enter the Cisco Secure Access VPN head end service domain, `*.vpn.sse.cisco.com` in Destination.
    5. Select **Save**.

### Cisco Secure Access VPNaaS - Cisco Secure Access setup

#### Split-Include configuration

1. Configure the VPN profile Traffic Steering:
    1. From the Cisco Secure Access portal, go to **Connect > End User Connectivity > Virtual Private Network**.
    2. Select your VPN Profile, then **Traffic Steering**.
    3. In Tunnel Mode, select **Bypass Secure Access** and add exceptions (what to tunnel) for your private application subnets and the Global Secure Access synthetic IP range, `6.6.0.0/16`.
    4. In DNS Mode, select **Split DNS** and add the domain suffix of your private applications.
1. Install the Cisco Secure Client software.

> [!NOTE]
> Currently **Split-Include** is the only supported Cisco Secure Access VPNaaS configuration.

## Cisco Secure Access VPNaaS - configuration scenarios

### 1. Microsoft Entra Internet Access and Microsoft Access with Cisco Secure Access VPNaaS for private access

> [!IMPORTANT]
> A side-build of the Global Secure Access client for macOS is required for this specific scenario. Please contact support for more information.

**Global Secure Access configuration:**
1. Enable Microsoft Entra Internet Access and Microsoft Access forwarding profiles.
1. Install and configure the Global Secure Access client for Windows or macOS.
1. Add an Internet Access traffic forwarding profile custom bypass to exclude Cisco Secure Access VPNaaS service. [Instructions above.](#adding-a-custom-bypass)

**Cisco configuration:**
1. Set up remote access VPN profile as [described previously](#split-include-configuration).
1. Install Cisco Secure Client with VPN.

**Validation:**
1. Ensure both clients are enabled.
1. To verify rules are applied and health checks pass, use Advanced Diagnostics in the Global Secure Access client.
1. Test traffic flow by accessing various sites and validating traffic logs in both platforms.
    1. In the system tray, right-click **Global Secure Access Client** > **Advanced Diagnostics** > **Traffic tab** > **Start collecting**.
    2. Access websites: `bing.com`, `salesforce.com`, `outlook.office365.com`.
    3. Verify Global Secure Access client captures traffic from these sites.
    4. In Microsoft Entra admin center, go to **Global Secure Access > Monitor > Traffic logs**. Validate traffic is logged.
    5. In Cisco Secure Access portal, go to **Monitor > Activity Search**. Validate traffic to these websites **isn't** captured.
    6. Access private resources via Cisco Secure Client (for example, RDP session).
    7. Validate RDP traffic is missing from Global Secure Access traffic logs and present in Cisco Secure Access logs.
    8. Stop collecting traffic in Global Secure Access client and validate no private application traffic was captured.

### 2. Microsoft Entra Private Access, Internet Access, and Microsoft Access with Cisco Secure Access VPN for private access

**Global Secure Access configuration:**
1. Enable Microsoft Entra Internet Access, Private Access, and Microsoft Access forwarding profiles.
1. Install a private network connector for Microsoft Entra Private Access.
1. Configure Quick Access and set up Private DNS.
1. Create an app segment, for example an SMB file share. This will be the application you want to access through Global Secure Access and not Cisco VPN.
1. Add an Internet Access traffic forwarding profile [custom bypass](#adding-a-custom-bypass) to exclude Cisco Secure Access VPNaaS endpoint.
1. Install and configure the Global Secure Access client for Windows or macOS.

**Cisco configuration:**
1. Set up remote access VPN profile as [described previously](#split-include-configuration).
1. Ensure that in step 1 you have configured applications to access through Cisco ASA VPN, for example an RDP server. This should be different apps than configured in Global Secure Access.
1. Install Cisco Secure Client with VPN.

**Validation:**
1. Ensure both clients are enabled.
1. To verify rules are applied and health checks pass, use Advanced Diagnostics in the Global Secure Access client.
1. Test traffic flow by accessing various sites and validating traffic logs in both platforms.
    1. Start collecting traffic in Global Secure Access client.
    2. Access websites: `bing.com`, `salesforce.com`, `outlook.office365.com`.
    3. Verify Global Secure Access client captures traffic from these sites.
    4. Validate traffic in Microsoft Entra admin center traffic logs.
    5. Validate traffic **isn't** captured in Cisco Secure Access portal.
    6. Access private resources via Cisco Secure Client (e.g, RDP session).
    7. Validate RDP traffic is missing from Global Secure Access logs and present in Cisco Secure Access logs.
    8. Access private application in Microsoft Entra Private Access (for example, SMB file share).
    9. Validate SMB traffic is captured in Global Secure Access logs and not in Cisco Secure Access logs.
    10. Stop collecting traffic in Global Secure Access client.


## Cisco ASA Remote Access VPN

### Cisco ASA Remote Access VPN - scenarios

1. **[Microsoft Entra Internet Access and Microsoft Access with Cisco ASA Remote Access VPN for private access](#1-microsoft-entra-internet-access-and-microsoft-access-with-cisco-asa-remote-access-vpn-for-private-access).**
Global Secure Access handles internet and Microsoft traffic. Cisco ASA captures only private application traffic.

2. **[Microsoft Entra Private Access, Internet Access, and Microsoft Access with Cisco ASA Remote Access VPN](#2-microsoft-entra-private-access-internet-access-and-microsoft-access-with-cisco-asa-remote-access-vpn-for-private-access).**
Both clients handle traffic for separate private applications. Global Secure Access handles private applications in Microsoft Entra Private Access, while private applications hosted through Cisco ASA are accessed through Cisco Secure Client VPN. Global Secure Access handles internet and Microsoft traffic.

### Cisco ASA Remote Access VPN - prerequisites

To configure Microsoft and Cisco ASA remote access VPN for a unified SASE solution:

1. Set up Microsoft Entra Internet Access and Microsoft Entra Private Access. These products make up the Global Secure Access solution.
2. Establish remote access connectivity to your Cisco ASA.
3. Configure fully qualified domain name (FQDN) and IP bypasses (instructions below).

### Cisco ASA Remote Access VPN - Global Secure Access setup

1. Enable and disable different traffic forwarding profiles for your Microsoft Entra tenant. For more information, see [Global Secure Access traffic forwarding profiles](concept-traffic-forwarding.md).
1. Install and configure the Microsoft Entra private network connector. See [How to configure connectors](how-to-configure-connectors.md).
    > [!NOTE] 
    > Private network connectors are required for Microsoft Entra Private Access applications.
1. Configure Quick Access to private resources and set up private Domain Name System (DNS) and DNS suffixes. See [How to configure Quick Access](how-to-configure-quick-access.md).
1. Install and configure the Global Secure Access client on end-user devices. See [Global Secure Access clients](concept-clients.md).
<a id="adding-a-custom-bypass-for-cisco-asa"></a>

1. Add an Internet Access traffic forwarding profile custom bypass to exclude Cisco ASA remote access VPN endpoint IP and FQDN.
    1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access > Connect > Traffic forwarding > Internet access profile**.
    2. Under Internet access policies, select **View**.
    3. Expand **Custom Bypass** and select **Add rule**.
    4. Leave destination type as FQDN and enter the FQDN used to connect to your Cisco ASA VPN in Destination.
    5. Set destination type as IP and enter the public IP address of your Cisco ASA.
    6. Select **Save**.

## Cisco ASA VPN setup

#### Split-Include configuration (ASA)

Configure split-include for Cisco ASA Remote Access VPN:

1. Sign in to Cisco ASA using the Cisco Adaptive Security Device Manager (ASDM) software.
2. Navigate to **Configuration > Remote Access VPN > Network (Client) Access > Secure Client Connection Profiles**.
3. Select an existing connection profile or create a new one, then select **Edit**.
4. Under **Group Policy**, specify the private IP address of the DNS server used for private traffic.
5. In the group policy settings, expand **Advanced > Split Tunneling** and configure the following:
  - **DNS Names**: `Inherit`
  - **Send All DNS Lookups Through Tunnel**: `No`
  - **Policy**: `Tunnel Network List Below`
  - **Network List**: Select the access list that includes your private application IP ranges.
6. Edit the access control list (ACL) to permit the private application IP ranges (for example, `10.101.0.0/16`) and the Global Secure Access synthetic IP range `6.6.0.0/16`.
7. Save and apply your changes.

> [!NOTE]
> Currently **Split-Include** is the only supported Cisco ASA VPN configuration.


## Cisco ASA Remote Access VPN - configuration scenarios

### Cisco ASA Remote Access VPN

#### 1. Microsoft Entra Internet Access and Microsoft Access with Cisco ASA Remote Access VPN for private access

**Global Secure Access configuration:**
1. Enable Microsoft Entra Internet Access and Microsoft Access forwarding profiles.
1. Install and configure the Global Secure Access client for Windows or macOS.
1. Add an Internet Access traffic forwarding profile [custom bypass](#adding-a-custom-bypass-for-cisco-asa) to exclude Cisco ASA remote access URL and public IP address.

**Cisco configuration:**
1. Configure Cisco ASA remote access VPN connection profile for [split-include](#split-include-configuration-asa) configuration, as described previously.
1. Install Cisco Secure Client or AnyConnect software.
1. Connect to your VPN endpoint.

**Validation:**
1. Ensure both clients are enabled.
1. To verify rules are applied and health checks pass, use Advanced Diagnostics in the Global Secure Access client.
1. Test traffic flow by accessing various sites and validating traffic logs in both platforms.
    1. Start collecting traffic in Global Secure Access client.
    2. Access websites: `bing.com`, `salesforce.com`, `outlook.office365.com`.
    3. Verify Global Secure Access client captures traffic from these sites.
    4. Validate traffic in Microsoft Entra admin center traffic logs.
    5. Validate website traffic **isn't** captured by your Cisco ASA.
    6. Access private resources via Cisco Secure Client (for example, RDP session).
    7. Validate RDP traffic is missing from Global Secure Access logs and present in Cisco logs.
    8. Stop collecting traffic in Global Secure Access client.

#### 2. Microsoft Entra Private Access, Internet Access, and Microsoft Access with Cisco ASA Remote Access VPN for private access

**Global Secure Access configuration:**
1. Enable Microsoft Entra Internet Access, Private Access, and Microsoft Access forwarding profiles.
1. Install a Private Network Connector for Microsoft Entra Private Access.
1. Configure Quick Access and set up Private DNS.
1. Create an app segment, for example an SMB file share. This will be the application you want to access through Global Secure Access and not Cisco ASA VPN.
1. Add an Internet Access traffic forwarding profile [custom bypass](#adding-a-custom-bypass-for-cisco-asa) to exclude Cisco ASA remote access URL and public IP address.
1. Install and configure the Global Secure Access client for Windows or macOS.

**Cisco configuration:**
1. Configure Cisco ASA remote access VPN connection profile for [split-include](#split-include-configuration-asa) configuration, as described previously.
1. Ensure that in step 1 you have configured applications to access through Cisco ASA VPN, for example an RDP server. This should be different apps than configured in Global Secure Access.
1. Install Cisco Secure Client software.
1. Connect to your VPN endpoint.

**Validation:**
1. Ensure both clients are enabled.
1. To verify rules are applied and health checks pass, use Advanced Diagnostics in the Global Secure Access client.
1. Test traffic flow by accessing various sites and validating traffic logs in both platforms.
    1. Start collecting traffic in Global Secure Access client.
    2. Access websites: `bing.com`, `salesforce.com`, `outlook.office365.com`.
    3. Verify Global Secure Access client captures traffic from these sites.
    4. Validate traffic in Microsoft Entra admin center traffic logs.
    5. Validate website traffic **isn't** captured by your Cisco ASA.
    6. Access private resources via Cisco Secure Client (for example, RDP session).
    7. Validate RDP traffic is missing from Global Secure Access logs and present in Cisco logs.
    8. Access private application in Microsoft Entra Private Access (for example, SMB file share).
    9. Validate SMB traffic is captured in Global Secure Access logs and not in Cisco logs.
    10. Stop collecting traffic in Global Secure Access client.

> [!NOTE]
> For troubleshooting health check failures, see [Troubleshoot the Global Secure Access client: Health check](troubleshoot-global-secure-access-client-diagnostics-health-check.md).
## Next steps

- [What is Global Secure Access?](overview-what-is-global-secure-access.md)
