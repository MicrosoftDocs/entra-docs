---
title: Set up a Node.js web application for profile editing
description: Learn how to set up your Node.js web application for profile editing with multifactor authentication protection in your external tenant
author: kengaderdus
manager: mwongerapz
ms.author: kengaderdus
ms.service: entra-external-id 
ms.subservice: external
ms.topic: how-to
ms.date: 11/28/2024
ms.custom: developer
#Customer intent: As a developer, I want to set up my Node.js web app for profile editing so that customer users can update their profile after a successful sign-in.
---

# Set up a Node.js web application for profile editing

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

After customer users successfully sign in into your external-facing app, you can enable them to edit their profiles. You enable the customer users to manage their profiles by using [Microsoft Graph API's](/graph/api/user-get) `/me` endpoint. Calling the `/me` endpoint requires a signed-in user and therefore a delegated permission.

To make sure that only the user makes changes to their profile, the user needs to complete an MFA challenge.

In this guide, you learn how to set up your web app to support profile editing with multifactor authentication (MFA) protection:

- The app uses Conditional Access (CA) policy to enable MFA requirement.
- The web app setup contains two web services, the client web app and a middle-tier service app.
- The client web app signs in the user and reads and displays the user's profile.
- The middle-tier service app acquires an access token, then edits the profile on behalf of the user.

**Updatable properties**

To customize the fields your customer users can edit in their profile, choose from the properties listed in the *Update profile* row of the table in [Microsoft Graph APIs and permissions](reference-user-permissions.md#microsoft-graph-apis-and-permissions). 

## Prerequisites

- Complete the steps in [Tutorial: Set up your external tenant to sign in users in a Node.js web app](tutorial-web-app-node-sign-in-prepare-tenant.md) tutorial series. The tutorial shows you how to register an app in your external tenant, and build a web app that signs in users. We refer to this web application as the client web app
- Complete the steps in [Sign in users and edit profile in a sample Node.js web app](sample-web-app-node-sign-in-edit-profile.md). This article shows you how to set up your external tenant for profile editing.

## Update the client web app

Add the following files to your Node.js client we app (*App* directory): 
- Create *views/gatedUpdateProfile.hbs* and *views/updateProfile.hbs*.
- Create *fetch.js*.

### Update app UI components

1. In your code editor, open *App/views/index.hbs* file, then add an **Edit profile** link by using the following code snippet:

    ```html
    <a href="/users/gatedUpdateProfile">Edit profile</a>
    ```
    
    After you make the update, your *App/views/index.hbs* file should look similar to the following file:

    ```html
    <h1>{{title}}</h1>
    {{#if isAuthenticated }}
    <p>Hi {{username}}!</p>
    <a href="/users/id">View ID token claims</a>
    <br>
    <a href="/users/gatedUpdateProfile">Profile editing</a>
    <br>
    <a href="/auth/signout">Sign out</a>
    {{else}}
    <p>Welcome to {{title}}</p>
    <a href="/auth/signin">Sign in</a>
    {{/if}}
    ```

1. In your code editor, open *App/views/gatedUpdateProfile.hbs* file, then add the following code:

    ```html
    <h1>Microsoft Graph API</h1>
    <h3>/me endpoint response</h3>
    <div style="display: flex; justify-content: left;">
        <div style="size: 400px;">
            <label>Id :</label>
            <label> {{profile.id}}</label>
            <br />
            <label for="email">Email :</label>
            <label> {{profile.mail}}</label>
            <br />
            <label for="userName">Display Name :</label>
            <label> {{profile.displayName}}</label>
            <br />
            <label for="userName">Given Name :</label>
            <label> {{profile.givenName}}</label>
            <br />    
            <label for="userSurname">Surname :</label>
            <label> {{profile.surname}}</label>
            <br />
        </div>
        <div>
            <br />
            <br />
            <a href="/users/updateProfile">
                <button>Edit Profile</button>
            </a>
        </div>
    </div>
    <br />
    <br />
    <a href="/">Go back</a>
    ```

    - This file contains an HTML form that represents the [editable user details](reference-user-permissions.md#microsoft-graph-apis-and-permissions). 
    - The user needs to select the **Edit Profile** button to update their display name, but the user must complete an MFA challenge if they've not already done so. 

1. In your code editor, open *App/views/updateProfile.hbs* file, then add the following code:

    ```html
    <h1>Microsoft Graph API</h1>
    <h3>/me endpoint response</h3>
    <div style="display: flex; justify-content: left;">
        <div style="size: 400px;">
            <form id="userInfoForm" action="/users/update" method="POST">
                <label>Id :</label>
                <label> {{profile.id}}</label>
                <br />
                <label>Email :</label>
                <label> {{profile.mail}}</label>
                <br />
                <label for="userName">Display Name :</label>
                <input
                    type="text"
                    id="displayName"
                    name="displayName"
                    value="{{profile.displayName}}"
                />
                <br />
                <label for="userName">Given Name :</label>
                <input
                    type="text"
                    id="givenName"
                    name="givenName"
                    value="{{profile.givenName}}"
                />
                <br />    
                <label for="userSurname">Surname :</label>
                <input
                    type="text"
                    id="surname"
                    name="surname"
                    value="{{profile.surname}}"
                />
                <br />    
                <button type="submit" id="button">Save</button>
            </form>
        </div>
        <br />
    </div>
    <a href="/">Go back</a>
    ```

This file contains an HTML form that represents the [editable user details](reference-user-permissions.md#microsoft-graph-apis-and-permissions), but only visible after the customer user completes MFA challenge.

### Install app dependencies

In your terminal, install  more Node packages, `axios`, `cookie-parser`, `body-parser`, `method-override`, by running the following command:

```console
npm install axios cookie-parser body-parser method-override 
```

## Set up the mid-tier app

In this section, you set up the mid-tier app. 

1. Create *API* directory.

1. To create your mid-tier app project, navigate into the *API* directory, then run the following command:

    ```console
    npm init -y
    ```

1. In the *API* directory, create new files, *authConfig.js*, *fetch.js* and *index.js*.

1. To install mid-tier app dependencies, run the following command:

```console
npm install express express-session axios cookie-parser http-errors @azure/msal-node body-parser uuid 
```
## Next step

> [!div class="nextstepaction"]
> [Edit profile in a Node.js web app](how-to-web-app-node-edit-profile-update-profile.md)