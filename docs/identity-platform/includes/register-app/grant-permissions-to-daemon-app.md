---
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.date: 11/06/2024
ms.reviewer:
ms.service: identity-platform
ms.topic: include
---

1. From the **App registrations** page, select the application that you created, such as *ciam-client-app*.
1. Under **Manage**, select **API permissions**.
1. Under **Configured permissions**, select **Add a permission**.
1. Under **Microsoft APIs** tab, select the **Microsoft Graph >> Application permissions**. We select the **Application permissions** option as the app signs in as itself, but not on behalf of a user. 
1. In the **Select permissions** list, search for then select **User.Read.All**. We grant this permission so the app wants can read all users' full profiles.
1. Select the **Add permissions** button.
1. At this point, you've assigned the permissions correctly. However, since the daemon app doesn't allow users to interact with it, the users themselves can't consent to these permissions. You as the tenant administrator must consent to these permissions on behalf of all the users in the tenant:

    1. Select **Grant admin consent for \<your tenant name\>**, then select **Yes**.
    1. Select **Refresh**, then verify that **Granted for \<your tenant name\>** appears under **Status** for both permissions.