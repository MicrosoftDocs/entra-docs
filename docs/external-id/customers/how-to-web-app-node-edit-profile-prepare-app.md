---
title: Set up a Node.js web application for profile editing
description: Learn how to set up your Node.js web application for profile editing with multifactor authentication protection in your external tenant
author: kengaderdus
manager: mwongerapz
ms.author: kengaderdus
ms.service: entra-external-id 
ms.subservice: customers
ms.topic: how-to
ms.date: 07/01/2024
ms.custom: developer
#Customer intent: As a developer, I want to set up my Node.js web app for profile editing so that customer users can update their profile after a successful sign-in.
---

# Set up a Node.js web application for profile editing

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

This article is part 2 of a series that demonstrates profile editing in a Node.js web app. In [part 1 of this series](how-to-web-app-node-edit-profile-prepare-tenant.md), you set up your external tenant for profile editing.  

## Prerequisites

- Complete the steps in the first part of this guide series, [Set up external tenant to for profile editing](how-to-web-app-node-edit-profile-prepare-tenant.md). 


## Add new project files

Add the following new files to your Node.js web app that signs in users: 
- Create *views/gatedUpdateProfile.hbs* and *views/updateProfile.hbs*.
- In the root folder of your app, create *fetch.js*. The root folder is one that contains the *package.json* file.

## Update app UI components

1. In your code editor, open *views/index.hbs* file, then add an **Edit profile** link by using the following code snippet:

    ```html
    <a href="/users/gatedUpdateProfile">Edit profile</a>
    ```
    
    After you make the update, your *views/index.hbs* file should look similar to the following file:

    ```html
    <h1>{{title}}</h1>
    {{#if isAuthenticated }}
    <p>Hi {{username}}!</p>
    <a href="/users/id">View ID token claims</a>
    <br>
    <a href="/users/gatedUpdateProfile">Edit profile</a>
    <br>
    <a href="/auth/signout">Sign out</a>
    {{else}}
    <p>Welcome to {{title}}</p>
    <a href="/auth/signin">Sign in</a>
    {{/if}}
    ```

1. In your code editor, open *views/gatedUpdateProfile.hbs* file, then add the following code:

    ```html
    <h3>Microsoft Graph API /me endpoint response</h3>
    <div style="display: flex; justify-content: left;">
    <div style="size: 400px;">
      <form id="userInfoForm" action='/users/update' method='POST'>
        <label>Id :</label>
        <label> {{profile.id}}</label>
        <br/>
        <label>Email :</label>
        <label> {{profile.mail}}</label>
        <br/>
        <label for="userName" >Display Name :</label>
        <input type="text" id="displayName" name="displayName" disabled value="{{profile.displayName}}" />
        <br/>
        <label for="userName">Given Name :</label>
        <input type="text" id="givenName" name="givenName" value="{{profile.givenName}}" />
        <br/>
    
        <label for="userSurname">Surname :</label>
        <input type="text" id="surname" name="surname" value="{{profile.surname}}" />
        <br/>
    
        <button type="submit" id="button">Save</button>
      </form>
    </div>
    <div>
      <br>
      <br>
        <a href="/users/updateProfile">
        <button>Edit</button>
        </a>
      </div>
    </div>
    <a href="/">Go back</a>
    ```

    - This file contains an HTML form that represents the [editable user details](reference-user-permissions.md#microsoft-graph-apis-and-permissions). 
    - This form's display name is disabled to demonstrate that the customer can't edit it until they complete an MFA challenge. You can customize the form so that other any field is protected with MFA.
    - The user needs to select the **Edit** button to update their display name, but the user must complete an MFA challenge if they've not already done so. 
    - The user can edit the rest of their details without requiring MFA.
    


1. In your code editor, open *views/updateProfile.hbs* file, then add the following code:

    ```html
    <h3>Microsoft Graph API /me endpoint response</h3>
    <div style="display: flex; justify-content: left;">
    <div style="size: 400px;">
      <form id="userInfoForm" action='/users/update' method='POST'>
        <label>Id :</label>
        <label> {{profile.id}}</label>
        <br/>
        <label>Email :</label>
        <label> {{profile.mail}}</label>
        <br/>
        <label for="userName" >Display Name :</label>
        <input type="text" id="displayName" name="displayName" value="{{profile.displayName}}" />
        <br />
        <label for="userName">Given Name :</label>
        <input type="text" id="givenName" name="givenName" value="{{profile.givenName}}" />
        <br />
    
        <label for="userSurname">Surname :</label>
        <input type="text" id="surname" name="surname" value="{{profile.surname}}" />
        <br />
    
        <button type="submit" id="button">Save</button>
      </form>
    </div>
    <br>
    </div>
    <a href="/">Go back</a>
    ```

This file contains an HTML form that represents the [editable user details](reference-user-permissions.md#microsoft-graph-apis-and-permissions), but only visible after the customer user completes MFA challenge.

## Install app dependencies

In your terminal, install  more Node packages, `axios`, `cookie-parser`, `body-parser`, `method-override`, by running the following command:

```console
npm install axios cookie-parser body-parser method-override 
```

## Next step

> [!div class="nextstepaction"]
> [Edit profile in a Node.js web app](how-to-web-app-node-edit-profile-update-profile.md)
