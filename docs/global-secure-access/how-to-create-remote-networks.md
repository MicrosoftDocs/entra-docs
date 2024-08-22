---
title: How to create remote networks
description: Learn how to create remote networks, such as branch office locations, for Global Secure Access.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: how-to
ms.date: 08/21/2024
ms.service: global-secure-access
# Customer intent: As an IT admin, I need to be able to create a remote network for a remote office so that my organization can connect to the Global Secure Access service.
---
# How to create a remote network with Global Secure Access

Remote networks are remote locations, such as a branch office, or networks that require internet connectivity. Setting up remote networks connects your users in remote locations to Global Secure Access. Once a remote network is configured, you can assign a traffic forwarding profile to manage your corporate network traffic. Global Secure Access provides remote network connectivity so you can apply network security policies to your outbound traffic. 

There are multiple ways to connect remote networks to Global Secure Access. In a nutshell, you're creating an Internet Protocol Security (IPSec) tunnel between a core router, known as the customer premises equipment (CPE), at your remote network and the nearest Global Secure Access endpoint. All internet-bound traffic is routed through the core router of the remote network for security policy evaluation in the cloud. Installation of a client isn't required on individual devices.

This article explains how to create a remote network for Global Secure Access.

## Prerequisites

To configure remote networks, you must have:

- A **Global Secure Access Administrator** role in Microsoft Entra ID.
- The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
- To use the Microsoft traffic forwarding profile, a Microsoft 365 E3 license is recommended.
- Customer premises equipment (CPE) must support the following protocols:
    - Internet Protocol Security (IPSec)
    - GCMEAES128, GCMAES 192, or GCMAES256 algorithms for Internet Key Exchange (IKE) phase 2 negotiation
    - Internet Key Exchange Version 2 (IKEv2)
    - Border Gateway Protocol (BGP)
- [Review the valid configurations for setting up remote networks](reference-remote-network-configurations.md).
- Remote network connectivity solution uses *RouteBased* VPN configuration with *any-to-any* (wildcard or 0.0.0.0/0) traffic selectors. Make sure that your CPE has the correct traffic selector set.
- Remote network connectivity solution uses *Responder* modes. Your CPE must initiate the connection.

### Known limitations

- The number of remote networks per tenant is limited to 10. The number of device links per remote network is limited to four.
- Microsoft traffic is accessed through remote network connectivity without the Global Secure Access client. However, the Conditional Access policy isn't enforced. In other words, Conditional Access policies for the Global Secure Access Microsoft traffic are only enforced when a user has the Global Secure Access client.
- You must use the Global Secure Access client for Microsoft Entra Private Access. Remote network connectivity only supports Microsoft Entra Internet Access.

## High-level steps

You can create a remote network in the Microsoft Entra admin center or through the Microsoft Graph API.

At a high level, there are five steps for creating a remote network and configuring an active IPsec tunnel:
 
