---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: customers
ms.topic: include
ms.date: 02/29/2024
ms.author: kengaderdus
ms.manager: mwongerapk
---

To specify that this app is a public client and can use native authentication, enable public client and native authentication flows:
 
1. From the app registrations page, select the app registration for which you want to enable public client and native authentication flows.  
1. Under **Manage**, select **Authentication**.
1. Under **Advanced settings**, for **Allow public client flows**, select **Yes**.
1. Under **Advanced settings**, for **Enable native authentication**, select **Yes**.
1. Select **Save** button.

If you don't see the **Enable native authentication** option, add a *enableNativeAuthConfiguration=true* query parameter to your Microsoft Entra admin center URL, then press the **Enter** key on your keyboard to load the page again. For example, if the URL in your browser address bar is:

```http
https://entra.microsoft.com/view/Overview/appId/9b0eb21e-0c23-abc34t-98uhd
```

Update it to look similar to:

```http
https://entra.microsoft.com/view/Overview/appId/9b0eb21e-0c23-abc34t-98uhd?enableNativeAuthConfiguration=true
```