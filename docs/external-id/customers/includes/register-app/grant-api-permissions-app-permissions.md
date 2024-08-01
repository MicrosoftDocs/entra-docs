---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: customers
ms.topic: include
ms.date: 07/29/2024
ms.author: kengaderdus
ms.manager: mwongerapk
---

1. From the **App registrations** page, select the application that you created, such as *ciam-client-app*.
1. Under **Manage**, select **API permissions**.
1. Under **Configured permissions**, select **Add a permission**.
1. Select the **APIs my organization uses** tab.
1. In the list of APIs, select the API such as *ciam-ToDoList-api*.
1. Select **Application permissions** option. We select this option as the app signs in as itself, but not on behalf of a user. 
1. From the permissions list, select **TodoList.Read.All, ToDoList.ReadWrite.All** (use the search box if necessary).
1. Select the **Add permissions** button.
1. At this point, you've assigned the permissions correctly. However, since the daemon app doesn't allow users to interact with it, the users themselves can't consent to these permissions. To address this problem, you as the admin must consent to these permissions on behalf of all the users in the tenant:

    1. Select **Grant admin consent for \<your tenant name\>**, then select **Yes**.
    1. Select **Refresh**, then verify that **Granted for \<your tenant name\>** appears under **Status** for both permissions.