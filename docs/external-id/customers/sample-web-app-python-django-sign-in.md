---
title: Sign in users in a sample Python Django web application 
description: Learn how to configure a sample Python Django web app to sign in and sign out users.
author: SHERMANOUKO
manager: mwongerapk

ms.author: shermanouko
ms.service: entra-external-id
ms.subservice: external
ms.topic: quickstart
ms.date: 03/18/2024
#Customer intent: As a dev, devops, I want to learn about how to configure a sample Python Django web app to sign in and sign out users with my external tenant.
---

# Sign in users in a sample Python Django web application

In this guide, you explore a Python Django web app that is secured by Microsoft Entra External ID. This sample takes you through the sign-in experience for customers authenticating to a Python Django web app. The sample web app uses the [Microsoft Authentication Library for Python (MSAL Python)](https://github.com/AzureAD/microsoft-authentication-library-for-python) to handle user authentication.

## Prerequisites

- [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.
- [Python 3+](https://www.python.org/).
- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.

## Register the web app

[!INCLUDE [register-application-common-steps](./includes/register-app/register-client-app-common.md)]
[!INCLUDE [django-app-redirect-uri-configuration](./includes/register-app/add-platform-redirect-url-python-django.md)]  

## Add app client secret

[!INCLUDE [add-client-secret](./includes/register-app/add-app-client-secret.md)]

## Grant admin consent

[!INCLUDE [grant-delegated-permissions](./includes/register-app/grant-api-permission-sign-in.md)]

## Create a user flow

[!INCLUDE [add-user-flow](./includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)]

## Associate the web application with the user flow

[!INCLUDE [associate-app-with-user-flow](./includes/configure-user-flow/add-app-user-flow.md)]

## Clone or download sample web application

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-docs-code-python.git
    ```
- [Download the .zip file](https://github.com/Azure-Samples/ms-identity-docs-code-python/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.

## Install project dependencies

1. Open a console window, and change to the directory that contains the Flask sample web app:

    ```console
    cd django-web-app
    ```

1. Set up virtual environment

    ### [Windows](#tab/windows)
    
    ```console
    py -m venv .venv
    .venv\scripts\activate
    ```
    
    ### [macOS/Linux](#tab/mac-linux)
    
    ```console
    python3 -m venv .venv
    source .venv/bin/activate
    ```

    ---

1. Run the following commands to install app dependencies:

    ```console
    python3 -m pip install -r requirements.txt
    ```

## Configure the sample web app

1. Open your project files on Visual Studio Code or the editor you're using.

1. Create an *.env* file in the root folder of the project using *.env.sample* file as a guide.

1. In your *.env* file, provide the following environment variables:

    1. `CLIENT_ID` which is the Application (client) ID of the app you registered earlier.
    1. `CLIENT_SECRET` which is the app secret value you copied earlier.
    1. `AUTHORITY` which is the URL that identifies a token authority. It should be of the format *https://{subdomain}.ciamlogin.com/{subdomain}.onmicrosoft.com*. Replace *subdomain* with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant subdomain, learn how to [read your tenant details](how-to-create-external-tenant-portal.md#get-the-external-tenant-details).
    1. `REDIRECT_URI` which should be similar to the redirect URI you registered earlier should match your configuration.

## Run and test sample web app

Run the app to see the sign-in experience at play.

[!INCLUDE [python-identity-library-warning](./includes/python-identity-library-alert.md)]

1. In your terminal, run the following command:

    ```console
    python manage.py runserver localhost:5000                                             
    ```
    
    You can use the port of your choice. This should be similar to the port of the redirect URI you registered earlier.

1. Open your browser, then go to `http://localhost:5000`. You should see the page similar to the following screenshot:

    :::image type="content" source="media/sample-web-app-django-sign-in/django-sign-in-page.png" alt-text="Screenshot of Django web app sample sign-in page.":::

1. After the page completes loading, select **Sign In** link. You're prompted to sign in.

1. On the sign-in page, type your **Email address**, select **Next**, type your **Password**, then select **Sign in**. If you don't have an account, select **No account? Create one** link, which starts the sign-up flow.

1. If you choose the sign-up option, you'll go through the sign-uo flow. Fill in your email, one-time passcode, new password, and more account details to complete the whole sign-up flow.

1. After you sign in or sign up, you're redirected back to the web app. You'll see a page that looks similar to the following screenshot:

    :::image type="content" source="media/sample-web-app-django-sign-in/django-authenticated-page.png" alt-text="Screenshot of flask web app sample after successful authentication.":::

1. Select **Logout** to sign the user out of the web app or select **Call a downstream API** to make a call to a Microsoft Graph endpoint.

### How it works

When users select the **Sign in** link, the app initiates an authentication request and redirects users to Microsoft Entra External ID. A user then signs in or signs up page on the page that appears. After providing in the required credentials and consenting to required scopes, Microsoft Entra External ID redirects the user back to the web app with an authorization code. The web app then uses this authorization code to acquire a token from Microsoft Entra External ID.

When the users select the **Logout** link, the app clears its session, the redirect the user to Microsoft Entra External ID sign-out endpoint to notify it that the user has signed out. The user is then redirected back to the web app.

## Related content

- [Sign in users using a sample Flask web application](./sample-web-app-python-flask-sign-in.md)
- [Enable password reset](how-to-enable-password-reset-customers.md)
- [Customize the default branding](how-to-customize-branding-customers.md)
- [Configure sign-in with Google](how-to-google-federation-customers.md)
