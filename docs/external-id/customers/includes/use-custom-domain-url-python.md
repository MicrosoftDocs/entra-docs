---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 07/23/2024
ms.author: kengaderdus
ms.manager: dougeby
---

Use a custom URL domain to fully brand the authentication URL. From a user perspective, users remain on your domain during the authentication process, rather than being redirected to *ciamlogin.com* domain name.

Use the following steps to use a custom URL domain:

1. Use the steps in [Enable custom URL domains for apps in external tenants](../how-to-custom-url-domain.md) to enable custom URL domain for your external tenant.

1. In your *.env* file, locate the `AUTHORITY` variable, then update its value to *https://Enter_the_Custom_Domain_Here/Enter_the_Tenant_ID_Here*. Replace `Enter_the_Custom_Domain_Here` with your custom URL domain and `Enter_the_Tenant_ID_Here` with your tenant ID. If you don't have your tenant ID, learn how to [read your tenant details](../how-to-create-external-tenant-portal.md#get-the-external-tenant-details).
    
After you make the changes to your *.env* file, if your custom URL domain is *login.contoso.com*, and your tenant ID is *aaaabbbb-0000-cccc-1111-dddd2222eeee*, then your file should look similar to the following snippet:

```env
AUTHORITY=https://login.contoso.com/aaaabbbb-0000-cccc-1111-dddd2222eeee
//Other variables
```