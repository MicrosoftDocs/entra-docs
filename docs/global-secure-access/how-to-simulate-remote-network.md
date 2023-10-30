---
title: Simulate remote network connectivity with Azure virtual networks
description: Configure Azure resources to simulate remote network connectivity to Microsoft's Security Edge Solutions, Microsoft Entra Internet Access and Microsoft Entra Private Access.
ms.service: network-access
ms.topic: how-to
ms.date: 10/30/2023
ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: absinh
---
# Create a remote network using Azure virtual networks

Organizations might want to extend the capabilities of Microsoft Entra Internet Access to entire networks not just individual devices they can [install the Global Secure Access Client](how-to-install-windows-client.md) on. This article shows how to extend these capabilities to an Azure virtual network hosted in the cloud. Similar principles might be applied to a customer's on-premises network equipment.

:::image type="content" source="media/how-to-simulate-remote-network/simulate-remote-network.png" alt-text="Diagram showing a virtual network in Azure connected to Microsoft Entra Internet Access simulating a customer's network." lightbox="media/how-to-simulate-remote-network/simulate-remote-network.png":::

Building this functionality out in Azure provides organizations the ability to understand how Microsoft Entra Internet Access works in a more broad implementation. The resources we create in Azure correspond to on-premises concepts in the following ways:

