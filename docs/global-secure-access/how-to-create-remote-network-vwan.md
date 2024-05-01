---
title: Create a remote network using Azure vWAN
description: Create a virtual wide area network to connect to your resources in Azure.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 04/30/2024
ms.author: jayrusso
author: HULKsmashGithub
manager: amycolannino
ms.reviewer: absinh

---
# Create a remote network using Azure vWAN

Organizations might want to extend the capabilities of Microsoft Entra Internet Access to entire networks not just individual devices they can [install the Global Secure Access Client](how-to-install-windows-client.md) on. This article shows how to extend these capabilities to an Azure virtual network hosted in the cloud. Similar principles might be applied to a customer's on-premises network equipment.

## Prerequisites

To complete the steps in this process, you must have the following prerequisites in place:
- An Azure subscription and permission to create resources in the Azure portal.
- A basic understanding of virtual wide area networks (vWAN).
- A Microsoft Entra tenant with the Global Secure Access Administrator role assigned.
- A basic understanding of Azure virtual desktops or Azure virtual machines.

In this document, we use the following default values. Feel free to configure these settings according to your own requirements.
- Subscription: Visual Studio Enterprise
- Resource group name: GlobalSecureAccess_Documentation
- Region: South Central US

## Set up a virtual WAN in the Azure portal
### Create a virtual WAN
Create a virtual wide area network to connect to your resources in Azure. For more information about Virtual WAN, see the [Virtual WAN Overview](https://learn.microsoft.com/en-us/azure/virtual-wan/virtual-wan-about).
1.	From the Azure portal, in the **Search resources** bar, type **Virtual WAN** in the search box and select **Enter**.
1.	Select Virtual WANs from the results. On the Virtual WANs page, select + Create to open the Create WAN page.
1.	On the Create WAN page, on the Basics tab, fill in the fields. Modify the example values to apply to your environment.
    - Subscription: Select the subscription that you want to use.
    - Resource group: Create new or use existing.
    - Resource group location: Choose a resource location from the dropdown. A WAN is a global resource and doesn't live in a particular region. However, you must select a region to manage and locate the WAN resource that you create.
    - Name: Type the Name that you want to call your virtual WAN.
    - Type: Basic or Standard. Select Standard. If you select Basic, understand that Basic virtual WANs can only contain Basic hubs. Basic hubs can only be used for site-to-site connections.
1.	After you finish filling out the fields, at the bottom of the page, select **Review + create**.
 :::image type="content" source="media/how-to-create-remote-network-vwan/create-vwan.png" alt-text="Screenshot of the Create WAN page with completed fields." lightbox="media/how-to-create-remote-network-vwan/create-vwan-expanded.png"::: 

1.	Once validation passes, click Create to create the virtual WAN.

### Create a virtual hub (VPN gateway)
The next step is to create a virtual hub with a site-to-site virtual private network (VPN) gateway. To do so, create a virtual hub:
1.	Within the new vWAN, under **Connectivity**, select **Hubs**.
1.	Select **+ New Hub**.
1.	On the **Create virtual hub** page, on the **Basics** tab, fill in the fields according to your environment.
    - **Region**: Select the region in which you want to deploy the virtual hub.
    - **Name**: The name by which you want the virtual hub to be known.
    - **Hub private address space**: The hub's address range in CIDR notation. The minimum address space is /24 to create a hub.
    - **Virtual hub capacity**: Select from the dropdown. For more information, see [Virtual hub settings](https://learn.microsoft.com/en-us/azure/virtual-wan/hub-settings).
    - **Hub routing preference**: Leave as default. For more information, see Virtual hub routing preference.
:::image type="content" source="media/how-to-create-remote-network-vwan/vwan-create-new-hub-basics.png" alt-text="Screenshot of the Create virtual hub page with completed fields." lightbox="media/how-to-create-remote-network-vwan/vwan-create-new-hub-basics-expanded.png"::: 

1.	Proceed to the **Site to site** tab and complete the following fields:
    - Select **Yes** to create a Site-to-site VPN.
    - AS Number: The AS Number field can't be edited.
    - Gateway scale units: Select the Gateway scale units value from the dropdown. The scale unit lets you pick the aggregate throughput of the VPN gateway being created in the virtual hub to connect sites to.

    If you pick 1 scale unit = 500 Mbps, it implies that two instances for redundancy will be created, each having a maximum throughput of 500 Mbps. For example, if you had five branches, each doing 10 Mbps at the branch, you'll need an aggregate of 50 Mbps at the head end. Planning for aggregate capacity of the Azure VPN gateway should be done after assessing the capacity needed to support the number of branches to the hub.

    - Routing preference: Azure routing preference lets you choose how your traffic routes between Azure and the internet. You can choose to route traffic either via the Microsoft network, or via the ISP network (public internet). These options are also referred to as cold potato routing and hot potato routing, respectively.

    The public IP address in Virtual WAN is assigned by the service, based on the routing option selected. For more information about routing preference via Microsoft network or ISP, see the Routing preference article.
 
[vwan-create-new-hub-site-to-site.png]
1.	Leave the remaining tab options set to their defaults; select Review + create to validate.
1.	Select Create to create the hub and gateway. This can take up to 30 minutes. After 30 minutes, Refresh to view the hub on the Hubs page. Select Go to resource to navigate to the resource.
When you create a new hub, you may notice a Warning message in the portal referring to the router version. This sometimes occurs when the router is provisioning. Once the router is fully provisioned, the message will no longer appear.


## Next steps

- [Tutorial: Create a site-to-site VPN connection in the Azure portal](/azure/vpn-gateway/tutorial-site-to-site-portal)
