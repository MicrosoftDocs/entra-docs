---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: customers
ms.topic: include
ms.date: 10/08/2024
ms.author: kengaderdus
ms.manager: mwongerapk
---

Once you register your application, it gets assigned the **User.Read** permission. However, since the tenant is an external tenant, the customer users themselves can't consent to this permission. You as the admin must consent to this permission on behalf of all the users in the tenant:

1. From the **App registrations** page, select the application that you created (such as *ciam-client-app*) to open its **Overview** page.
1. Under **Manage**, select **API permissions**.

    1. Select **Grant admin consent for \<your tenant name\>**, then select **Yes**.
    1. Select **Refresh**, then verify that **Granted for \<your tenant name\>** appears under **Status** for both scopes.