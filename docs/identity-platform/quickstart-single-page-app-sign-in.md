---
title: "Quickstart - Sign in users in a single-page app (SPA) and call the Microsoft Graph API"
description: Quickstart that shows how to configure a sample SPA that signs in employees or customers by using the Microsoft identity platform
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.custom:
ms.date: 01/27/2025
ms.reviewer: 
ms.service: identity-platform
zone_pivot_groups: entra-tenants
ms.topic: quickstart
#Customer intent: As an app developer, I want to learn how to get access tokens and refresh tokens by using the Microsoft identity platform so that my single-page app app can sign in users of personal accounts, work accounts, and school accounts.
---

# Quickstart: Sign in users in a single-page app (SPA) and call the Microsoft Graph API

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

In this quickstart, you use a sample single-page app (SPA) to show you how to sign in users by using the [authorization code flow](./v2-oauth2-auth-code-flow.md) with Proof Key for Code Exchange (PKCE) and call the Microsoft Graph API. The sample uses the [Microsoft Authentication Library](msal-overview.md) to handle authentication.

::: zone pivot="workforce"
 
## Prerequisites

* An Azure account with an active subscription. If you don't already have one, [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
  * Application Administrator
  * Application Developer
* A workforce tenant. You can use your Default Directory or [set up a new tenant](./quickstart-create-new-tenant.md).
* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.

#### [JavaScript](#tab/javascript-workforce)

* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* Add the following redirect URIs using the **Single-page application** platform configuration. Refer to [How to add a redirect URI in your application](./how-to-add-redirect-uri.md) for more details.
  * **Redirect URI**: `http://localhost:3000/`
