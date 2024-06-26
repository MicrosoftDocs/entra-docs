---
title: Edit profile in a Node.js web app
description: Learn how to edit profile with multifactor authentication protection in your external-facing Node.js web app
manager: mwongerapz
author: kengaderdus
ms.author: kengaderdus
ms.service: entra-external-id 
ms.subservice: customers
ms.topic: how-to
ms.date: 07/01/2024
ms.custom: developer
#Customer intent: As a developer, I want to learn how to add edit profile to a Node.js web app so that customer users can update their profile after a successful sign-in to external-facing app.
---

# Edit profile in a Node.js web app

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

This article is part 3 of a series that demonstrates how to add the profile editing logic in an Node.js web app. In [part 2 of this series](how-to-web-app-node-edit-profile-prepare-app.md), you prepared your app for profile editing by adding the required user interface components.

In this how-to guide, you learn how to acquire an access token to call Microsoft Graph API for profile editing.

## Prerequisites

- Complete the steps in the second part of this guide series, [Prepare a Node.js web application for profile editing](how-to-web-app-node-edit-profile-prepare-app.md).

## Update authConfig.js file

1. In your code editor, open *authConfig.js* file, then add three new variable, `GRAPH_API_ENDPOINT`, `GRAPH_ME_ENDPOINT` and `mfaProtectedResourceScope`. Make sure to export the three variables:

    ```JavaScript
        //...
        const GRAPH_API_ENDPOINT = process.env.GRAPH_API_ENDPOINT || "https://graph.microsoft.com/";
        // https://learn.microsoft.com/en-us/graph/api/user-update?view=graph-rest-1.0&tabs=http
        const GRAPH_ME_ENDPOINT = GRAPH_API_ENDPOINT + "v1.0/me";
        const mfaProtectedResourceScope = process.env.MFA_PROTECTED_SCOPE || 'api://{clientId}/User.MFA';
        
        module.exports = {
            //...
            mfaProtectedResourceScope,
            GRAPH_API_ENDPOINT,
            GRAPH_ME_ENDPOINT,
            //...
        };
    ```

    - The `mfaProtectedResourceScope` variable represents MFA protected resource, that's the MFA web API.

    - The `GRAPH_ME_ENDPOINT` is the Microsoft Graph API endpoint. 
    
1. Replace the placeholder `{clientId}` with the Application (client) ID of the MFA web API that you registered earlier.

## 