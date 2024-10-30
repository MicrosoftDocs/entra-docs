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

- An Azure account with an active subscription. [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- Android Studio
- Android 16+

#### [iOS/macOS](#tab/ios-macos-workforce)

* An Azure account with an active subscription. [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* XCode 10+
* iOS 10+
* macOS 10.12+

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

- <a href="https://developer.android.com/studio" target="_blank">Android Studio</a>.
- An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>. 

#### [Android(.NETMAUI)](#tab/android-netmaui-external)

- [.NET 7.0 SDK](https://dotnet.microsoft.com/download/dotnet/7.0)
- [Visual Studio 2022](https://aka.ms/vsdownloads) with the MAUI workload installed:
  - [Instructions for Windows](/dotnet/maui/get-started/installation?tabs=vswin)
  - [Instructions for macOS](/dotnet/maui/get-started/installation?tabs=vsmac)
- An external tenant. If you don't already have one, [sign up for a free trial](https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl).

#### [iOS/macOS](#tab/ios-macos-external)

- <a href="https://developer.apple.com/xcode/resources/" target="_blank">Xcode</a>.
- An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>.

---

::: zone-end
