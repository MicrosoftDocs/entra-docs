---
title: "Tutorial: Register a Python web app with the Microsoft identity platform"
description: In this tutorial, you learn how to register a Python web app with the Microsoft identity platform.
author: Dickson-Mwendia
manager: CelesteDG
ms.author: dmwendia
ms.date: 04/18/2024
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an application developer, I want to know how to register my application with the Microsoft identity platform so that the security token service can issue access tokens to client applications that request them.
---

# Tutorial: Register a Python web app with the Microsoft identity platform

This tutorial series demonstrates how to build a Python web app that signs in users and calls a protected web API. You use the [Microsoft Authentication Library for Python](/entra/msal/python/) library to authenticate users in your Microsoft Entra ID tenant. Finally, you'll run the app to sign-in, call a protected API, and sign out users.

In this tutorial, you:

> [!div class="checklist"]
> * Register a web app in the Microsoft Entra admin center and record its identifiers
> * Define the platform and URLs
> * Create a client secret for the web app
> * Grant permissions to the web app to access the Microsoft Graph API

## Prerequisites

* An Azure account with an active subscription. If you don't have one, [create an account for free](https://azure.microsoft.com/free/).
* The Azure account you use must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
    * Application Administrator
    * Application Developer
    * Cloud Application Administrator

## Register the Python web app and record identifiers

To integrate identity and access management capabilities into your application, you start by registering your app with the  Microsoft identity platform. Follow these steps to register your application in the Microsoft Entra admin center: 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/signin/index/).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="./media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the tenant in which you want to register the application from the **Directories + subscriptions** menu.
1. Browse to **Identity** > **Applications** > **App registrations** and select **New registration**.
1. Enter a **Name** for your application, for example *python-flask-webapp*. Users of your application might see the display name when they use the app, for example during sign-in. You can change the display name at any time.
1. Under **Supported account types**, select **Accounts in this organizational directory only**.
1. Select **Register** to complete the initial app registration.

When registration finishes, the Microsoft Entra admin center displays the app registration's **Overview** pane. From the **Overview** pane, record the Directory (tenant) ID and the Application (client) ID to be used in a later step.

## Add a redirect URI

To add a redirect URI for your Python Flask web app, follow these steps:

1. In the Microsoft Entra admin center, in **App registrations**, select your application.
1. Under **Manage**, select **Authentication**.
1. Under **Platform configurations**, select **Add a platform**, then select **Web**.
1. Upon selecting web as your app's platform, you're prompted to enter a redirect URI. Add `http://localhost:5000/getAToken` as the redirect URI for your web app.  
1. Select **Configure**.

## Configure credentials

For this tutorial, you'll use a client secret, also known as an application password to identify the app as a confidential client. Follow these steps to add a client secret to your app registration:

1. In the Microsoft Entra admin center, in **App registrations**, select your application.
1. Under **Manage**, select **Certificates & secrets**.
1. In the **Client secrets** section, select **New client secret**.
1. In the **Add a client secret** pane, provide a description for your client secret.
1. Select an expiration for the secret or specify a custom lifetime.
   - Client secret lifetime is limited to two years (24 months) or less. You can't specify a custom lifetime longer than 24 months. Microsoft recommends that you set an expiration value of less than 12 months.
1. Select **Add**.
1. Record the client secret value (not its ID) for use in a later step. This secret value is only shown once when you create it and never displayed after leaving this page.

Although you used a client secret in this tutorial, we recommend using a certificate before moving the application to a production environment. For more information on how to use a certificate, see [these instructions](./certificate-credentials.md).

## Add a scope

Since this app signs in users, you need to add delegated permissions:

1. Under **Manage**, select **API permissions** > **Add a permission**.
1. Ensure that the **Microsoft APIs** tab is selected.
1. From the **Commonly used Microsoft APIs** section, select **Microsoft Graph**.
1. From the **Delegated permissions** section, ensure that **User.Read** is selected. Use the search box if necessary.
1. Select **Add permissions**.


## Next steps

> [!div class="nextstepaction"]
> [Tutorial: Prepare a Python Flask web app for authentication](tutorial-web-app-python-prepare-app.md)