---
title: Create a remote network using Azure vWAN
description: Create a virtual wide area network to connect to your resources in Azure.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 05/17/2024
ms.author: jayrusso
author: HULKsmashGithub
manager: amycolannino
ms.reviewer: absinh

---
# Create a remote network using Azure vWAN

In this article, we'll explain how to simulate remote network connectivity using a remote virtual wide-area network (vWAN). If you want to simulate remote network connectivity using an Azure virtual network gateway, see the article, [Create a remote network using Azure virtual networks](/entra/global-secure-access/how-to-simulate-remote-network).

## Prerequisites

To complete the steps in this process, you must have the following prerequisites in place:
- An Azure subscription and permission to create resources in the [Azure portal](https://portal.azure.com).
- A basic understanding of virtual wide area networks (vWAN).
- A basic understanding of [site-to-site VPN connections](/azure/vpn-gateway/tutorial-site-to-site-portal).
- A Microsoft Entra tenant with the [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator) role assigned.
- A basic understanding of Azure virtual desktops or Azure virtual machines.

In this document, we use the following default values. Feel free to configure these settings according to your own requirements.
- Subscription: Visual Studio Enterprise
- Resource group name: GlobalSecureAccess_Documentation
- Region: South Central US

## Set up a virtual WAN in the Azure portal
To set up a virtual WAN, you'll need to complete three sub-steps: create a virtual WAN, create a virtual hub with a site-to-site virtual private network (VPN) gateway, and obtain the VPN gateway information.

### Create a virtual WAN
Create a virtual wide area network to connect to your resources in Azure. For more information about Virtual WAN, see the [Virtual WAN Overview](/azure/virtual-wan/virtual-wan-about).
1.	From the Microsoft Azure portal, in the **Search resources** bar, type **Virtual WAN** in the search box and select **Enter**.
1.	Select **Virtual WANs** from the results. On the Virtual WANs page, select **+ Create** to open the **Create WAN** page.
1.	On the **Create WAN** page, on the **Basics** tab, fill in the fields. Modify the example values to apply to your environment.
    - **Subscription**: Select the subscription that you want to use.
    - **Resource group**: Create new or use existing.
    - **Resource group location**: Choose a resource location from the dropdown. A WAN is a global resource and doesn't live in a particular region. However, you must select a region to manage and locate the WAN resource that you create.
    - **Name**: Type the Name that you want to call your virtual WAN.
    - **Type**: Basic or Standard. Select **Standard**. If you select Basic, understand that Basic virtual WANs can only contain Basic hubs. Basic hubs can only be used for site-to-site connections.
1.	After filling out the fields, at the bottom of the page, select **Review + create**.
 :::image type="content" source="media/how-to-create-remote-network-vwan/create-vwan.png" alt-text="Screenshot of the Create WAN page with completed fields." lightbox="media/how-to-create-remote-network-vwan/create-vwan-expanded.png"::: 

1.	Once validation passes, click **Create** to create the virtual WAN.

### Create a virtual hub with a VPN gateway
Next, create a virtual hub with a site-to-site virtual private network (VPN) gateway:
1.	Within the new vWAN, under **Connectivity**, select **Hubs**.
1.	Select **+ New Hub**.
1.	On the **Create virtual hub** page, on the **Basics** tab, fill in the fields according to your environment.
    - **Region**: Select the region in which you want to deploy the virtual hub.
    - **Name**: The name by which you want the virtual hub to be known.
    - **Hub private address space**: The hub's address range in CIDR notation. The minimum address space is /24 to create a hub.
    - **Virtual hub capacity**: Select from the dropdown. For more information, see [Virtual hub settings](/azure/virtual-wan/hub-settings).
    - **Hub routing preference**: Leave as default. For more information, see [Virtual hub routing preference](/azure/virtual-wan/about-virtual-hub-routing-preference).
:::image type="content" source="media/how-to-create-remote-network-vwan/vwan-create-new-hub-basics.png" alt-text="Screenshot of the Create virtual hub page, on the Basics tab, with completed fields." lightbox="media/how-to-create-remote-network-vwan/vwan-create-new-hub-basics-expanded.png"::: 

1.	Proceed to the **Site to site** tab and complete the following fields:
    - Select **Yes** to create a Site-to-site (VPN gateway).
    - **AS Number**: The AS Number field can't be edited.
    - **Gateway scale units**: Select the value to align with the aggregate throughput of the VPN gateway being created in the virtual hub.
    - **Routing preference**: Choose how your traffic routes between Azure and the internet. For more information about routing preference via Microsoft network or ISP, see the [Routing preference](/azure/virtual-network/ip-services/routing-preference-overview) article.
:::image type="content" source="media/how-to-create-remote-network-vwan/vwan-create-new-hub-site-to-site.png" alt-text="Screenshot of the Create virtual hub page, on the Site to site tab, with completed fields." lightbox="media/how-to-create-remote-network-vwan/vwan-create-new-hub-site-to-site-expanded.png"::: 

1. Leave the remaining tab options set to their defaults and select **Review + create** to validate.
1. Select **Create** to create the hub and gateway. *This can take up to 30 minutes*. 
1. After 30 minutes, **Refresh** to view the hub on the **Hubs** page, and then select **Go to resource** to navigate to the resource.

### Obtain VPN gateway information
To create a remote network in the Microsoft Entra admin center, you’ll need to view and record the VPN gateway information for the virtual hub you created in the previous step.
1.	Within the new vWAN, under **Connectivity**, select **Hubs**.
1.	Select the virtual hub.
1.	Select **VPN (Site to site)**.
1.	On the Virtual Hub page, select the **VPN Gateway** link.
:::image type="content" source="media/how-to-create-remote-network-vwan/vwan-create-new-hub-access-hub-hub-1-vpn-gateway.png" alt-text="Screenshot of the VPN (Site to site) page, with the the VPN Gateway link visible." lightbox="media/how-to-create-remote-network-vwan/vwan-create-new-hub-access-hub-hub-1-vpn-gateway-expanded.png":::
 
1. On the VPN Gateway page, select **JSON View**.
1. Copy the JSON text into a file for reference in upcoming steps. Make note of the **autonomous system number (ASN)**, device **IP address**, and the device **border gateway protocol (BGP) address** to use in the Entra admin center in next step.

> [!TIP]
> You cannot change the ASN value. 

## Create a remote network in the Microsoft Entra admin center
In this step, use the network information from the VPN gateway to create a remote network in the Microsoft Entra admin center. The first step is to provide the name and location of your remote network. This tab is required.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Navigate to **Global Secure Access (preview)** > **Connect** > **Remote networks**.
1. Select the **Create remote network** button and provide the details.
    - **Name**
    - **Region**
1. Proceed to the **Connectivity** tab, where you add the device links for the remote network.
1. Click **+ Add a link**.
1. Complete the fields on the the **General** tab in the **Add a link** form, using the VPN gateway's *Instance0* configuration from the previous step:
    - **Link name**: Name of your Customer Premises Equipment (CPE).
    - **Device type**: Choose a device option from the dropdown list.
    - **IP address**: Public IP address of your device.
    - **Local BGP address**: Enter a BGP IP address that *isn't* part of your on-premises network where your CPE resides.
    - **Peer BGP address**: Enter the BGP IP address of your CPE.
    - **Link ASN**: Provide the autonomous system number (ASN) of the CPE.
    - **Redundancy**: Select either *No redundancy* or *Zone redundancy* for your IPSec tunnel.
    - **Zone redundant local BGP address**: This optional field shows up only when you select **Zone redundancy**.
        - Enter a BGP IP address that isn't* part of your on-premises network where your CPE resides and is different from the **Local BGP address**.
    - **Bandwidth capacity (Mbps)**: Specify tunnel bandwidth. Available options are 250, 500, 750, and 1,000 Mbps.

For more information about links, see the article, [How to manage remote network device links](how-to-manage-remote-network-device-links.md).

1. Select the **Next** button to view the **Details** tab. Keep the default settings.
1. Select the **Next** button to view the **Security** tab. 
1. Enter the **Preshared key (PSK)**. The same secret key must be used on your CPE.
1. Select the **Save** button.

Repeat the above steps to create a second device link with VPN gateway's *Instance1* configuration. 

1. Proceed to the **Traffic profiles** tab to select the traffic profile to link to the remote network. 
1. Select **Microsoft 365 traffic profile**.
1. Select **Review + create**.
1. Select **Create remote network**.

Navigate to the Remote network page to view the details of the new remote network. There should be one **Region** and two **Links**. 
1. Under **Connetivity details**, select the **View configuration** link.
1. Copy the Remote network configuration text into a file for reference in upcoming steps. Make note of the **Endpoint**, **ASN**, and **BGP address** for each of the links.

## Create a VPN site using the Microsoft gateway

### Create a VPN site
1. In the Microsoft Azure Portal, sign in the the virtual hub created above.
1. Navigate to **Connectivity** > **VPN (Site to site)**.
1. Select **+ Create new VPN site**.
1. On the **Create VPN site** page, complete the fields on the **Basics** tab.
1. Proceed to the **Links** tab. For each link, enter the Microsoft gateway configuration from the Remote network configuration noted in the above "view details" step:
    - **Link name**
    - **Link speed**
    - **Link provider name**
    - **Link IP address / FQDN**: Use the Endpoint address.
    - **Link BGP address**: Use the BGP address.
    - **Link ASN**: Use the ASN.
:::image type="content" source="media/how-to-create-remote-network-vwan/create-vwan-create-new-vpn-site-links-enhanced.png" alt-text="Screenshot of the Create VPN page, on the Links tab, with completed fields." lightbox="media/how-to-create-remote-network-vwan/create-vwan-create-new-vpn-site-links_expanded.png"::: 

1. Select **Review + create**.
1. Select **Create**.

### Create a site-to-site connection
In this step, associate the VPN site from the previous step with the hub. Next, remove the default hub association:
1. Navigate to **Connectivity** > **VPN (Site to site)**.
1. Select the **X** to remove the default **Hub association : Connected to this hub** filter so the VPN site appears on the list of available VPN sites.
:::image type="content" source="media/how-to-create-remote-network-vwan/clear-hub-association-filter.png" alt-text="Screenshot of the VPN (Site to site) page with the X highlighted for the hub association filter." lightbox="media/how-to-create-remote-network-vwan/clear-hub-association-filter-expanded.png":::

1. Select the VPN site from the list and select **Connect VPN sites**.
1. In the Connect sites form, type the same **Pre-shared key (PSK)** used for the Entra admin center.
1. Select **Connect**.
1. After about 30 minutes, the VPN site will update to show that the **Connection provisioning status** has succeeded and the **Connectivity status** is connected.
:::image type="content" source="media/how-to-create-remote-network-vwan/provisioning-status-succeeded.png" alt-text="Screenshot of the VPN (Site to site) page showing green checkmarks that indicate that Connection provisioning has succeeded and Connectivity is connected." lightbox="media/how-to-create-remote-network-vwan/provisioning-status-succeeded-expanded.png":::

### Check BGP connectivity and learned routes in Microsoft Azure portal
In this step, use the BGP Dashboard to check the list of learned routes that the site-to-site gateway has learned.
1. Navigate to **Connectivity** > **VPN (Site to site)**.
1. Select the VPN site created above.
1. Select **BGP Dashboard**.

The BGP dashboard lists the **BGP Peers** (VPN gateways and VPN site), which should have a **Status** of **Connected**.
1. To view the list of learned routes, select **Routes the site-to-site gateway is learning**.

The list of **Learned Routes** shows that the site-to-site gateway has learned the M365 routes listed in the M365 traffic profile.
:::image type="content" source="media/how-to-create-remote-network-vwan/BGP-peers-learned-routes.png" alt-text="Screenshot of the Learned Routes page with the learned M365 routes highlighted." lightbox="media/how-to-create-remote-network-vwan/BGP-peers-learned-routes-expanded.png":::

The image below shows the traffic profile **Policies & rules** for the Microsoft 365 profile, which should should match the routes learned from the site-to-site gateway.
:::image type="content" source="media/how-to-create-remote-network-vwan/traffic-profile-match.png" alt-text="Screenshot of the Microsoft 365 traffic forwarding profiles, showing the matching learned routes." lightbox="media/how-to-create-remote-network-vwan/traffic-profile-match-expanded.png":::

### Check connectivity in Microsoft Entra admin center
View the Remote netowk health logs to validate connectivity in the Microsoft Entra admin center.
1. In Microsoft Entra admin center, navigate to **Global Secure Access (Preview)** > **Monitor** > **Remote network health logs**.
1. Select **Add Filter**. 
1. Select **Source IP** and type the source IP address for the VPN gateway's Instance0 or Instance1 IP address. Select **Apply**.
1. The connectivity should be **"Remote network alive"**.

## Test security features with Azure virtual Desktop (AVD)
This step uses Azure Virtual Desktop (AVD) to test tenant restrictions on the virtual netork.

### Create a virtual network
1. In the Azure portal, search for and select **Virtual networks**.
1. On the **Virtual networks** page, select **+ Create**.
1. Complete the **Basics** tab and select **Next** to proceed to the **Security** tab.
1. In the **Azure Bastion** section, select **Enable Bastion**, type the **Azure Bastion host name**, and select the **Azure Bastion public IP address**.
1. Select **Next** to proceed to the **IP Addresses tab** tab. Configure the address space of the virtual network with one or more IPv4 or IPv6 address ranges.
> [!TIP]
> Don’t use an overlapping address space. For example, if the virtual hub created above uses the address space 10.0.0.0/16, create this virtual network with the address space 10.2.0.0/16.
1. Select **Review + create**. When validation passes, select **Create**.

### Add a virtual network connection to the virtual WAN
1. Open the virtual WAN created above and navigate to **Connectivity** > **Virtual network connections**.
1. Select **+ Add connection**.
1. Complete the **Add connection** form, using the virtual **Hub** and **Virtual network** created in previous sections. Leave the remaining fields set to their default values.
1. Select **Create**. 

### Create an Azure virtual Desktop
1. In the Azure portal, search for and select **Azure Virtual desktop**.
1. On the **Azure Virtual Desktop** page, select **Create a host pool**.
1. Complete the **Basics** tab with the following:
    * The **Host pool name**.
    * The **Location** of where the Azure Virtual Desktop object is located.  
    * **Preferred app group type**: Desktop 
    * **Host pool type**: Pooled
    * **Load balancing algorithm**: Breadth-first
    * **Max session limit**: 2
1. Select **Next: Virtual Machines**.
1. Complete the **Next: Virtual Machines** tab with the following:
    * **Add virtual machines**: Yes 
    * The desired **Resource group**. 
    * **Name prefix**: avd 
    * **Virtual machine type**: Azure virtual machine 
    * **Virtual machine location**: East US 
    * **Availability options**: No infrastructure redundancy required 
    * **Security type**: Trusted launch virtual machine 
    * **Enable secure boot**: Yes 
    * **Enable vTPM**: Yes 
    * **Image**: Windows 11 Enterprise multi-session + Microsoft 365 apps version 22H2 
    * **Virtual machine size**: Standard D2s v3, 2 vCPU's, 8 GiB memory 
    * **Number of VMs**: 1 
    * Select the virtual network created in previous step. 
    * **Domain to join**: Microsoft Entra ID 
    * Enter the admin account credentials. 
1. Leave other options to default and select **Review + create**.
1. When validation passes, select **Create**.
1. After about 30 minutes, the host pool will update to show that the deployment is complete.
1. Navigate to Microsoft Azure **Home** and select **Virtual machines**.
1. Select the virtual machine created above.
1. Select **Connect** > **Connect via Bastion**.
1. Select **Deploy Bastion**. The system will take about 30 minutes to provision the Bastion host.
1. After the Bastion is deployed, enter the same admin credentials used to create the Azure Virtual Desktop. 
1. Select **Connect**. The virtual desktop launches.

### Test the tenant restriction
Before testing, enable tenant restrictions on the virtual network.
1. In Microsoft Entra admin center, navigate to **Global Secure Access (Preview)** > **Global settings** > **Session management**.
1. Set the **Enable tagging to enforce tenant restrictions on your network** toggle to on.
1. Select **Save**.
1. To modify the cross-tenant access policy by navigating to **Identity** > **External identities** > **Cross-tenant access settings**. For more information, see the article, [Cross-tenant access overview](../external-id/cross-tenant-access-overview.md).
1. Keep the default settings, which prevent users from logging in with external accounts on managed devices. 

To test:
1. Log in to the Azure Virtual Desktop virtual machine created in the previous steps.
1. Go to www.office.com and log in with an internal organization ID. This test should pass successfully.
1. Repeat the above step, but with an *external account*. This test should fail due to blocked access.

### Test source IP restoration
Before testing, enable conditional access.
1. In Microsoft Entra admin center, navigate to **Global Secure Access (Preview)** > **Global settings** > **Session management**.
1. Select the **Adaptive Access** tab.
1. Set the **Enable Global Secure Access signaling in Conditional Access** toggle to on.
1. Select **Save**. For more information, see the article, [Source IP restoration](how-to-source-ip-restoration.md).

To test (option 1):
1. Log in to the Azure Virtual Desktop virtual machine created in the previous steps.
1. Go to www.office.com and log in with an internal organization ID. This test should pass successfully.
1. Repeat the above step, but with an external account. This test should fail due to blocked access.

To test (option 2):
1. In Microsoft Entra admin center, navigate to **Global Secure Access (Preview)** > **Monitor** > **Remote network health logs**.
1. Select **Add Filter**. 
1. Select **Source IP** and type the VPN gateway public IP address. Select **Apply**.
:::image type="content" source="media/how-to-create-remote-network-vwan/test-option-one.png" alt-text="Screenshot of the Remote network health logs page with the Add filter menu open ready to type the Source IP." lightbox="media/how-to-create-remote-network-vwan/test-option-one-expanded.png":::

The system restores the branch office's customer premises equipment (CPE) IP address. Becasue the VPN gateway represents the CPE, the health logs show the public IP address of the VPN gateway, not the proxy's IP address.

## Next steps

- [Tutorial: Create a site-to-site VPN connection in the Azure portal](/azure/vpn-gateway/tutorial-site-to-site-portal)
