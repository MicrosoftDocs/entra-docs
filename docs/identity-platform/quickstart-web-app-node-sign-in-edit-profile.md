---
title: Quickstart - Edit profile in a sample Node.js web app
description: Learn how to configure a sample web app to edit user's profile. The edit profile operation requires a customer user to complete multifactor authentication (MFA)
 
author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: identity-platform
ms.topic: quickstart
ms.date: 11/28/2024
ms.custom: developer
#Customer intent: As a dev, devops, or IT admin, I want to configure a sample Node.js web app so that customer users edit profile after completing a multifactor authentication (MFA) in their external tenant
---

# Quickstart - Edit profile in a sample Node.js web app

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this Quickstart, you use a sample Node.js web app to learn how to add sign in and edit profile in a web app. The sample web app uses [Microsoft Authentication Library for Node (MSAL Node)](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-node) and Microsoft Graph API to complete the sign in and edit profile operation. The edit profile operation requires a user to complete an multifactor authentication (MFA).

## Prerequisites

- Complete the steps and prerequisites in [Quickstart: Sign in users in a sample web app](quickstart-web-app-sign-in.md?pivots=external&tabs=node-external) article. This Quickstart shows you how to sign in users by using a sample Node.js web app. 

## Register API app

In this step, you register and configure an API app (EditProfileService app), which provides a mechanism to protect the edit profile operation by requiring MFA. 

### Register EditProfileService app

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](../external-id/customers//includes/register-app/register-mfa-api-app.md)]

### Configure EditProfileService app API scopes

The EditProfileService app needs to expose permissions that a client app acquires to call the web API.

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](../external-id/customers//includes/register-app/add-api-mfa-scopes.md)]

### Add app client secret

[!INCLUDE [active-directory-b2c-add-client-secret](../external-id/customers//includes/register-app/add-mfa-api-app-client-secret.md)]

### Grant User.ReadWrite permission to the EditProfileService app

*User.ReadWrite* is a Microsoft Graph API permission that enables a user to update their profile. To grant the *User.ReadWrite* permission to the EditProfileService app, use the following steps: 

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](../external-id/customers//includes/register-app/grant-api-permission-edit-profile.md)]

### Grant admin consent in the EditProfileService app

You've assigned the *User.ReadWrite* permissions correctly to your EditProfileService app. However, since the tenant is an external tenant, the customer users themselves can't consent to these permissions. As the administrator of the tenant, you must consent to this permission on behalf of all the users in the tenant:
    
1. Select **Grant admin consent for \<your tenant name\>**, then select **Yes**.

1. Select **Refresh**, then verify that **Granted for \<your tenant name\>** appears under **Status** for both scopes.

## Grant API permissions to the client web app

In this section, you grant API permissions to the client web app that you registered earlier (in prerequisites). 

Grant your client web app the *EditProfileService.ReadWrite* permission. This permission is exposed by the EditProfileService app, and it protects the update profile operation with MFA. To grant the *EditProfileService.ReadWrite* permission to client web app, use the following steps:

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](../external-id/customers//includes/register-app/grant-api-permissions-mfa-api-app.md)]

### Grant admin consent in the client web app

You've assigned the **EditProfileService.ReadWrite* permissions correctly to your client web app. However, since the tenant is an external tenant, the customer users themselves can't consent to these permissions. As the administrator of the tenant, you must consent to this permission on behalf of all the users in the tenant:
    
1. Select **Grant admin consent for \<your tenant name\>**, then select **Yes**.

1. Select **Refresh**, then verify that **Granted for \<your tenant name\>** appears under **Status** for both scopes.

## Create Conditional Access MFA policy

Your EditProfileService app that you registered earlier is the resource that you protect with MFA. 

To create an MFA Conditional Access (CA) policy, use the steps in [Add multifactor authentication to an app](../external-id/customers/how-to-multifactor-authentication-customers.md). Use the following settings when you create your policy:
- For the **Name**, use *MFA policy*.
- For the Target resources, select the EditProfileService app that you registered earlier, such as *edit-profile-service*.

## Clone or download sample web app

You already cloned the [sample app](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial) from the prerequisites, but if you've not already done so, you can either clone it from GitHub or download it as a `.zip` file.

[Download the .zip file](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial/archive/refs/heads/main.zip) or clone the sample web app from GitHub by running the following command:

```Console
git clone https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial.git
```

## Configure the sample web app

This code sample contains two apps, the client web app and the API app (EditProfileService app). You need to update these apps to use your external tenant settings. To do so, use the following steps:

1. In your code editor, open `1-Authentication\7-edit-profile-with-mfa-express\App\authConfig.js` file, then find the placeholder:

    - `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the client web app you registered earlier.
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](/entra/external-id/customers/how-to-create-customer-tenant-portal#get-the-customer-tenant-details).
    - `Enter_the_Client_Secret_Here` and replace it with the app secret value of the client web app you copied earlier.
    - `graph_end_point` and replace it with the Microsoft Graph API endpoint, that's `https://graph.microsoft.com/`.
    - `Add_your_protected_scope_here` and replace it with the API app (EditProfileService app) scope. The value looks similar to *api://{clientId}/EditProfileService.ReadWrite*. `{clientId}` is the Application (client) ID value of the [EditProfileService you registered earlier](#register-editprofileservice-app).

1. In your code editor, open `1-Authentication\7-edit-profile-with-mfa-express\Api\authConfig.js` file, then find the placeholder:
    
    - `Enter_the_Tenant_Subdomain_Here` and replace it with Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details). 
    - `Enter_the_Tenant_ID_Here` and replace it with Tenant ID. If you don't have your Tenant ID, learn how to [read your tenant details](../external-id/customers/how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).
    - `Enter_the_Edit_Profile_Service_Application_Id_Here` and replace it with is the Application (client) ID value of the [EditProfileService you registered earlier](#register-editprofileservice-app).
    - `Enter_the_Client_Secret_Here` and replace it with the [EditProfileService app secret](#add-app-client-secret) value you copied earlier.
    - `graph_end_point` and replace it with the Microsoft Graph API endpoint, that's `https://graph.microsoft.com/`.

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

1. Open your browser, then go to http://localhost:3000. If you experience SSL certificate errors, create a `.env` file, then add the following configuration:

    ```Console
    # Use this variable only in the development environment. 
    # Remove the variable when you move the app to the production environment.
    NODE_TLS_REJECT_UNAUTHORIZED='0'
    ```

1. Select the **Sign In** button, then you sign in.

1. On the sign-in page, type your **Email address**, select **Next**, type your **Password**, then select **Sign in**. If you don't have an account, select **No account? Create one** link, which starts the sign-up flow.

1. To update profile, select the **Profile editing** link. You see a page similar to the following screenshot:

    :::image type="content" source="media/how-to-web-app-node-edit-profile-update-profile/edit-user-profile.png" alt-text="Screenshot of user update profile."::: 

1. To edit profile, select the **Edit Profile** button. If you haven't already done so, the app prompts you to complete an MFA challenge. 

1. Make changes to any of the profile details, then select **Save** button. 

## Related content

-  [Learn how to add edit profile in your own Node.js web app](/entra/external-id/customers/how-to-web-app-node-edit-profile-prepare-app).