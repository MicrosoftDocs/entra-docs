---
title: "Tutorial: Add authentication flows to a JavaScript SPA"
description: Learn how to add authentication to a JavaScript single-page app (SPA) using the Microsoft identity platform.
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.service: entra-external-id
ms.subservice: external
ms.custom: devx-track-js
ms.topic: tutorial
ms.date: 02/11/2024
#Customer intent: As a developer, I want to learn how to configure  JavaScript single-page app (SPA) to sign in and sign out users with my external tenant.
---

# Tutorial: Add sign-in and sign-out flows to a JavaScript SPA

In this tutorial you'll configure a JavaScript (JS) single-page application (SPA) for authenticaiton. In [part 1 of this series](tutorial-single-page-app-javascript-prepare-app.md), you created a JS SPA and prepared it for authentication. In this tutorial, you'll learn how to add authentication flows by adding [Microsoft Authentication Library (MSAL)](msal-overview.md) components to your app.

In this tutorial;

> [!div class="checklist"]
> * Configure the settings for the application
> * Add code to *authRedirect.js* to handle the authentication flow
> * Add code to *authPopup.js* to handle the authentication flow

## Prerequisites

* [Tutorial: Prepare a JavaScript single-page application for authentication](tutorial-single-page-app-javascript-prepare-app.md).

## Add code to the redirection file

A redirection file is required to handle the response from the sign-in page. It's used to extract the access token from the URL fragment and to call the protected API. It's also used to catch errors that occur during the authentication process.

1. Open *public/authRedirect.js* and add the following code snippet:

    ```javascript
    // Create the main myMSALObj instance
    // configuration parameters are located at authConfig.js
    const myMSALObj = new msal.PublicClientApplication(msalConfig);

    let username = "";

    /**
    * A promise handler needs to be registered for handling the
    * response returned from redirect flow. For more information, visit:
    * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/initialization.md#redirect-apis
    */
    myMSALObj.handleRedirectPromise()
        .then(handleResponse)
        .catch((error) => {
            console.error(error);
        });

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
            welcomeUser(currentAccounts[0].username);
            updateTable(currentAccounts[0]);
        }
    }

    function handleResponse(response) {

        /**
        * To see the full list of response object properties, visit:
        * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/request-response-object.md#response
        */

        if (response !== null) {
            username = response.account.username
            welcomeUser(username);
            updateTable(response.account);
        } else {
            selectAccount();

        }
    }

    function signIn() {

        /**
        * You can pass a custom request object below. This will override the initial configuration. For more information, visit:
        * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/request-response-object.md#request
        */

        myMSALObj.loginRedirect(loginRequest);
    }

    function signOut() {

        /**
        * You can pass a custom request object below. This will override the initial configuration. For more information, visit:
        * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/request-response-object.md#request
        */

        // Choose which account to logout from by passing a username.
        const logoutRequest = {
            account: myMSALObj.getAccountByUsername(username),
            postLogoutRedirectUri: '/signout', // remove this line if you would like navigate to index page after logout.

        };

        myMSALObj.logoutRedirect(logoutRequest);
    }
    ```

1. Save the file.

### Add code to the *authPopup.js* file

The application uses *authPopup.js* to handle the authentication flow when the user signs in using the pop-up window. The pop-up window is used when the user is already signed in and the application needs to get an access token for a different resource.

1. Open *public/authPopup.js* and add the following code snippet:

    ```javascript
    // Create the main myMSALObj instance
    // configuration parameters are located at authConfig.js
    const myMSALObj = new msal.PublicClientApplication(msalConfig);
    
    let username = "";
    
    function selectAccount () {
    
        /**
         * See here for more info on account retrieval: 
         * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-common/docs/Accounts.md
         */
    
        const currentAccounts = myMSALObj.getAllAccounts();
    
        if (!currentAccounts  || currentAccounts.length < 1) {
            return;
        } else if (currentAccounts.length > 1) {
            // Add your account choosing logic here
            console.warn("Multiple accounts detected.");
        } else if (currentAccounts.length === 1) {
            username = currentAccounts[0].username
            welcomeUser(currentAccounts[0].username);
            updateTable(currentAccounts[0]);
        }
    }
    
    function handleResponse(response) {
    
        /**
         * To see the full list of response object properties, visit:
         * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/request-response-object.md#response
         */
        
        if (response !== null) {
            username = response.account.username
            welcomeUser(username);
            updateTable(response.account);
        } else {
            selectAccount();
        }
    }
    
    function signIn() {
    
        /**
         * You can pass a custom request object below. This will override the initial configuration. For more information, visit:
         * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/request-response-object.md#request
         */
    
        myMSALObj.loginPopup(loginRequest)
            .then(handleResponse)
            .catch(error => {
                console.error(error);
            });
    }
    
    function signOut() {
    
        /**
         * You can pass a custom request object below. This will override the initial configuration. For more information, visit:
         * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/request-response-object.md#request
         */
    
        // Choose which account to logout from by passing a username.
        const logoutRequest = {
            account: myMSALObj.getAccountByUsername(username),
            mainWindowRedirectUri: '/signout'
        };
    
        myMSALObj.logoutPopup(logoutRequest);
    }
    
    selectAccount();
    ```

