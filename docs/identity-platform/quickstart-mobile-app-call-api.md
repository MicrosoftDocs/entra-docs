---
title: Quickstart - Sign in users and call a web API in sample app
description: Quickstart for configuring a sample mobile app to sign in users and call web API with Microsoft identity platform.
services: identity-platform
author: henrymbuguakiarie
manager: mwongerapk
ms.service: identity-platform
ms.topic: quickstart
ms.date: 10/30/2024
ms.author: henrymbugua
zone_pivot_groups: entra-tenants

#Customer intent: As a developer, I want to configure a sample mobile app so that I can sign in my users and call web API by using Microsoft identity platform.
---

# Quickstart: Sign in users and call a web API in a sample mobile app

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

Before you begin, use the **Choose a tenant type** selector at the top of this page to select tenant type. Microsoft Entra ID provides two tenant configurations, [workforce](../external-id/tenant-configurations.md) and [external](../external-id/tenant-configurations.md). A workforce tenant configuration is for your employees, internal apps, and other organizational resources. An external tenant is for your customer-facing apps.

This guide demonstrates how to configure a sample mobile application to sign in users, and call an ASP.NET Core web API.

#### [Android](#tab/android-external)

In this article, you do the following tasks: 
 
- Register an application in the Microsoft Entra admin center.
- Add a platform redirect URL.
- Enable public client flows.   
- Update the Android configuration code sample file to use your own Microsoft Entra External ID for customer tenant details.  
- Run and test the sample Android mobile application.
- Call a protected web API.

#### [iOS/macOS](#tab/ios-macos-external)

In this article, you do the following tasks: 

- Register an application in the Microsoft Entra admin center.
- Add a platform redirect URL.
- Enable public client flows.   
- Update the iOS configuration code sample file to use your own Microsoft Entra External ID for customer tenant details.  
- Run and test the sample iOS mobile application. 

---

## Prerequisites

#### [Android](#tab/android-external)

- <a href="https://developer.android.com/studio" target="_blank">Android Studio</a>.
- An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>. 
- An API registration that exposes at least one scope (delegated permissions) and one app role (application permission) such as *ToDoList.Read*. If you haven't already, follow the instructions for [call an API in a sample Android mobile app](../external-id/customers/sample-native-authentication-android-sample-app-call-web-api.md) to have a functional protected ASP.NET Core web API. Make sure you complete the following steps:

    - Register a web API application
    - Configure API scopes
    - Configure app roles
    - Configure optional claims
    - Clone or download sample web API
    - Configure and run sample web API

#### [iOS/macOS](#tab/ios-macos-external)

- <a href="https://developer.apple.com/xcode/resources/" target="_blank">Xcode</a>.
- An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>.
- An API registration that exposes at least one scope (delegated permissions) and one app role (application permission) such as *ToDoList.Read*. If you haven't already, follow the instructions for [call an API in a sample iOS mobile app](../external-id/customers/sample-native-authentication-ios-sample-app-call-web-api.md) to have a functional protected ASP.NET Core web API. Make sure you complete the following steps:

    - Register a web API application.
    - Configure API scopes.
    - Configure app roles.
    - Configure optional claims.
    - Clone or download sample web API.
    - Configure and run sample web API.

---

## Register an application

[!INCLUDE [register client app](../external-id/customers/includes/register-app/register-client-app-common.md)]

## Add a platform redirect URL

#### [Android](#tab/android-external)

[!INCLUDE [Enable public client](../external-id/customers/includes/register-app/add-platform-redirect-url-android.md)]

#### [iOS/macOS](#tab/ios-macos-external)

[!INCLUDE [Enable public client](../external-id/customers/includes/register-app/add-platform-redirect-url-ios.md)]

---

