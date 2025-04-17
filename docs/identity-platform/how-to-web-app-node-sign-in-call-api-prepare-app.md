---
title: Create a Node.js web app that calls a web API
description: Learn how to prepare your Node.js client web app to call a protected API using access tokens from Microsoft Entra External ID.
author: kengaderdus
manager: mwongerapz
ms.author: kengaderdus
ms.service: identity-platform
ms.topic: how-to
ms.date: 03/16/2025
ms.custom:
#Customer intent: As a developer, I want to learn about how to start building my Node.js web app so that I can call a web API 
---

# Create a Node.js web app that calls a web API

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this article, you prepare the app project you created in [Tutorial: Prepare your external tenant to sign in users in a Node.js web app](tutorial-web-app-node-sign-in-prepare-app.md) to call a web API. This article is the second part of a four-part guide series.

## Prerequisites

- Complete the steps in the first part of this guide series, [Prepare external tenant to call an API in a Node.js web application](how-to-web-app-node-sign-in-call-api-prepare-tenant.md).

## Update project files

Create more files, *fetch.js*, *todolistController.js*, *todos.js*, *todos.hbs* and *.env*, then organize them to achieve the following project structure:

```powershell
    ciam-sign-in-call-api-node-express-web-app/
    ├── .env
    └── server.js
    └── app.js
    └── authConfig.js
    └── fetch.js
    └── package.json
    └── auth/
        └── AuthProvider.js
    └── controller/
        └── authController.js
        └── todolistController.js
    └── routes/
        └── auth.js
        └── index.js
        └── todos.js
        └── users.js
    └── views/
        └── layouts.hbs
        └── error.hbs
        └── id.hbs
        └── index.hbs   
        └── todos.hbs 
    └── public/stylesheets/
        └── style.css
```

## Install app dependencies

In your terminal, install  more Node packages, `axios`, `cookie-parser`, `body-parser`, `method-override`, by running the following command:

```console
    npm install axios cookie-parser body-parser method-override 
```

### Update app UI components

1. In your code editor, open *views/index.hbs* file, then add a *View your todolist* link:

    ```html
        <a href="/todos">View your todolist</a>
    ```
    Your *views/index.hbs* file now looks similar to the following file:

    ```html
        <h1>{{title}}</h1>
        {{#if isAuthenticated }}
        <p>Hi {{username}}!</p>
        <a href="/users/id">View your ID token claims</a>
        <br>
        <a href="/todos">View your todolist</a>
        <br>
        <a href="/auth/signout">Sign out</a>
        {{else}}
        <p>Welcome to {{title}}</p>
        <a href="/auth/signin">Sign in</a>
        {{/if}}
    ```
    
    We add a link to a UI that enables you interact with the *ciam-ToDoList-api*. We define the express route for this endpoint later in this guide.

1. In your code editor, open `views/todos.hbs` file, then add the following code:

    ```html
        <h1>Todolist</h1>
        <div>
            <form action="/todos" method="POST">
                <input type="text" name="description" class="form-control" placeholder="Enter a task" aria-label="Enter a task"
                    aria-describedby="button-addon">
                <button type="submit" id="button-addon">Add</button>
            </form>
        </div>
        <div class="row" style="margin: 10px;">
            <ol id="todoListItems" class="list-group"> 
                {{#each todos}} 
                <li class="todoListItem" id="todoListItem">
                    <span>{{description}}</span>
                    <form action='/todos?_method=DELETE' method='POST'>
                        <span><input type='hidden' name='_id' value='{{id}}'></span>
                        <span><button type='submit'>Remove</button></span>
                    </form>
                </li> 
                {{/each}} 
            </ol>
        </div>
        <a href="/">Go back</a>
    ```

    This view allows the user to perform tasks that initiate an API call. For instance, after a user signs in, and the app acquires an access token, the user can create a resource (task) in the API app by submitting a form.

## Next steps

Next, learn how to sign-in users and acquire an access token:

> [!div class="nextstepaction"]
> [Sign-in users and acquire an access token](how-to-web-app-node-sign-in-call-api-sign-in-acquire-access-token.md)