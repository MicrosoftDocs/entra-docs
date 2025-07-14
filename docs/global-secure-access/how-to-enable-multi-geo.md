---
title: Multi-Geo for Microsoft Entra Private Access (Preview)
description: "Learn how to enable Multi-Geo Capability for Microsoft Entra Private Access to optimize traffic flow from Microsoft Entra Clients to Microsoft Entra Apps."
ms.author: jayrusso
author: HULKsmashGithub
manager: dougeby
ms.service: global-secure-access
ms.topic: how-to   
ms.date: 04/30/2025
ms.reviewer: sumi

#customer intent: As an IT admin, I want to enable Multi-Geo Capability for Microsoft Entra Private Access so that I can optimize traffic flow from Microsoft Entra Clients to Microsoft Entra Apps.

---
# Enable multi-Geo capability for Microsoft Entra Private Access (Preview)
Multi-Geo capability can help optimize the traffic flow from Microsoft Entra clients to Microsoft Entra apps through private access. This article explains how to enable the multi-Geo capability for Microsoft Entra Private Access.

> [!IMPORTANT]
> Multi-Geo capability for Microsoft Entra Private Access is currently in PREVIEW.
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here. 
> The preview is for testing purposes; don't use the preview for production traffic. We recommend that you use a test tenant for the preview. If you must use a production tenant for testing, don't use production connector groups. Instead, create a separate test connector group. 

## Prerequisites

- You must have a Microsoft Entra Private Access license.    
- You must have a Microsoft Entra Private Access connector group. For more information, see [How to configure private network connectors for Microsoft Entra Private Access and Microsoft Entra application proxy](how-to-configure-connectors.md).   
- You must have the **Global Secure Access Administrator** role or the **Privileged Role Administrator** role. For more information, see [Microsoft Entra Built-in Roles](../identity/role-based-access-control/permissions-reference.md).   

## Overview

Multi-Geo capability helps optimize traffic flow from Microsoft Entra clients to Microsoft Entra apps through private access. Currently, the tenant's default geo location determines the Microsoft Entra routing for private access. For instance, if a tenant's default region is North America, all connector groups must connect to the Microsoft Entra backend in North America, even if some applications and connector groups are in different regions. Multi-Geo support lets customers optimize traffic flow by assigning connector groups according to their preferred geo locations instead of relying solely on the tenant's geo location. Each connector group connects to the SSE backend in the selected area, enhancing overall efficiency. This arrangement provides customers with the flexibility to direct connections to the SSE backend of their choice.
<!-- Art Library Source# ConceptArt-0-000-048 -->
:::image type="content" source="media/how-to-enable-multi-geo/multi-geo-support-diagram.svg" alt-text="Diagram that illustrates how Multi-Geo support routes traffic with Microsoft Entra private network connectors.":::

## Enable multi-Geo capability
To enable the multi-Geo capability for Microsoft Entra Private Access, complete the following steps. This procedure involves creating connector groups in different geographic regions, installing connectors, and adding application segments to the connector groups.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator).
1. Browse to **Applications** > **Enterprise applications** > **Private Network connectors**.    
1. Create two connector groups, each associated with a different geographic region.   
    1. Select **+ New Connector Group**.   
    1. In the **New Connector Group** pane, enter a name for the connector group.
    1. Under Advanced settings, select the optimized **country/region** for the connector group. The region you select determines the backend that the connector group connects to.
    1. Repeat steps **a** - **c** for the second connector group.
1. Install a connector in each region. These connector installations require working with an admin in the associated region. For more information, see [How to configure private network connectors for Microsoft Entra Private Access and Microsoft Entra application proxy](how-to-configure-connectors.md).   
1. Add an application segment to each of the connector groups.   
    1. Browse to **Global Secure Access** > **Applications** > **Enterprise applications** > **Network access properties**.   
    1. Select **+ Add application segment**.
    1. Select the application segment you want to add to the connector group.  
    1. Select **Save**.  
    1. Repeat steps **a** - **d** for the second connector group.
1. After about 30 minutes, the multi-Geo configuration takes effect and traffic begins flowing. 

> [!NOTE]
> - Multi-Geo connectors aren't available through Quick Access. Multi-Geo supports only private enterprise apps.   
> - Multi-Geo doesn't support the Domain Name System (DNS) experience.
> - Mulit-Geo doesn't support Japan region selection through Microsoft Entra admin center.   

## Enable multi-Geo capability for Japan region
The UI experience through the Microsoft Entra admin center doesn't support the Japan region yet. To select Japan as **country/region** for the connector group, use Microsoft Graph APIs:
- Open Microsoft [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) and login with the tenant account.
- Create a [Connector Group](/graph/api/connectorgroup-post?view=graph-rest-beta&tabs=http&preserve-view=true) using Graph API. Use `region` property to assign the region to Japan. For example, run the `POST` request with region set to `Japan` to create a connector group assigned to Japan.

### Example HTTP Request
```http
POST https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationProxy/connectorGroups
Content-type: application/json

{
  "name": "<Connector Group Name>",
  "region": "Japan"
}
```
## Related content

* [How to configure private network connectors for Microsoft Entra Private Access and Microsoft Entra application proxy](how-to-configure-connectors.md)
