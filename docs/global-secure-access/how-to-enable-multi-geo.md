---
title: Enable Multi-Geo Capability for Microsoft Entra Private Access (Preview)
description: "[Article description]."
ms.author: jayrusso
author: HULKsmashGithub
manager: femila
ms.service: global-secure-access
ms.topic: how-to   
ms.date: 03/10/2025   
ms.reviewer: Sumeet Mittal   

#customer intent: As a <role>, I want <what> so that <why>.

---

<!-- --------------------------------------

- Use this template with pattern instructions for:

How To

- Before you sign off or merge:

Remove all comments except the customer intent.

- Feedback:

https://aka.ms/patterns-feedback

-->

# Enable multi-Geo capability for Microsoft Entra Private Access (Preview)
Multi-Geo Capability can help optimize the traffic flow from Entra Clients to Entra Apps through Private Access. This article explains how to enable the multi-Geo capability for Microsoft Entra Private Access.

> [!IMPORTANT]
> Multi-Geo Capability for Microsoft Entra Private Access is currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here. 
> The preview for testing purposes; don't use the preview for production traffic. We recommend that you use a test tenant for the preview. If you must use a production tenant for testing, don't use production connector groups. Instead, create a separate test connector group. 

## Overview

Multi-Geo Capability can help optimize the traffic flow from Entra Clients to Entra Apps through Private Access. Currently, Entra routing for Private Access is determined by the tenant's default geo location. For instance, if a tenant's default region is North America, all connector groups must connect to the Entra backend in North America, even if some applications and connector groups are in different regions. Multi-Geo support enables customers to optimize traffic flow by assigning Connector Groups according to their preferred geo locations instead of relying solely on the tenant's geo location. Each connector group will connect to the SSE backend in the selected area, enhancing overall efficiency. This provides customers with the flexibility to direct connections to the SSE backend of their choice.   
<!-- Art Library Source# ConceptArt-0-000-048 -->
:::image type="content" source="media/how-to-enable-multi-geo/multi-geo-diagram.png" alt-text="Diagram that illustrates how Multi-Geo Support routes traffice with Microsoft Entra Private Netowrk Connectors.":::   

## Enable multi-Geo capability

[Introduce the procedure.]

1. Procedure step
1. Procedure step
1. Procedure step

## Known limitations

[!INCLUDE [known-limitations-include](../includes/known-limitations-include.md)]

## Related content

* [Related article title](link.md)
