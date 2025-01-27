---
title: Register an Android (Kotlin and Java) app in External ID tenant
description: The tutorials provide a step-by-step guide on how to register and configure an Android mobile app in External ID tenant.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: external
ms.topic: tutorial
ms.date: 05/10/2024
ms.custom: developer
zone_pivot_groups: entra-tenants
#Customer intent: As a developer, I want to authenticate users from a sample Android mobile app so that I can experience how Microsoft Entra External ID
---

# Tutorial: Set up an Android app to sign in users by using Microsoft identity platform

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]


This is the second tutorial in the tutorial series that demonstrates how to add Microsoft Authentication Library (MSAL) for Android to your Android app. MSAL enables Android applications to authenticate users with Microsoft Entra.

In this tutorial you'll;

> [!div class="checklist"]
>
> - Add MSAL dependency
> - Add configuration
> - Use custom URL domain (Optional)
> - Create MSAL SDK instance

## Prerequisites

- [Quickstart: Sign in users in a sample mobile app](quickstart-mobile-app-sign-in.md?pivots=external&tabs=java-external)