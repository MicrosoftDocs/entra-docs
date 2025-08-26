---
title: Microsoft Entra application proxy and Qlik Sense
description:  Integrate Microsoft Entra application proxy with Qlik Sense.
author: kenwith
manager: dougeby 
ms.service: entra-id
ms.subservice: app-proxy
ms.topic: how-to
ms.date: 05/01/2025
ms.author: kenwith
ms.reviewer: ashishj
ai-usage: ai-assisted
---

# Microsoft Entra application proxy and Qlik Sense 
Microsoft and Qlik Sense worked together to provide remote access using Microsoft Entra application proxy.  

## Prerequisites 
- Set up [Qlik Sense](https://community.qlik.com/docs/DOC-19822). 
- [Install a private network connector](application-proxy-add-on-premises-application.md).
 
## Publish your applications in Microsoft Entra
To publish Qlik Sense, publish two applications in Azure.

### Application #1: 

Publish your application in Microsoft Entra. For a more detailed walkthrough of steps 1-8, see [Publish applications using Microsoft Entra application proxy](~/identity/app-proxy/application-proxy-add-on-premises-application.md). 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**.
3. Select **New application** at the top of the page. 
4. Select **On-premises application**. 
5. Fill out the required fields with information about your new app. 
   - **Internal URL**: This application should have an internal URL that is the Qlik Sense URL itself. For example, `https//demo.qlikemm.com:4244`. 
   - **Pre-authentication method**: Microsoft Entra ID (recommended but not required).
1. Select **Add** at the bottom of the page. Your application is added, and the quick start menu opens. 
2. In the quick start menu, select **Assign a user for testing**, and add at least one user to the application. Make sure this test account has access to the on premises application. 
3. Select **Assign** to save the test user assignment. 
4. (Optional) On the app management page, select single sign-on. Choose **Kerberos Constrained Delegation** from the drop-down menu, and fill out the required fields based on your Qlik Sense configuration. Select **Save**. 

### Application #2: 
Follow the same steps as for Application #1, with the following exceptions: 

**Step #5**: The Internal URL should now be the Qlik Sense URL with the authentication port used by the application. The default is **4244** for HTTPS, and **4248** for HTTP for Qlik Sense releases before April 2018. The default for Qlik Sense releases after April 2018 is **443** for HTTPS and **80** for HTTP. For example, `https//demo.qlik.com:4244`.

**Step #10:** Don’t set up single sign-on. Leave the **single sign-on** option disabled.
 
## Testing 
Your application is now ready to test. Access the external URL you used to publish Qlik Sense in Application #1, and sign in as a user assigned to both applications.  

## References
For more information about publishing Qlik Sense with application proxy, see following the Qlik Community Articles: 
- [Microsoft Entra ID with integrated Windows authentication using a Kerberos Constrained Delegation with Qlik Sense](https://community.qlik.com/docs/DOC-20183)
- [Qlik Sense integration with Microsoft Entra application proxy](https://community.qlik.com/t5/Technology-Partners-Ecosystem/Azure-AD-Application-Proxy/ta-p/1528396)

## Next steps

- [Publish applications with application proxy](~/identity/app-proxy/application-proxy-add-on-premises-application.md)
- [Working with private network connectors](~/identity/app-proxy/application-proxy-connector-groups.md)
