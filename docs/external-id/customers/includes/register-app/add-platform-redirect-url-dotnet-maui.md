---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 11/22/2023
ms.author: kengaderdus
ms.manager: dougeby
---

To specify your app type to your app registration, follow these steps:

1. Under **Manage**, select **Authentication**.
1. On the **Platform configurations** page, select **Add a platform**, and then select **Mobile and Desktop applications** option.
1. For the **Redirect URIs** enter `msal{client_id}://auth`. Ensure that the `{client_id}` matches the value of your app registration. Select **Configure**.
1. Select **Save** to save the changes.
