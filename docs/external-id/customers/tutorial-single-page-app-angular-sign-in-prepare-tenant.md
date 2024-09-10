---
title: Tutorial - Prepare your external tenant to authenticate users in an Angular single-page app (SPA)
description: Learn how to configure your external tenant for authentication with an Angular single-page app (SPA).
services: active-directory
author: garrodonnell
manager: celestedg
ms.service: entra-external-id
ms.subservice: customers
ms.topic: tutorial
ms.date: 10/27/2023
ms.author: godonnell

#Customer intent: As a dev I want to prepare my external tenant for building a single-page app with Angular.
---

# Tutorial: Prepare your external tenant to authenticate users in an Angular single-page app

This tutorial series demonstrates how to build an Angular single-page application (SPA) and prepare it for authentication using the Microsoft Entra admin center. You'll use the [Microsoft Authentication Library for JavaScript](/javascript/api/%40azure/msal-angular/) to authenticate your app with your external tenant. Finally, you'll run the application and test the sign-in and sign-out experiences.

In this tutorial:

> [!div class="checklist"]
> - Register a SPA in the Microsoft Entra admin center, and record its identifiers
> - Define the platform and URLs
> - Grant permissions to the SPA to access the Microsoft Graph API
> - Create a sign-in and sign-out user flow in the Microsoft Entra admin center
> - Associate your SPA with the user flow

## Prerequisites

- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/tutorials/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
- This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
  - Application Administrator
  - Application Developer
  - Cloud Application Administrator

## Register the SPA and record identifiers

[!INCLUDE [register-client-app-common](./includes/register-app/register-client-app-common.md)]

## Add a platform redirect URL

[!INCLUDE [add-platform-redirect-url-react](./includes/register-app/add-platform-redirect-url-angular.md)]

## Grant admin consent

[!INCLUDE [grant-api-permission-sign-in](./includes/register-app/grant-api-permission-sign-in.md)]

## Create a user flow

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [External ID User Flow Administrator](~/identity/role-based-access-control/permissions-reference.md#external-id-user-flow-administrator).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="~/external-id/customers/media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu.
1. Browse to **Identity** > **External Identities** > **User flows**.
1. Select **+ New user flow**.
1. On the **Create** page:

   1. Enter a **Name** for the user flow, such as *SignInSignUpSample*.
   1. In the **Identity providers** list, select **Email Accounts**. This identity provider allows users to sign-in or sign-up using their email address.

         > [!NOTE]
         > Additional identity providers will be listed here only after you set up federation with them. For example, if you set up federation with [Google](./how-to-google-federation-customers.md) or [Facebook](./how-to-facebook-federation-customers.md), you'll be able to select those additional identity providers here.

   1. Under **Email accounts**, you can select one of the two options. For this tutorial, select **Email with password**.

      - **Email with password:** Allows new users to sign up and sign in using an email address as the sign-in name and a password as their first factor credential.
      - **Email one-time-passcode:** Allows new users to sign up and sign in using an email address as the sign-in name and email one-time passcode as their first factor credential.

         > [!NOTE]
         > Email one-time passcode must be enabled at the tenant level (**All Identity Providers** > **Email one-time-passcode**) for this option to be available at the user flow level.

1. Select **Create**. The new user flow appears in the **User flows** list. If necessary, refresh the page.

## Associate the application with your user flow

[!INCLUDE [add-app-user-flow](./includes/configure-user-flow/add-app-user-flow.md)]

## Next step

> [!div class="nextstepaction"]
> [Part 2: Create an Angular SPA for authentication in an external tenant](tutorial-single-page-app-angular-sign-in-prepare-app.md)