* [Node.js](https://nodejs.org/en/download/)

#### [React](#tab/react-workforce)

* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* Add the following redirect URIs using the **Single-page application** platform configuration. Refer to [How to add a redirect URI in your application](./how-to-add-redirect-uri.md) for more details.
  * **Redirect URI**: `http://localhost:3000/`
* [Node.js](https://nodejs.org/en/download/)

#### [Angular](#tab/angular-workforce)

* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* Add the following redirect URI using the **Single-page application** platform configuration. Refer to [How to add a redirect URI in your application](./how-to-add-redirect-uri.md) for more details.
  * **Redirect URI**: `http://localhost:4200/`
* [Node.js](https://nodejs.org/en/download/)

#### [Blazor](#tab/blazor-workforce)

* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* Add the following redirect URIs using the **Single-page application** platform configuration. Refer to [How to add a redirect URI in your application](./how-to-add-redirect-uri.md) for more details.
  * **Redirect URI**: `http://localhost:5000/authentication/login-callback.`
* [.NET SDK](https://dotnet.microsoft.com/download/dotnet)

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
    git clone https://github.com/Azure-Samples/ms-identity-docs-code-dotnet.git
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
1. Open *react-spa/src/authConfig.js* and update the following values with the information recorded in the admin center.

    :::code language="JavaScript" source="~/../ms-identity-docs-code-javascript/react-spa/src/authConfig.js":::

    * `clientId` - The identifier of the application, also referred to as the client. Replace the text in quotes with the **Application (client) ID** value that was recorded earlier.
    * `authority` - The authority is a URL that indicates a directory that MSAL can request tokens from. Replace *Enter_the_Tenant_Info_Here* with the **Directory (tenant) ID** value that was recorded earlier.
    * `redirectUri` - The **Redirect URI** of the application. If necessary, replace the text in quotes with the redirect URI that was recorded earlier.

#### [Angular](#tab/angular-workforce)

1. In your IDE, open the project folder, *ms-identity-docs-code-javascript/angular-spa*, containing the sample.
1. Open *angular-spa/src/app/app.module.ts* and update the following values with the information recorded in the admin center.

    :::code language="JavaScript" source="~/../ms-identity-docs-code-javascript/angular-spa/src/app/app.module.ts":::

    * `clientId` - The identifier of the application, also referred to as the client. Replace the text in quotes with the **Application (client) ID** value that was recorded earlier.
    * `authority` - The authority is a URL that indicates a directory that MSAL can request tokens from. Replace *Enter_the_Tenant_Info_Here* with the **Directory (tenant) ID** value that was recorded earlier.
    * `redirectUri` - The **Redirect URI** of the application. If necessary, replace the text in quotes with the redirect URI that was recorded earlier.

#### [Blazor](#tab/blazor-workforce)

1. In your IDE, open the project folder, *ms-identity-docs-code-dotnet/spa-blazor-wasm*, containing the sample.
1. Open *spa-blazor-wasm/wwwroot/appsettings.json* and update the following values with the information recorded earlier in the admin center.

    :::code language="JavaScript" source="~/../ms-identity-docs-code-dotnet/spa-blazor-wasm/wwwroot/appsettings.json":::
    
    * `Authority` - The authority is a URL that indicates a directory that MSAL can request tokens from. Replace *Enter_the_Tenant_Info_Here* with the **Directory (tenant) ID** value that was recorded earlier.
    * `ClientId` - The identifier of the application, also referred to as the client. Replace the text in quotes with the **Application (client) ID** value that was recorded earlier.

---

## Run the application and sign in and sign out

#### [JavaScript](#tab/javascript-workforce)

Run the project with a web server by using Node.js:

1. To start the server, run the following commands from within the project directory:

    ```console
    cd vanillajs-spa/App
    npm install
    npm start
    ```

1. Copy the `https` URL that appears in the terminal, for example, `https://localhost:3000`, and paste it into a browser. We recommend using a private or incognito browser session.
1. Follow the steps and enter the necessary details to sign in with your Microsoft account. You'll be requested an email address so a one time passcode can be sent to you. Enter the code when prompted.
1. The application will request permission to maintain access to data you have given it access to, and to sign you in and read your profile. Select **Accept**. The following screenshot appears, indicating that you have signed in to the application and have accessed your profile details from the Microsoft Graph API.

    :::image type="content" source="./media/quickstarts/js-spa/quickstart-js-spa-sign-in.png" alt-text="Screenshot of JavaScript App depicting the results of the API call." lightbox="./media/quickstarts/js-spa/quickstart-js-spa-sign-in.png":::

#### [React](#tab/react-workforce)

Run the project with a web server by using Node.js:

1. To start the server, run the following commands from within the project directory:

    ```console
    cd react-spa
    npm install
    npm start
    ```

1. Copy the `https` URL that appears in the terminal, for example, `https://localhost:3000`, and paste it into a browser. We recommend using a private or incognito browser session.
1. Follow the steps and enter the necessary details to sign in with your Microsoft account. You're requested an email address so a one time passcode can be sent to you. Enter the code when prompted.
1. The application requests permission to maintain access to data you have given it access to, and to sign you in and read your profile. Select **Accept**. The following screenshot appears, indicating that you have signed in to the application and have accessed your profile details from the Microsoft Graph API.

    :::image type="content" source="./media/common-spa/react-spa/display-api-call-results-react-spa.png" alt-text="Screenshot of JavaScript App depicting the results of the API call." lightbox="./media/common-spa/react-spa/display-api-call-results-react-spa.png":::

#### [Angular](#tab/angular-workforce)

Run the project with a web server by using Node.js:

1. To start the server, run the following commands from within the project directory:

    ```console
    cd angular-spa/App
    npm install
    npm start
    ```

1. Copy the `https` URL that appears in the terminal, for example, `https://localhost:4200`, and paste it into a browser address bar. We recommend using a private or incognito browser session.
1. Follow the steps and enter the necessary details to sign in with your Microsoft account. You'll be requested an email address so a one time passcode can be sent to you. Enter the code when prompted.
1. The application will request permission to maintain access to data you have given it access to, and to sign you in and read your profile. Select **Accept**. The following screenshot appears, indicating that you have signed in to the application and have accessed your profile details from the Microsoft Graph API.

    :::image type="content" source="./media/quickstarts/angular-spa/quickstart-angular-spa-sign-in.png" alt-text="Screenshot of JavaScript App depicting the results of the API call." lightbox="./media/quickstarts/angular-spa/quickstart-angular-spa-sign-in.png":::

#### [Blazor](#tab/blazor-workforce)

Run the project with a web server by using dotnet:

1. To start the server, run the following commands from within the project directory:

    ```console
    cd spa-blazor-wasm
    dotnet workload install wasm-tools
    dotnet run
    ```

1. Copy the `http` URL that appears in the terminal, for example, `http://localhost:5000`, and paste it into a browser. We recommend using a private or incognito browser session.
1. Follow the steps and enter the necessary details to sign in with your Microsoft account. You'll be requested an email address so a one time passcode can be sent to you. Enter the code when prompted.
1. The application will request permission to maintain access to data you have given it access to, and to sign you in and read your profile. Select **Accept**. The following screenshot appears, indicating that you have signed in to the application and have accessed your profile details from the Microsoft Graph API.

    :::image type="content" source="./media/common-spa/blazor-spa/display-api-call-results-blazor-spa.png" alt-text="Screenshot of Blazor WASM SPA App depicting the results of the API call." lightbox="./media/common-spa/blazor-spa/display-api-call-results-blazor-spa.png":::

---

::: zone-end
::: zone pivot="external"

## Prerequisites

* An Azure account with an active subscription. If you don't already have one, [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
  * Application Administrator
  * Application Developer
* An external tenant. To create one, choose from the following methods:
  * Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code. *(Recommended)*
  * [Create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
* A user flow. For more information, refer to [create self-service sign-up user flows for apps in external tenants](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md). This user flow can be used for multiple applications.
* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.

#### [JavaScript](#tab/javascript-external)

* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* Add the following redirect URIs using the **Single-page application** platform configuration. Refer to [How to add a redirect URI in your application](./how-to-add-redirect-uri.md) for more details.
    * **Redirect URI**: `http://localhost:3000/`
* [Add your application to the user flow](/entra/external-id/customers/how-to-user-flow-add-application)
* [Node.js](https://nodejs.org/en/download/)

#### [React](#tab/react-external)

* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* Add the following redirect URIs using the **Single-page application** platform configuration. Refer to [How to add a redirect URI in your application](./how-to-add-redirect-uri.md) for more details.
    * **Redirect URI**: `http://localhost:3000/`
* [Add your application to the user flow](/entra/external-id/customers/how-to-user-flow-add-application)
* [Node.js](https://nodejs.org/en/download/)

#### [Angular](#tab/angular-external)

* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* Add the following redirect URIs using the **Single-page application** platform configuration. Refer to [How to add a redirect URI in your application](./how-to-add-redirect-uri.md) for more details.
    * **Redirect URI**: `http://localhost:4200/`
* [Add your application to the user flow](/entra/external-id/customers/how-to-user-flow-add-application)
* [Node.js](https://nodejs.org/en/download/)

---

## Clone or download sample SPA

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

#### [JavaScript](#tab/javascript-external)

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial.git
    ```

- [Download the sample](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters. 

#### [React](#tab/react-external)

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial.git
    ```

- [Download the sample](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters. 

#### [Angular](#tab/angular-external)

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial.git
    ```

- [Download the sample](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.

---

## Configure the sample SPA

#### [JavaScript](#tab/javascript-external)

1. Open `App/public/authConfig.js` and replace the following with the values obtained from the Microsoft Entra admin center:

     * `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the app you registered earlier.
     * `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).

1. Save the file.

#### [React](#tab/react-external)

1. Open `SPA\src\authConfig.js` and replace the following with the values obtained from the Microsoft Entra admin center:

     * `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the app you registered earlier.
     * `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).

1. Save the file.

#### [Angular](#tab/angular-external)

1. Open `SPA/src/app/auth-config.ts` and replace the following with the values obtained from the Microsoft Entra admin center:

     * `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the app you registered earlier.
     * `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).

1. Save the file.

---

## Run your project and sign in

#### [JavaScript](#tab/javascript-external)

1. To start the server, run the following commands from within the project directory:

    ```console
    cd 1-Authentication\0-sign-in-vanillajs\App
    npm install
    npm start
    ```

1. Copy the `https` URL that appears in the terminal, for example, `https://localhost:3000`, and paste it into a browser. We recommend using a private or incognito browser session.
1. Sign-in with an account registered to the tenant.
1. The following screenshot appears, indicating that you have signed in to the application and have accessed your profile details from the Microsoft Graph API.

    :::image type="content" source="./media/common-spa/react-spa/display-api-call-results-react-spa.png" alt-text="Screenshot of JavaScript App depicting the results of the API call." lightbox="./media/common-spa/react-spa/display-api-call-results-react-spa.png":::

#### [React](#tab/react-external)

1. To start the server, run the following commands from within the project directory:

    ```console
    cd 1-Authentication\1-sign-in-react\SPA
    npm install
    npm start
    ```

1. Copy the `https` URL that appears in the terminal, for example, `https://localhost:3000`, and paste it into a browser. We recommend using a private or incognito browser session.
1. Sign-in with an account registered to the external tenant.
1. The following screenshot appears, indicating that you have signed in to the application and have accessed your profile details from the Microsoft Graph API.

#### [Angular](#tab/angular-external)

1. To start the server, run the following commands from within the project directory:

    ```console
    cd 1-Authentication\2-sign-in-angular\SPA
    npm install
    npm start
    ```

1. Copy the `https` URL that appears in the terminal, for example, `https://localhost:4200`, and paste it into a browser. We recommend using a private or incognito browser session.
1. Sign-in with an account registered to the external tenant.
1. The following screenshot appears, indicating that you have signed in to the application and have accessed your profile details from the Microsoft Graph API.

    :::image type="content" source="./media/common-spa/angular-spa/customer-display-api-call-results-angular-spa.png" alt-text="Screenshot of JavaScript App depicting the results of the API call." lightbox="./media/common-spa/angular-spa/customer-display-api-call-results-angular-spa.png":::

---

::: zone-end

## Sign out from the application

1. Find the **Sign out** button on the page, and select it.
1. You'll be prompted to pick an account to sign out from. Select the account you used to sign in.

A message appears indicating that you have signed out. You can now close the browser window.

## Related content

- [Quickstart: Protect an ASP.NET Core web API with the Microsoft identity platform](./quickstart-web-api-aspnet-core-protect-api.md).
- [Learn more by building a React SPA that signs in users in the following multi-part tutorial series](./tutorial-single-page-app-react-prepare-app.md).
- [Enable password reset](../external-id/customers/how-to-enable-password-reset-customers.md).
- [Customize the default branding](../external-id/customers/how-to-customize-branding-customers.md).
- [Configure sign-in with Google](../external-id/customers/how-to-google-federation-customers.md).
