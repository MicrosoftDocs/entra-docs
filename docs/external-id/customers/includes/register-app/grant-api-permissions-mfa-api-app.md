---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: customers
ms.topic: include
ms.date: 07/01/2024
ms.author: kengaderdus
ms.manager: mwongerapk
---
 
1. Under **Manage**, select **API permissions**.
 
1. Under **Configured permissions**, select **Add a permission**.

1. Select the **APIs my organization uses** tab.
 
1. In the list of APIs, select the API such as *mfa-api-app*.

1. Select **Delegated permissions** option.
 
1. From the permissions list, select **User.MFA**.

1. Select the **Add permissions** button.

1. From the **Configured permissions** list, select the **User.MFA** permission, then copy the permission's full URI for later use. The full permission URI looks something similar to `api://{clientId}/{User.MFA}`.