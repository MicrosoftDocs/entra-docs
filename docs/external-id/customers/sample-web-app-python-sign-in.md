---
title: Sign in users to a sample Python web application
description: Learn how to configure a sample Python web app to sign in and sign out users by using a Microsoft Entra ID for customers tenant.
 
author: medhir
manager: 

ms.author: medbhargava
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: sample
ms.date: 02/14/2024
ms.custom: developer, devx-track-python
#Customer intent: As a dev, devops, I want to learn about how to configure a sample Python web app to sign in and sign out users with my Microsoft Entra ID for customers tenant
---

# Sign in users for a sample Python web app in a Microsoft Entra ID for customers tenant

This how-to guide uses a sample ASP.NET web application to show the fundamentals of modern authentication using the [Microsoft Authentication Library for .NET](https://github.com/AzureAD/microsoft-authentication-library-for-dotnet) and [Microsoft Identity Web](https://github.com/AzureAD/microsoft-identity-web/) for ASP.NET to handle authentication.

In this article, you'll register a web application in the Microsoft Entra admin center and create a sign in and sign out user flow. You'll associate your web application with the user flow, download and update a sample Python Flask web application using your own Microsoft Entra ID for customers tenant details. Finally, you'll run and test the sample web application.

## Prerequisites

- Although any IDE that supports Python applications can be used, Visual Studio Code is used for this guide. It can be downloaded from the [Downloads](https://visualstudio.microsoft.com/downloads/) page.
- [Python 3.7+](https://www.python.org/downloads/)
- Microsoft Entra ID for customers tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>.

## Register the web app

[!INCLUDE [active-directory-b2c-register-app](./includes/register-app/register-client-app-common.md)]

## Define the platform and URLs

[!INCLUDE [ciam-redirect-url-dotnet](./includes/register-app/add-platform-redirect-url-python.md)]

## Add app client secret

[!INCLUDE [ciam-add-client-secret](./includes/register-app/add-app-client-secret.md)]

## Grant API permissions

[!INCLUDE [ciam-grant-delegated-permissions](./includes/register-app/grant-api-permission-sign-in.md)]

## Create a user flow

[!INCLUDE [ciam-app-integration-add-user-flow](./includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)]

## Associate the web application with the user flow

[!INCLUDE [ciam-integration-add-user-flow](./includes/configure-user-flow/add-app-user-flow.md)]

## Clone sample web application

To get the web app sample code, clone the sample web application from GitHub by running the following command:

    ```powershell
    git clone https://github.com/Azure-Samples/ms-identity-python-webapp.git
    ```

## Configure the application

1. Go to the application folder.

1. Create an *.env* file in the root folder of the project using *.env.sample* as a guide.

    :::code language="python" source="~/../ms-identity-python-webapp-quickstart/.env.sample" range="4-16" highlight="1,2,13":::

    * Set the value of `CLIENT_ID` to the application ID (clientId) of the app you registered in the Microsoft Entra admin center.
    * Set the value of `CLIENT_SECRET` to the client secret value you set up in [Add app client secret](#add-app-client-secret).
    * Set the value of `AUTHORITY` to the URL to your customer tenant's domain. For example, if your tenant primary domain is caseyjensen@onmicrosoft.com, the value you should enter is *https://caseyjensen.ciamlogin.com*.
    
    The environment variables are referenced in *app_config.py*, and are kept in a separate *.env* file to keep them out of source control. The provided *.gitignore* file prevents the *.env* file from being checked in.

## Run the code sample

1. Create a virtual environment for the app:

    [!INCLUDE [Virtual environment setup](~/../azure-docs-pr/articles/app-service/includes/quickstart-python/virtual-environment-setup.md)]

1. Install the requirements using `pip`:

    ```shell
    python3 -m pip install -r requirements.txt
    ```

1. Run the app from the command line, specifying the host and port to match the redirect URI:

    ```shell
    python3 -m flask run --debug --host=localhost --port=3000
    ```

   > [!IMPORTANT]
   > This quickstart application uses a client secret to identify itself as confidential client. Because the client secret is added as a plain-text to your project files, for security reasons, it is recommended that you use a certificate instead of a client secret before considering the application as production application. For more information on how to use a certificate, see [these instructions](./certificate-credentials.md).

## Next steps

- [Enable password reset](how-to-enable-password-reset-customers.md)
- [Customize the default branding](how-to-customize-branding-customers.md)
- [Configure sign-in with Google](how-to-google-federation-customers.md)
- [Sign in users in your own ASP.NET web application by using a Microsoft Entra ID for customers tenant](tutorial-web-app-dotnet-sign-in-prepare-app.md)
