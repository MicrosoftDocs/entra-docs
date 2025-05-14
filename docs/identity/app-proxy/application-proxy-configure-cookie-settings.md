---
title: Application Proxy Cookie Settings
description: Microsoft Entra ID uses access and session cookies to access on-premises applications through application proxy. This article explains how to use and configure the cookie settings. 

author: HULKsmashGithub
manager: femila
ms.service: entra-id
ms.subservice: app-proxy
ms.custom: no-azure-ad-ps-ref
ms.topic: how-to
ms.date: 03/25/2025
ms.author: jayrusso
ms.reviewer: KaTabish

#customer intent: As an IT admin, I want to understand and configure application proxy cookie settings so that I can secure access to on-premises applications.
---

# Cookie settings for accessing on-premises applications in Microsoft Entra ID

Microsoft Entra ID uses access and session cookies to access on-premises applications through application proxy. Learn how to configure the application proxy cookie settings. 

## What are the cookie settings?

[Application proxy](overview-what-is-app-proxy.md) uses the following access and session cookie settings.

| Cookie setting | Default | Description | Recommendations |
| -------------- | ------- | ----------- | --------------- |
| Use HTTP-Only Cookie | **No** | **Yes** lets application proxy include the HTTPOnly flag in HTTP response headers. This flag provides extra security benefits, for example, it prevents client-side scripting (CSS) from copying or modifying the cookies.<br></br><br></br>Before we supported the HTTP-Only setting, application proxy encrypted and transmitted cookies over a secured Transport Layer Security (TLS) channel to protect against modification. | Use **Yes** because of the extra security benefits.<br></br><br></br>Use **No** for clients or user agents that do require access to the session cookie. For example, use **No** for Remote Desktop Protocol (RDP) or Microsoft Terminal Services Client (MSTSC) that connects to a Remote Desktop Gateway server through application proxy.|
| Use Secure Cookie | **Yes** | **Yes** allows application proxy to include the Secure flag in HTTP response headers. Secure Cookies enhances security by transmitting cookies over a TLS secured channel such as HTTPS. TLS prevents cookie transmission in clear text. | Use **Yes** because of the extra security benefits.|
| Use Persistent Cookie | **No** | **Yes** allows application proxy to set its access cookies to not expire when the web browser is closed. The persistence lasts until the access token expires, or until the user manually deletes the persistent cookies. | Use **No** because of the security risk associated with keeping users authenticated.<br></br><br></br>Use **Yes** only for older applications that can't share cookies between processes. It's better to update your application to handle sharing cookies between processes instead of using persistent cookies. For example, you might need persistent cookies to allow a user to open Office documents in explorer view from a SharePoint site. Without persistent cookies, this operation might fail if the access cookies aren't shared between the browser, the explorer process, and the Office process. |

## SameSite Cookies
Cookies that don't specify the [SameSite](https://web.dev/samesite-cookies-explained) attribute are treated as if they're set to **SameSite=Lax**. The `SameSite` attribute declares how cookies should be restricted to a same-site context. When set to `Lax`, the cookie is only sent to same-site requests or top-level navigation. However, application proxy requires these cookies to be preserved in the third-party context to keep users signed in during their session. Due to the requirement, updates were made:

* Setting the **SameSite** attribute to **None** ensures application proxy session cookies are sent in the third-party context.
* Setting the **Use Secure Cookie** setting to use **Yes** as the default. Chrome rejects cookies that don't use the `Secure` flag. The change applies to all existing applications published through application proxy. Application proxy access cookies are set to Secure and only transmitted over HTTPS. The change only applies to the session cookies.

Additionally, if your back-end application has cookies that need third-party context, you must explicitly opt in by changing your application to use `SameSite=None`. Application proxy translates the `Set-Cookie` header to its URLs and respects the settings.


## Set cookie settings with Microsoft Entra admin center

To set the cookie settings using the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Application proxy**.
5. Under **Additional Settings**, set the cookie setting to **Yes** or **No**.
6. Select **Save** to apply your changes. 

## View current cookie settings with PowerShell

To see the current cookie settings for the application, use this PowerShell command:  

```powershell
Get-MgBetaApplication -ApplicationId <Id> | FL *
```

## Set cookie settings with PowerShell

In the following PowerShell commands, `<Id>` is the **Id** of the application. 

**Http-Only Cookie** 

```powershell
Set-EntraBetaApplicationProxyApplication -ApplicationId <Id> -IsHttpOnlyCookieEnabled $true 
Set-EntraBetaApplicationProxyApplication -ApplicationId <Id> -IsHttpOnlyCookieEnabled $false
```

**Secure Cookie**

```powershell
Set-EntraBetaApplicationProxyApplication -ApplicationId <Id> -IsSecureCookieEnabled $true 
Set-EntraBetaApplicationProxyApplication -ApplicationId <Id> -IsSecureCookieEnabled $false
```

**Persistent Cookies**

```powershell
Set-EntraBetaApplicationProxyApplication -ApplicationId <Id> -IsPersistentCookieEnabled $true 
Set-EntraBetaApplicationProxyApplication -ApplicationId <Id> -IsPersistentCookieEnabled $false
```
