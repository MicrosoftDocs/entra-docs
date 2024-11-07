---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 07/01/2024
ms.author: kengaderdus
ms.manager: mwongerapk
---

An API needs to publish a minimum of one scope, also called [Delegated Permission](~/identity-platform/permissions-consent-overview.md), for the client apps to obtain an access token for a user successfully. To publish a scope, follow these steps:

1. From the **App registrations** page, select the API application that you created (such as *edit-profile-service*) to open its **Overview** page.
1. Under **Manage**, select **Expose an API**.
1. At the top of the page, next to **Application ID URI**, select the **Add** link to generate a URI that is unique for this app.
1. Accept the proposed Application ID URI such as `api://{clientId}`, and select **Save**. When your web application requests an access token for the web API, it adds the URI as the prefix for each scope that you define for the API.

1. Under **Scopes defined by this API**, select **Add a scope**.

1. Enter the following values that define a read access to the API, then select **Add scope** to save your changes:    

    | Property | Value |
    |----------|-------|
    | Scope name | *EditProfileService.ReadWrite* |
    | Who can consent | **Admins only** |
    | Admin consent display name | *Client edits profile through edit profile service* |
    | Admin consent description | *The scope to allow client web app to edit profile through calling the edit profile service*. |
    | State | **Enabled** |
    
1. Under **Manage**, select **Manifest** to open the API manifest editor.
1. Set `accessTokenAcceptedVersion` property to `2`.
1. Select **Save**.