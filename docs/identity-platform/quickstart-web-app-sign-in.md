---
title: Quickstart - Sign in users in a sample web app
description: Web app quickstart
services: identity-platform
author: kengaderdus
manager: mwongerapk
ms.service: identity-platform
ms.topic: quickstart
ms.date: 11/20/2024
ms.author: kengaderdus
zone_pivot_groups: entra-tenants

#Customer intent: As a developer, I want to configure a sample web app so that I can sign in my employees and customers by using Microsoft identity platform.
---

# Quickstart - Sign in users in a sample web app

Before you begin, use the **Choose a tenant type** selector at the top of this page to select tenant type. Microsoft Entra ID provides two tenant configurations, [workforce](../external-id/tenant-configurations.md) and [external](../external-id/tenant-configurations.md). A workforce tenant configuration is for your employees, internal apps, and other organizational resources. An external tenant is for your customer-facing apps.

::: zone pivot="workforce"

This quickstart uses a sample web app to show you how to sign in users in your workforce tenant. The sample uses the [Microsoft Authentication Library](msal-overview.md) to handle authentication.

## Prerequisites

#### [Node](#tab/node-worforce)

placeholder

#### [ASP.NET Core](#tab/asp-dot-net-core-worforce)

placeholder


#### [Java](#tab/java-worforce)

placeholder

#### [Python Flask](#tab/python-flask-worforce)

placeholder


---


::: zone-end 

::: zone pivot="external"

This quickstart uses a sample web app to show you how to sign in users in your external tenant. The sample uses the [Microsoft Authentication Library](msal-overview.md) to handle authentication.

## Prerequisites

#### [Node](#tab/node)