1. Save the file.

## Add code to the *index.html* file

The main page of the SPA, *index.html*, is the first page that is loaded when the application is started. It's also the page that is loaded when the user selects the **Sign-Out** button. 

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
    
    <body>
        <nav class="navbar navbar-expand-sm navbar-dark bg-primary navbarStyle">
            <a class="navbar-brand" href="/">Microsoft identity platform</a>
            <div class="navbar-collapse justify-content-end">
                <button type="button" id="signIn" class="btn btn-secondary" onclick="signIn()">Sign-in</button>
                <button type="button" id="signOut" class="btn btn-success d-none" onclick="signOut()">Sign-out</button>
            </div>
        </nav>
        <br>
        <h5 id="title-div" class="card-header text-center">JavaScript single-page application secured with MSAL.js
        </h5>
        <h5 id="welcome-div" class="card-header text-center d-none"></h5>
        <br>
        <div class="table-responsive-ms" id="table">
            <table id="table-div" class="table table-striped d-none">
                <thead id="table-head-div">
                    <tr>
                        <th>Claim Type</th>
                        <th>Value</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody id="table-body-div">
                </tbody>
            </table>
        </div>
        <!-- importing bootstrap.js and supporting js libraries -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous">
            </script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
            integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
            crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"></script>
            
        <!-- importing app scripts (load order is important) -->
        <script type="text/javascript" src="./authConfig.js"></script>
        <script type="text/javascript" src="./ui.js"></script>
        <script type="text/javascript" src="./claimUtils.js"></script>
        <!-- <script type="text/javascript" src="./authRedirect.js"></script> -->
        <!-- uncomment the above line and comment the line below if you would like to use the redirect flow -->
        <script type="text/javascript" src="./authPopup.js"></script>
    </body>
    
    </html>
    ```

1. Save the file.

## Add code to the *ui.js* file

When authorization has been configured, the user interface can be created to allow users to sign in and sign out when the project is run. To build the user interface (UI) for the application, [Bootstrap](https://getbootstrap.com/) is used to create a responsive UI that contains a **Sign-In** and **Sign-Out** button. The UI also contains a table that displays the claims from the token which will be added later in the tutorial.

1. Open *public/ui.js* and add the following code snippet:

    ```javascript
    // Select DOM elements to work with
    const signInButton = document.getElementById('signIn');
    const signOutButton = document.getElementById('signOut');
    const titleDiv = document.getElementById('title-div');
    const welcomeDiv = document.getElementById('welcome-div');
    const tableDiv = document.getElementById('table-div');
    const tableBody = document.getElementById('table-body-div');
    
    function welcomeUser(username) {
        signInButton.classList.add('d-none');
        signOutButton.classList.remove('d-none');
        titleDiv.classList.add('d-none');
        welcomeDiv.classList.remove('d-none');
        welcomeDiv.innerHTML = `Welcome ${username}!`;
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

The *signout.html* file is used to display a message to the user when they sign out of the application. It's also used to clear the cache when the user signs out.

1. Open *public/signout.html* and add the following code snippet:

    ```html
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JavaScript SPA</title>
        <link rel="SHORTCUT ICON" href="./favicon.svg" type="image/x-icon">
    
        <!-- adding Bootstrap 4 for UI components  -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/boot8strap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
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

## Add styles to the app

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
> [Sign in and sign out of the JS SPA](./tutorial-single-page-app-javascript-sign-in-sign-out.md)
