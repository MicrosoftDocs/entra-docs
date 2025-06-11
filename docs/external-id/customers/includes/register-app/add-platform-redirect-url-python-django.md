---
author: SHERMANOUKO
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 03/13/2024
ms.author: shermanouko
ms.manager: mwongerapk
---

To specify your app type to your app registration, follow these steps:

1. Under **Manage**, select **Authentication** 
1. On the **Platform configurations** page, select **Add a platform**, and then select **Web** option.
1. For the **Redirect URIs** enter `http://localhost:5000/redirect`. This redirect URI is the location where the authorization server sends the access token. You can customize it to suit your use case.
1. Select **Configure** to save your changes.
