---
title: Register an Android (Kotlin) app in External ID tenant
description: The tutorials provide a step-by-step guide on how to register and configure an Android mobile app in External ID tenant.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: sample
ms.date: 05/10/2024
ms.custom: developer
#Customer intent: As a developer, I want to authenticate users from a sample Android mobile app so that I can experience how Microsoft Entra External ID works.
---

# Tutorial: Register and configure Android (Kotlin) mobile app

This tutorial series demonstrates how to build an Android (Kotlin) mobile app that authenticates using an external tenant. You register an app within the customer's tenant, create an Android (Kotlin) app, and you implement the sign-in, sign-out, and call a protected web API.

In this tutorial, you'll;

> [!div class="checklist"]
>
> - Register an application in customers tenant.
> - Add a Platform redirect URL
> - Enable public client flow.
> - Add delegated permission to Microsoft Graph

## Prerequisites  

- An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>. 

## Register an application
 
[!INCLUDE [register client app](../customers/includes/register-app/register-client-app-common.md)]

## Add a platform redirect URL

[!INCLUDE [Enable public client](../customers/includes/register-app/add-platform-redirect-url-android.md)]

## Enable public client flow

[!INCLUDE [Enable public client](../customers/includes/register-app/enable-public-client-flow.md)]

## Grant admin consent

[!INCLUDE [Grant API permissions](../customers/includes/register-app/grant-api-permission-sign-in.md)]

## Next steps

[Tutorial: Prepare your Android app for authentication](tutorial-mobile-app-android-kotlin-prepare-app.md).

