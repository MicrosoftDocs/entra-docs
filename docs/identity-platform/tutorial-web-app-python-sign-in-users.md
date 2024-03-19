---
title: "Tutorial: Add sign in to a Python web app"
description: Add sign in logic to an Python web app
author: Dickson-Mwendia
manager: CelesteDG
ms.author: dmwendia
ms.date: 03/18/2024
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an application developer, I want to install the packages necessary for authentication in my IDE, and implement authentication in my web app.
---

# Tutorial: Add sign in to a Python Flask web app

This tutorial is the final part of a tutorial series that demonstrates building a Node.js command line interface (CLI) app and preparing it for authentication using the Microsoft Entra admin center. In [part 2 of this series](./tutorial-cli-app-node-sign-in-prepare-app.md), you built a Node.js CLI application and prepared it for authentication. This tutorial shows you how to authenticate users in the Node.js CLI application you built.

> [!div class="checklist"]
>
> - Import the required modules and configuration
> - Create an instance of a Flask web app
> - Configure ProxyFix middleware for local development

> - Create a token request object
> - Define function to acquire tokens
> - Initiate the authentication flow
> - 


## Import required packages and configurations

The web app you're building uses the `identity.web` package built on top of MSAL Python to authenticate users in web apps. To import the `identity.web` package, Flask framework, Flask modules, Flask session, and the app configurations defined in the previous tutorial, add the following code to *app.py*:

```python
import identity.web
import requests
from flask import Flask, redirect, render_template, request, session, url_for
from flask_session import Session

import app_config
```

In this code snippet, you import the `redirect`, `render_template`, `request`, `session`, and `url_for`: functions and objects for handling web requests and sessions in Flask. You also import `app_config` which contains the configuration settings for your app.

## Create an instance of the Flask web app

After importing the required modules, we initialize the web app using the configurations in `app-config`. To create an instance of your web app, add the following snippet to `app.py`:

```python
app = Flask(__name__)
app.config.from_object(app_config)
assert app.config["REDIRECT_PATH"] != "/", "REDIRECT_PATH must not be /"
Session(app)
```

In the above code snippet, you initialize a new Flask application and load the configuration settings using `app.config.from_object(app_config)`. By using `from_object`, the app inherits the configurations from the specified in `(app_config)`. 

You also perform an assertion check to ensure the redirect path of your app is not set to the root path (“/”). `Session(app)` initializes session management for your app, which enables you to handle sessions and store data such as user authentication states across multiple requests. 

## Configure ProxyFix middleware for local development

Since the sample web app will run on local host, we use the `ProxyFix` middleware to fix the URL scheme and host information in the request headers. Add the following code to `app.py` to apply ProxyFix:

```python
from werkzeug.middleware.proxy_fix import ProxyFix
app.wsgi_app = ProxyFix(app.wsgi_app, x_proto=1, x_host=1)
```

## Initialize an authentication object

Next, you initialize an authentication object by creating an instance of the `[Auth](https://identity-library.readthedocs.io/en/latest/#identity.web.Auth)` object, and p



```python
app.jinja_env.globals.update(Auth=identity.web.Auth)  # Useful in template for B2C
auth = identity.web.Auth(
    session=session,
    authority=app.config["AUTHORITY"],
    client_id=app.config["CLIENT_ID"],
    client_credential=app.config["CLIENT_SECRET"],
)
```

## Sign in users

```python

@app.route("/login")
def login():
    return render_template("login.html", version=__version__, **auth.log_in(
        scopes=app_config.SCOPE, # Have user consent to scopes during log-in
        redirect_uri=url_for("auth_response", _external=True), # Optional. If present, this absolute URL must match your app's redirect_uri registered in Azure Portal
        prompt="select_account",  # Optional. More values defined in  https://openid.net/specs/openid-connect-core-1_0.html#AuthRequest
        ))
```


## 

```python
@app.route(app_config.REDIRECT_PATH)
def auth_response():
    result = auth.complete_log_in(request.args)
    if "error" in result:
        return render_template("auth_error.html", result=result)
    return redirect(url_for("index"))
```


## Sign out users

```python

@app.route("/logout")
def logout():
    return redirect(auth.log_out(url_for("index", _external=True)))
```

## 