1. [**Basics**](#basics): Enter the basic details like the **Name** and **Region** of your remote network. **Region** specifies where you want your other end of IPsec tunnel. The other end of the tunnel is your router or CPE.

1. [**Connectivity**](#connectivity): Add a device link (or IPsec tunnel) to the remote network. In this step, you enter your router's details in the Microsoft Entra admin center, which tells Microsoft where to expect IKE negotiations to come from.

1. [**Traffic forwarding profile**](#traffic-forwarding-profiles): Associate a traffic forwarding profile with the remote network, which specifies what traffic to acquire over the IPsec tunnel. We use dynamic routing through BGP.

1. [**View CPE connectivity configuration**](#view-cpe-connectivity-configuration): Retrieve the IPsec tunnel details of Microsoft's end of the tunnel. On the **Connectivity** step, you provided your router's details to Microsoft. In this step, you retrieve Microsoft's side of the connectivity configuration.

1. [**Set up your CPE**](#set-up-your-cpe): Take Microsoft's connectivity configuration from the previous step and enter it in the management console of your router or CPE. This step *isn't* in the Microsoft Entra admin center.

## [Microsoft Entra admin center](#tab/microsoft-entra-admin-center) 

Remote networks are configured on three tabs. You must complete each tab in order. After completing the tab either select the next tab from the top of the page, or select the **Next** button at the bottom of the page.

### Basics
The first step is to provide the name and location of your remote network. Completing this tab is required.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Connect** > **Remote networks**.
1. Select the **Create remote network** button and provide the details.
    - **Name**
    - **Region**   

:::image type="content" source="media/how-to-create-remote-networks/create-basics-tab.png" alt-text="Screenshot of the basics tab of the create device link process.":::

### Connectivity

The **Connectivity** tab is where you add the device links for the remote network. You can add device links *after* creating the remote network. You need to provide the device type, public IP address of your CPE, border gateway protocol (BGP) address, and autonomous system number (ASN) for each device link. 

The details required to complete the **Connectivity** tab can be complex. For more information, see [How to manage remote network device links](how-to-manage-remote-network-device-links.md).

### Traffic forwarding profiles

You can assign the remote network to a traffic forwarding profile when you create the remote network. You can also assign the remote network at a later time. For more information, see [Traffic forwarding profiles](concept-traffic-forwarding.md).

1. Either select the **Next** button or select the **Traffic profiles** tab.
1. Select the appropriate traffic forwarding profile.
1. Select the **Review + Create** button.

The final tab in the process is to review all of the settings that you provided. Review the details provided here and select the **Create remote network** button.

### View CPE connectivity configuration

All your remote networks appear on the **Remote network** page. Select the **View configuration** link in the **Connectivity details** column to view your configuration details.

These details contain the connectivity information from Microsoft's side of the bidirectional communication channel that you use to set up your CPE.

This process is covered in detail in the [How to configure your customer premises equipment](how-to-configure-customer-premises-equipment.md).

### Set up your CPE

This step is performed in management console your CPE, not in Microsoft Entra admin center. Until you complete this step, your IPsec *isn't* set up. IPsec is a bidirectional communication. IKE negotiations happen between two parties before the tunnel is successfully set up. So, don't miss this step.

## [Microsoft Graph API](#tab/microsoft-graph-api)

Global Secure Access remote networks can be viewed and managed using Microsoft Graph on the `/beta` endpoint. Creating a remote network and assigning a traffic forwarding profile are separate API calls.

1. Sign in to [Graph Explorer](https://aka.ms/ge).
1. Select `POST` as the `HTTP` method.
1. Select `BETA` as the `AP` version.
1. Run the query.

    ```http
    POST https://graph.microsoft.com/beta/networkaccess/connectivity/branches 
    { 
        "name": "ContosoBranch", 
        "region": "East US", 
        "deviceLinks": [ 
        { 
            "name": "CPE Link 1", 
            "ipAddress": "20.125.118.219", 
            "deviceVendor": "Other", 
            "bgpConfiguration": { 
                "localIpAddress": "172.16.11.5",
                "peerIpAddress": "10.16.11.5", 
                "asn": 8888 
              },
            "redundancyConfiguration": {
                "redundancyTier": "noRedundancy",
                "zoneLocalIpAddress": "1.2.1.1"
            },
            "bandwidthCapacityInMbps": "mbps250"
            "tunnelConfiguration": { 
                  "@odata.type": "#microsoft.graph.networkaccess.tunnelConfigurationIKEv2Default", 
                  "preSharedKey": "Detective5OutgrowDiligence" 
              } 
        }] 
    }  
    ```

### Assign a traffic forwarding profile

Associating a traffic forwarding profile to your remote network using the Microsoft Graph API is two step process. First, locate the ID of the traffic profile. The ID is different for all tenants. Second, associate the traffic forwarding profile with your desired remote network.

1. Sign in to [Graph Explorer](https://aka.ms/ge).
1. Select `PATCH` as the `HTTP` method from the dropdown.
1. Select the `API` version to **beta**.
1. Enter the query.
    ```
    GET https://graph.microsoft.com/beta/networkaccess/forwardingprofiles 
    ```
1. Select **Run query**.
1. Find the `ID` of the desired traffic forwarding profile.
1. Select `PATCH` as the `HTTP` method from the dropdown.
1. Enter the query.
    ```
        PATCH https://graph.microsoft.com/beta/networkaccess/connectivity/branches/d2b05c5-1e2e-4f1d-ba5a-1a678382ef16/forwardingProfiles
        {
            "@odata.context": "#$delta",
            "value":
            [{
                "ID": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            }]
        }
    ```

---

## Verify your remote network configurations

There are a few things to consider and verify when creating remote networks. You might need to double-check some settings.

- **Verify IKE crypto profile**: The crypto profile (IKE phase 1 and phase 2 algorithms) set for a device link should match what is set on the CPE. If you chose the **default IKE policy**, ensure that your CPE is set up with the crypto profile specified in the [Remote network configurations](reference-remote-network-configurations.md) reference article.

- **Verify pre-shared key**: Compare the pre-shared key (PSK) you specified when creating the device link in Microsoft Global Secure Access with the PSK you specified on your CPE. This detail is added on the **Security** tab during the **Add a link** process. For more information, see [How to manage remote network device links.](how-to-manage-remote-network-device-links.md#add-a-link---security-tab).

- **Verify local and peer BGP IP addresses**: The public IP and BGP address you use to configure the CPE must match what you use when you create a device link in Microsoft Global Secure Access.
    - Refer to the [valid BGP addresses](reference-remote-network-configurations.md#valid-bgp-addresses) list for reserved values that can't be used.
    - The local and peer BGP addresses are reversed between the CPE and what is entered in Global Secure Access.
        - **CPE**: Local BGP IP address = IP1, Peer BGP IP address = IP2
        - **Global Secure Access**: Local BGP IP address = IP2, Peer BGP IP address = IP1
    - Choose an IP address for Global Secure Access that doesn't overlap with your on-premises network.

- **Verify ASN**: Global Secure Access uses BGP to advertise routes between two autonomous systems: your network and Microsoft's. These autonomous systems should have different Autonomous System Numbers (ASNs).
    - Refer to the [valid ASN values](reference-remote-network-configurations.md#valid-asn) list for reserved values that can't be used.
    - When creating a remote network in the Microsoft Entra admin center, use your network's ASN.
    - When configuring your CPE, use Microsoft's ASN. Go to **Global Secure Access** > **Devices** > **Remote Networks**. Select **Links** and confirm the value in the **Link ASN** column.

- **Verify your public IP address**: In a test environment or lab setup, the public IP address of your CPE might change unexpectedly. This change can cause the IKE negotiation to fail even though everything remains the same.
    - If you encounter this scenario, complete the following steps:
        - Update the public IP address in the crypto profile of your CPE.
        - Go to the **Global Secure Access** > **Devices** > **Remote Networks**.
        - Select the appropriate remote network, delete the old tunnel, and recreate a new tunnel with the updated public IP address.

- **Verify Microsoft's public IP address**: When you delete a device link and/or create a new one, you might get another public IP endpoint of that link in **View configuration** for that remote network. This change can cause the IKE negotiation to fail. If you encounter this scenario, update the public IP address in the crypto profile of your CPE.

- **Verify BGP connectivity setting on your CPE**: Suppose you create a device link for a remote network. Microsoft provides you with the public IP address, say PIP1, and BGP address, say BGP1, of its gateway. This connectivity information is available under `localConfigurations` in the jSON blob you see when you select **View Configuration** for that remote network. On your CPE, make sure that you have a static route destined to BGP1 sent over the tunnel interface created with PIP1. The route is necessary so that CPE can learn the BGP routes we publish over the IPsec tunnel you created with Microsoft.

- **Verify firewall rules**: Allow User Datagram Protocol (UDP) port 500 and 4500 and Transmission Control Protocol (TCP) port 179 for IPsec tunnel and BGP connectivity in your firewall.
  
- **Port forwarding**: In some situations, the Internet Service Provider (ISP) router is also a network address translation (NAT) device. A NAT converts the private IP addresses of home devices to a public internet-routable device.
    - Generally, a NAT device changes both the IP address and the port. This port changing is the root of the problem.
    - For IPsec tunnels to work, Global Secure Access uses port 500. This port is where IKE negotiation happens.
    - If the ISP router changes this port to something else, Global Secure Access can't identify this traffic and negotiation fails.
    - As a result, phase 1 of IKE negotiation fails and the tunnel isn't established.
    - To remediate this failure, complete the port forwarding on your device, which tells the ISP router to not change the port and forward it as-is.



## Next steps

The next step for getting started with Microsoft Entra Internet Access is to [target the Microsoft traffic profile with Conditional Access policy](how-to-target-resource-microsoft-profile.md).

For more information about remote networks, see the following articles:
- [List remote networks](how-to-list-remote-networks.md)
- [Manage remote networks](how-to-manage-remote-networks.md)
- [Learn how to add remote network device links](how-to-manage-remote-network-device-links.md)
