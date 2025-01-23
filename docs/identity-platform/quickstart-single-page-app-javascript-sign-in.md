---
title: "Quickstart: Sign in to a SPA & call an API - JavaScript"
description: In this quickstart, learn how a JavaScript single-page application (SPA) can sign in users of personal accounts, work accounts, and school accounts by using the authorization code flow.
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.custom: scenarios:getting-started, languages:JavaScript, devx-track-js
ms.date: 03/05/2024
ms.reviewer: OwenRichards1
ms.service: identity-platform
zone_pivot_groups: entra-tenants
ms.topic: quickstart
#Customer intent: As an app developer, I want to learn how to get access tokens and refresh tokens by using the Microsoft identity platform so that my JavaScript app can sign in users of personal accounts, work accounts, and school accounts.
---

# Quickstart: Sign in users in a single-page app (SPA) and call the Microsoft Graph API using JavaScript

::: zone pivot="workforce"

This quickstart uses a sample JavaScript (JS) single-page app (SPA) to show you how to sign in users by using the [authorization code flow](./v2-oauth2-auth-code-flow.md) with Proof Key for Code Exchange (PKCE) and call the Microsoft Graph API. The sample uses the [Microsoft Authentication Library for JavaScript](/javascript/api/%40azure/msal-react/) to handle authentication.

## Prerequisites

#### [JavaScript](#tab/javascript-workforce)