```python
@app.route("/")
def index():
    if not (app.config["CLIENT_ID"] and app.config["CLIENT_SECRET"]):
        # This check is not strictly necessary.
        # You can remove this check from your production code.
        return render_template('config_error.html')
    if not auth.get_user():
        return redirect(url_for("login"))
    return render_template('index.html', user=auth.get_user(), version=__version__)
```



## Launch browser window for user interaction

For users to sign in and consent to the scopes that the app requires, define the `openBrowser` function that opens a browser window for user interaction, as shown:

```javascript
const openBrowser = async (url) => {
    open(url);
};
```

## Create a token request object

Next, create a `tokenRequest` object by combining properties in the `loginRequest` (imported from *authConfig.js*) and the `openBrowser` function by adding the following code to *index.js*:

```javascript
const tokenRequest = {
    ...loginRequest,
    openBrowser,
    successTemplate: '<h1>Successfully signed in!</h1> <p>You can close this window now.</p>',
    errorTemplate:
        '<h1>Oops! Something went wrong</h1> <p>Navigate back to the Electron application and check the console for more information.</p>',
};
```
The `successTemplate` and `errorTemplate` are HTML templates used for displaying messages after authentication.

## Define function to acquire tokens

To create the `acquireToken` function that the application uses to obtain an access token for the user, add the following code to *index.js*:

```javascript
const acquireToken = async () => {
    const accounts = await pca.getTokenCache().getAllAccounts();
    if (accounts.length === 1) {
        // Try to acquire token silently for the single account.
        // If silent acquisition fails, use interactive authentication.
        const silentRequest = {
            account: accounts[0],
        };
        return pca.acquireTokenSilent(silentRequest).catch((e) => {
            if (e instanceof InteractionRequiredAuthError) {
                return pca.acquireTokenInteractive(tokenRequest);
            }
        });
    } else if (accounts.length > 1) {
        // Multiple accounts found. Prompt the user to select an account.
        accounts.forEach((account) => {
            console.log(account.username);
        });
        return Promise.reject('Multiple accounts found. Please select an account to use.');
    } else {
        // No account found. Use interactive authentication.
        return pca.acquireTokenInteractive(tokenRequest);
    }
};
```
In this code snippet, the `acquireToken` function tries to get an access token for a single account silently; if it fails, it uses interactive authentication. If multiple accounts are found, it prompts the user to select an account, and if no account is found, it initiates interactive authentication to prompt the user for sign-in and consent.

## Initiate the authentication flow

Finally, call the `acquireToken()` function to initiate the authentication flow by adding the following code to *index.js*:

```javascript
acquireToken()
    .then((response) => {
        console.log(response);
    })
    .catch((e) => {
        console.error(e);
        process.exit(1);
    });
```

If the call to `acquireToken()` is successful, the response, which contains an access token, is logged to the console. If there's an error during authentication, the error is logged, and the process exits with an error code.

## Run and test the sample Node.js CLI application

To run and test your Node.js CLI application, ensure you've replaced the placeholder values in the *authConfig.js* file with your Microsoft Entra app registration details. You can now test the application you built by following these steps:

1. In your terminal, run the following command:

    ```powershell
   cd 1-Authentication\6-sign-in-node-cli-app\App
    npm start
    ```

1. The browser opens up automatically and you should see a page similar to the following:

     :::image type="content" source="media/tutorial-node-cli-app-sign-in/node-cli-app-sign-in-page.png" alt-text="Screenshot of the sign in page in a node CLI application.":::

1. On the sign-in page, type your **Email address**. If you don't have an account, select **No account? Create one**, which starts the sign-up flow.

1. If you choose the sign-up option, after filling in your email, one-time passcode, new password and more account details, you complete the whole sign-up flow. After completing the sign up flow and signing in, you see a page similar to the following screenshot:

     :::image type="content" source="media/tutorial-node-cli-app-sign-in/node-cli-app-signed-in-user.png" alt-text="Screenshot showing a signed-in user in a node CLI application.":::

1. Move back to the terminal and see your authentication information including the ID token claims returned by Microsoft Entra.

## See also 

- [Enable password reset](how-to-enable-password-reset-customers.md)
- [Customize branding for your sign-in experience](./how-to-customize-branding-customers.md)
