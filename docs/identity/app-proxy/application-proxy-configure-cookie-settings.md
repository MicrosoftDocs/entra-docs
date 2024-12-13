---
title: Application proxy cookie settings
description:  Microsoft Entra ID has access and session cookies for accessing on-premises applications through application proxy. In this article, you find out how to use and configure the cookie settings. 

author: kenwith
manager: amycolannino
ms.service: entra-id
ms.subservice: app-proxy
ms.custom: has-azure-ad-ps-ref
ms.topic: how-to
ms.date: 02/07/2024
ms.author: kenwith
ms.reviewer: ashishj
---

# Cookie settings for accessing on-premises applications in Microsoft Entra ID

Microsoft Entra ID has access and session cookies for accessing on-premises applications through application proxy. Find out how to use the application proxy cookie settings. 

## What are the cookie settings?

[Application proxy](overview-what-is-app-proxy.md) uses the following access and session cookie settings.

| Cookie setting | Default | Description | Recommendations |
| -------------- | ------- | ----------- | --------------- |
| Use HTTP-Only Cookie | **No** | **Yes** allows application proxy to include the HTTPOnly flag in HTTP response headers. This flag provides extra security benefits, for example, it prevents client-side scripting (CSS) from copying or modifying the cookies.<br></br><br></br>Before we supported the HTTP-Only setting, application proxy encrypted and transmitted cookies over a secured Transport Layer Security (TLS) channel to protect against modification. | Use **Yes** because of the extra security benefits.<br></br><br></br>Use **No** for clients or user agents that do require access to the session cookie. For example, use **No** for Remote Desktop Protocol (RDP) or Microsoft Terminal Services Client (MTSC) that connects to a Remote Desktop Gateway server through application proxy.|
| Use Secure Cookie | **Yes** | **Yes** allows application proxy to include the Secure flag in HTTP response headers. Secure Cookies enhances security by transmitting cookies over a TLS secured channel such as HTTPS. TLS prevents cookie transmission in clear text. | Use **Yes** because of the extra security benefits.|
| Use Persistent Cookie | **No** | **Yes** allows application proxy to set its access cookies to not expire when the web browser is closed. The persistence lasts until the access token expires, or until the user manually deletes the persistent cookies. | Use **No** because of the security risk associated with keeping users authenticated.<br></br><br></br>We suggest only using **Yes** for older applications that can't share cookies between processes. It's better to update your application to handle sharing cookies between processes instead of using persistent cookies. For example, you might need persistent cookies to allow a user to open Office documents in explorer view from a SharePoint site. Without persistent cookies, this operation might fail if the access cookies aren't shared between the browser, the explorer process, and the Office process. |

## SameSite Cookies
Cookies that don't specify the [SameSite](https://web.dev/samesite-cookies-explained) attribute are treated as if they were set to **SameSite=Lax**. The `SameSite` attribute declares how cookies should be restricted to a same-site context. When set to `Lax`, the cookie is only sent to same-site requests or top-level navigation. However, application proxy requires these cookies are preserved in the third-party context in order to keep users properly signed in during their session. Due to the requirement, updates were made:

* Setting the **SameSite** attribute to **None**. application proxy sessions cookies are properly sent in the third-party context.
* Setting the **Use Secure Cookie** setting to use **Yes** as the default. Chrome rejects cookies not using the `Secure` flag. The change applies to all existing applications published through application proxy. Application proxy access cookies are set to Secure and only transmitted over HTTPS. The change only applies to the session cookies.

Additionally, if your back-end application has cookies that need third-party context, you must explicitly opt in by changing your application to use `SameSite=None`. Application proxy translates the `Set-Cookie` header to its URLs and respects the settings.


## Set the cookie settings - Microsoft Entra admin center

To set the cookie settings using the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Application proxy**.
5. Under **Additional Settings**, set the cookie setting to **Yes** or **No**.
6. Select **Save** to apply your changes. 

## View current cookie settings - PowerShell

To see the current cookie settings for the application, use this PowerShell command:  

```powershell
Get-AzureADApplicationProxyApplication -ObjectId <ObjectId> | fl * 
```

## Set cookie settings - PowerShell

In the following PowerShell commands, ```<ObjectId>``` is the ObjectId of the application. 

**Http-Only Cookie** 

```powershell
Set-AzureADApplicationProxyApplication -ObjectId <ObjectId> -IsHttpOnlyCookieEnabled $true 
Set-AzureADApplicationProxyApplication -ObjectId <ObjectId> -IsHttpOnlyCookieEnabled $false 
```

**Secure Cookie**

```powershell
Set-AzureADApplicationProxyApplication -ObjectId <ObjectId> -IsSecureCookieEnabled $true 
Set-AzureADApplicationProxyApplication -ObjectId <ObjectId> -IsSecureCookieEnabled $false 
```

**Persistent Cookies**

```powershell
Set-AzureADApplicationProxyApplication -ObjectId <ObjectId> -IsPersistentCookieEnabled $true 
Set-AzureADApplicationProxyApplication -ObjectId <ObjectId> -IsPersistentCookieEnabled $false 
```
