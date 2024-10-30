---
title: Quickstart - Sign in users in a sample mobile app
description: Quickstart for configuring a sample mobile app to sign in employees or customers with Microsoft identity platform.
services: identity-platform
author: henrymbuguakiarie
manager: mwongerapk
ms.service: identity-platform
ms.topic: quickstart
ms.date: 11/20/2024
ms.author: henrymbugua
zone_pivot_groups: entra-tenants

#Customer intent: As a developer, I want to configure a sample mobile app so that I can sign in my employees or customers by using Microsoft identity platform.
---

# Quickstart: Sign in users in a sample mobile app

Before you begin, use the **Choose a tenant type** selector at the top of this page to select tenant type. Microsoft Entra ID provides two tenant configurations, [workforce](../external-id/tenant-configurations.md) and [external](../external-id/tenant-configurations.md). A workforce tenant configuration is for your employees, internal apps, and other organizational resources. An external tenant is for your customer-facing apps.

::: zone pivot="workforce"

In this quickstart, you download and run a code sample that demonstrates how an Android application can sign in users and get an access token to call the Microsoft Graph API.

Applications must be represented by an app object in Microsoft Entra ID so that the Microsoft identity platform can provide tokens to your application.

## Prerequisites

#### [Android](#tab/android-workforce)

Android prerequisites.

#### [iOS/macOS](#tab/ios-macos-workforce)

iOS/macOS prerequisites.

---

::: zone-end 

::: zone pivot="external"

This guide demonstrates how to configure a sample Android mobile application to sign in users.
  
In this article, you do the following tasks: 
 
- Register an application in the Microsoft Entra admin center.
- Add a platform redirect URL.
- Enable public client flows.   
- Update the Android configuration code sample file to use your own Microsoft Entra External ID for customer tenant details.  
- Run and test the sample Android mobile application.

## Prerequisites

#### [Android](#tab/android-external)

Android prerequisites.

#### [iOS/macOS](#tab/ios-macos-external)

iOS/macOS prerequisites.

#### [Android(.NETMAUI)](#tab/android-netmaui-external)

Android(.NETMAUI) prerequisites.

---

::: zone-end
