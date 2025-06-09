---
title: Application Discovery (Preview) for Global Secure Access
description: Use Application discovery to detect the applications accessed by users and create separate private applications.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 12/16/2024
ms.author: jayrusso
author: HULKsmashGithub
manager: dougeby
ms.reviewer: lirazbarak
ms.custom: sfi-image-nochange
# Customer intent: As an administrator, I want to use Application discovery to detect the applications accessed by users and create separate private applications.
---
# Application discovery (Preview) for Global Secure Access
> [!IMPORTANT]
> Application discovery is currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Application discovery enables administrators to gain comprehensive visibility into application usage within their corporate network. By identifying which applications are accessed and by whom, administrators can create private applications with precise segmentation and least privilege access, which minimizes unnecessary access. 

With Quick Access, you can quickly onboard to Private Access by publishing wide IP ranges and wildcard FQDNs, as you would with traditional VPN solutions. You can then transition from Quick Access to per-application publishing for better control and granularity over each application. For example, you can create a Conditional Access policy and set user assignments per application.  

This article walks through the process of using Application discovery to detect which applications users access (through Quick Access) and creating separate private applications.

## Prerequisites

- A Microsoft Entra tenant onboarded to [Microsoft Entra Private Access](concept-private-access.md).
- A Microsoft Entra tenant configured with [Quick Access](how-to-configure-quick-access.md).
- A device configured with the Global Secure Access client ([Windows](how-to-install-windows-client.md), [macOS](how-to-install-macos-client.md), [Android](how-to-install-android-client.md), [iOS](how-to-install-ios-client.md)).

## Discover applications
To view a list of all the application segments in Quick Access that users accessed via the Global Secure Access client in the last 30 days:
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Applications** > **Application discovery**.
:::image type="content" source="media/how-to-application-discovery/application-discovery-default-view.png" alt-text="Screenshot of Application discovery screen.":::

By default, the **Application discovery** view sorts the application segments in descending order according to the number of users. This default sort order moves the most heavily used application segments to the top of the list, making them more visible to the administrator.  

The administrator can adjust the time range, add other filters, and sort the application segments according to each of the columns. The administrator can also **filter by user** to see the list of the application segments accessed by a specific user. From the **Search** field, the administrator can filter by fully qualified domain name (FQDN), IP address, and port address.

The following columns are available for each application segment: 
- **Destination FQDN**: the FQDN of the application segment. 
- **Destination IP**: the IP of the application segment. 
- **Transport protocol**: the transport protocol of the application segment. Private Access currently supports Transmission Control Protocol (TCP) and User Datagram Protocol (UDP).   
- **Destination port**: the port of the application segment.   
- **Users**: the number of users who accessed the application segment.   
- **Transactions**: the number of transactions (connections) to the application segment.  
- **Devices** - the number of devices that were used to access the application segment.  
- **Sent bytes**: the total bytes of data that the user device sent to the application segment.  
- **Received bytes**: the total bytes of data that the user device received from the application segment.  
- **Last access**: the last time in the time range that the application segment was accessed.   
- **First access**: the first time in the time range that the application segment was accessed.  

## Create a new application
Use Application discovery to create new Microsoft Entra ID applications based on the discovered application segments of the main table. To add an application segment to a new application:
1. From the Application discovery list, choose one or more application segments that correspond to an application that you would like to create.
:::image type="content" source="media/how-to-application-discovery/select-application-segments.png" alt-text="Screenshot of the list of application segments with two segments selected.":::
    1. Often, one application uses one application segment. For example:
        - A file server, such as: `filesrv.contoso.com`, TCP, 445.
        - A portal, such as: `internalportal.contoso.com`, TCP, 443.
    1. However, sometimes a single application uses several ports, protocols, or spans across multiple servers (FQDNs/IPs). In this case, you can choose several application segments and even add others manually. For example:
        - Publishing ADDS services in a specific AD site: `dc1.contoso.com` and `dc2.contoso.com`, TCP, 88, 135, 137, 138, 389, 445, 464, 636, 3268, 3269 and a fixed high port for Netlogon `dc1.contoso.com` and `dc2.contoso.com`, UDP, 88, 123, 389, 464.  
    1. For a comprehensive list of ADDS ports, see [How to configure a firewall for Active Directory domains and trusts](/troubleshoot/windows-server/active-directory/config-firewall-for-ad-domains-and-trusts).  
