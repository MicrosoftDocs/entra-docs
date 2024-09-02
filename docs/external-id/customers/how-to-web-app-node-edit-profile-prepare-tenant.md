---
title: Set up an external tenant for profile editing with MFA in a Node.js web application
description: Learn how to set up external tenant to edit profile with multifactor authentication protection in your external-facing Node.js web app
manager: mwongerapz
author: kengaderdus
ms.author: kengaderdus
ms.service: entra-external-id 
ms.subservice: customers
ms.topic: how-to
ms.date: 09/02/2024
ms.custom: developer
#Customer intent: As a developer, or IT admin, I want to learn how to configure my external tenant for profile editing with multifactor authentication protection, so that my customer users can edit their profile in external-facing app. 
---

# Set up an external tenant for profile editing with MFA in a Node.js web application

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

After customer users successfully sign in into your external-facing app, you can enable them to edit their profiles. You enable the customer users to manage their profiles by using [Microsoft Graph API's](/graph/api/user-get) `/me` endpoint. Calling the `/me` endpoint requires a signed-in user and therefore a delegated permission.

In this how-to guide, you learn how to set up your external tenant to support editing their profile with multifactor authentication (MFA) protection. The MFA requirement is enabled by a Conditional Access (CA) policy.

This article is the first part of a three-part guide.

## Updatable properties 

To customize the fields your customer users can edit in their profile, choose from the properties listed in the *Update profile* row of the table in [Microsoft Graph APIs and permissions](reference-user-permissions.md#microsoft-graph-apis-and-permissions).

## Prerequisites

- Complete the steps in [Tutorial: Set up your external tenant to sign in users in a Node.js web app](tutorial-web-app-node-sign-in-prepare-tenant.md) tutorial series. The tutorial shows you how to register an app in your external tenant, and build a web app that signs in users. We refer to this web application as the client web app.

## Register edit profile service

In this step, you register the edit profile service application, which provides a mechanism to protect the edit profile operation with MFA. 

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

### ### Grant EditProfileService.ReadWrite permission to the client web app

[!INCLUDE [active-directory-b2c-app-integration-add-user-flow](./includes/register-app/grant-api-permissions-mfa-api-app.md)]

### Grant admin consent

At this point, you've assigned the permissions correctly. However, since the tenant is an external tenant, the customer users themselves can't consent to these permissions. To address this problem, you as the administrator must consent to these permissions on behalf of all the users in the tenant:
    
1. Select **Grant admin consent for \<your tenant name\>**, then select **Yes**.

1. Select **Refresh**, then verify that **Granted for \<your tenant name\>** appears under **Status** for both scopes.

## Create CA MFA policy

Your edit profile service app that you registered earlier is the resource that you protect with MFA. 

Use the steps in [Add multifactor authentication to an app](how-to-multifactor-authentication-customers.md) to create an MFA CA policy and choose your MFA method, such as email. Use the following settings when you create your policy:
- For the **Name**, use *MFA policy*.
- For the **Target resources**, select the edit profile service app that you registered earlier, such as *edit-profile-service*.

## Next step

> [!div class="nextstepaction"]
> [Set up your Node.js web application for profile editing](how-to-web-app-node-edit-profile-prepare-app.md)
