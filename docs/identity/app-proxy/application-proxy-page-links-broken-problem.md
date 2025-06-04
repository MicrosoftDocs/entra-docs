---
title: Broken Links in an Application
description:  Troubleshoot problems with broken links in application proxy apps that are integrated with Microsoft Entra ID.
author: kenwith
manager: 
ms.service: entra-id
ms.subservice: app-proxy
ms.topic: troubleshooting
ms.date: 05/01/2025
ms.author: kenwith
ms.reviewer: asteen
ai-usage: ai-assisted
---

# Broken links in an application proxy app

This article describes why broken links might occur in your Microsoft Entra application proxy application and resolution options.

After you publish an application proxy app, by default, the only links that work in the app are links to destinations that are located in the published root URL.

If a link in the app doesn't work, the likely cause is that the link goes to a destination that is outside the published root URL.

*What causes broken links in my app?* When an app user selects a link in an application, application proxy tries to resolve the URL as either an internal URL within the same application or as an externally available URL. If the link points to an internal URL that isn't in the same application, the link doesn't fit in either of these buckets. The result is a "not found" error.

## Resolve broken links

You have three options to resolve this issue. The choices are listed in increasing complexity.

1. Make sure that the internal URL is a root that contains all the relevant links for the application. The root lets all links resolve as content published within the same application.

    If you change the internal URL but don’t want to change the landing page for users, change the home page URL to the previously published internal URL. Go to **Microsoft Entra ID** > **App Registrations** and select the **Branding** for the application. In the branding section, set **Home Page URL** to the original published landing page URL.

    > [!IMPORTANT]
    > To make this change, a user must have permissions to modify application objects in Microsoft Entra ID. The user must be assigned the [Application Administrator](~/identity/role-based-access-control/delegate-app-roles.md#assign-built-in-application-administrator-roles) role.

1. If your applications use fully qualified domain names (FQDNs), use [custom domains](how-to-configure-custom-domain.md) to publish your applications. When you use the custom domains feature, you can use the same URL both internally and externally.

    This option ensures that the links in your application are externally accessible through application proxy because the application links to internal URLs are also recognized externally. All links still need to belong to a published application. However, with this option, the links don't need to belong to the same application and can belong to multiple applications.

1. If neither of these options are feasible, there are multiple options to set up inline link translation. These options include using the Intune Managed Browser, the My Apps extension, or the link translation setting on your application.

   To learn more about each of these options and how to enable them, see [Redirect hardcoded links for apps published with Microsoft Entra application proxy](application-proxy-configure-hard-coded-link-translation.md).

## Related content

- [Work with existing on-premises proxy servers](application-proxy-configure-connectors-with-proxy-servers.md)
