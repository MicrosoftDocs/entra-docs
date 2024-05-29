---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: customers
ms.topic: include
ms.date: 04/06/2024
ms.author: kengaderdus
ms.manager: mwongerapk
---

1. From the **App registrations** page, select the application that you created (such as *ciam-client-app*) to open its **Overview** page.
1. Under **Manage**, select **API permissions**. From the **Configured permissions** list, your application has been assigned the **User.Read** permission. However, since the tenant is an external tenant, the consumer users themselves can't consent to this permission. You as the admin must consent to this permission on behalf of all the users in the tenant:

    1. Select **Grant admin consent for \<your tenant name\>**, then select **Yes**.
    1. Select **Refresh**, then verify that **Granted for \<your tenant name\>** appears under **Status** for both scopes.