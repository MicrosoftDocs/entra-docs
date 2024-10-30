---
title: Register an iOS (Swift) mobile app in External ID tenant
description: The tutorials provide a step-by-step guide on how to register and configure an iOS mobile app in External ID tenant.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: external
ms.topic: tutorial
ms.date: 05/09/2024
ms.custom: developer
#Customer intent: As a developer, I want to reigister and configure iOS application in an External ID tenant.
---

# Tutorial: Register and configure iOS (Swift) mobile app

This tutorial series demonstrates how to build an iOS (Swift) mobile app that authenticates using an external tenant. You register an app within the customer's tenant, create an iOS (Swift) app, and you implement the sign-in, sign-out and call a protected web API.

In this tutorial, you'll;

> [!div class="checklist"]
>
> - Register an application in customers tenant.
> - Add a Platform redirect URL
> - Enable public client flow.
> - Add delegated permission to Microsoft Graph

## Prerequisites  

- <a href="https://developer.apple.com/xcode/resources/" target="_blank">Xcode</a>.
- An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>.

## Register an application

[!INCLUDE [register client app](../customers/includes/register-app/register-client-app-common.md)]

## Add a platform redirect URL

[!INCLUDE [Enable public client](../customers/includes/register-app/add-platform-redirect-url-ios.md)]

## Enable public client flow

[!INCLUDE [Enable public client](../customers/includes/register-app/enable-public-client-flow.md)]

## Grant admin consent

[!INCLUDE [Grant API permissions](../customers/includes/register-app/grant-api-permission-sign-in.md)]

## Next steps

[Tutorial: Prepare your iOS app for authentication](tutorial-mobile-app-ios-swift-prepare-app.md).


