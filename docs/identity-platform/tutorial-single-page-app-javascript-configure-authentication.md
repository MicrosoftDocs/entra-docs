---
title: "Tutorial: Add sign-in and sign-out flows to a JavaScript single-page app (SPA)"
description: Learn how to add authentication to a JavaScript single-page app (SPA) using the Microsoft identity platform.
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.service: identity-platform
ms.custom:
ms.topic: tutorial
ms.date: 02/11/2024
#Customer intent: As a developer, I want to learn how to configure JavaScript single-page app (SPA) to sign in and sign out users with my external tenant.
---

# Tutorial: Add sign-in and sign-out flows to a JavaScript single-page app

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

In this tutorial you'll configure a JavaScript single-page application (SPA) for authentication. In [part 1 of this series](tutorial-single-page-app-javascript-prepare-app.md), you created a JavaScript SPA and prepared it for authentication. In this tutorial, you'll learn how to add authentication flows by adding [Microsoft Authentication Library (MSAL)](msal-overview.md) components to your app and build a responsive user interface (UI) for your app.

In this tutorial;

> [!div class="checklist"]
> * Add code to *auth.js* to handle the authentication flow
> * Build a user interface for the application

## Prerequisites

* [Tutorial: Prepare a JavaScript single-page application for authentication](tutorial-single-page-app-javascript-prepare-app.md).

## Add code to the redirection file

An authentication flow is a series of steps that an application takes to authenticate a user. *Auth.js* contains functions that are used to handle the authentication flow, including signing in and signing out using either the redirect or popup method.

1. Open *public/auth.js* and add the following code:

    ```javascript
    // Browser check variables: If you support IE, our recommendation is to sign-in using Redirect APIs. If you are testing using Edge InPrivate mode, please add "isEdge" to the if check.
    const ua = window.navigator.userAgent;
    const msie = ua.indexOf("MSIE ");
    const msie11 = ua.indexOf("Trident/");
    const msedge = ua.indexOf("Edge/");
    const isIE = msie > 0 || msie11 > 0;
    const isEdge = msedge > 0;

    let signInType;
    let accountId = "";

    // myMSALObj instance - configuration parameters are located at authConfig.js
    const myMSALObj = new msal.PublicClientApplication(msalConfig);

    myMSALObj.initialize().then(() => {
        // Redirect: once login is successful and redirects with tokens, call Graph API
        myMSALObj.handleRedirectPromise().then(handleResponse).catch(err => {
            console.error(err);
        });
    })

    function selectAccount() {

        /**
        * See here for more info on account retrieval: 
        * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-common/docs/Accounts.md
        */

        const currentAccounts = myMSALObj.getAllAccounts();

        if (!currentAccounts) {
            return;
        } else if (currentAccounts.length > 1) {
            // Add your account choosing logic here
            console.warn("Multiple accounts detected.");
        } else if (currentAccounts.length === 1) {
            username = currentAccounts[0].username
            showWelcomeMessage(currentAccounts[0].username);
            updateTable(currentAccounts[0]);
        }
    }

    function handleResponse(resp) {
        if (resp !== null) {
            accountId = resp.account.homeAccountId;
            myMSALObj.setActiveAccount(resp.account);
            showWelcomeMessage(resp.account);
        } else {
                selectAccount();
            } 
        }

    async function signIn(method) {
        signInType = isIE ? "redirect" : method;
        if (signInType === "popup") {
            return myMSALObj.loginPopup({
                ...loginRequest,
                redirectUri: "/redirect"
            }).then(handleResponse).catch(function (error) {
                console.log(error);
            });
        } else if (signInType === "redirect") {
            return myMSALObj.loginRedirect(loginRequest)
        }
    }

    function signOut(interactionType) {
        const logoutRequest = {
            account: myMSALObj.getAccountByHomeId(accountId)
        };

        if (interactionType === "popup") {
            myMSALObj.logoutPopup(logoutRequest).then(() => {
                window.location.reload();
            });
        } else {
            myMSALObj.logoutRedirect(logoutRequest);
        }
    }

    // This function can be removed if you do not need to support IE
    async function getTokenRedirect(request, account) {
        return await myMSALObj.acquireTokenSilent(request).catch(async (error) => {
            console.log("silent token acquisition fails.");
            if (error instanceof msal.InteractionRequiredAuthError) {
                // fallback to interaction when silent call fails
                console.log("acquiring token using redirect");
                myMSALObj.acquireTokenRedirect(request);
            } else {
                console.error(error);
            }
        });
    }
    ```

1. Save the file.


## Build a user interface for the application

