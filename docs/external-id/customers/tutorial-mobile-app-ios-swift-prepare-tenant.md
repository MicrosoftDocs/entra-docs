---
title: Register an iOS (Swift) mobile app in External ID tenant
description: The tutorials provide a step-by-step guide on how to register and configure an iOS mobile app in External ID tenant .

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: sample
ms.date: 04/04/2024
ms.custom: developer
#Customer intent: As a developer, I want to reigister and configure iOS application in an External ID tenant.
---

# Tutorial: Register and configure iOS (Swift) mobile app

This tutorial series demonstrates how to build an iOS (Swift) mobile app that authenticates using an external tenant. You'll register an app within the customer's tenant, create the an iOS (Swift) app, and you implement the sign-in and sign-out code to enable secure authentication.

In this tutorial, you'll;

> [!div class="checklist"]
>
> - Register an iOS (Swift) mobile app in customers tenant.
> - Create a sign-in and sign-out user flow in customers tenant.
> - Associate your .NET MAUI mobile app with the user flow.

## Prerequisites  

- <a href="https://developer.apple.com/xcode/resources/" target="_blank">Xcode</a>.
- An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>.

## Register an application

[!INCLUDE [register client app](../customers/includes/register-app/register-client-app-common.md)]

## Add a platform redirect URL

[!INCLUDE [Enable public client](../customers/includes/register-app/add-platform-redirect-url-ios.md)]

## Enable public client flow

[!INCLUDE [Enable public client](../customers/includes/register-app/enable-public-client-flow.md)]

## Delegated permission to Microsoft Graph

Configure delegated permission to Microsoft Graph to enable your client application to perform operations on behalf of the logged-in user, for example reading their email or modifying their profile. By default, users of your client app are asked when they sign in to consent to the delegated permissions.

[!INCLUDE [Grant API permissions](../customers/includes/register-app/grant-native-authentication-api-permission.md)]

## Next steps

[Tutorial: Prepare your iOS app for authentication](tutorial-mobile-app-android-kotlin-prepare-app.md)


