---
title: How to Assign a Remote Network to a Traffic Forwarding Profile for Global Secure Access
description: "Assign remote networks to traffic forwarding profiles through the Microsoft Entra admin center or Microsoft Graph API to route branch office traffic through Global Secure Access."
ms.topic: how-to
ms.reviewer: abhijeetsinha
ms.date: 04/01/2026
ai-usage: ai-assisted
---
# Assign a remote network to a traffic forwarding profile for Global Secure Access

## Overview

If you tunnel your Microsoft traffic through the Global Secure Access service, you can assign remote networks to the traffic forwarding profile. Your end users can access Microsoft resources by connecting to the service from a remote network, such as a branch office location.

You can assign a remote network to the traffic forwarding profile in several ways:

- When you create or manage a remote network in the Microsoft Entra admin center
- When you enable or manage the traffic forwarding profile in the Microsoft Entra admin center
- By using the Microsoft Graph API

[!INCLUDE [remote-network-traffic-enforcement-include](../includes/remote-network-traffic-enforcement-include.md)]

## Prerequisites 

To assign a remote network to a traffic forwarding profile, you must have:

- A **Global Secure Access Administrator** role in Microsoft Entra ID. 
- The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).

### Known limitations

[!INCLUDE [known-limitations-include](../includes/known-limitations-include.md)]

## Assign the remote network to Microsoft or the internet traffic profile

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Connect** > **Remote networks**.
1. Select a remote network. 
1. Select **Traffic profiles**. 
1. Select (or unselect) the checkbox for **Microsoft traffic profile**. 
1. Select **Save**.

    :::image type="content" source="media/how-to-assign-traffic-profile-to-remote-network/microsoft-traffic-profile-selected.png" alt-text="Screenshot of the Create a remote network page, open to the Traffic profiles tab, with Microsoft traffic profile selected.":::

## Assign a remote network to the Microsoft traffic forwarding profile

1. Browse to **Global Secure Access** > **Connect** > **Traffic forwarding**.
1. Select **Add/edit assignments** for **Microsoft traffic profile**. 

    :::image type="content" source="media/how-to-assign-traffic-profile-to-remote-network/microsoft-traffic-profile-remote-network.png" alt-text="Screenshot of the add/edit assignment on the Microsoft traffic profile." lightbox="media/how-to-assign-traffic-profile-to-remote-network/microsoft-traffic-profile-remote-network.png":::

### Assign a traffic profile to a remote network using the Microsoft Graph API

To associate a traffic profile with your remote network by using the Microsoft Graph API, complete two steps. First, get the traffic forwarding profile ID. This ID is unique for all tenants. Then, use the traffic forwarding profile ID to assign the traffic forwarding profile to your remote network. 

Assign a traffic forwarding profile by using Microsoft Graph on the `/beta` endpoint.
 
1. Open a web browser and go to **Graph Explorer** at https://aka.ms/ge.
1. Select **GET** as the HTTP method from the dropdown. 
1. Select the API version as **beta**. 
1. Enter the query.
    ```
    GET https://graph.microsoft.com/beta/networkaccess/forwardingprofiles 
    ```
1. Select **Run query**. 
1. Find the ID of the desired traffic forwarding profile. 
1. Select **PATCH** as the HTTP method from the dropdown. 
1. Enter the query.
    ```
        PATCH https://graph.microsoft.com/beta/networkaccess/branches/d2b05c5-1e2e-4f1d-ba5a-1a678382ef16/forwardingProfiles
        {
            "@odata.context": "#$delta",
            "value":
            [{
                "ID": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            }]
        }
    ```
1. Select **Run query** to update the branch. 



## Next steps
- [List remote networks](how-to-list-remote-networks.md)