When authorization has been configured, a UI can be created to interact with application when the project is run. [Bootstrap](https://getbootstrap.com) is used to create a responsive UI that contains a **Sign-In** and **Sign-Out** button. The UI also contains a table that displays the claims from the token, which will be added later in the tutorial.

### Add code to the *index.html* file

The main page of the SPA, *index.html*, is the first page that is loaded when the application is started. It's also the page that is loaded when the user selects the **Sign-Out** button. The page contains a navigation bar, a welcome message with the users email and a table that displays the claims from the token.

1. Open *public/index.html* and add the following code snippet:

   ```html
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <title>Microsoft identity platform</title>
        <link rel="SHORTCUT ICON" href="./favicon.svg" type="image/x-icon">
        <link rel="stylesheet" href="./styles.css">
        
        <!-- adding Bootstrap 5 for UI components  -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
        <!-- msal.min.js can be used in the place of msal-browser.js -->
        <script src="/msal-browser.min.js"></script>
    </head>

    <!DOCTYPE html>
    <html lang="en">
    <head>
    <meta charset="UTF-8">
    <title>Bootstrap 5 Navbar</title>
    <!-- Bootstrap 5 CSS -->
    <link 
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" 
        rel="stylesheet" 
        integrity="sha384-Zenh87qX5JnK2Rl3l94faQlfdS3b8SpxyDkgOn+Y5Qu3og6JpNZnN9LfX9k8wAI5" 
        crossorigin="anonymous">
    </head>

    <body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-sm navbar-dark bg-primary navbarStyle">
        <a class="navbar-brand" href="/">Microsoft identity platform</a>
    
        <div class="ms-auto d-flex align-items-center">
        <!-- Dropdown group (Bootstrap 5 uses dropstart instead of dropleft) -->
        <div class="btn-group dropstart">
            <!-- Toggle button for dropdown -->
            <button
            id="signIn"
            type="button"
            class="btn btn-primary dropdown-toggle"
            data-bs-toggle="dropdown"
            aria-expanded="false"
            >
            Sign In
            </button>
    
            <!-- Dropdown menu -->
            <div class="dropdown-menu">
            <button class="dropdown-item" id="popup" onclick="signIn(this.id)">
                Sign in using Popup
            </button>
            <button class="dropdown-item" id="redirect" onclick="signIn(this.id)">
                Sign in using Redirect
            </button>
            </div>
        </div>
    
        <!-- Sign Out button -->
        <button class="btn btn-secondary ms-2" id="signOut" onclick="signOut()">
            Sign Out
        </button>
        </div>
    </nav>
    

    <br />
    <div class="container">
        <div class="row">
        <h5 id="title-div" class="card-header text-center">
            JavaScript single-page application secured with MSAL.js
        </h5>
        <br />
        <h5 id="welcome-div" class="card-header text-center d-none"></h5>

        <table class="table table-striped table-bordered d-none" id="table-div">
            <thead>
            <tr>
                <th>Claim Type</th>
                <th>Value</th>
                <th>Description</th>
            </tr>
            </thead>
            <tbody id="table-body-div"></tbody>
        </table>
        </div>
    </div>

    <script 
        src="https://code.jquery.com/jquery-3.3.1.slim.min.js" 
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" 
        crossorigin="anonymous">
    </script>

    <!-- Bootstrap 5 JS bundle (includes Popper) -->
    <script 
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" 
        integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" 
        crossorigin="anonymous">
    </script>

    <!-- Your custom scripts -->
    <script type="text/javascript" src="./authConfig.js"></script>
    <script type="text/javascript" src="./ui.js"></script>
    <script type="text/javascript" src="./claimUtils.js"></script>
    <script type="text/javascript" src="./auth.js"></script>
    </body>
    </html>
    ```

1. Save the file.

### Add code to the *ui.js* file

To make your application interactive, the *ui.js* file is used to handle UI elements of the application. The file contains functions that are used to update the user's name when they sign in and to update the table with the claims from the token.

1. Open *public/ui.js* and add the following code snippet:

    ```javascript
    // Select DOM elements to work with
    const signInButton = document.getElementById('signIn');
    const signOutButton = document.getElementById('signOut');
    const titleDiv = document.getElementById('title-div');
    const welcomeDiv = document.getElementById('welcome-div');
    const tableDiv = document.getElementById('table-div');
    const tableBody = document.getElementById('table-body-div');

    function showWelcomeMessage(account) {
        signInButton.classList.add('d-none');
        signOutButton.classList.remove('d-none');
        titleDiv.classList.add('d-none');
        welcomeDiv.classList.remove('d-none');
        welcomeDiv.innerHTML = `Welcome ${account.username}!`;
        updateTable(account);
    };

    function updateTable(account) {
        tableDiv.classList.remove('d-none');
        
        const tokenClaims = createClaimsTable(account.idTokenClaims);

        Object.keys(tokenClaims).forEach((key) => {
            let row = tableBody.insertRow(0);
            let cell1 = row.insertCell(0);
            let cell2 = row.insertCell(1);
            let cell3 = row.insertCell(2);
            cell1.innerHTML = tokenClaims[key][0];
            cell2.innerHTML = tokenClaims[key][1];
            cell3.innerHTML = tokenClaims[key][2];
        });
    };
    ```

1. Save the file.

## Add code to the *signout.html* file

The *signout.html* file is used to display a message to the user when they sign out of the application.

1. Open *public/signout.html* and add the following code snippet:

    ```html
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Microsoft Entra ID | JavaScript SPA</title>
        <link rel="SHORTCUT ICON" href="./favicon.svg" type="image/x-icon">

        <!-- adding Bootstrap 4 for UI components  -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    </head>
    <body>
        <div class="jumbotron" style="margin: 10%">
            <h1>Goodbye!</h1>
            <p>You have signed out and your cache has been cleared.</p>
            <a class="btn btn-primary" href="/" role="button">Take me back</a>
        </div>
    </body>
    </html>
    ```

1. Save the file.

### Add styles to the app

Finally, add some styles to the application to make it look more appealing. The styles are added to the *styles.css* file and can be customized to suit your needs.

1. Open *public/styles.css* and add the following code snippet:

    ```css
    .navbarStyle {
        padding: .5rem 1rem !important;
    }
    
    .table-responsive-ms {
        max-height: 39rem !important;
        padding-left: 10%;
        padding-right: 10%;
    }
    ```

1. Save the file.

## Next step

> [!div class="nextstepaction"]
> [Sign in and sign out of your JS SPA](./tutorial-single-page-app-javascript-sign-in-sign-out.md)
