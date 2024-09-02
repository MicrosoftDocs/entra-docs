---
title: Sign in users and edit profile in a sample Node.js web app
description: Learn how to configure a sample web app to sign in and edit user's profile. The edit profile operation requires user to complete multifactor authentication
 
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: entra-external-id 
ms.subservice: customers
ms.topic: sample
ms.date: 09/02/2024
ms.custom: developer
#Customer intent: As a dev, devops, or IT admin, I want to configure a sample Node.js web application so that customer users can sign in and edit profile in their external tenant
---

# Sign in users and edit profile in a sample Node.js web application

This guide uses a sample Node.js web application to show you how to add sign in and edit profile in a web application. The sample web application uses [Microsoft Authentication Library for Node (MSAL Node)](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-node) and Microsoft Graph API to complete the sign in and edit profile operation.

In this article, you complete the following tasks:

- Register and configure web API in the Microsoft Entra admin center.
- Create Conditional Access (CA) multifactor authentication (MFA) policy.
- Run and test the application. 

## Prerequisites

- Complete the steps in [Sign in users and call an API in sample Node.js web application](sample-web-app-node-sign-in.md) article. This article shows you how to sign in users by using a sample Node.js web app. 

## Register edit profile service

In this step, you register the edit profile service application, which provides a mechanism to protect the edit profile operation by requiring MFA. 

### Register a web API application

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/register-mfa-api-app.md)]

### Configure API scopes

This API needs to expose permissions, which a client needs to acquire for calling the API:

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/add-api-mfa-scopes.md)]

## Grant API permissions to the client web app

In this section, you grant API permissions to the client web app that you registered earlier (from the prerequisites). You grant two permissions: 

- *User.ReadWrite* - a Microsoft Graph APIs permission that enables user to update their profile.
- *api://{clientId}/EditProfileService.ReadWrite* - the edit profile service app permission that protects the update profile operation with MFA.

### Grant User.ReadWrite permission to the client web app

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/grant-api-permission-edit-profile.md)]

### Grant EditProfileService.ReadWrite permission to the client web app

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/grant-api-permissions-mfa-api-app.md)]

### Grant admin consent

At this point, you've assigned the permissions correctly. However, since the tenant is an external tenant, the customer users themselves can't consent to these permissions. To address this problem, you as the administrator must consent to these permissions on behalf of all the users in the tenant:
    
1. Select **Grant admin consent for \<your tenant name\>**, then select **Yes**.

1. Select **Refresh**, then verify that **Granted for \<your tenant name\>** appears under **Status** for both scopes.

## Create CA MFA policy

Your edit profile service app that you registered earlier is the resource that you protect with MFA. 

Use the steps in [Add multifactor authentication to an app](how-to-multifactor-authentication-customers.md) to create an MFA CA policy. Use the following settings when you create your policy:
- For the **Name**, use *MFA policy*.
- For the Target resources, select the edit profile service app that you registered earlier, such as *edit-profile-service*.

## Clone or download sample web application

To obtain the sample application, you can either clone it from GitHub or download it as a `.zip` file.

[Download the .zip file](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial/archive/refs/heads/main.zip) or clone the sample web application from GitHub by running the following command:

```Console
git clone https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial.git
```

## Install project dependencies

1. Open your terminal window, and change to the directory that contains the Node.js sample app:
    
    ```Console
    cd 1-Authentication\7-sign-in-express-mfa\App
    ```
1. Run the following commands to install app dependencies:

    ```Console
    npm install
    ```

## Configure the sample web app

To use your edit profile service app registration in the app sample:

1. In your code editor, open `App\authConfig.js` file.

1. Find the placeholder:
    - `graph_end_point` and replace it with the Microsoft Graph API endpoint, that's *https://graph.microsoft.com/*.
    - `Add_your_protected_scope_here` and replace it with the edit profile service app scope. The values looks similar to *api://{clientId}/EditProfileService.ReadWrite*. `{clientId}` is the Application (client) ID value of the edit profile service app.

## Run and test web app

1. In your terminal, run the following command::

    ```console
    npm start
    ```
1. Open your browser, then go to http://localhost:3000.

1. Select the **Sign In** button, then you sign in.

1. On the sign-in page, type your **Email address**, select **Next**, type your **Password**, then select **Sign in**. If you don't have an account, select **No account? Create one** link, which starts the sign-up flow.

1. To update profile, select the **Edit profile** link. You see a page similar to the following screenshot:

    :::image type="content" source="media/how-to-web-app-node-edit-profile-update-profile/edit-user-profile.png" alt-text="Screenshot of user update profile."::: 

1. To edit the user's **Display Name**, select the **Edit** button. If you haven't already done so, the app prompts you to complete an MFA challenge. 

## Related content

-  [Learn how to add edit profile in your own Node.js web app](how-to-web-app-node-edit-profile-prepare-tenant.md).