- [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.
- [Node.js](https://nodejs.org).
- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.

#### [ASP.NET Core](#tab/asp-dot-net-core)

- Although any IDE that supports ASP.NET Core applications can be used, Visual Studio Code is used for this guide. It can be downloaded from the [Downloads](https://visualstudio.microsoft.com/downloads/) page.
- [.NET 7.0 SDK](https://dotnet.microsoft.com/download/dotnet).
- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.

#### [Python Django](#tab/python-django)

- [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.
- [Python 3+](https://www.python.org/).
- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.

#### [Python Flask](#tab/python-flask)

- [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.
- [Python 3+](https://www.python.org/).
- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
  
---

## Register the web app

[!INCLUDE [register-application-common-steps](../external-id/customers/includes/register-app/register-client-app-common.md)]

## Define the platform and URLs

#### [Node](#tab/node)

[!INCLUDE [ciam-redirect-url-node](../external-id/customers/includes/register-app/add-platform-redirect-url-node.md)]

#### [ASP.NET Core](#tab/asp-dot-net-core)

[!INCLUDE [ciam-redirect-url-dotnet](../external-id/customers/includes/register-app/add-platform-redirect-url-dotnet.md)]

#### [Python Django](#tab/python-django)

[!INCLUDE [django-app-redirect-uri-configuration](../external-id/customers/includes/register-app/add-platform-redirect-url-python-django.md)]  

#### [Python Flask](#tab/python-flask)

[!INCLUDE [flask-app-redirect-uri-configuration](../external-id/customers/includes/register-app/add-platform-redirect-url-python-flask.md)]  

---

## Add app client secret

[!INCLUDE [ciam-add-client-secret](../external-id/customers/includes/register-app/add-app-client-secret.md)]

## Grant admin consent

[!INCLUDE [ciam-grant-delegated-permissions](../external-id/customers/includes/register-app/grant-api-permission-sign-in.md)]

## Create a user flow 

[!INCLUDE [add-user-flow](../external-id/customers/includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)]

## Associate the web application with the user flow

[!INCLUDE [associate-app-with-user-flow](../external-id/customers/includes/configure-user-flow/add-app-user-flow.md)]

## Clone or download sample web application 

#### [Node](#tab/node)

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file:

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial.git
    ```

- Alternatively, [download the sample .zip file](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial/archive/refs/heads/main.zip), then extract it to a file path where the length of the name is fewer than 260 characters.

### Install project dependencies

1. Open a console window, and change to the directory that contains the Node.js sample app:

    ```console
    cd 1-Authentication\5-sign-in-express\App
    ```

1. Run the following commands to install app dependencies:

    ```console
    npm install
    ```

#### [ASP.NET Core](#tab/asp-dot-net-core)

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-dotnet-tutorial.git
    ```

- [Download the .zip file](https://github.com/Azure-Samples/ms-identity-ciam-dotnet-tutorial/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters. 


#### [Python Django](#tab/python-django)

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-docs-code-python.git
    ```
- [Download the .zip file](https://github.com/Azure-Samples/ms-identity-docs-code-python/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.

### Install project dependencies

1. Open a console window, and change to the directory that contains the Flask sample web app:

    ```console
    cd django-web-app
    ```

1. Set up virtual environment:
    a. For **Windows**, run the following commands:        
    ```console
    py -m venv .venv
    .venv\scripts\activate
    ```    
    b. For **macOS/Linux**, run the following commands:    
    ```console
    python3 -m venv .venv
    source .venv/bin/activate
    ```

1. To install app dependencies, run the following commands:

    ```console
    python3 -m pip install -r requirements.txt
    ```

#### [Python Flask](#tab/python-flask)

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-docs-code-python.git
    ```

- [Download the .zip file](https://github.com/Azure-Samples/ms-identity-docs-code-python/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.


### Install project dependencies

1. Open a console window, and change to the directory that contains the Flask sample web app:

    ```console
    cd flask-web-app
    ```

1. Set up virtual environment:

    a. For **Windows**, run the following commands:    
    ```console
    py -m venv .venv
    .venv\scripts\activate
    ```    
    b. For **macOS/Linux**, run the following commands:    
    ```console
    python3 -m venv .venv
    source .venv/bin/activate
    ```
1. To install app dependencies, run the following commands:

    ```console
    python3 -m pip install -r requirements.txt
    ```

---

## Configure the sample web app

#### [Node](#tab/node)

1. In your code editor, open *App\authConfig.js* file.

1. Find the placeholder:

    - `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the app you registered earlier.
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](/entra/external-id/customers/how-to-create-customer-tenant-portal#get-the-customer-tenant-details).
    - `Enter_the_Client_Secret_Here` and replace it with the app secret value you copied earlier.


#### [ASP.NET Core](#tab/asp-dot-net-core)

1. Navigate to the root folder of the sample you have downloaded and directory that contains the ASP.NET Core sample app:

    ```console
    cd 1-Authentication\1-sign-in-aspnet-core-mvc
    ```

1. Open the *appsettings.json* file.
1. In **Authority**, find `Enter_the_Tenant_Subdomain_Here` and replace it with the subdomain of your tenant. For example, if your tenant primary domain is *caseyjensen@onmicrosoft.com*, the value you should enter is *casyjensen*.
1. Find the `Enter_the_Application_Id_Here` value and replace it with the application ID (clientId) of the app you registered in the Microsoft Entra admin center.
1. Replace `Enter_the_Client_Secret_Here` with the client secret value you set up in [Add app client secret](#add-app-client-secret).


#### [Python Django](#tab/python-django)

1. Open your project files on Visual Studio Code or the editor you're using.

1. Create an *.env* file in the root folder of the project using *.env.sample* file as a guide.

1. In your *.env* file, provide the following environment variables:

    1. `CLIENT_ID` which is the Application (client) ID of the app you registered earlier.
    1. `CLIENT_SECRET` which is the app secret value you copied earlier.
    1. `AUTHORITY` which is the URL that identifies a token authority. It should be of the format *https://{subdomain}.ciamlogin.com/{subdomain}.onmicrosoft.com*. Replace *subdomain* with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant subdomain, learn how to [read your tenant details](/entra/external-id/customers/how-to-create-external-tenant-portal#get-the-external-tenant-details).
    1. `REDIRECT_URI` which should be similar to the redirect URI you registered earlier should match your configuration.


#### [Python Flask](#tab/python-flask)

1. Open your project files on Visual Studio Code or the editor you're using.

1. Create an *.env* file in the root folder of the project using *.env.sample* file as a guide.

1. In your *.env* file, provide the following environment variables:

    - `CLIENT_ID` which is the Application (client) ID of the app you registered earlier.
    - `CLIENT_SECRET` which is the app secret value you copied earlier.
    - `AUTHORITY` which is the URL that identifies a token authority. It should be of the format *https://{subdomain}.ciamlogin.com/{subdomain}.onmicrosoft.com*. Replace *subdomain* with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant subdomain, learn how to [read your tenant details](/entra/external-id/customers/how-to-create-customer-tenant-portal#get-the-customer-tenant-details).

1. Confirm that the redirect URI is well configured. The redirect URI you registered earlier should match your configuration. This sample by default sets the redirect URI path to `/getAToken`. This is configured in the *app_config.py* file as *REDIRECT_PATH*.

---


## Run and test sample web app

#### [Node](#tab/node)

You can now test the sample Node.js web app. You need to start the Node.js server and access it through your browser at `http://localhost:3000`.

1. In your terminal, run the following command:

    ```console
    npm start 
    ```

1. Open your browser, then go to `http://localhost:3000`. You should see the page similar to the following screenshot:

    :::image type="content" source="media/how-to-web-app-node-sample-sign-in/web-app-node-sign-in.png" alt-text="Screenshot of sign in into a node web app.":::

1. After the page completes loading, select **Sign in** link. You're prompted to sign in.

1. On the sign-in page, type your **Email address**, select **Next**, type your **Password**, then select **Sign in**. If you don't have an account, select **No account? Create one** link, which starts the sign-up flow.

1. If you choose the sign-up option, after filling in your email, one-time passcode, new password and more account details, you complete the whole sign-up flow. You see a page similar to the following screenshot. You see a similar page if you choose the sign-in option.

    :::image type="content" source="media/how-to-web-app-node-sample-sign-in/web-app-node-view-claims.png" alt-text="Screenshot of view ID token claims.":::

1. Select **Sign out** to sign the user out of the web app or select **View ID token claims** to view ID token claims returned by Microsoft Entra.

### How it works

When users select the **Sign in** link, the app initiates an authentication request and redirects users to Microsoft Entra External ID. On the sign-in or sign-up page that appears, once a user successfully signs in or creates an account, Microsoft Entra External ID returns an ID token to the app. The app validates the ID token, reads the claims, and returns a secure page to the users.  

When the users select the **Sign out** link, the app clears its session, the redirect the user to Microsoft Entra External ID sign-out endpoint to notify it that the user has signed out.

If you want to build an app similar to the sample you've run, complete the steps in [Sign in users in your own Node.js web application](/entra/external-id/customers/tutorial-web-app-node-sign-in-prepare-tenant) article.

#### [ASP.NET Core](#tab/asp-dot-net-core)

1. From your shell or command line, execute the following commands:

    ```console
    dotnet run
    ```

1. Open your web browser and navigate to `https://localhost:7274`.

1. Sign-in with an account registered to the external tenant.

1. Once signed in the display name is shown next to the **Sign out** button as shown in the following screenshot.

    :::image type="content" source="media/tutorial-web-app-dotnet-sign-in-sign-in-out/display-aspnet-welcome.png" alt-text="Screenshot of sign in into a ASP.NET Core web app.":::

1. To sign out from the application, select the **Sign out** button.

#### [Python Django](#tab/python-django)

Run the app to see the sign-in experience at play.

[!INCLUDE [python-identity-library-warning](../external-id/customers/includes/python-identity-library-alert.md)]

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

#### [Python Flask](#tab/python-flask)

Run the app to see the sign-in experience at play.

[!INCLUDE [python-identity-library-warning](../external-id/customers/includes/python-identity-library-alert.md)]

[!INCLUDE [python-flask-web-app-run-app](../external-id/customers/includes/run-app/flask-web-app.md)]

### How it works

When users select the **Sign in** link, the app initiates an authentication request and redirects users to Microsoft Entra External ID. A user then signs in or signs up page on the page that appears. After providing in the required credentials and consenting to required scopes, Microsoft Entra External ID redirects the user back to the web app with an authorization code. The web app then uses this authorization code to acquire a token from Microsoft Entra External ID.

When the users select the **Logout** link, the app clears its session, the redirect the user to Microsoft Entra External ID sign-out endpoint to notify it that the user has signed out. The user is then redirected back to the web app.

---

## Related content

#### [Node](#tab/node)

- [Customize the default branding](/entra/external-id/customers/how-to-customize-branding-customers)
- [Configure sign-in with Google](/entra/external-id/customers/how-to-google-federation-customers)
- [Sign in users in your Node.js web application](/entra/external-id/customers/tutorial-web-app-node-sign-in-prepare-tenant)

#### [ASP.NET Core](#tab/asp-dot-net-core)

- [Use our multi-part tutorial series to build this ASP.NET web application from scratch](/entra/external-id/customers/tutorial-web-app-dotnet-sign-in-prepare-app)
- [Enable password reset](/entra/external-id/customers/how-to-enable-password-reset-customers)
- [Customize the default branding](/entra/external-id/customers/how-to-customize-branding-customers)


#### [Python Django](#tab/python-django)

- [Sign in users using a sample Flask web application](/entra/external-id/customers/sample-web-app-python-flask-sign-in)
- [Enable password reset](/entra/external-id/customers/how-to-enable-password-reset-customers)
- [Customize the default branding](/entra/external-id/customers/how-to-customize-branding-customers)


#### [Python Flask](#tab/python-flask)

- [Enable password reset](/entra/external-id/customers/how-to-enable-password-reset-customers)f
- [Customize the default branding](/entra/external-id/customers/how-to-customize-branding-customers)


---

::: zone-end