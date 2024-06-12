---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: customers
ms.topic: include
ms.date: 07/12/2023
ms.author: kengaderdus
ms.manager: mwongerapk
---

To use your client app certificate, you need to associate the app you registered in the Microsoft Entra admin center with the certificate:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator). 

1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="~/external-id/customers/media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu. 

1. Browse to **Identity** > **Applications** > **App registrations**.

1. From the app registration list, select the app that you want to associate with the certificate, such as *ciam-client-app*.

1. Under **Manage**, select **Certificates & secrets**.

1. Select **Certificates**, then select **Upload certificate**.

1. Select the **Select a file** file icon, then select the certificate you want to upload, such as *ciam-client-app-cert.pem* or *ciam-client-app-cert.cer* or *ciam-client-app-cert.crt*.

1. For **Description**, type in a description, such as, *CIAM client app certificate*, then select **Add** to upload your certificate. Once the certificate is uploaded, the **Thumbprint**, **Start date**, and *Expires* values are displayed.

1. Record the **Thumbprint** value for use later when you configure your client app.