| Azure resource | Traditional on-premises component |
| --- | --- |
| **[Virtual network](#virtual-network)** | Your on-premises IP address space. |
| **[Virtual network gateway](#virtual-network-gateway)** | Your on-premises router, sometimes referred to as customer premises equipment (CPE). |
| **[Local network gateway](#3-create-local-network-gateway)** | The Microsoft gateway that your router (Azure virtual network gateway) creates an IPsec tunnel to. |
| **[Connection](#4-create-site-to-site-s2s-vpn-connection)** | IPsec VPN tunnel created between the virtual network gateway and local network gateway. |
| **[Virtual machine](#virtual-machine)** | Client devices on your on-premises network. |

In this document, we use the following default values. Feel free to configure these settings according to your own requirements.

**Subscription:** Visual Studio Enterprise
**Resource group name:** Network_Simulation
**Region:** East US

> [!TIP]
> This article switches between configuration tasks in the [Microsoft Entra admin center](https://entra.microsoft.com) and the [Azure portal](https://portal.azure.com). It might be helpful to have multiple tabs open you can switch between.

## Prerequisites

In order to complete the following steps, you must have these prerequisites in place.

- An Azure subscription and permission to create resources in the [Azure portal](https://portal.azure.com).
   - A basic understanding of [site-to-site VPN connections](/azure/vpn-gateway/tutorial-site-to-site-portal).
- A Microsoft Entra tenant with the [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator) role assigned.
- Completed the [remote network onboarding steps](how-to-create-remote-networks.md#onboard-your-tenant-for-remote-networks).

### Prerequisite infrastructure

Before creating our virtual resources, we need a resource group and virtual network that we use throughout the following sections.

#### Resource group

Create a resource group to contain all of the necessary resources.

1. Sign in to the [Azure portal](https://portal.azure.com) with permission to create resources.
1. Select **Create a resource**.
1. Search for **Resource group** and choose **Create** > **Resource group**.
1. Select your **Subscription**, **Region**, and provide a name for your **Resource group**.
1. Select **Review + create**.
1. Confirm your details, then select **Create**.

> [!TIP]
> If you're using this article for testing Microsoft Entra Internet Access, clean up all related Azure resources by deleting the resource group you create after you're done.

#### Virtual network

Next we need to create a virtual network inside of our resource group.

1. From the Azure portal, select **Create a resource**.
1. Select **Networking** > **Virtual Network**.
1. Select the **Resource group** created previously.
1. Provide your network with a **Name**.
1. Leave the default values for the other fields.
1. Select **Review + create**.
1. Select **Create**.

## Create a virtual network gateway

Next we need to create a virtual network gateway inside of our resource group. 

1. From the Azure portal, select **Create a resource**.
1. Select **Networking** > **Virtual network gateway**.
1. Provide your virtual network gateway with a **Name**.
1. Select the appropriate region.
1. Select the **Virtual network** created in the previous section.
1. Create a **Public IP address** and provide it with descriptive name.
   1. **OPTIONAL**: If you want a secondary IPsec tunnel, under **SECOND PUBLIC IP ADDRESS** section, create another public IP address and give it a name. In this case, you need to create two device links in the Microsoft Entra admin center.
1. Set **Configure BGP** to **Enabled**
   1. Set the **Autonomous system number (ASN)** to an appropriate value.
      1. Don't use any reserved ASN numbers. For more information, see the article [Global Secure Access remote network configurations](reference-remote-network-configurations.md#valid-autonomous-system-number-asn).
1. Leave all other settings to their defaults or blank.
1. Select **Review + create**, confirm your settings.
1. Select **Create**.
   1. You can continue to the following sections while the gateway is created.

:::image type="content" source="media/how-to-simulate-remote-network/create-virtual-network-gateway.png" alt-text="Screenshot of the Azure portal showing configuration settings for a virtual network gateway." lightbox="media/how-to-simulate-remote-network/create-virtual-network-gateway.png":::

## Create remote network and device links

### Create a remote network

You need the public IP addresses of your virtual network gateway. These IP addresses can be found by browsing to the **Configuration** page of your virtual network gateway.

Organizations can add redundancy in two ways:

1. Choose **Zone redundancy** while creating a device link. We create another gateway for you in a different availability zone within the same datacenter **Region** you picked while creating your remote network. In this case, you need just one public IP address on your virtual network gateway. Two IPsec tunnels are created from the same public IP address of your router to different Microsoft gateways in different availability zones.
1. Have a secondary public IP address and create two device links with different public IP addresses. You can choose **No redundancy** then when creating device links. In this case, you need primary and secondary public IP addresses on your virtual network gateway.

In this article, we choose the zone redundancy path.

:::image type="content" source="media/how-to-simulate-remote-network/virtual-network-gateway-public-ip-addresses.png" alt-text="Screenshot showing how to find the public IP addresses of a virtual network gateway." lightbox="media/how-to-simulate-remote-network/virtual-network-gateway-public-ip-addresses.png":::

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access (Preview)** > **Devices** > **Remote network** > **Create remote network**.
1. Provide a **Name** for your network, select an appropriate **Region**, then select **Next: Connectivity**.
1. On the **Connectivity** tab, select **Add a link**.
   1. On the **General** tab:
      1. Provide a **Link name** and set **Device type** to **Other**.
      1. Set the **IP address** to the primary IP address of your virtual network gateway.
      1. Set the **Peer BGP address** to the BGP IP address of your virtual network gateway.
      1. Set the **Local BGP address** to a private IP address that is *outside* the address space of the virtual network associated with your virtual network gateway. For example, if the address space of your virtual network is 10.1.0.0/16, then you can use 10.2.0.0 as your Local BGP address.
      1. Set the **Link ASN** to the ASN of your virtual network gateway.
      1. Set **Redundancy** set to **Zone redundancy**.
      1. Set **Zone Redundant local BGP address** to a private IP address that is *outside* the address space of the virtual network associated with your virtual network gateway. This address must be different from **Local BGP address**.
      1. Set **Bandwidth capacity (Mbps)** to the appropriate setting.
      1. Select Next to continue to the **Details** tab.
   1. On the **Details** tab:
      1. Leave the defaults selected unless you made a different selection previously.
      1. Select Next to continue to the **Security** tab.
   1. On the **Security** tab:
      1. Enter the **Pre-shared key (PSK)**.
   1. Select **Add link**.
   1. Select **Next: Traffic profiles**.
1. On the **Traffic profiles** tab:
   1. Check the box for the **Microsoft 365 traffic profile**.
   1. Select **Next: Review + create**.
1. Confirm your settings and select **Create remote network**.

For more information about remote networks, see the article [How to create a remote network](how-to-create-remote-networks.md).

### View connectivity configuration

1. Browse to **Global Secure Access (Preview)** > **Devices** > **Remote network**.
1. Select **View configuration** button for the remote network you created.
   1. The configuration is shown as a JSON blob.
1. Locate and save Microsoft's public IP address `endpoint`, `asn` and `bgpAddress` from the pane that opens.

Use this information to set up your connectivity in next step. For more information about configuration, see the article [Configure customer premises equipment](how-to-configure-customer-premises-equipment.md).

## Create local network gateway

If you selected **No redundancy** while creating device links in the Microsoft Entra admin center, you need to create just one local network gateway.

If you selected **Zone redundancy**, then you need to create two local network gateways. You have two sets of `endpoint`, `asn` and `bgpAddress` in `localConfigurations` for the device links. This information is provided in **View Configuration** for that remote network in the Microsoft Entra admin center.

1. From the Azure portal, select **Create a resource**.
1. Select **Networking** > **Local network gateway**.
1. Select the **Resource group** created previously.
1. Select the appropriate region.
1. Provide your local network gateway with a **Name**.
1. For **Endpoint**, select **IP address**, then provide the IP address provided in the Microsoft Entra admin center.
1. Select **Next: Advanced**.
1. Set **Configure BGP** to **Yes**
   1. Set the **Autonomous system number (ASN)** to the appropriate value provided in the Microsoft Entra admin center.
   1. Set the **BGP peer IP address** to the appropriate value provided in the Microsoft Entra admin center.
1. Select **Review + create**, confirm your settings.
1. Select **Create**.

Repeat these steps to create another local network gateway with second set of values.

:::image type="content" source="media/how-to-simulate-remote-network/create-local-network-gateway.png" alt-text="Screenshot of the Azure portal showing configuration settings for a local network gateway." lightbox="media/how-to-simulate-remote-network/create-local-network-gateway.png":::

## 4. Create Site-to-site (S2S) VPN connection

You create two connections one for your primary and secondary gateways.

1. From the Azure portal, select **Create a resource**.
1. Select **Networking** > **Connection**.
1. Select the **Resource group** created previously.
1. Under **Connection type**, select **Site-to-site (IPsec)**.
1. Provide a **Name** for the connection, and select the appropriate **Region**.
1. Move to the **Settings** tab.
   1. Select your **Virtual network gateway** and **Local network gateway** created previously.
   1. Enter the same **Shared key (PSK)** that you entered while creating the device link in previous step.
   1. Check the box for **Enable BGP**.
   1. Keep the other default settings.
1. Select **Review + create**, confirm your settings.
1. Select **Create**.

Repeat these steps to create another connection with second local network gateway.

:::image type="content" source="media/how-to-simulate-remote-network/create-site-to-site-connection.png" alt-text="Screenshot of the Azure portal showing configuration settings for a site-to-site connection." lightbox="media/how-to-simulate-remote-network/create-site-to-site-connection.png":::

## Verify connectivity

### Virtual machine

We use the virtual machine (VM) created here to simulate on-premises traffic flows.

1. From the Azure portal, select **Create a resource**.
1. Select **Virtual machine**.
1. Select the **Resource group** created previously.
1. Provide a **Virtual machine name**.
1. Select the Image you want to use, for this example we choose **Windows 11 Pro, version 22H2 - x64 Gen2**
1. Select **Run with Azure Spot discount** for this test.
1. Provide a **Username** and **Password** for your VM
1. Move to the **Networking** tab.
   1. Select the **Virtual network** created previously.
   1. Keep the other networking defaults.
1. Move to the **Management** tab
   1. Check the box **Login with Microsoft Entra ID**
   1. Keep the other management defaults.
1. Select **Review + create**, confirm your settings.
1. Select **Create**.

You might choose to lock down remote access to the network security group to only a specific network or IP.

### Verify connectivity status

After you create the remote networks and connections in the previous steps, it might take a few minutes for the connection to be established. From the Azure portal, we can validate that the VPN tunnel is connected and that BGP peering is successful.

1. In the Azure portal, browse to the **virtual network gateway** created earlier and select **Connections**.
1. Each of the connections should show a **Status** of **Connected** once the configuration is applied and successful.
1. Browsing to **BGP peers** under the **Monitoring** section allows you to confirm that BGP peering is successful. Look for the peer addresses provided by Microsoft. Once configuration is applied and successful, the **Status** should show **Connected**.

:::image type="content" source="media/how-to-simulate-remote-network/verify-connectivity.png" alt-text="Screenshot showing how to find the connection status for your virtual network gateway." lightbox="media/how-to-simulate-remote-network/verify-connectivity.png" :::

You can use the virtual machine you created to validate that traffic is flowing to Microsoft 365 locations like SharePoint Online. Browsing to resources in SharePoint or Exchange Online should result in traffic on your virtual network gateway. This traffic can be seen by browsing to [Metrics on the virtual network gateway](/azure/vpn-gateway/monitor-vpn-gateway#analyzing-metrics) or by [Configuring packet capture for VPN gateways](/azure/vpn-gateway/packet-capture).

## Next steps

- [Tutorial: Create a site-to-site VPN connection in the Azure portal](/azure/vpn-gateway/tutorial-site-to-site-portal)