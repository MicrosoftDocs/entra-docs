---
title: Sign in users in a sample Python Flask web application 
description: Learn how to configure a sample Python Flask web app to sign in and sign out users.
author: SHERMANOUKO
manager: mwongerapk

ms.author: shermanouko
ms.service: entra-external-id
ms.subservice: customers
ms.topic: sample
ms.date: 03/18/2024
#Customer intent: As a dev, devops, I want to learn about how to configure a sample Python Flask web app to sign in and sign out users with my external tenant.
---

# Sign in users in a sample Python Flask web application

In this article, you explore a Python Flask web app that is secured by Microsoft Entra External ID. This sample takes you through the sign-in experience for customers authenticating to a Python Flask web app. The sample web app uses the [Microsoft Authentication Library for Python (MSAL Python)](https://github.com/AzureAD/microsoft-authentication-library-for-python) to handle user authentication.

## Prerequisites

- [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.
- [Python 3+](https://www.python.org/).
- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.

## Register the web app

[!INCLUDE [register-application-common-steps](./includes/register-app/register-client-app-common.md)]
[!INCLUDE [flask-app-redirect-uri-configuration](./includes/register-app/add-platform-redirect-url-python-flask.md)]  

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
    cd flask-web-app
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

    - `CLIENT_ID` which is the Application (client) ID of the app you registered earlier.
    - `CLIENT_SECRET` which is the app secret value you copied earlier.
    - `AUTHORITY` which is the URL that identifies a token authority. It should be of the format *https://{subdomain}.ciamlogin.com/{subdomain}.onmicrosoft.com*. Replace *subdomain* with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant subdomain, learn how to [read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).

1. Confirm that the redirect URI is well configured. The redirect URI you registered earlier should match your configuration. This sample by default sets the redirect URI path to `/getAToken`. This is configured in the *app_config.py* file as *REDIRECT_PATH*.

## Run and test sample web app

Run the app to see the sign-in experience at play.

[!INCLUDE [python-identity-library-warning](./includes/python-identity-library-alert.md)]

[!INCLUDE [python-flask-web-app-run-app](./includes/run-app/flask-web-app.md)]

### How it works

When users select the **Sign in** link, the app initiates an authentication request and redirects users to Microsoft Entra External ID. A user then signs in or signs up page on the page that appears. After providing in the required credentials and consenting to required scopes, Microsoft Entra External ID redirects the user back to the web app with an authorization code. The web app then uses this authorization code to acquire a token from Microsoft Entra External ID.

When the users select the **Logout** link, the app clears its session, the redirect the user to Microsoft Entra External ID sign-out endpoint to notify it that the user has signed out. The user is then redirected back to the web app.

## Related content

- [Sign in users in a sample Django web application](./sample-web-app-python-django-sign-in.md)
- [Enable password reset](how-to-enable-password-reset-customers.md)
- [Customize the default branding](how-to-customize-branding-customers.md)
- [Configure sign-in with Google](how-to-google-federation-customers.md)
