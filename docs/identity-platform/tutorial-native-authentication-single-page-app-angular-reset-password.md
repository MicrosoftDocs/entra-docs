---
title: Reset Password in Angular SPA App by Using Native Authentication JavaScript SDK
description: Learn how to build a Angular single-page app that enables users to reset their passwords by using native authentication JavaScript SDK.

author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: tutorial
ms.date: 07/30/2025
#Customer intent: As a developer, I want to build Angular single-page application that uses native authentication JavaScript SDK so that I can sign in users with a username (email) and password or email with one-time passcode.
---

# Tutorial: Reset password in Angular single-page app by using native authentication JavaScript SDK

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this tutorial, you learn how to enable password reset in Angular single-page app by using native authentication JavaScript SDK. 

In this tutorial, you:

>[!div class="checklist"]
>
> - Update the Angular app to reset user's password.
> - Test password reset flow


## Prerequisites

- Complete the steps in [Tutorial: Sign up users into Angular single-page app by using native authentication JavaScript SDK](tutorial-native-authentication-single-page-app-angular-sign-up.md).
- [Enable self-service password reset (SSPR)](../external-id/customers/how-to-enable-password-reset-customers.md) for customer users in the external tenant. SSPR is available for customer users for apps that use email with password authentication flow.