---
title: How to access Azure SQL with a service endpoint using Microsoft Entra Private Access
description: Learn how to access Azure SQL with a service endpoint using Microsoft Entra Private Access.
author: kenwith    
ms.author: kenwith
manager: femila
ms.topic: how-to
ms.date: 02/21/2025
ms.service: global-secure-access
ms.subservice: entra-private-access 
ms.reviewer: katabish
ai-usage: ai-assisted
---

# How to access Azure SQL with a service endpoint using Microsoft Entra Private Access

Access Azure services using Microsoft Entra Private Access with a virtual network service endpoint. The combination provides direct connectivity using an optimal network route. A virtual network service endpoint lets you limit network access to Azure service resources and remove access from the internet. Service endpoints provide a direct connection between your virtual network and supported Azure services. You use your virtual networks private address space to access the Azure services.

To learn more about virtual networks, see [What is Azure Virtual Network?](/azure/virtual-network/virtual-networks-overview).

This article shows you how to access Azure SQL with a service endpoint using Microsoft Entra Private Access.

## Prerequisites
- Administrators who interact with **Global Secure Access** features must have one or more of the following role assignments depending on the tasks they're performing.
   - The [Global Secure Access Administrator role](/azure/active-directory/roles/permissions-reference) role to manage the Global Secure Access features.
   - The [Conditional Access Administrator](/azure/active-directory/roles/permissions-reference#conditional-access-administrator) to create and interact with Conditional Access policies.
- Azure SQL Server configured with service endpoint 
- Microsoft Entra private network connector deployed in the service endpoint subnet. To learn how to deploy a connector, see [How to configure private network connectors for Microsoft Entra Private Access and Microsoft Entra application proxy](how-to-configure-connectors.md). To learn more about connectors, see [Understand the Microsoft Entra private network connector](concept-connectors.md). To learn more about connector groups, see [Understand Microsoft Entra private network connector groups](concept-connector-groups.md).

## Change Azure SQL Server connection policy to proxy 
Since users are connecting from outside Azure, your Azure SQL server should have a connection policy of `proxy`. The `proxy` policy establishes the Transmission Control Protocol (TCP) session via the Azure SQL Database gateway and all subsequent packets flow via the gateway. 

To set the policy to `proxy`: 
1. Sign in to the Azure portal and navigate to your SQL server.
1. In the left hand navigation under **Security**, select **Networking**. 
1. On the **Connectivity** tab, set **Connection Policy** to `Proxy`.
1. Select **Save**.

:::image type="content" source="media/how-to-use-with-azure-sql-service-endpoint/networking-connectivity.png" alt-text="Screenshot showing the connectivity tab on the networking page within Security section." lightbox="media/how-to-use-with-azure-sql-service-endpoint/networking-connectivity.png":::

## Create a Global Secure Access application for the Azure SQL server
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Applications** > **Enterprise applications**.
1. Select **New application**. 
1. Choose the right connector group with the connector deployed in the service endpoint subnet.
1. Select **Add application segment**:
    - Destination type: `FQDN` 
    - Fully Qualified Domain Name (FQDN): `<fqdn of the storage account>`. For example, `contosodbserver1.database.windows.net`.
    - Ports: `1443`
    - Protocol: `TCP`
1. Select **Apply** to add the application segment.
1. Select **Save** to save the application.
1. Assign users to the application. 

## Validate the configuration
Ensure connectivity to the SQL server works from the connector machine. The connector is deployed on the service endpoint subnet. 

Check connectivity to the SQL server from outside the service endpoint subnet. Computers that don't the Global Secure Access client installed should fail. Computers that have the Global Secure Access client installed should succeed.

## Next steps
- [Learn about Microsoft Entra Private Access](concept-private-access.md)
