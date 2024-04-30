---
author: henrymbugua
ms.service: entra-external-id
ms.subservice: customers
ms.topic: include
ms.date: 02/28/2024
ms.author: henrymbuguakiarie
ms.manager: mwongerapk
---

1. From the **App registrations** page, select the application that you created (such as _ciam-client-app_) to open its **Overview** page. 
1. Under **Manage**, select **API permissions**. 
1. Under **Configured permissions**, select **Add a permission**. 
1. Select **Microsoft APIs** tab. 
1. Under **Commonly used Microsoft APIs** section, select **Microsoft Graph**. 
1. Select **Delegated permissions** option. 
1. Under **Select permissions** section, search for and select **offline_access**, **openid**, and **profile** permissions. 
1. Select the **Add permissions** button. 
1. At this point, you've assigned the permissions correctly. However, since the tenant is a customer's tenant, the consumer users themselves can't consent to these permissions. You as the admin must consent to these permissions on behalf of all the users in the tenant: 
 
   1. Select **Grant admin consent for \<your tenant name\>**, then select **Yes**. 
   1. Select **Refresh**, then verify that **Granted for \<your tenant name\>** appears under **Status** for both scopes. 
 
    :::image type="content" source="../../media/native-authentication/android/api-permissions.jpg" alt-text="Screenshot showing configured permission in Microsoft Entra admin center." lightbox="../../media/native-authentication/android/api-permissions.jpg"::: 
