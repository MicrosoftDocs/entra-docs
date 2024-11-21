---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 04/29/2024
ms.author: kengaderdus
ms.manager: mwongerapk
---

1. Locate, then open *auth_config_native_auth.json*.

1. In the JSON object, locate the `challenge_types` setting, then add *password* challenge type. Your JSON object should look similar to the following code snippet:

    ```json
        { 
          "client_id": "Enter_the_Application_Id_Here", 
          "authorities": [ 
            { 
              "type": "CIAM", 
              "authority_url": "https://Enter_the_Tenant_Subdomain_Here.ciamlogin.com/Enter_the_Tenant_Subdomain_Here.onmicrosoft.com/" 
            } 
          ], 
          "challenge_types": ["oob","password"], 
          "logging": { 
            //...
          } 
        }
    ```

  The challenge types are a list of values, which the app uses to notify Microsoft Entra about the authentication method that it supports. Learn more [challenge types](../../concept-native-authentication-challenge-types.md).