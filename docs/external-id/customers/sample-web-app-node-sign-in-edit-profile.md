---
title: Sign in users and edit profile in a sample Node.js web app
description: Learn how to configure a sample web app to edit user's profile. The edit profile operation requires a customer user to complete multifactor authentication (MFA)
 
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: entra-external-id 
ms.subservice: external
ms.topic: sample
ms.date: 10/31/2024
ms.custom: developer
#Customer intent: As a dev, devops, or IT admin, I want to configure a sample Node.js web app so that customer users can sign in and edit profile in their external tenant
---

# Sign in users and edit profile in a sample Node.js web app

This guide uses a sample Node.js web app to show you how to add sign in and edit profile in a web app. The sample web app uses [Microsoft Authentication Library for Node (MSAL Node)](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-node) and Microsoft Graph API to complete the sign in and edit profile operation.

## Prerequisites

- Complete the steps in [Sign in users in a sample Node.js web app](sample-web-app-node-sign-in.md) article. This article shows you how to sign in users by using a sample Node.js web app. 

## Register and configure EditProfileService app

In this step, you register the EditProfileService app (the API app) app, which provides a mechanism to protect the edit profile operation by requiring MFA. 

### Register EditProfileService app

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/register-mfa-api-app.md)]

### Configure EditProfileService app API scopes

The EditProfileService app needs to expose permissions, which a client needs to acquire for calling the API:

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/add-api-mfa-scopes.md)]

### Add app client secret

[!INCLUDE [active-directory-b2c-add-client-secret](./includes/register-app/add-mfa-api-app-client-secret.md)]

### Grant User.ReadWrite permission to the EditProfileService app

*User.ReadWrite* is a Microsoft Graph API permission that enables a user to update their profile. To grant the *User.ReadWrite* permission to the EditProfileService app, use the following steps: 

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/grant-api-permission-edit-profile.md)]

### Grant admin consent

You've assigned the *User.ReadWrite* permissions correctly. However, since the tenant is an external tenant, the customer users themselves can't consent to these permissions. As the administrator of the tenant, you must consent to this permission on behalf of all the users in the tenant:
    
1. Select **Grant admin consent for \<your tenant name\>**, then select **Yes**.

1. Select **Refresh**, then verify that **Granted for \<your tenant name\>** appears under **Status** for both scopes.

## Grant API permissions to the client web app

In this section, you grant API permissions to the client web app that you registered earlier (from the prerequisites). 

Grant your client web app the *EditProfileService.ReadWrite* permission. This permission is exposed by the EditProfileService app, and it protects the update profile operation with MFA. To grant the *EditProfileService.ReadWrite* permission to client web app, use the following steps:

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/grant-api-permissions-mfa-api-app.md)]

### Grant admin consent

You've assigned the **EditProfileService.ReadWrite* permissions correctly. However, since the tenant is an external tenant, the customer users themselves can't consent to these permissions. As the administrator of the tenant, you must consent to these permission on behalf of all the users in the tenant:
    
1. Select **Grant admin consent for \<your tenant name\>**, then select **Yes**.

1. Select **Refresh**, then verify that **Granted for \<your tenant name\>** appears under **Status** for both scopes.

## Create CA MFA policy

Your EditProfileService app that you registered earlier is the resource that you protect with MFA. 

To create an MFA CA policy, use the steps in [Add multifactor authentication to an app](how-to-multifactor-authentication-customers.md). Use the following settings when you create your policy:
- For the **Name**, use *MFA policy*.
- For the Target resources, select the EditProfileService app that you registered earlier, such as *edit-profile-service*.

## Clone or download sample web app

To obtain the sample app, you can either clone it from GitHub or download it as a `.zip` file.

[Download the .zip file](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial/archive/refs/heads/main.zip) or clone the sample web app from GitHub by running the following command:

```Console
git clone https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial.git
```

## Configure the sample web app

This code sample contains two apps, the client app and the service/API app. You need to update these apps to use your external tenant settings. To do so, use the following steps:

1. In your code editor, open `1-Authentication\7-edit-profile-with-mfa-express\App\authConfig.js` file, then find the placeholder:

    - `graph_end_point` and replace it with the Microsoft Graph API endpoint, that's *https://graph.microsoft.com/*.
    - `Add_your_protected_scope_here` and replace it with the EditProfileService app scope. The value looks similar to *api://{clientId}/EditProfileService.ReadWrite*. `{clientId}` is the Application (client) ID value of the [EditProfileService you registered earlier](#register-editprofileservice-app).

1. In your code editor, open `1-Authentication\7-edit-profile-with-mfa-express\Api\authConfig.js` file, then find the placeholder:
    
    - `Enter_the_Tenant_Subdomain_Here` and replace it with Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details). 
    - `Enter_the_Tenant_ID_Here` and replace it with Tenant ID. If you don't have your Tenant ID, learn how to [read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).
    - `Enter_the_Edit_Profile_Service_Application_Id_Here` and replace it with is the Application (client) ID value of the [EditProfileService you registered earlier](#register-editprofileservice-app).
    - `Enter_the_Client_Secret_Here` and replace it with the [EditProfileService app secret](#add-app-client-secret) value you copied earlier.
    - `graph_end_point` and replace it with the Microsoft Graph API endpoint, that's *https://graph.microsoft.com/*.

## Install project dependencies and run app

To test your app, install project dependencies for both the client app and the service/API app, then run them.

1. To run the client app, open your terminal window, then run the following commands:
    
    ```Console
    cd 1-Authentication\7-edit-profile-with-mfa-express\App
    npm install
    npm start
    ```
1. To run the edit service/API app, change directory to the edit service/API app, *1-Authentication\7-edit-profile-with-mfa-express\Api*, then run the following commands:

    ```Console
    npm install
    npm start
    ```

1. Open your browser, then go to http://localhost:3000.

1. Select the **Sign In** button, then you sign in.

1. On the sign-in page, type your **Email address**, select **Next**, type your **Password**, then select **Sign in**. If you don't have an account, select **No account? Create one** link, which starts the sign-up flow.

1. To update profile, select the **Profile editing** link. You see a page similar to the following screenshot:

    :::image type="content" source="media/how-to-web-app-node-edit-profile-update-profile/edit-user-profile.png" alt-text="Screenshot of user update profile."::: 

1. To edit profile, select the **Edit Profile** button. If you haven't already done so, the app prompts you to complete an MFA challenge. 

1. Make changes to the any of the profile details, then select **Save** button. 

## Related content

-  [Learn how to add edit profile in your own Node.js web app](how-to-web-app-node-edit-profile-prepare-tenant.md).