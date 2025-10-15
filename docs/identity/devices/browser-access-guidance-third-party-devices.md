---
title: Browser access guidance for third party mobile device management providers
description: Remove support for TLS 1.0 and 1.1 for the Microsoft Entra Device Registration Service


ms.service: entra-id
ms.subservice: devices
ms.topic: reference
ms.date: 10/15/2025

ms.author: owinfrey
author: owinfreyATL
manager: dougeby
ms.reviewer: zhvolosh

---


# Browser access guidance for third party mobile device management providers

Update your [Android Device policy](https://developers.google.com/android/management/reference/rest/v1/enterprises.policies) resource to support automatically enabling browser access during device registration.

As announced in September 2024 and November 2025 in the What’s New in Microsoft Entra blog, we are automatically enabling browser access by default for Android users. This change is part of hardening all Microsoft products as part of the [Secure Future Initiative](https://www.microsoft.com/microsoft-cloud/resources/secure-future-initiative). As part of this initiative, we are eliminating the mechanism to export device registration keys from device storage after registration completes. 


This change means that users of Android devices will no longer be able to modify their browser access settings in Authenticator app or Company Portal after their device has been registered in Microsoft Entra ID.  Instead, Android users will have browser access enabled by default. 

## If you are an MDM provider


We request that you modify your [Android Device policy](https://developers.google.com/android/management/reference/rest/v1/enterprises.policies) resource to support enabling browser access during device registration. The policy resource is used to create and save groups of device and app management settings for your customers to apply to devices.

To enable browser access on behalf of your customers, you need to either create or modify an existing policy to provide a delegated certificate to the Authenticator app and Company Portal. 

The following is an example of a policy: 

**Policy example for setting delegated scope CERT_INSTALL for authenticator**


```html
"applications": [{
    "packageName": "com.azure.authenticator"
    "installType": "REQUIRED_FOR_SETUP"
    "delegatedScopes": [
        "CERT_INSTALL"
      ]   
}],
```








## Related content
TODO: Add your next step link(s)
- [Write concepts](article-concept.md)

<!--
Remove all the comments in this template before you sign-off or merge to the 
main branch.

-->
