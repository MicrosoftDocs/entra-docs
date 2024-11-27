---
title: Configure Application Discovery (Preview)
description: Configure Application discovery to detect the applications accessed by users and create separate private applications.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 11/26/2024
ms.author: jayrusso
author: HULKsmashGithub
manager: amycolannino
ms.reviewer: lirazbarak


# Customer intent: As an administrator, I want to configure Application discovery so I can detect the applications accessed by users and create separate private applications.
---
# Configure Application discovery (Preview)
Application discovery, a part of Quick Access, is a tool administrators can use to gain visibility and insight about who uses which applications in their corporate network.  

With Quick Access, you can quickly onboard to Private Access by publishing wide IP ranges and wildcard FQDNs, in a way as you would with traditional VPN solutions. You can then transition from Quick Access to per-application publishing for better control and granularity over each application. For example, you can create a conditional access policy and set user assignments per application.  

This article walks through the process of using Application discovery to detect which applications users access (through Quick Access) and creating separate private applications.

## Prerequisites

- A Microsoft Entra tenant onboarded to [Microsoft Entra Private Access](concept-private-access.md).
- A Microsoft Entra tenant configured with [Quick Access](how-to-configure-quick-access.md).
- A device configured with the Global Secure Access client ([Windows](how-to-install-windows-client.md), [macOS](how-to-install-macos-client.md), [Android](how-to-install-android-client.md), [iOS](how-to-install-ios-client.md)).
> [!IMPORTANT]
> Because of a new feature that prioritizes specific applications over Quick Access, you must modify all application segemnts in existing Global Secure Access tenants and save the new settings.

## Discover applications
To view a list of all the application segments in Quick Access that users accessed via the Global Secure Access client in the last 30 days:
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Applications** > **Application discovery**.
:::image type="content" source="media/how-to-application-discovery/___.png" alt-text="Screenshot of Application discovery screen.":::

By default, the **Application discovery** view sorts the application segments in descending order according to the number of users. This default sort order moves the most heavily used application segments to the top of the list, making them more visible to the administrator.  

The administrator can adjust the time range, add other filters, and sort the application segments according to each of the columns. The administrator can also **filter by user** to see the list of the application segments accessed by a specific user. From the **Search** field, the administrator can filter by fully qualified domain name (FQDN), IP address, and port address.

The following columns are available for each application segment: 
- **Destination FQDN**: the FQDN of the application segment. 
- **Destination IP**: the IP of the application segment. 
- **Transport Protocol**: the transport protocol of the application segment. Currently TCP and UDP are supported.   
- **Destination port**: the port of the application segment. 
- **Access type**: Application discovery currently supports only application segments that were accessed through Quick Access. 
- **Users**: the number of users who accessed the application segment.  
- **Transactions**: the number of transactions (connections) to the application segment.  
- **Devices** - the number of devices that were used to access the application segment. 
- **Sent bytes**: the total bytes of data that were sent from the user device to the application segment. 
- **Received bytes**: the total bytes of data that were received by the user device from the application segment. 
- **Last access**: the last time in the time range that the application segment was accessed.  
- **First access**: the first time in the time range that the application segment was accessed. 

## Add a new application
Application Discovery helps the administrator to create a new Entra ID applications based on the discovered application segments of the main table.  


## Add to an existing application 
Application Discovery also allows the administrator to add application segments to an existing private application. 


## Application segments details 
Before the decision to create a private application, you may review other details of the application segment. 