1. Select **Add to new application**. The **Create Global Secure Access application** screen opens, showing the selected application segments.
    1. Give the application a **Name** and select the corresponding **Connector Group**.
    1. You can also add or delete applications segments manually. 
    1. To apply your changes, select **Save**.
:::image type="content" source="media/how-to-application-discovery/create-application.png" alt-text="Screenshot of the Create Global Secure Access application screen with the Name field, Connector Group field, and Save button highlighted.":::
1. Enable access for the appropriate users by adjusting the users and groups assigned to the new application.  
    1. You should fine-tune the assignments *after* creating the application. This way, the list contains only groups of users who require access to the new application, according to the principle of least privilege.              
    1. For enterprise applications:
        1. Browse to **Global Secure Access** > **Applications** > **Enterprise applications** > **Users and groups**.
        1. Select the application you created. 
        1. Modify the user and group assignments as needed. 
> [!IMPORTANT]
> Global Secure Access prioritizes traffic for individually defined applications higher than Quick Access. This means that once you move an application segment from Quick Access to a specific Global Secure Access app, all traffic routed to that application segment will be routed according to your application configuration. No traffic to the new application will route through Quick Access even though the application segment may persist within the ranges defined by Quick Access. As a result, to avoid service disruption, new applications you create through application discovery inherit all of the assigned users and groups from Quick Access (at the time of creation). After the new application is validated, you should rescope the permissions of the application to only those users who need to connect to the application segments defined within it.

4. (Optional) For extra security, you can set Conditional Access policies according to your company's security policies. For example, you might want to require multifactor authentication (MFA) and device compliance when users access a critical application.
> [!NOTE]
> Application segments persist in the Application discovery main table even after you've created an application, until a user signs in to the new application and accesses the resource. In the future, the Application discovery main table will update regardless of user interaction. 

## Add to an existing application 
You can use Application discovery to add application segments to an existing private application. To add an application segment to an existing application:
1. From the Application discovery list, choose one or more application segments. 
1. Select **Add to an existing application**.   
1. Choose the existing private application to which you would like to add the segments. The **Edit Global Secure Access application** screen opens, showing the properties of the existing application, the selected application segments (with status **Pending**), and any previously configured application segments (with status **Success**).
1. Review the configuration and revise the **Name**, **Connector Group**, and application segments, and make any necessary revisions.   
1. To apply your changes, select **Save**. 
:::image type="content" source="media/how-to-application-discovery/edit-application.png" alt-text="Screenshot of the Edit Global Secure Access application screen with the Status column and Save button highlighted.":::

## View the details of an application segment   
Before you decide to create a private application, you might want to review other details of the application segment. 
1. On the Application discovery table, select the **Destination FQDN** or **Destination IP** for the application segment you wish to explore.
1. The **Usage** tab defaults to a graph of **Users** over time. You can set the graph to show the distribution of **Transactions**, **Devices**, **Bytes sent**, and **Bytes received** over time. You can also change the time range by adjusting the **Timespan** setting.
:::image type="content" source="media/how-to-application-discovery/usage-tab.png" alt-text="Screenshot of the Usage tab with the Y-axis display options highlighted.":::   
1. The **Users** tab shows the list of users who accessed the selected application segment in the last 30 days.    
:::image type="content" source="media/how-to-application-discovery/users-tab.png" alt-text="Screenshot of the Users tab showing the list of users.":::
> [!IMPORTANT]
> Use the list of users to inform the decisions you make regarding the users and groups that you plan to assign to the Entra application once you onboard the selected application segment.  

## Related content
* [How to configure Quick Access for Global Secure Access](how-to-configure-quick-access.md)
