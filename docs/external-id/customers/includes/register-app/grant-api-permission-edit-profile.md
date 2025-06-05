---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 09/02/2024
ms.author: kengaderdus
ms.manager: mwongerapk
---

1. From the **App registrations** page, select the application that you created (such as *edit-profile-service*) to open its **Overview** page.

1. Under **Manage**, select **API permissions**.

1. Select the **Microsoft APIs** tab, then under **Commonly used Microsoft APIs**, select **Microsoft Graph**.

1. Select **Delegated permissions**, then search for, and select **User.ReadWrite** from the list of permissions.

1. Select the **Add permissions** button.

1. You've assigned the *User.ReadWrite* permissions correctly to your EditProfileService app. However, since the tenant is an external tenant, the customer users themselves can't consent to these permissions. As the administrator of the tenant, you must consent to this permission on behalf of all the users in the tenant:
    1. Select **Grant admin consent for \<your tenant name\>**, then select **Yes**.
    1. Select **Refresh**, then verify that **Granted for \<your tenant name\>** appears under **Status** for both scopes.