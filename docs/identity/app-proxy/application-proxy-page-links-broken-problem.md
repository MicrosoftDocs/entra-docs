---
title: Links on the page don't work for a Microsoft Entra application proxy application
description:  Troubleshoot issues with broken links on application proxy applications integrated with Microsoft Entra ID.
author: kenwith
manager: amycolannino
ms.service: entra-id
ms.subservice: app-proxy
ms.topic: troubleshooting
ms.date: 02/27/2024
ms.author: kenwith
ms.reviewer: asteen
---

# Links on the page don't work for an application proxy application

This article helps you troubleshoot why links on your Microsoft Entra application proxy application don't work correctly.

## Overview
After you publish an application proxy app, the only links that work by default in the application are links to destinations contained within the published root URL. The links within the applications aren’t working. The internal URL for the application probably doesn't include all the destinations of links within the application.

**Why does this happen?** When a user selects a link in an application, application proxy tries to resolve the URL as either an internal URL within the same application, or as an externally available URL. If the link points to an internal URL that isn't within the same application, it doesn't belong to either of these buckets and result in a not found error.

## Ways you can resolve broken links

There are three ways to resolve this issue. The choices are in listed in increasing complexity.

1.  Make sure the internal URL is a root that contains all the relevant links for the application. The root lets all links resolve as content published within the same application.

    If you change the internal URL but don’t want to change the landing page for users, change the Home page URL to the previously published internal URL. Navigate to **Microsoft Entra ID** > **App Registrations** and select the application **Branding**. In the branding section, set the **Home Page URL** field to the desired landing page. 
    
    > [!IMPORTANT]
    > In order to make the above changes you require rights to modify application objects in Microsoft Entra ID. The user needs to be assigned [Application Administrator](~/identity/role-based-access-control/delegate-app-roles.md#assign-built-in-application-administrator-roles) role which grants application modification rights in Microsoft Entra ID to the user.

2.  If your applications use fully qualified domain names (FQDNs), use [custom domains](how-to-configure-custom-domain.md) to publish your applications. This feature allows the same URL to be used both internally and externally.

    This option ensures that the links in your application are externally accessible through application proxy since the links within the application to internal URLs are also recognized externally. All links still need to belong to a published application. However, with this option, the links don't need to belong to the same application and can belong to multiple applications.

3.  If neither of these options are feasible, there are multiple options for enabling inline link translation. These options include using the Intune Managed Browser, My Apps extension, or using the link translation setting on your application. To learn more about each of these options and how to enable them, see [Redirect hardcoded links for apps published with Microsoft Entra application proxy](application-proxy-configure-hard-coded-link-translation.md).

## Next steps
[Work with existing on-premises proxy servers](application-proxy-configure-connectors-with-proxy-servers.md)
