---
title: Simulate remote network connectivity using Azure vWAN
description: Use Global Secure Access to configure Azure and Microsoft Entra resources to create a virtual wide area network to connect to your resources in Azure.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 02/25/2025
ms.author: jayrusso
author: HULKsmashGithub
manager: femila
ms.reviewer: absinh
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to simulate a virtual wide area network to connect resources in Azure so I can better understand how Global Secure Access can be implemented in my organization.
---
# Simulate remote network connectivity using Azure vWAN

This article explains how to simulate remote network connectivity using a remote virtual wide-area network (vWAN). If you want to simulate remote network connectivity using an Azure virtual network gateway (VNG), see the article, [Simulate remote network connectivity using Azure VNG](/entra/global-secure-access/how-to-simulate-remote-network).

## Prerequisites

To complete the steps in this process, you must have the following prerequisites in place:
- An Azure subscription and permission to create resources in the [Azure portal](https://portal.azure.com).
- A basic understanding of virtual wide area networks (vWAN).
- A basic understanding of [site-to-site VPN connections](/azure/vpn-gateway/tutorial-site-to-site-portal).
- A Microsoft Entra tenant with the [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator) role assigned.
- A basic understanding of Azure virtual desktops or Azure virtual machines.

This document uses the following example values, along with the values in the images and steps. Feel free to configure these settings according to your own requirements.
- Subscription: Visual Studio Enterprise
- Resource group name: GlobalSecureAccess_Documentation
- Region: South Central US

## High-level steps
The steps to create a remote network using Azure vWAN require access to both the Azure portal and the Microsoft Entra admin center. To switch between them easily, keep Azure and Microsoft Entra open in separate tabs. Because certain resources can take more than 30 minutes to deploy, set aside at least two hours to complete this process. Reminder: Resources left running can cost you money. When done testing, or at the end of a project, it's a good idea to remove the resources that you no longer need.

1. [Set up a vWAN in the Azure portal](#set-up-a-vwan-in-the-azure-portal)
    1. [Create a vWAN](#create-a-vwan)
    1. [Create a virtual hub with a site-to-site VPN gateway](#create-a-virtual-hub-with-a-vpn-gateway)
        *The virtual hub takes about 30 minutes to deploy.*
    1. [Obtain VPN gateway information](#obtain-vpn-gateway-information)
1. [Create a remote network in the Microsoft Entra admin center](#create-a-remote-network-in-the-microsoft-entra-admin-center)
1. [Create a VPN site using the Microsoft gateway](#create-a-vpn-site-using-the-microsoft-gateway)
    1. [Create a VPN site](#create-a-vpn-site)
    1. [Create a site-to-site connection](#create-a-site-to-site-connection)
        *The site-to-site connection takes about 30 minutes to deploy.*
    1. [Check border gateway protocol connectivity and learned routes in Microsoft Azure portal](#check-bgp-connectivity-and-learned-routes-in-microsoft-azure-portal)
    1. [Check connectivity in Microsoft Entra admin center](#check-connectivity-in-microsoft-entra-admin-center)
1. [Configure security features for testing](#configure-security-features-for-testing)
    1. [Create a virtual network](#create-a-virtual-network)
    1. [Add a virtual network connection to the vWAN](#add-a-virtual-network-connection-to-the-vwan)
    1. [Create an Azure virtual Desktop](#create-an-azure-virtual-desktop)
        *The Azure virtual Desktop takes about 30 minutes to deploy. The Bastion takes another 30 minutes.*
1. [Test security features with Azure virtual Desktop (AVD)](#test-security-features-with-azure-virtual-desktop-avd)
    1. [Test the tenant restriction](#test-the-tenant-restriction)
    1. [Test source IP restoration](#test-source-ip-restoration)


## Set up a vWAN in the Azure portal
There are three main steps to set up a vWAN:
1. [Create a vWAN](#create-a-vwan)
1. [Create a virtual hub with a site-to-site VPN gateway](#create-a-virtual-hub-with-a-vpn-gateway)
1. [Obtain VPN gateway information](#obtain-vpn-gateway-information)

### Create a vWAN
Create a vWAN to connect to your resources in Azure. For more information about vWAN, see the [vWAN Overview](/azure/virtual-wan/virtual-wan-about).
1.	From the Microsoft Azure portal, in the **Search resources** bar, type **vWAN** in the search box and select **Enter**.
1.	Select **vWANs** from the results. On the vWANs page, select **+ Create** to open the **Create WAN** page.
1.	On the **Create WAN** page, on the **Basics** tab, fill in the fields. Modify the example values to apply to your environment.
    - **Subscription**: Select the subscription that you want to use.
    - **Resource group**: Create new or use existing.
    - **Resource group location**: Choose a resource location from the dropdown. A WAN is a global resource and doesn't live in a particular region. However, you must select a region to manage and locate the WAN resource that you create.
    - **Name**: Type the Name that you want to call your vWAN.
    - **Type**: Basic or Standard. Select **Standard**. If you select Basic, understand that Basic vWANs can only contain Basic hubs. Basic hubs can only be used for site-to-site connections.
1.	After filling out the fields, at the bottom of the page, select **Review + create**.
 :::image type="content" source="media/how-to-create-remote-network-vwan/create-vwan.png" alt-text="Screenshot of the Create WAN page with completed fields." lightbox="media/how-to-create-remote-network-vwan/create-vwan-expanded.png"::: 
1.	Once validation passes, select the **Create** button.

### Create a virtual hub with a VPN gateway
Next, create a virtual hub with a site-to-site virtual private network (VPN) gateway:
1.	Within the new vWAN, under **Connectivity**, select **Hubs**.
1.	Select **+ New Hub**.
1.	On the **Create virtual hub** page, on the **Basics** tab, fill in the fields according to your environment.
    - **Region**: Select the region in which you want to deploy the virtual hub.
    - **Name**: The name by which you want the virtual hub to be known.
    - **Hub private address space**: For this example, use 10.101.0.0/24. To create a hub, the address range must be in Classless Inter-Domain Routing (CIDR) notation and have a minimum address space of /24.
    - **Virtual hub capacity**: For this example, select **2 Routing Infrastructure Units, 3 Gbps Router, Supports 2000 VMs**. For more information, see [Virtual hub settings](/azure/virtual-wan/hub-settings).
    - **Hub routing preference**: Leave as default. For more information, see [Virtual hub routing preference](/azure/virtual-wan/about-virtual-hub-routing-preference).
    - Select **Next : Site to site >**.
:::image type="content" source="media/how-to-create-remote-network-vwan/vwan-create-new-hub-basics.png" alt-text="Screenshot of the Create virtual hub page, on the Basics tab, with completed fields." lightbox="media/how-to-create-remote-network-vwan/vwan-create-new-hub-basics-expanded.png"::: 
1.	On the **Site to site** tab, complete the following fields:
    - Select **Yes** to create a Site-to-site (VPN gateway).
    - **AS Number**: The AS Number field can't be edited.
    - **Gateway scale units**: For this example, select **1 scale unit - 500 Mbps x 2**. This value should align with the aggregate throughput of the VPN gateway being created in the virtual hub.
    - **Routing preference**: For this example, select **Microsoft network** for how to route your traffic between Azure and the internet. For more information about routing preference via a Microsoft network or Internet Service Provider (ISP), see the [Routing preference](/azure/virtual-network/ip-services/routing-preference-overview) article.
:::image type="content" source="media/how-to-create-remote-network-vwan/vwan-create-new-hub-site-to-site.png" alt-text="Screenshot of the Create virtual hub page, on the Site to site tab, with completed fields." lightbox="media/how-to-create-remote-network-vwan/vwan-create-new-hub-site-to-site-expanded.png"::: 
1. Leave the remaining tab options set to their defaults and select **Review + create** to validate.
1. Select **Create** to create the hub and gateway. *This process can take up to 30 minutes*. 
1. After 30 minutes, **Refresh** to view the hub on the **Hubs** page, and then select **Go to resource** to navigate to the resource.

### Obtain VPN gateway information
To create a remote network in the Microsoft Entra admin center, you need to view and record the VPN gateway information for the virtual hub you created in the previous step.
1.	Within the new vWAN, under **Connectivity**, select **Hubs**.
1.	Select the virtual hub.
1.	Select **VPN (Site to site)**.
1.	On the Virtual Hub page, select the **VPN Gateway** link.
:::image type="content" source="media/how-to-create-remote-network-vwan/vwan-create-new-hub-access-hub-hub-1-vpn-gateway.png" alt-text="Screenshot of the VPN (Site to site) page, with the VPN Gateway link visible." lightbox="media/how-to-create-remote-network-vwan/vwan-create-new-hub-access-hub-hub-1-vpn-gateway-expanded.png":::
1. On the VPN Gateway page, select **JSON View**.
1. Copy the JSON text into a file for reference in upcoming steps. Make note of the **autonomous system number (ASN)**, device **IP address**, and the device **border gateway protocol (BGP) address** to use in the Microsoft Entra admin center in the next step.
    ```json
       "bgpSettings": {
            "asn": 65515,
            "peerWeight": 0,
            "bgpPeeringAddresses": [
                {
                    "ipconfigurationId": "Instance0",
                    "defaultBgpIpAddresses": [
                        "10.101.0.12"
                    ],
                    "customBgpIpAddresses": [],
                    "tunnelIpAddresses": [
                        "203.0.113.250",
                        "10.101.0.4"
                    ]
                },
                {
                    "ipconfigurationId": "Instance1",
                    "defaultBgpIpAddresses": [
                        "10.101.0.13"
                    ],
                    "customBgpIpAddresses": [],
                    "tunnelIpAddresses": [
                        "203.0.113.251",
                        "10.101.0.5"
                    ]
                }
            ]
        }

> [!TIP]
> You cannot change the ASN value. 

## Create a remote network in the Microsoft Entra admin center
In this step, use the network information from the VPN gateway to create a remote network in the Microsoft Entra admin center. The first step is to provide the name and location of your remote network.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator).
1. Navigate to **Global Secure Access** > **Connect** > **Remote networks**.
1. Select the **Create remote network** button and provide the details.
    - **Name**: For this example, use Azure_vWAN.
    - **Region**: For this example, select **South Central US**.
1. Select **Next: Connectivity** to proceed to the **Connectivity** tab.
:::image type="content" source="media/how-to-create-remote-network-vwan/entra-create-remote-network-basics-tab.png" alt-text="Screenshot of the Create a remote network page on the Basics tab, with the Next: Connectivity button highlighted." lightbox="media/how-to-create-remote-network-vwan/entra-create-remote-network-basics-tab-expanded.png":::
1. On the **Connectivity** tab, add device links for the remote network. Create one link for the VPN gateway's *Instance0* and another link for the VPN gateway's *Instance1*:
    1. Select **+ Add a link**.
    1. Complete the fields on the **General** tab in the **Add a link** form, using the VPN gateway's *Instance0* configuration from the JSON view:
        - **Link name**: Name of your Customer Premises Equipment (CPE). For this example, **Instance0**.
        - **Device type**: Choose a device option from the dropdown list. Set to **Other**.
        - **Device IP address**: Public IP address of your device. For this example, use **203.0.113.250**.
        - **Device BGP address**: Enter the Border Gateway Protocol (BGP) IP address of your CPE. For this example, use **10.101.0.4**.
        - **Device ASN**: Provide the autonomous system number (ASN) of the CPE. For this example, the ASN is **65515**.
        - **Redundancy**: Set to **No redundancy**.
        - **Zone redundant local BGP address**: This optional field shows up only when you select **Zone redundancy**.
            - Enter a BGP IP address that *isn't* part of your on-premises network where your CPE resides and is different from the **Local BGP address**.
        - **Bandwidth capacity (Mbps)**: Specify tunnel bandwidth. For this example, set to **250 Mbps**.
        - **Local BGP address**: Use a BGP IP address that *isn't* part of your on-premises network where your CPE resides, such as **192.168.10.10**.
            - Refer to the [valid BGP addresses](reference-remote-network-configurations.md#valid-bgp-addresses) list for reserved values that can't be used.    
    
            :::image type="content" source="media/how-to-create-remote-network-vwan/vwan-json-add-a-link-general-crop.png" alt-text="Screenshot of the Add a link form with arrows showing the relationship between the JSON code and the link information.":::
    1. Select the **Next** button to view the **Details** tab. Keep the default settings.
    1. Select the **Next** button to view the **Security** tab. 
    1. Enter the **Preshared key (PSK)**. The same secret key must be used on your CPE.
    1. Select the **Save** button.
 
For more information about links, see the article, [How to manage remote network device links](how-to-manage-remote-network-device-links.md).
   
1. Repeat the above steps to create a second device link using the VPN gateway's *Instance1* configuration.
    1. Select **+ Add a link**.
    1. Complete the fields on the **General** tab in the **Add a link** form, using the VPN gateway's *Instance1* configuration from the JSON view:
        - **Link name**: Instance1
        - **Device type**: Other
        - **Device IP address**: 203.0.113.251
        - **Device BGP address**: 10.101.0.5
        - **Device ASN**: 65515
        - **Redundancy**: No redundancy
        - **Bandwidth capacity (Mbps)**: 250 Mbps
        - **Local BGP address**: 192.168.10.11
    1. Select the **Next** button to view the **Details** tab. Keep the default settings.
    1. Select the **Next** button to view the **Security** tab. 
    1. Enter the **Preshared key (PSK)**. The same secret key must be used on your CPE.
    1. Select the **Save** button.
1. Proceed to the **Traffic profiles** tab to select the traffic profile to link to the remote network. 
1. Select **Microsoft 365 traffic profile**.
1. Select **Review + create**.
1. Select **Create remote network**.

Navigate to the Remote network page to view the details of the new remote network. There should be one **Region** and two **Links**. 
1. Under **Connectivity details**, select the **View configuration** link.
:::image type="content" source="media/how-to-create-remote-network-vwan/vwan-view-configuration.png" alt-text="Screenshot of the Remote network page with the newly created region, its two links, and the View configuration link highlighted." lightbox="media/how-to-create-remote-network-vwan/vwan-view-configuration-expanded.png":::
1. Copy the Remote network configuration text into a file for reference in upcoming steps. Make note of the **Endpoint**, **ASN**, and **BGP address** for each of the links (**Instance0** and **Instance1**).
    ```json
       {
      "id": "68d2fab0-0efd-48af-bb17-d793f8ec8bd8",
      "displayName": "Instance0",
      "localConfigurations": [
        {
          "endpoint": "203.0.113.32",
          "asn": 65476,
          "bgpAddress": "192.168.10.10",
          "region": "southCentralUS"
        }
      ],
      "peerConfiguration": {
        "endpoint": "203.0.113.250",
        "asn": 65515,
        "bgpAddress": "10.101.0.4"
      }
    },
    {
      "id": "26500385-b1fe-4a1c-a546-39e2d0faa31f",
      "displayName": "Instance1",
      "localConfigurations": [
        {
          "endpoint": "203.0.113.34",
          "asn": 65476,
          "bgpAddress": "192.168.10.11",
          "region": "southCentralUS"
        }
      ],
      "peerConfiguration": {
        "endpoint": "203.0.113.251",
        "asn": 65515,
        "bgpAddress": "10.101.0.5"
      }
    }
     ```
    

## Create a VPN site using the Microsoft gateway
In this step, create a VPN site, associate the VPN site with the hub, and then validate the connection.

### Create a VPN site
1. In the Microsoft Azure portal, sign in the virtual hub created in the previous steps.
1. Navigate to **Connectivity** > **VPN (Site to site)**.
1. Select **+ Create new VPN site**.
1. On the **Create VPN site** page, complete the fields on the **Basics** tab.
1. Proceed to the **Links** tab. For each link, enter the Microsoft gateway configuration from the Remote network configuration noted in the "view details" step:
    - **Link name**: For this example, **Instance0**; **Instance1**.
    - **Link speed**: For this example, **250** for both links.
    - **Link provider name**: Set to **Other** for both links.
    - **Link IP address / FQDN**: Use the Endpoint address. For this example, **203.0.113.32**; **203.0.113.34**.
    - **Link BGP address**: Use the BGP address, **192.168.10.10**; **192.168.10.11**.
    - **Link ASN**: Use the ASN. For this example, **65476** for both links.
:::image type="content" source="media/how-to-create-remote-network-vwan/create-vwan-create-new-vpn-site-links-enhanced.png" alt-text="Screenshot of the Create VPN page, on the Links tab, with completed fields."::: 
1. Select **Review + create**.
1. Select **Create**.

### Create a site-to-site connection
In this step, associate the VPN site from the previous step with the hub. Next, remove the default hub association:
1. Navigate to **Connectivity** > **VPN (Site to site)**.
1. Select the **X** to remove the default **Hub association : Connected to this hub** filter so the VPN site appears on the list of available VPN sites.
:::image type="content" source="media/how-to-create-remote-network-vwan/clear-hub-association-filter.png" alt-text="Screenshot of the VPN (Site to site) page with the X highlighted for the hub association filter." lightbox="media/how-to-create-remote-network-vwan/clear-hub-association-filter-expanded.png":::
1. Select the VPN site from the list and select **Connect VPN sites**.
1. In the Connect sites form, type the same **Pre-shared key (PSK)** used for the Microsoft Entra admin center.
1. Select **Connect**.
1. After about 30 minutes, the VPN site updates to show success icons for both the **Connection provisioning status** and **Connectivity status**.
:::image type="content" source="media/how-to-create-remote-network-vwan/provisioning-status-succeeded.png" alt-text="Screenshot of the VPN (Site to site) page showing a successful status for both Connection provisioning and Connectivity." lightbox="media/how-to-create-remote-network-vwan/provisioning-status-succeeded-expanded.png":::

### Check BGP connectivity and learned routes in Microsoft Azure portal
In this step, use the BGP Dashboard to check the list of learned routes that the site-to-site gateway is learning.
1. Navigate to **Connectivity** > **VPN (Site to site)**.
2. Select the VPN site created the previous steps.
3. Select **BGP Dashboard**.

The BGP dashboard lists the **BGP Peers** (VPN gateways and VPN site), which should have a **Status** of **Connected**.

4. To view the list of learned routes, select **Routes the site-to-site gateway is learning**.

The list of **Learned Routes** shows that the site-to-site gateway is learning the Microsoft 365 routes listed in the Microsoft 365 traffic profile.
:::image type="content" source="media/how-to-create-remote-network-vwan/list-of-bgp-learned-routes.png" alt-text="Screenshot of the Learned Routes page with the learned Microsoft 365 routes highlighted." lightbox="media/how-to-create-remote-network-vwan/list-of-bgp-learned-routes-expanded.png":::

The following image shows the traffic profile **Policies & rules** for the Microsoft 365 profile, which should match the routes learned from the site-to-site gateway.
:::image type="content" source="media/how-to-create-remote-network-vwan/traffic-profile-match.png" alt-text="Screenshot of the Microsoft 365 traffic forwarding profiles, showing the matching learned routes." lightbox="media/how-to-create-remote-network-vwan/traffic-profile-match-expanded.png":::

### Check connectivity in Microsoft Entra admin center
View the Remote network health logs to validate connectivity in the Microsoft Entra admin center.
1. In Microsoft Entra admin center, navigate to **Global Secure Access** > **Monitor** > **Remote network health logs**.
1. Select **Add Filter**. 
1. Select **Source IP** and type the source IP address for the VPN gateway's *Instance0* or *Instance1* IP address. Select **Apply**.
1. The connectivity should be **"Remote network alive"**.

You can also validate by filtering by **tunnelConnected** or **BGPConnected**. For more information, see [What are remote network health logs?](/entra/global-secure-access/how-to-remote-network-health-logs).

## Configure security features for testing
In this step, we prepare for testing by configuring a virtual network, adding a virtual network connection to the vWAN, and creating an Azure Virtual Desktop.

### Create a virtual network
In this step, use the Azure portal to create a virtual network.
1. In the Azure portal, search for and select **Virtual networks**.
1. On the **Virtual networks** page, select **+ Create**.
1. Complete the **Basics** tab, including the **Subscription**, **Resource group**, **Virtual network name**, and the **Region**.
1. Select **Next** to proceed to the **Security** tab.
1. In the **Azure Bastion** section, select **Enable Bastion**.
    - Type the **Azure Bastion host name**. For this example, use **Virtual_network_01-bastion**.
    - Select the **Azure Bastion public IP address**. For this example, select **(New) default**.
    :::image type="content" source="media/how-to-create-remote-network-vwan/vwan-bastion-settings.png" alt-text="Screenshot of the Create virtual network screen, on the Security tab, showing the Bastion settings.":::
1. Select **Next** to proceed to the **IP addresses tab** tab. Configure the address space of the virtual network with one or more IPv4 or IPv6 address ranges.
> [!TIP]
> Don’t use an overlapping address space. For example, if the virtual hub created in the previous steps uses the address space 10.0.0.0/16, create this virtual network with the address space 10.2.0.0/16.
7. Select **Review + create**. When validation passes, select **Create**.

### Add a virtual network connection to the vWAN
In this step, connect the virtual network to the vWAN.
1. Open the vWAN created in the previous steps and navigate to **Connectivity** > **Virtual network connections**.
1. Select **+ Add connection**.
1. Complete the **Add connection** form, selecting the values from the virtual hub and virtual network created in previous sections:
    - **Connection name**: VirtualNetwork
    - **Hubs**: hub1
    - **Subscription**: Contoso Azure Subscription
    - **Resource group**: GlobalSecureAccess_Documentation
    - **Virtual network**: VirtualNetwork
1. Leave the remaining fields set to their default values and select **Create**.
:::image type="content" source="media/how-to-create-remote-network-vwan/vwan-add-connection.png" alt-text="Screenshot of the Add connection form with example information in the required fields." lightbox="media/how-to-create-remote-network-vwan/vwan-add-connection-expanded.png":::

### Create an Azure Virtual Desktop
In this step, create a virtual desktop and host it with Bastion.
1. In the Azure portal, search for and select **Azure Virtual Desktop**.
1. On the **Azure Virtual Desktop** page, select **Create a host pool**.
1. Complete the **Basics** tab with the following:
    * The **Host pool name**. For this example, **VirtualDesktops**. 
    * The **Location** of the Azure Virtual Desktop object. In this case, **South Central US**.  
    * **Preferred app group type**: select **Desktop**.
    * **Host pool type**: select **Pooled**.
    * **Load balancing algorithm**: select **Breadth-first**.
    * **Max session limit**: select **2**.
1. Select **Next: Virtual Machines**.
1. Complete the **Next: Virtual Machines** tab with the following:
    * **Add virtual machines**: Yes 
    * The desired **Resource group**. For this example, **GlobalSecureAccess_Documentation**.
    * **Name prefix**: avd 
    * **Virtual machine type**: select **Azure virtual machine**.
    * **Virtual machine location**: **South Central US**.
    * **Availability options**: select **No infrastructure redundancy required**. 
    * **Security type**: select **Trusted launch virtual machine**.
    * **Enable secure boot**: Yes 
    * **Enable vTPM**: Yes 
    * **Image**: For this example, select **Windows 11 Enterprise multi-session + Microsoft 365 apps version 22H2**.
    * **Virtual machine size**: select **Standard D2s v3, 2 vCPU's, 8-GB memory**.
    * **Number of VMs**: 1 
    * **Virtual network**: select the virtual network created in previous step, **VirtualNetwork**. 
    * **Domain to join**: select **Microsoft Entra ID**.
    * Enter the admin account credentials. 
1. Leave other options to default and select **Review + create**.
1. When validation passes, select **Create**.
1. After about 30 minutes, the host pool will update to show that the deployment is complete.
1. Navigate to Microsoft Azure **Home** and select **Virtual machines**.
1. Select the virtual machine created in the previous steps.
1. Select **Connect** > **Connect via Bastion**.
1. Select **Deploy Bastion**. The system takes about 30 minutes to deploy the Bastion host.
1. After the Bastion is deployed, enter the same admin credentials used to create the Azure Virtual Desktop. 
1. Select **Connect**. The virtual desktop launches.

## Test security features with Azure Virtual Desktop (AVD)
In this step, we use the AVD to test access restrictions to the virtual network.

### Test the tenant restriction
Before testing, enable tenant restrictions on the virtual network.
1. In Microsoft Entra admin center, navigate to **Global Secure Access** > **Settings** > **Session management**.
1. Set the **Enable tagging to enforce tenant restrictions on your network** toggle to on.
1. Select **Save**.
1. You can modify the cross-tenant access policy by navigating to **Entra ID** > **External Identities** > **Cross-tenant access settings**. For more information, see the article, [Cross-tenant access overview](../external-id/cross-tenant-access-overview.md).
1. Keep the default settings, which prevent users from logging in with external accounts on managed devices.

To test:
1. Sign in to the Azure Virtual Desktop virtual machine created in the previous steps.
1. Go to www.office.com and sign in with an internal organization ID. This test should pass successfully.
1. Repeat the previous step, but with an *external account*. This test should fail due to blocked access.   
:::image type="content" source="media/how-to-create-remote-network-vwan/access-blocked-troubleshooting-details-without-highlight.png" alt-text="Screenshot of the 'Access is blocked' message.":::

### Test source IP restoration
Before testing, enable Conditional Access.
1. In Microsoft Entra admin center, navigate to **Global Secure Access** > **Settings** > **Session management**.
1. Select the **Adaptive Access** tab.
1. Set the **Enable Global Secure Access signaling in Conditional Access** toggle to on.
1. Select **Save**. For more information, see the article, [Source IP restoration](how-to-source-ip-restoration.md).

To test (option 1):
Repeat the tenant restriction test from the previous section: 
1. Sign in to the Azure Virtual Desktop virtual machine created in the previous steps.
1. Go to www.office.com and sign in with an internal organization ID. This test should pass successfully.
1. Repeat the previous step, but with an *external account*. This test should fail because the source **IP address** in the error message is coming from the VPN gateway public IP address instead of the Microsoft SSE proxying the request to Microsoft Entra.   
:::image type="content" source="media/how-to-create-remote-network-vwan/access-blocked-troubleshooting-details-with-highlight.png" alt-text="Screenshot of the 'Access is blocked' message with the IP address highlighted.":::

To test (option 2):
1. In Microsoft Entra admin center, navigate to **Global Secure Access** > **Monitor** > **Remote network health logs**.
1. Select **Add Filter**. 
1. Select **Source IP** and type the VPN gateway public IP address. Select **Apply**.
:::image type="content" source="media/how-to-create-remote-network-vwan/remote-network-health-logs-filter.png" alt-text="Screenshot of the Remote network health logs page with the Add filter menu open ready to type the Source IP.":::

The system restores the branch office's customer premises equipment (CPE) IP address. Because the VPN gateway represents the CPE, the health logs show the public IP address of the VPN gateway, not the proxy's IP address.

## Remove unneeded resources
When done testing, or at the end of a project, it's a good idea to remove the resources that you no longer need. Resources left running can cost you money. You can delete resources individually or delete the resource group to delete the entire set of resources.