* An Azure account with an active subscription. If you don't already have one, [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* [Node.js](https://nodejs.org/en/download/)
* [Visual Studio 2022](https://visualstudio.microsoft.com/vs/) or [Visual Studio Code](https://code.visualstudio.com/)

#### [React](#tab/react-workforce)

* An Azure account with an active subscription. If you don't already have one, [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* [Node.js](https://nodejs.org/en/download/)
* [Visual Studio 2022](https://visualstudio.microsoft.com/vs/) or [Visual Studio Code](https://code.visualstudio.com/)

#### [Angular](#tab/angular-workforce)

* An Azure account with an active subscription. If you don't already have one, [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* [Node.js](https://nodejs.org/en/download/)
* [Visual Studio 2022](https://visualstudio.microsoft.com/vs/) or [Visual Studio Code](https://code.visualstudio.com/)

#### [Blazor](#tab/blazor-workforce)

* An Azure account with an active subscription. If you don't already have one, [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* [.NET SDK](https://dotnet.microsoft.com/download/dotnet)
* [Visual Studio 2022](https://visualstudio.microsoft.com/vs/) or [Visual Studio Code](https://code.visualstudio.com/)

---

## Clone or download the sample application

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

#### [JavaScript](#tab/javascript-workforce)

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-docs-code-javascript.git
    ```

- [Download the .zip file](https://github.com/Azure-Samples/ms-identity-docs-code-javascript/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.

#### [React](#tab/react-workforce)

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-docs-code-javascript.git
    ```

- [Download the .zip file](https://github.com/Azure-Samples/ms-identity-docs-code-javascript/tree/main). Extract it to a file path where the length of the name is fewer than 260 characters.

#### [Angular](#tab/angular-workforce)

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-docs-code-javascript.git
    ```

- [Download the .zip file](https://github.com/Azure-Samples/ms-identity-docs-code-javascript/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.

#### [Blazor](#tab/blazor-workforce)

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-docs-code-dotnet
    ```

- [Download the .zip file](https://github.com/Azure-Samples/ms-identity-docs-code-dotnet/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.

---

## Configure the project

#### [JavaScript](#tab/javascript-workforce)

1. In your IDE, open the project folder, *ms-identity-docs-code-javascript*, containing the sample.
1. Open *vanillajs-spa/App/public/authConfig.js* and update the following values with the information recorded in the admin center.

    :::code language="JavaScript" source="~/../ms-identity-docs-code-javascript/vanillajs-spa/App/public/authConfig.js":::

    * `clientId` - The identifier of the application, also referred to as the client. Replace the text in quotes with the **Application (client) ID** value that was recorded earlier.
    * `authority` - The authority is a URL that indicates a directory that MSAL can request tokens from. Replace *Enter_the_Tenant_Info_Here* with the **Directory (tenant) ID** value that was recorded earlier.
    * `redirectUri` - The **Redirect URI** of the application. If necessary, replace the text in quotes with the redirect URI that was recorded earlier.

#### [React](#tab/react-workforce)

1. In your IDE, open the project folder, *ms-identity-docs-code-javascript/react-spa*, containing the sample.
1. Open *src/authConfig.js* and update the following values with the information recorded in the admin center.

    :::code language="JavaScript" source="~/../ms-identity-docs-code-javascript/react-spa/src/authConfig.js":::

    * `clientId` - The identifier of the application, also referred to as the client. Replace the text in quotes with the **Application (client) ID** value that was recorded earlier.
    * `authority` - The authority is a URL that indicates a directory that MSAL can request tokens from. Replace *Enter_the_Tenant_Info_Here* with the **Directory (tenant) ID** value that was recorded earlier.
    * `redirectUri` - The **Redirect URI** of the application. If necessary, replace the text in quotes with the redirect URI that was recorded earlier.

#### [Angular](#tab/angular-workforce)

1. In your IDE, open the project folder, *ms-identity-docs-code-javascript/angular-spa*, containing the sample.
1. Open *src/app/app.module.ts* and update the following values with the information recorded in the admin center.

    :::code language="JavaScript" source="~/../ms-identity-docs-code-javascript/angular-spa/src/app/app.module.ts":::

    * `clientId` - The identifier of the application, also referred to as the client. Replace the text in quotes with the **Application (client) ID** value that was recorded earlier.
    * `authority` - The authority is a URL that indicates a directory that MSAL can request tokens from. Replace *Enter_the_Tenant_Info_Here* with the **Directory (tenant) ID** value that was recorded earlier.
    * `redirectUri` - The **Redirect URI** of the application. If necessary, replace the text in quotes with the redirect URI that was recorded earlier.

#### [Blazor](#tab/blazor-workforce)

1. In your IDE, open the project folder, *ms-identity-docs-code-dotnet/spa-blazor-wasm*, containing the sample.
1. Open *wwwroot/appsettings.json* and update the following values with the information recorded earlier in the admin center.

    :::code language="JavaScript" source="~/../ms-identity-docs-code-dotnet/spa-blazor-wasm/wwwroot/appsettings.json":::
    
    * `Authority` - The authority is a URL that indicates a directory that MSAL can request tokens from. Replace *Enter_the_Tenant_Info_Here* with the **Directory (tenant) ID** value that was recorded earlier.
    * `ClientId` - The identifier of the application, also referred to as the client. Replace the text in quotes with the **Application (client) ID** value that was recorded earlier.

---

## Run the application and sign in and sign out

Run the project with a web server by using Node.js:

#### [JavaScript](#tab/javascript-workforce)

1. To start the server, run the following commands from within the project directory:

    ```console
    npm install
    npm start
    ```

1. Copy the `https` URL that appears in the terminal, for example, `https://localhost:3000`, and paste it into a browser. We recommend using a private or incognito browser session.
1. Follow the steps and enter the necessary details to sign in with your Microsoft account. You'll be requested an email address so a one time passcode can be sent to you. Enter the code when prompted.
1. The application will request permission to maintain access to data you have given it access to, and to sign you in and read your profile. Select **Accept**. The following screenshot appears, indicating that you have signed in to the application and have accessed your profile details from the Microsoft Graph API.

    :::image type="content" source="./media/quickstarts/js-spa/quickstart-js-spa-sign-in.png" alt-text="Screenshot of JavaScript App depicting the results of the API call." lightbox="./media/quickstarts/js-spa/quickstart-js-spa-sign-in.png":::

#### [React](#tab/react-workforce)

1. To start the server, run the following commands from within the project directory:

    ```console
    npm install
    npm start
    ```

1. Copy the `https` URL that appears in the terminal, for example, `https://localhost:3000`, and paste it into a browser. We recommend using a private or incognito browser session.
1. Follow the steps and enter the necessary details to sign in with your Microsoft account. You're requested an email address so a one time passcode can be sent to you. Enter the code when prompted.
1. The application requests permission to maintain access to data you have given it access to, and to sign you in and read your profile. Select **Accept**. The following screenshot appears, indicating that you have signed in to the application and have accessed your profile details from the Microsoft Graph API.

    :::image type="content" source="./media/common-spa/react-spa/display-api-call-results-react-spa.png" alt-text="Screenshot of JavaScript App depicting the results of the API call." lightbox="./media/common-spa/react-spa/display-api-call-results-react-spa.png":::

#### [Angular](#tab/angular-workforce)

1. To start the server, run the following commands from within the project directory:

    ```console
    npm install
    npm start
    ```

1. Copy the `https` URL that appears in the terminal, for example, `https://localhost:4200`, and paste it into a browser address bar. We recommend using a private or incognito browser session.
1. Follow the steps and enter the necessary details to sign in with your Microsoft account. You'll be requested an email address so a one time passcode can be sent to you. Enter the code when prompted.
1. The application will request permission to maintain access to data you have given it access to, and to sign you in and read your profile. Select **Accept**. The following screenshot appears, indicating that you have signed in to the application and have accessed your profile details from the Microsoft Graph API.

    :::image type="content" source="./media/quickstarts/angular-spa/quickstart-angular-spa-sign-in.png" alt-text="Screenshot of JavaScript App depicting the results of the API call.":::

#### [Blazor](#tab/blazor-workforce)

1. To start the server, run the following commands from within the project directory:

    ```console
    dotnet run
    ```

1. Copy the `http` URL that appears in the terminal, for example, `http://localhost:5000`, and paste it into a browser. We recommend using a private or incognito browser session.
1. Follow the steps and enter the necessary details to sign in with your Microsoft account. You'll be requested an email address so a one time passcode can be sent to you. Enter the code when prompted.
1. The application will request permission to maintain access to data you have given it access to, and to sign you in and read your profile. Select **Accept**. The following screenshot appears, indicating that you have signed in to the application and have accessed your profile details from the Microsoft Graph API.

    :::image type="content" source="./media/common-spa/blazor-spa/display-api-call-results-blazor-spa.png" alt-text="Screenshot of Blazor WASM SPA App depicting the results of the API call.":::

---

## Sign out from the application

1. Find the **Sign out** button in on the page, and select it.
1. You'll be prompted to pick an account to sign out from. Select the account you used to sign in.

A message appears indicating that you have signed out. You can now close the browser window.

## Related content

- [Quickstart: Protect an ASP.NET Core web API with the Microsoft identity platform](./quickstart-web-api-aspnet-core-protect-api.md).

- Learn more by building a React SPA that signs in users in the following multi-part [tutorial series](./tutorial-single-page-app-react-register-app.md).

::: zone-end
::: zone pivot="external"

## Prerequisites

test

::: zone-end

<!-- REACT -->
# Sign in users in a sample React single-page app (SPA) 

This guide uses a sample React single-page application (SPA) to demonstrate how to add authentication to a SPA. This SPA enables users to sign in and sign out by using your external tenant. The sample uses the [Microsoft Authentication Library for JavaScript (MSAL.js)](https://github.com/AzureAD/microsoft-authentication-library-for-js) to handle authentication.

## Prerequisites

- [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.
- [Node.js](https://nodejs.org/en/download/).
- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.

## Register the SPA in the Microsoft Entra admin center

[!INCLUDE [active-directory-b2c-register-app](./includes/register-app/register-client-app-common.md)]
[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/add-platform-redirect-url-react.md)]

## Grant admin consent

[!INCLUDE [active-directory-b2c-grant-delegated-permissions](./includes/register-app/grant-api-permission-sign-in.md)]

## Create a user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)]

## Associate the SPA with the user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/add-app-user-flow.md)]

## Clone or download sample SPA

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial.git
    ```

- [Download the sample](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters. 

## Install project dependencies

1. Open a terminal window in the root directory of the sample project, and enter the following snippet to navigate to the project folder:

    ```console
    cd 1-Authentication\1-sign-in-react\SPA
    ```

1. Install the project dependencies:

    ```console
    npm install
    ```

## Configure the sample SPA

1. Open *SPA\src\authConfig.js* and replace the following with the values obtained from the Microsoft Entra admin center:

     * `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the app you registered earlier.
     * `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).

1. Save the file.

## Run your project and sign in

All the required code snippets have been added, so the application can now be called and tested in a web browser.

1. Open a new terminal by selecting **Terminal** > **New Terminal**.
1. Run the following command to start your web server.

    ```console
    cd 1-Authentication\1-sign-in-react\SPA
    npm start
    ```

1. Open a web browser and navigate to `http://localhost:3000/`.

1. Sign-in with an account registered to the external tenant.

1. Once signed in the display name is shown next to the **Sign out** button.

## Related content

- [Use our multi-part tutorial series to build this React SPA from scratch](tutorial-single-page-app-react-sign-in-prepare-app.md).
- [Enable password reset](how-to-enable-password-reset-customers.md).
- [Customize the default branding](how-to-customize-branding-customers.md).
- [Configure sign-in with Google](how-to-google-federation-customers.md).


<!-- JAVASCRIPT -->
---
title: Sign in users in a sample vanilla JavaScript single-page application
description: Learn how to configure a sample JavaScript single-page application (SPA) to sign in and sign out users.
 
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.service: entra-external-id
ms.subservice: external
ms.custom: devx-track-js
ms.topic: quickstart
ms.date: 04/10/2024
#Customer intent: As a dev, devops, I want to learn about how to configure a sample vanilla JS SPA to sign in and sign out users with my external tenant. .
---

# Sign in users in a sample vanilla JavaScript single-page application

This guide uses a sample vanilla JavaScript (JS) single-page Application (SPA) to demonstrate how to add authentication to a SPA. The SPA enables users to sign in and sign out by using your external tenant. The sample uses the [Microsoft Authentication Library for JavaScript (MSAL.js)](https://github.com/AzureAD/microsoft-authentication-library-for-js) to handle authentication.

## Prerequisites

- [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.
- [Node.js](https://nodejs.org/en/download/).
- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.

## Register the SPA in the Microsoft Entra admin center

[!INCLUDE [active-directory-b2c-register-app](./includes/register-app/register-client-app-common.md)]
[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/add-platform-redirect-url-vanilla-js.md)]

## Grant admin consent

[!INCLUDE [active-directory-b2c-grant-delegated-permissions](./includes/register-app/grant-api-permission-sign-in.md)]

## Create a user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)]

## Associate the SPA with the user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/add-app-user-flow.md)]

## Clone or download sample SPA

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial.git
    ```

- [Download the sample](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters. 

## Install project dependencies

1. Open a terminal window in the root directory of the sample project, and enter the following snippet to navigate to the project folder:

    ```console
    cd 1-Authentication\0-sign-in-vanillajs\App
    ```

1. Install the project dependencies:

    ```console
    npm install
    ```

## Configure the sample SPA

1. Open `App/public/authConfig.js` and replace the following with the values obtained from the Microsoft Entra admin center:

     * `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the app you registered earlier.
     * `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).

1. Save the file.

## Run your project and sign in

1. Open a new terminal and run the following command to start your express web server.

    ```console
    npm start
    ```

1. Open a web browser and navigate to `http://localhost:3000/`.
1. Sign-in with an account registered to the external tenant.
1. Once signed in the display name is shown next to the **Sign out** button as shown in the following screenshot.
1. The SPA will now display a button saying **Request Profile Information**. Select it to display profile data.

    :::image type="content" source="media/how-to-spa-vanillajs-sign-in-sign-in-out/display-vanillajs-welcome.png" alt-text="Screenshot of sign in into a vanilla JS SPA." lightbox="media/how-to-spa-vanillajs-sign-in-sign-in-out/display-vanillajs-welcome.png":::

## Sign out of the application

1. To sign out of the application, select **Sign out** in the navigation bar.
1. A window appears asking which account to sign out of.
1. Upon successful sign out, a final window appears advising you to close all browser windows.

## Related content

- [Use our multi-part tutorial series to build this Vanilla JS SPA from scratch](tutorial-single-page-app-vanillajs-prepare-app.md).
- [Enable password reset](how-to-enable-password-reset-customers.md).
- [Customize the default branding](how-to-customize-branding-customers.md).
- [Configure sign-in with Google](how-to-google-federation-customers.md).


<!-- ANGULAR -->
---
title: Sign in users in a sample Angular single-page application.
description: Learn how to configure a sample Angular Single Page Application (SPA) using Microsoft Entra External ID.
 
author: garrodonnell
manager: celestedg
ms.author: godonnell
ms.service: entra-external-id
 
ms.subservice: external
ms.topic: quickstart
ms.date: 04/10/2024
ms.custom: developer

#Customer intent: As a dev, devops, I want to learn about how to configure a sample Angular Single-page application to sign in and sign out users with my external tenant
---

# Sign in users in a sample Angular single-page application 

This how-to guide uses a sample Angular single-page application (SPA) to demonstrate how to add authentication users into a SPA. The SPA enables users to sign in and sign out by using your external tenant. The sample uses the [Microsoft Authentication Library for JavaScript (MSAL.js)](https://github.com/AzureAD/microsoft-authentication-library-for-js) to handle authentication.

## Prerequisites

- [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.
- [Node.js](https://nodejs.org/en/download/).
- An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.

## Register the SPA in the Microsoft Entra admin center

[!INCLUDE [active-directory-b2c-register-app](./includes/register-app/register-client-app-common.md)]
[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/add-platform-redirect-url-angular.md)]

## Grant admin consent

[!INCLUDE [active-directory-b2c-grant-delegated-permissions](./includes/register-app/grant-api-permission-sign-in.md)]

## Create a user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/create-sign-in-sign-out-user-flow.md)]

## Associate the SPA with the user flow

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/configure-user-flow/add-app-user-flow.md)]

## Clone or download sample SPA

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial.git
    ```

- [Download the sample](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.

## Install project dependencies

1. Open a terminal window in the root directory of the sample project, and enter the following snippet to navigate to the project folder:

    ```console
    cd 1-Authentication\2-sign-in-angular\SPA
    ```

1. Install the project dependencies:

    ```console
    npm install
    ```

## Configure the sample SPA

1. Open `SPA/src/app/auth-config.ts` and replace the following with the values obtained from the Microsoft Entra admin center:

     * `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the app you registered earlier.
     * `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).

1. Save the file.

## Run your project and sign in

All the required code snippets have been added, so the application can now be called and tested in a web browser.

1. Open a new terminal by selecting **Terminal** > **New Terminal**.
1. Run the following command to start your web server.

    ```console
    cd 1-Authentication\2-sign-in-angular\SPA
    npm start
    ```

1. Open a web browser and navigate to `http://localhost:4200/`.

1. Sign-in with an account registered to the external tenant.

1. Once you successfully sign-in, the display name is shown next to the **Sign out** button.

## Related content

- [Use our multi-part tutorial series to build this Angular SPA from scratch](tutorial-single-page-app-angular-sign-in-prepare-app.md).
- [Enable password reset](how-to-enable-password-reset-customers.md).
- [Customize the default branding](how-to-customize-branding-customers.md).
- [Configure sign-in with Google](how-to-google-federation-customers.md).
