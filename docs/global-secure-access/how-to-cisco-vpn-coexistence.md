---
title: Security Service Edge (SSE) Coexistence With Microsoft and Cisco VPNs
description: Microsoft and Cisco VPNs coexistence solution guide.
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

# Security Service Edge (SSE) coexistence with Microsoft and Cisco VPNs

Organizations require robust, unified solutions to ensure secure and seamless connectivity. Microsoft Secure Access Service Edge (SASE) capabilities that, when integrated with Cisco Virtual Private Networks (VPN), provide enhanced security and connectivity for diverse access scenarios.

This guide outlines how to configure and deploy Microsoft Entra solutions alongside Cisco VPN offerings. By leveraging both platforms, you can optimize your organization's security posture while maintaining high-performance connectivity for private applications, Microsoft 365 traffic, and internet access.

## Cisco remote access VPN platforms

This guide focuses on two Cisco remote access VPN platforms:

- **Cisco Adaptive Security Appliance (ASA) Remote Access VPN**
- **Cisco Secure Access VPN (Firewall-as-a-Service, FWaaS)**

## Coexistence scenarios

### Cisco Secure Access VPN

#### Scenario 1: Internet and Microsoft traffic with Cisco Secure Access VPN for private access

Global Secure Access handles internet and Microsoft traffic. Cisco Secure Access VPN captures only private application traffic.

#### Scenario 2: Split private access with Cisco Secure Access VPN

Both clients handle traffic for separate private applications. Private applications in Entra Private Access are handled by Global Secure Access, while private applications hosted through Cisco Secure Access VPN are accessed through Cisco Secure Client VPN. Internet and Microsoft traffic are handled by Global Secure Access.

### Cisco ASA Remote Access VPN

#### Scenario 1: Internet and Microsoft traffic with Cisco ASA Remote Access VPN for private access

Global Secure Access handles internet and Microsoft traffic. Cisco ASA captures only private application traffic.

#### Scenario 2: Split private access with Cisco ASA Remote Access VPN

Both clients handle traffic for separate private applications. Private applications in Entra Private Access are handled by Global Secure Access, while private applications hosted through Cisco ASA are accessed through Cisco Secure Client VPN. Internet and Microsoft traffic are handled by Global Secure Access.

## Prerequisites

To configure Microsoft and Cisco Secure Access for a unified SASE solution:

1. Set up Entra Internet Access and Entra Private Access. These products make up the Global Secure Access solution.
2. Set up a Cisco Secure Access VPN profile.
3. Configure Global Secure Access fully qualified domain name (FQDN) and IP bypasses.

### Setting up Global Secure Access

- Enable and disable different traffic forwarding profiles for your Entra tenant. For more information, see [Global Secure Access traffic forwarding profiles](concept-traffic-forwarding.md).
- Install and configure the Entra private network connector. See [How to configure connectors](how-to-configure-connectors.md).
- **Note:** Private Network Connectors are required for Entra Private Access applications.
- Configure Quick Access to private resources and set up private Domain Name System (DNS) and DNS suffixes. See [How to configure Quick Access](how-to-configure-quick-access.md).
- Install and configure the Global Secure Access client on end-user devices. See [Global Secure Access clients](concept-clients.md).

- Add an Internet Access traffic forwarding profile custom bypass to exclude Cisco Secure Access VPN FQDN. This is only required for Cisco Secure Access VPN.

  1. Sign in to Entra admin center and browse to **Global Secure Access > Connect > Traffic forwarding > Internet access profile**.
  2. Under Internet access policies, select **View**.
  3. Expand **Custom Bypass** and select **Add rule**.
  4. Leave destination type as FQDN and enter `*.vpn.sse.cisco.com` in Destination.
  5. Select **Save**.

### Setting up Cisco Secure Access VPN

