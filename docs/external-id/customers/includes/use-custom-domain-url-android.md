---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: customers
ms.topic: include
ms.date: 06/27/2024
ms.author: kengaderdus
ms.manager: mwongerapk
---

### Use custom URL domain (Optional)

Use a custom domain to fully brand the authentication URL. From a user perspective, users remain on your domain during the authentication process, rather than being redirected to *ciamlogin.com* domain name.

Use the following steps to use a custom domain:

1. Use the steps in [Enable custom URL domains for apps in external tenants](../how-to-custom-url-domain.md) to enable custom URL domain for your external tenant.

1. Open *auth_config_ciam_auth.json* file:
    1. Update the value of the `authority_url` property to *https://Enter_the_Custom_Domain_Here/Enter_the_Tenant_ID_Here*. Replace `Enter_the_Custom_Domain_Here` with your custom URL domain and `Enter_the_Tenant_ID_Here` with your tenant ID. If you don't have your tenant ID, learn how to [read your tenant details](../how-to-create-external-tenant-portal.md#get-the-external-tenant-details). 
    1. Add `knownAuthorities` property with a value *[Enter_the_Custom_Domain_Here]*.
    
After you make the changes to your *auth_config_ciam_auth.json* file, if your custom URL domain is *login.contoso.com*, and your tenant ID is *aaaabbbb-0000-cccc-1111-dddd2222eeee*, then your file should look similar to the following snippet:

```json
{
    "client_id" : "Enter_the_Application_Id_Here",
    "authorization_user_agent" : "DEFAULT",
    "redirect_uri" : "Enter_the_Redirect_Uri_Here",
    "account_mode" : "SINGLE",
    "authorities" : [
    {
        "type": "CIAM",
        "authority_url": "https://login.contoso.com/aaaabbbb-0000-cccc-1111-dddd2222eeee",
        "knownAuthorities": ["login.contoso.com"]
    }
    ]
}
```