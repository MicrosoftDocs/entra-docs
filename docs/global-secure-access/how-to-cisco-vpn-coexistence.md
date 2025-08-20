---
title: Security Service Edge (SSE) Coexistence With Microsoft and Cisco VPNs
description: Microsoft and Cisco VPNs coexistence solution guide.
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

# Security Service Edge (SSE) coexistence with Microsoft and Cisco VPNs

Organizations require robust, unified solutions to ensure secure and seamless connectivity. Microsoft Secure Access Service Edge (SASE) capabilities that, when integrated with Cisco Virtual Private Networks (VPN), provide enhanced security and connectivity for diverse access scenarios.

This guide outlines how to configure and deploy Microsoft Entra solutions alongside Cisco VPN offerings. By using both platforms, you can optimize your organization's security posture while maintaining high-performance connectivity for private applications, Microsoft 365 traffic, and internet access.

## Cisco remote access VPN platforms

This guide focuses on two Cisco remote access VPN platforms:

- **[Cisco Secure Access VPN-as-a-Service (VPNaaS)](#cisco-secure-access-vpnaas)** 
- **[Cisco Adaptive Security Appliance (ASA) Remote Access VPN](#cisco-asa-remote-access-vpn)**

## Cisco Secure Access VPNaaS

## Scenarios
1.  **[Microsoft Entra Internet Access and Microsoft Access with Cisco Secure Access VPNaaS for private access](#1-internet-and-microsoft-traffic-with-cisco-secure-access-vpnaas-for-private-access).**
Global Secure Access handles internet and Microsoft traffic. Cisco Secure Access VPNaaS captures only private application traffic.

2.  **[Microsoft Entra Private Access, Internet Access, and Microsoft Access with Cisco Secure Access VPNaaS](#2-internet-private-access-and-microsoft-traffic-with-cisco-secure-access-vpn-for-split-private-access).**
Both clients handle traffic for separate private applications. Global Secure Access handles private applications in Microsoft Entra Private Access, while private applications hosted through Cisco Secure Access VPNaaS are accessed through Cisco Secure Client VPN. Global Secure Access handles internet and Microsoft traffic.

## Prerequisites

To configure Microsoft and Cisco Secure Access VPNaaS for a unified SASE solution:

- Set up Microsoft Entra Internet Access and Microsoft Entra Private Access. These products make up the Global Secure Access solution.
- Establish connectivity to Cisco Secure Access VPNaaS
- Set up a Cisco remote access VPN profile.
- Configure Global Secure Access fully qualified domain name (FQDN) and IP bypasses.

## Global Secure Access setup

- Enable and disable different traffic forwarding profiles for your Microsoft Entra tenant. For more information, see [Global Secure Access traffic forwarding profiles](concept-traffic-forwarding.md).
- Install and configure the Microsoft Entra private network connector. See [How to configure connectors](how-to-configure-connectors.md).

> [!NOTE] 
   > Private network connectors are required for Microsoft Entra Private Access applications.
   
- Configure Quick Access to private resources and set up private Domain Name System (DNS) and DNS suffixes. See [How to configure Quick Access](how-to-configure-quick-access.md).
- Install and configure the Global Secure Access client on end-user devices. See [Global Secure Access clients](concept-clients.md).

- Add an Internet Access traffic forwarding profile custom bypass to exclude Cisco Secure Access VPNaaS service FQDN.
  1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access > Connect > Traffic forwarding > Internet access profile**.
  2. Under Internet access policies, select **View**.
  3. Expand **Custom Bypass** and select **Add rule**.
  4. Leave destination type as FQDN and enter `*.vpn.sse.cisco.com` in Destination.
  5. Select **Save**.

## Cisco Secure Access VPNaaS setup

#### Split-Include configuration

- Configure the VPN profile Traffic Steering:
  1. From the Cisco Secure Access portal, go to **Connect > End User Connectivity > Virtual Private Network**.
  2. Select your VPN Profile, then **Traffic Steering**.
  3. In Tunnel Mode, select **Bypass Secure Access** and add exceptions for your private application subnets and the synthetic IP range, `6.6.0.0/16`.
  4. In DNS Mode, select **Split DNS** and add the domain suffix of your private applications.
- Install the Cisco Secure Client software. See [Cisco Secure Client Download and Installation guide](https://docs.cisco.com/secure-client-download).

> [!NOTE]
> Currently **Split-Include** is the only supported Cisco Secure Access VPNaaS configuration. Other coexistence configurations may be added as they are validated.

## Configuration scenarios

### 1. Internet and Microsoft traffic with Cisco Secure Access VPNaaS for private access.


#### Steps

**Global Secure Access configuration:**
- Enable Microsoft Entra Internet Access and Microsoft Access forwarding profiles.
- Install and configure the Global Secure Access client for Windows or macOS.
- Add an Internet Access traffic forwarding profile custom bypass to exclude Cisco Secure Access VPNaaS service. [Instructions above.](#adding-a-custom-bypass)

**Cisco configuration:**
- Set up remote access VPN profile as [described previously](#split-include-configuration).
- Install Cisco Secure Client with VPN.

**Validation:**
- Ensure both clients are enabled and the Umbrella profile is `Active`.
- To verify rules are applied and health checks pass, use Advanced Diagnostics in the Global Secure Access client.
- Test traffic flow by accessing various sites and validating traffic logs in both platforms.
  1. In the system tray, right-click **Global Secure Access Client** > **Advanced Diagnostics** > **Traffic** tab > **Start collecting**.
  2. Access websites: `bing.com`, `salesforce.com`, `outlook.office365.com`.
  3. Verify Global Secure Access client captures traffic from these sites.
  4. In Microsoft Entra admin center, go to **Global Secure Access > Monitor > Traffic logs**. Validate traffic is logged.
  5. In Cisco Secure Access portal, go to **Monitor > Activity Search**. Validate traffic to these websites **isn't** captured.
  6. Access private resources via Cisco Secure Client (for example, RDP session).
  7. Validate RDP traffic is missing from Global Secure Access traffic logs and present in Cisco Secure Access logs.
  8. Stop collecting traffic in Global Secure Access client and validate no private application traffic was captured.

---

### 2. Internet, Private Access, and Microsoft traffic with Cisco Secure Access VPN for split private access


#### Steps

**Global Secure Access configuration:**
- Enable Microsoft Entra Internet Access, Private Access, and Microsoft Access forwarding profiles.
- Install a private network connector for Microsoft Entra Private Access.
- Configure Quick Access and set up Private DNS.
- Add an Internet Access traffic forwarding profile [custom bypass](#adding-a-custom-bypass) to exclude Cisco Secure Access VPNaaS endpoint.
- Install and configure the Global Secure Access client for Windows or macOS.

**Cisco configuration:**
- Set up remote access VPN profile as [described previously](#split-include-configuration).
- Install Cisco Secure Client with VPN.

**Validation:**
- Ensure both clients are enabled and the Umbrella profile is `Active`.
- To verify rules are applied and health checks pass, use Advanced Diagnostics in the Global Secure Access client.
- Test traffic flow by accessing various sites and validating traffic logs in both platforms.
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

---
## Cisco ASA Remote Access VPN

## Scenarios

1. **[Internet and Microsoft traffic with Cisco ASA Remote Access VPN for private access](#1-internet-and-microsoft-traffic-with-cisco-asa-private-access).**
Global Secure Access handles internet and Microsoft traffic. Cisco ASA captures only private application traffic.

2. **[Private Access, Internet Access, and Microsoft Access with Cisco ASA Remote Access VPN](#2-internet-private-access-and-microsoft-traffic-with-cisco-asa-private-access).**
Both clients handle traffic for separate private applications. Global Secure Access handles private applications in Microsoft Entra Private Access, while private applications hosted through Cisco ASA are accessed through Cisco Secure Client VPN. Global Secure Access handles internet and Microsoft traffic.

## Prerequisites

To configure Microsoft and Cisco ASA remote access VPN for a unified SASE solution:

1. Set up Microsoft Entra Internet Access and Microsoft Entra Private Access. These products make up the Global Secure Access solution.
2. Establish remote access connectivity to your Cisco ASA.
3. Configure Global Secure Access fully qualified domain name (FQDN) and IP bypasses.

## Global Secure Access setup

- Enable and disable different traffic forwarding profiles for your Microsoft Entra tenant. For more information, see [Global Secure Access traffic forwarding profiles](concept-traffic-forwarding.md).
- Install and configure the Microsoft Entra private network connector. See [How to configure connectors](how-to-configure-connectors.md).

> [!NOTE] 
   > Private network connectors are required for Microsoft Entra Private Access applications.
   
- Configure Quick Access to private resources and set up private Domain Name System (DNS) and DNS suffixes. See [How to configure Quick Access](how-to-configure-quick-access.md).
- Install and configure the Global Secure Access client on end-user devices. See [Global Secure Access clients](concept-clients.md).

- Add an Internet Access traffic forwarding profile custom bypass to exclude Cisco ASA remote access VPN endpoint IP and FQDN.

  1. Sign in to Microsoft Entra admin center and browse to **Global Secure Access > Connect > Traffic forwarding > Internet access profile**.
  2. Under Internet access policies, select **View**.
  3. Expand **Custom Bypass** and select **Add rule**.
  4. Leave destination type as FQDN and enter the FQDN used to connect to your VPN in Destination.
  5. Set destination type as IP and enter the public IP address of your Cisco ASA.
  6. Select **Save**.

## Cisco ASA VPN setup

#### Split-Include configuration

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
6. Edit the access control list (ACL) to permit the private application IP ranges (for example, `10.101.0.0/16`) and the synthetic IP range `6.6.0.0/16`.
7. Save and apply your changes.

> [!NOTE]
> This configuration is known as split-include. At this time, split-exclude isn't a supported coexistence configuration.

#### Tunnel All Networks with dynamic exclusions
> [!IMPORTANT]
> **Known limitation:** If the Secure Client Profile Host Address is configured as a fully qualified domain name (FQDN) and the Global Secure Access (GSA) client connects first, the Cisco Secure Client will lose connection shortly after authenticating.  
>  
> To avoid this issue, verify the Host Address setting in Cisco ASDM:
> - Go to **Remote Access VPN > Network (Client) Access > Secure Client Profile > “ProfileName” > Server List**.
> - Ensure the **Host Address** is set to an IP address, not an FQDN.

1. Sign in to Cisco ASA through ASDM software.
2. Go to **Configuration > Remote Access VPN > Network (Client) Access > Advanced > Secure Client Custom Attributes > Add**.
3. For Type, enter `dynamic-split-exclude-domains`. For Description, enter `Dynamic split tunneling`.
4. Add a custom attribute name (for example, `GSAfqdns`) and value (`globalsecureaccess.microsoft.com`).
5. Apply settings.
6. Navigate to **Configuration > Remote Access VPN > Network (Client) Access > Secure Client Connection Profiles**.
7. Select an existing connection profile or create a new one, then select **Edit**.
8. In the **Basic** menu under **Group Policy**, specify the private IP address of the DNS server used for private traffic.
9. In the group policy settings, expand **Advanced > Split Tunneling** and configure the following:
  - **DNS Names**: `Inherit`
  - **Send All DNS Lookups Through Tunnel**: `No`
  - **Policy**: `Tunnel All Networks`
  - **Network List**: None
10. Navigate to **Advanced > expand Secure Client > Custom Attributes > Add > for Attribute type** click **Manage** > Select **“dynamic-split-exclude-domains”** > **OK**
11. Choose **Select Value > GSAfqdns > OK > Apply**
> [!NOTE]
  > There's a known issue with this configuration preventing coexistence with Global Secure Access on macOS. 

> [!NOTE]
> When using the Tunnel All Networks configuration, after the client connects, it might take a few seconds before you can access private resources through the Cisco VPN.

## Configuration scenarios

### Cisco ASA Remote Access VPN

### 1. Internet and Microsoft traffic with Cisco ASA private access

#### Steps

**Global Secure Access configuration:**
- Enable Microsoft Entra Internet Access and Microsoft Access forwarding profiles.
- Install and configure the Global Secure Access client for Windows or macOS.
- Add an Internet Access traffic forwarding profile [custom bypass](#adding-a-custom-bypass-for-cisco-asa) to exclude Cisco ASA remote access TLS URL and public IP address.

**Cisco configuration:**
- Configure Cisco ASA remote access VPN connection profile for [split-include](#split-include-configuration) or [tunnel all](#tunnel-all-networks-with-dynamic-exclusions) configuration, as described previously.
- Install Cisco Secure Client or AnyConnect software.
- Connect to your VPN endpoint.

**Validation:**
- Ensure both clients are enabled and the Umbrella profile is `Active`.
- To verify rules are applied and health checks pass, use Advanced Diagnostics in the Global Secure Access client.
- Test traffic flow by accessing various sites and validating traffic logs in both platforms.
  1. Start collecting traffic in Global Secure Access client.
  2. Access websites: `bing.com`, `salesforce.com`, `outlook.office365.com`.
  3. Verify Global Secure Access client captures traffic from these sites.
  4. Validate traffic in Microsoft Entra admin center traffic logs.
  5. In Cisco ASDM, go to **Monitoring > Logging > View**. Validate website traffic **isn't** captured.
  6. Access private resources via Cisco Secure Client (for example, RDP session).
  7. Validate RDP traffic is missing from Global Secure Access logs and present in Cisco ASDM logs.
  8. Stop collecting traffic in Global Secure Access client.

---
### 2. Internet, Private Access, and Microsoft traffic with Cisco ASA private access

#### Steps

**Global Secure Access configuration:**
- Enable Microsoft Entra Internet Access, Private Access, and Microsoft Access forwarding profiles.
- Install a Private Network Connector for Microsoft Entra Private Access.
- Configure Quick Access and set up Private DNS.
- Add an Internet Access traffic forwarding profile [custom bypass](#adding-a-custom-bypass-for-cisco-asa) to exclude Cisco ASA remote access TLS URL and public IP address.
- Install and configure the Global Secure Access client for Windows or macOS.

**Cisco configuration:**
- Configure Cisco ASA remote access VPN connection profile for [split-include](#split-include-configuration) or [tunnel all](#tunnel-all-networks-with-dynamic-exclusions) configuration, as described previously.
- Install Cisco Secure Client software.
- Connect to your VPN endpoint.

**Validation:**
- Ensure both clients are enabled and the Umbrella profile is `Active`.
- To verify rules are applied and health checks pass, use Advanced Diagnostics in the Global Secure Access client.
- Test traffic flow by accessing various sites and validating traffic logs in both platforms.
  1. Start collecting traffic in Global Secure Access client.
  2. Access websites: `bing.com`, `salesforce.com`, `outlook.office365.com`.
  3. Verify Global Secure Access client captures traffic from these sites.
  4. Validate traffic in Microsoft Entra admin center traffic logs.
  5. In Cisco ASDM, go to **Monitoring > Logging > View**. Validate website traffic **isn't** captured.
  6. Access private resources via Cisco Secure Client (for example, RDP session).
  7. Validate RDP traffic is missing from Global Secure Access logs and present in Cisco ASDM logs.
  8. Access private application in Microsoft Entra Private Access (for example, SMB file share).
  9. Validate SMB traffic is captured in Global Secure Access logs and not in Cisco ASDM logs.
  10. Stop collecting traffic in Global Secure Access client.

---

## Next steps

- [What is Global Secure Access?](overview-what-is-global-secure-access.md)