- Create a Network Tunnel to establish connectivity to the Cisco Secure Access platform. See [Manage Network Tunnel Groups](https://docs.cisco.com/network-tunnel-groups).
- Configure the VPN profile Traffic Steering:
  - From the Cisco Secure Access portal, go to **Connect > End User Connectivity > Virtual Private Network**.
  - Select your VPN Profile, then **Traffic Steering**.
  - In Tunnel Mode, select **Bypass Secure Access** and add exceptions for your private application subnets and `6.6.0.0/16`.
  - In DNS Mode, select **Split DNS** and add the domain suffix of your private applications.
- Install the Cisco Secure Client software. See [Cisco Secure Client Download and Installation guide](https://docs.cisco.com/secure-client-download).

**Note:** Other ways to configure Tunnel Mode and DNS Mode exist. For the scenarios below, only Bypass Secure Access and Split DNS (Split-Include) are selected. This is the only supported Cisco Secure Access VPN configuration currently. This guide will be updated as more configurations are validated.

### Setting up Cisco ASA VPN

#### Split-Include configuration

1. Login to Cisco ASA through ASDM software.
2. Go to **Configuration > Remote Access VPN > Network (Client) Access > Secure Client Connection Profiles**.
3. Select or create a Connection Profile and click **Edit**.
4. Under Default Group Policy, add the private IP address of the DNS server used for private traffic.
5. In Group Policy, expand **Advanced > Split Tunneling**:
   - DNS Names: Inherit
   - Send All DNS Lookups Through Tunnel: No
   - Policy: Tunnel Network List Below
   - Network List: Select the access list that includes your private apps IP ranges.
6. Edit the ACL to permit the private application IP range (e.g., `10.101.0.0/16` and `6.6.0.0/16`).
7. Save and apply settings.

**Note:** Your ASA configuration may differ. This is known as split-include, meaning ASA only tunnels what is in the ACL. At this time split-exclude is not a supported coexistence configuration.

#### Tunnel All Networks with dynamic exclusions
> [!NOTE]
> This configuration requires an IP address as the host address in the Secure Client Profile. See the [Known limitations](https://github.com/MicrosoftDocs/entra-docs-pr/pull/9086/files/3a59be5442d56ec71ca14f0bd52d0a21e87615b3#TunnelAllKnownLimitations) below for more information.
1. Login to Cisco ASA through ASDM software.
2. Go to **Configuration > Remote Access VPN > Network (Client) Access > Advanced > Secure Client Custom Attributes > Add**.
3. For Type, enter `dynamic-split-exclude-domains`. For Description, enter "Dynamic split tunneling".
4. Add a custom attribute name (e.g., `GSAfqdns`) and value (`globalsecureaccess.microsoft.com`).
5. Apply settings.
6. Configure the Remote Access VPN profile to tunnel all networks. Dynamic split exclusions bypass required IPs and FQDNs.
> [!NOTE]
  > There is a known issue with this configuration preventing coexistence with Global Secure Access on macOS. 

**Note:** In Tunnel All Networks configuration, if the Global Secure Access client is started first and then Cisco Secure Client VPN is established, it may take a few seconds for private resources to be accessible through the Cisco VPN.

## Coexistence configurations

### Cisco Secure Access VPN

#### Configuration 1: Internet and Microsoft traffic with Cisco Secure Access VPN for private access

- Enable Entra Microsoft Access and Internet Access forwarding profiles.
- Install and configure the Global Secure Access client for Windows or macOS.
- Add an Internet Access traffic forwarding profile custom bypass to exclude Cisco Secure Access VPN service.
- Set up remote access VPN profile as described above.
- Install Cisco Secure Client with VPN.

After both clients are installed and running, verify that Global Secure Access and Cisco clients are enabled.

**Verify configuration:**

- Right-click Global Secure Access client > Advanced Diagnostics > Forwarding Profile. Verify only Internet and Microsoft 365 rules are applied.
- In Advanced Diagnostics > Health Check, ensure no checks are failing.
- See [Troubleshoot the Global Secure Access client: Health check](troubleshoot-global-secure-access-client-diagnostics-health-check.md).

**Test traffic flow:**

1. In the system tray, right-click **Global Secure Access Client** > **Advanced Diagnostics** > **Traffic** tab > **Start collecting**.
2. Access websites: `bing.com`, `salesforce.com`, `outlook.office365.com`.
3. Verify Global Secure Access client captures traffic from these sites.
4. In Entra admin center, go to **Global Secure Access > Monitor > Traffic logs**. Validate traffic is logged.
5. In Cisco Secure Access portal, go to **Monitor > Activity Search**. Validate traffic to these websites is not captured.
6. Access private resources via Cisco Secure Access VPN client (e.g., RDP session).
7. Validate RDP traffic is missing from Global Secure Access traffic logs and present in Cisco Secure Access logs.
8. Stop collecting traffic in Global Secure Access client.

#### Configuration 2: Internet, Private Access, and Microsoft traffic with Cisco Secure Access VPN for split private access

- Enable Entra Private Access, Internet Access, and Microsoft Access forwarding profiles.
- Install a Private Network Connector for Entra Private Access.
- Configure Quick Access and set up Private DNS.
- Add an Internet Access traffic forwarding profile custom bypass to exclude Cisco Secure Access VPN endpoint.
- Install and configure the Global Secure Access client for Windows or macOS.
- Set up remote access VPN profile as described above.
- Install Cisco Secure Client with VPN.

After both clients are installed and running, verify that Global Secure Access and Cisco clients are enabled.

**Verify configuration:**

- Right-click Global Secure Access client > Advanced Diagnostics > Forwarding Profile. Verify only Internet and Microsoft 365 rules are applied.
- In Advanced Diagnostics > Health Check, ensure no checks are failing.

**Test traffic flow:**

1. Start collecting traffic in Global Secure Access client.
2. Access websites: `bing.com`, `salesforce.com`, `outlook.office365.com`.
3. Verify Global Secure Access client captures traffic from these sites.
4. Validate traffic in Entra admin center traffic logs.
5. Validate traffic is not captured in Cisco Secure Access portal.
6. Access private resources via Cisco Secure Access VPN client (e.g., RDP session).
7. Validate RDP traffic is missing from Global Secure Access logs and present in Cisco Secure Access logs.
8. Access private application in Entra Private Access (e.g., SMB file share).
9. Validate SMB traffic is captured in Global Secure Access logs and not in Cisco Secure Access logs.
10. Stop collecting traffic in Global Secure Access client.

### Cisco ASA Remote Access VPN

#### Configuration 1: Internet and Microsoft traffic with Cisco ASA private access

- Enable Entra Microsoft Access and Internet Access forwarding profiles.
- Install and configure the Global Secure Access client for Windows or macOS.
- Add an Internet Access traffic forwarding profile custom bypass to exclude Cisco ASA remote access SSL URL and public IP address.
- Configure Cisco ASA remote access VPN connection profile as described above.
- Install Cisco Secure Client or AnyConnect software.
- Connect to your VPN endpoint.

After both clients are installed and running, verify that Global Secure Access and Cisco clients are enabled.

**Verify configuration:**

- Right-click Global Secure Access client > Advanced Diagnostics > Forwarding Profile. Verify only Internet and Microsoft 365 rules are applied.
- In Advanced Diagnostics > Health Check, ensure no checks are failing.

**Test traffic flow:**

1. Start collecting traffic in Global Secure Access client.
2. Access websites: `bing.com`, `salesforce.com`, `outlook.office365.com`.
3. Verify Global Secure Access client captures traffic from these sites.
4. Validate traffic in Entra admin center traffic logs.
5. In Cisco ASDM, go to **Monitoring > Logging > View**. Validate website traffic is not captured.
6. Access private resources via Cisco Secure Client (e.g., RDP session).
7. Validate RDP traffic is missing from Global Secure Access logs and present in Cisco ASDM logs.
8. Stop collecting traffic in Global Secure Access client.

#### Configuration 2: Internet, Private Access, and Microsoft traffic with Cisco ASA private access

- Enable Entra Private Access forwarding profile.
- Install a Private Network Connector for Entra Private Access.
- Configure Quick Access and set up Private DNS.
- Add an Internet Access traffic forwarding profile custom bypass to exclude Cisco ASA remote access SSL URL and public IP address.
- Install and configure the Global Secure Access client for Windows or macOS.
- Configure Cisco ASA remote access VPN connection profile as described above.
- Install Cisco Secure Client or AnyConnect software.
- Connect to your VPN endpoint.

After both clients are installed and running, verify that Global Secure Access and Cisco clients are enabled.

**Verify configuration:**

- Right-click Global Secure Access client > Advanced Diagnostics > Forwarding Profile. Verify Internet, Microsoft 365, and Private Apps rules are applied.
- In Advanced Diagnostics > Health Check, ensure no checks are failing.

**Test traffic flow:**

1. Start collecting traffic in Global Secure Access client.
2. Access websites: `bing.com`, `salesforce.com`, `outlook.office365.com`.
3. Verify Global Secure Access client captures traffic from these sites.
4. Validate traffic in Entra admin center traffic logs.
5. In Cisco ASDM, go to **Monitoring > Logging > View**. Validate website traffic is not captured.
6. Access private resources via Cisco Secure Client (e.g., RDP session).
7. Validate RDP traffic is missing from Global Secure Access logs and present in Cisco ASDM logs.
8. Access private application in Entra Private Access (e.g., SMB file share).
9. Validate SMB traffic is captured in Global Secure Access logs and not in Cisco ASDM logs.
10. Stop collecting traffic in Global Secure Access client.

## Next steps

- [What is Global Secure Access?](overview-what-is-global-secure-access.md)

