---
title: "Tutorial: Register a Python web app with the Microsoft identity platform"
description: In this tutorial, you learn how to register a Python web app with the Microsoft identity platform.
author: Dickson-Mwendia
manager: CelesteDG
ms.author: dmwendia
ms.date: 02/27/2024
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an application developer, I want to know how to register my application with the Microsoft identity platform so that the security token service can issue access tokens to client applications that request them.
---

# Tutorial: Register a Python web app with the Microsoft identity platform

This tutorial series demonstrates how to build a Python web app and prepare it for authentication using the Microsoft Entra admin center. You'll use the [Microsoft Authentication Library for Python](/entra/msal/python/) library to authenticate your app with your Microsoft Entra ID tenant. Finally, you'll run the application and test the sign-in and sign-out experiences.

In this tutorial, you'll;

> [!div class="checklist"]
> * Register a web application in the Microsoft Entra admin center, and record its identifiers
> * Create a client secret for the web application
> * Define the platform and URLs
> * Grant permissions to the web app to access the Microsoft Graph API

## Prerequisites

* An Azure account with an active subscription. If you don't have one, [create an account for free](https://azure.microsoft.com/en-us/free/).
* The Azure account you use must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
    * Application Administrator
    * Application Developer
    * Cloud Application Administrator

## Register the Python web app and record identifiers

The Microsoft identity platform performs identity and access management (IAM) only for registered applications. Follow these steps to register your application in the Microsoft Entra Admin Center: 

1. Sign in to the [Microsoft Entra Admin Center](https://portal.azure.com).
1. If you have access to multiple tenants, use the **Directories + subscriptions** filter :::image type="icon" source="../media/2-portal-directory-subscription-filter.png" border="false"::: at the right of the top menu to switch to the tenant where you want to register the application.
1. Search for and select **Azure Active Directory**.
1. On the left side bar, under **Manage**, select **App registrations**, then **New registration**. 
1. Enter a **Name** for your application, for example *python-flask-webapp*. Users of your application might see the display name when they use the app, for example during sign-in. You can change the display name at any time.
1. Under **Supported account types**, select **Accounts in any organizational directory(Any Azure AD directory Multitenant)**
1. Ignore the **Redirect URI (optional)** for now. You'll configure it in the next section
1. Select **Register** to complete the initial app registration.

When registration finishes, the Microsoft Entra Admin Center displays the app registration's **Overview** pane. You see the automatically generated **Application (client) ID**.

## Add a redirect URI

To add a redirect URI for your Python Flask web app, follow these steps:

1. In the Microsoft Entra Admin Center, in **App registrations**, select your application.
2. Under **Manage**, select **Authentication**.
3. Under **Platform configurations**, select **Add a platform**.
4. Under **Configure platforms**, select **Web**.
5. Upon selecting web as your app's platform, you'll be prompted to enter a redirect URI. Add `http://localhost:5000/getAToken` as the redirect URI for your web app.  
6. Select **Configure**.

## Configure credentials

For this tutorial, you'll use a client secret, also known as an application password to identify the app as a confidential client. Follow these steps to add a client secret to your app registration:

1. In the Microsoft Entra Admin Center, in **App registrations**, select your application.
1. Under **Manage**, select **Certificates & secrets**.
1. In the **Client secrets** section, select **New client secret**.
1. In the **Add a client secret** pane, provide a description for your client secret.
1. Select an expiration for the secret or specify a custom lifetime.
   - Client secret lifetime is limited to two years (24 months) or less. You can't specify a custom lifetime longer than 24 months. Microsoft recommends that you set an expiration value of less than 12 months.
1. Select **Add**.
1. Record the client secret value (not its ID) for use in a later step. This secret value is only shown once when you create it and never displayed after leaving this page.

Although you used a client secret is added as a plain-text to your project files, for security reasons, it is recommended that you use a certificate instead of a client secret before moving the application to a production environment. For more information on how to use a certificate, see [these instructions](./certificate-credentials.md).

## Next steps

> [!div class="nextstepaction"]
> [Tutorial: Prepare a Python Flask web app for authentication](tutorial-web-app-python-prepare-app.md)