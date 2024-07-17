---
title: Microsoft Entra application proxy and Tableau
description: Learn how to use Microsoft Entra application proxy to provide remote access for your Tableau deployment.
author: kenwith
manager: amycolannino
ms.service: entra-id
ms.subservice: app-proxy
ms.topic: how-to
ms.date: 02/20/2024
ms.author: kenwith
ms.reviewer: ashishj
---

# Microsoft Entra application proxy and Tableau 

Microsoft and Tableau worked together so you can use application proxy to provide remote access for your Tableau deployment.

## Prerequisites 
- Configure [Tableau](https://onlinehelp.tableau.com/current/server/en-us/proxy.htm#azure). 
- Install an [private network connector](~/identity/app-proxy/application-proxy-add-on-premises-application.md).

 
## Enabling application proxy for Tableau 
Application proxy supports the OAuth 2.0 Grant Flow, which is required for Tableau to work properly. This means that there are no longer any special steps required to enable this application, other than configuring it by following the publishing steps.

## Publish your applications in Microsoft Entra
To publish Tableau, you need to publish an application in the Microsoft Entra admin center.
- Steps 1 through 8 are detailed in the application proxy tutorial. For more information, see [Publish applications using Microsoft Entra application proxy](~/identity/app-proxy/application-proxy-add-on-premises-application.md). 
- Information about how to find Tableau values for the application proxy fields, see the Tableau documentation.

**To publish your app**: 
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**.
1. Select **New application** at the top of the page. 
1. Select **On-premises application**. 
1. Fill out the required fields with information about the new app. 
    - **Internal URL**: This application should have an internal URL that is the Tableau URL itself. For example, `https://adventure-works.tableau.com`. 
    - **Pre-authentication method**: Microsoft Entra ID (recommended but not required). 
1. Select **Add** at the top of the page. Your application is added, and the quick start menu opens. 
1. In the quick start menu, select **Assign a user for testing**, and add at least one user to the application. Make sure this test account has access to the on-premises application. 
1. Select **Assign** to save the test user assignment. 
1. (Optional) On the app management page, select **Single sign-on**. Choose **Integrated Windows Authentication** from the drop-down menu, and fill out the required fields based on your Tableau configuration. Select **Save**. 
 
## Testing 
Your application is now ready to test. Access the external URL you used to publish Tableau, and sign in as a user assigned to both applications.

## Next steps
- [How to provide secure remote access to on-premises applications](overview-what-is-app-proxy.md)
