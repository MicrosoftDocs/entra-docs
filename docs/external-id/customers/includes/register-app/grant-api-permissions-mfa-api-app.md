---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 09/02/2024
ms.author: kengaderdus
ms.manager: mwongerapk
---
 
1. From the **App registrations** page, select the API application that you created (such as *ciam-client-app*) to open its **Overview** page.

1. Under **Manage**, select **API permissions**.
 
1. Under **Configured permissions**, select **Add a permission**.

1. Select the **APIs my organization uses** tab.
 
1. In the list of APIs, select the API such as *edit-profile-service*.

1. Select **Delegated permissions** option.
 
1. From the permissions list, select **EditProfileService.ReadWrite**.

1. Select the **Add permissions** button.

1. From the **Configured permissions** list, select the **EditProfileService.ReadWrite** permission, then copy the permission's full URI for later use. The full permission URI looks something similar to `api://{clientId}/{EditProfileService.ReadWrite}`.

1. You've assigned the **EditProfileService.ReadWrite* permissions correctly to your client web app. However, since the tenant is an external tenant, the customer users themselves can't consent to these permissions. As the administrator of the tenant, you must consent to this permission on behalf of all the users in the tenant:
    1. Select **Grant admin consent for \<your tenant name\>**, then select **Yes**.
    1. Select **Refresh**, then verify that **Granted for \<your tenant name\>** appears under **Status** for both scopes.