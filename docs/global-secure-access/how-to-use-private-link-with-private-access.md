---
title: How to access an Azure Storage account behind Azure Private Link using Microsoft Entra Private Access
description: Learn how to access an Azure Storage account behind Azure Private Link using Microsoft Entra Private Access.
author: kenwith    
ms.author: kenwith
manager: dougeby
ms.topic: how-to
ms.date: 02/21/2025
ms.service: global-secure-access
ms.subservice: entra-private-access 
ms.reviewer: katabish
ai-usage: ai-assisted
---

# How to access an Azure Storage account behind Azure Private Link using Microsoft Entra Private Access
Microsoft Entra Private Access lets you extend the security features of Azure Private Link to remote and on-premises users. Extending the security features brings modern authentication features, such as Conditional Access, to the front of Azure Platform as a Service (PaaS) resources.

Azure Private Link lets you access Azure PaaS Services such as Azure Storage and Azure SQL Database. Azure Private Link also lets you access your Azure hosted services and partner services over a private endpoint in your virtual network. The result is that resources like virtual machines (VMs) can privately and securely communicate with Private Link resources.

To learn more about Azure Private Link, see [What is Azure Private Link?](/azure/private-link/private-link-overview).

This article shows you how to use Microsoft Entra Private Access to access an Azure Storage account behind Azure Private Link.

:::image type="content" source="media/how-to-use-private-link-with-private-access/architecture-diagram.png" alt-text="Diagram showing the architecture of Azure Private Link using Microsoft Entra Private Access." lightbox="media/how-to-use-private-link-with-private-access/architecture-diagram.png":::

## Prerequisites
- Administrators who interact with **Global Secure Access** features must have one or more of the following role assignments depending on the tasks they're performing.
   - The [Global Secure Access Administrator role](/azure/active-directory/roles/permissions-reference) role to manage the Global Secure Access features.
   - The [Conditional Access Administrator](/azure/active-directory/roles/permissions-reference#conditional-access-administrator) to create and interact with Conditional Access policies.
- Set up a storage account behind Azure Private Link. To learn how to set up a storage account in Azure Private Link, see [Tutorial: Connect to a storage account using an Azure Private Endpoint](/azure/private-link/tutorial-private-endpoint-storage-portal). To learn more about private endpoints in Azure Private Link, see [What is a private endpoint?](/azure/private-link/private-endpoint-overview).
- Deploy a Microsoft Entra private network connector in a private virtual network. To learn how to deploy a connector, see [How to configure private network connectors for Microsoft Entra Private Access and Microsoft Entra application proxy](how-to-configure-connectors.md). To learn more about connectors, see [Understand the Microsoft Entra private network connector](concept-connectors.md). To learn more about connector groups, see [Understand Microsoft Entra private network connector groups](concept-connector-groups.md). To learn more about Azure Virtual Network, see [What is Azure Virtual Network?](/azure/virtual-network/virtual-networks-overview).
 
## Create a Global Secure Access application for the Azure storage account
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Applications** > **Enterprise applications**.
1. Select **New application**. 
1. Choose the right connector group with the connector deployed in the private virtual network.
1. Select **Add application segment**:
    - Destination type: `FQDN` 
    - Fully Qualified Domain Name (FQDN): `<fqdn of the storage account>`. For example, `storage1.blob.core.windows.net`.
    - Ports: `443`
    - Protocol: `TCP`
1. Select **Apply** to add the application segment.
1. Select **Save** to save the application.
1. Assign users to the application. 

:::image type="content" source="media/how-to-use-private-link-with-private-access/network-access-properties.png" alt-text="Screenshot showing network access properties." lightbox="media/how-to-use-private-link-with-private-access/network-access-properties.png":::

## Validate the configuration
Ensure connectivity to the storage account works from the connector machine. The connector is deployed on the same private virtual network.

Check connections to the storage account from outside the private virtual network. Computers that don't have the Global Secure Access client installed should fail. Computers that have the Global Secure Access client installed should succeed. 

## Next steps
- [Learn about Microsoft Entra Private Access](concept-private-access.md)
