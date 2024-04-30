---
title: Create a remote network using Azure vWAN
description: Create a virtual wide area network to connect to your resources in Azure.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 04/29/2024
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
Create a virtual wide area network to connect to your resources in Azure. For more information about Virtual WAN, see the Virtual WAN Overview.
1.	From the Azure portal, in the Search resources bar, type Virtual WAN in the search box and select Enter.
2.	Select Virtual WANs from the results. On the Virtual WANs page, select + Create to open the Create WAN page.
3.	On the Create WAN page, on the Basics tab, fill in the fields. Modify the example values to apply to your environment.
    - Subscription: Select the subscription that you want to use.
    - Resource group: Create new or use existing.
    - Resource group location: Choose a resource location from the dropdown. A WAN is a global resource and doesn't live in a particular region. However, you must select a region to manage and locate the WAN resource that you create.
    - Name: Type the Name that you want to call your virtual WAN.
    - Type: Basic or Standard. Select Standard. If you select Basic, understand that Basic virtual WANs can only contain Basic hubs. Basic hubs can only be used for site-to-site connections.
4.	After you finish filling out the fields, at the bottom of the page, select Review + create.
 
[filename: create-vwan.png]
5.	Once validation passes, click Create to create the virtual WAN.


## Next steps

- [Tutorial: Create a site-to-site VPN connection in the Azure portal](/azure/vpn-gateway/tutorial-site-to-site-portal)
