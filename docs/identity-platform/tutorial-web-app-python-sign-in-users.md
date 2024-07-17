---
title: "Tutorial: Add sign in to a Python web app"
description: "Add sign in logic to a Python web app"
author: Dickson-Mwendia
manager: CelesteDG
ms.author: dmwendia
ms.date: 04/03/2024
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an application developer, I want to install the packages necessary for authentication in my IDE, and implement authentication in my web app.
---

# Tutorial: Add sign in to a Python Flask web app

This tutorial is the third part of a tutorial series that demonstrates building a Python Flask web app from scratch and integrating authentication using the Microsoft identity platform. In this tutorial, you add code to authenticate users in the app you built.

> [!div class="checklist"]
>
> - Import the required modules and configuration
> - Create an instance of a Flask web app
> - Configure ProxyFix middleware for local development
> - Add code to sign in and sign out users
> - Define an entry point for the web app


## Import required packages and configurations

The web app you're building uses the `identity.web` package built on top of MSAL Python to authenticate users in web apps. To import the `identity.web` package, Flask framework, Flask modules, Flask session, and the app configurations defined in the previous tutorial, add the following code to *app.py*:

```python
import identity.web
import requests
from flask import Flask, redirect, render_template, request, session, url_for
from flask_session import Session

import app_config
```

In this code snippet, you import the `redirect`, `render_template`, `request`, `session`, and `url_for`: functions and objects for handling web requests and sessions in Flask. You also import `app_config`, which contains the configuration settings for your app.

## Create an instance of the Flask web app

After importing the required modules, we initialize the web app using the configurations in `app-config`. To create an instance of your web app, add the following snippet to `app.py`:

```python
app = Flask(__name__)
app.config.from_object(app_config)
assert app.config["REDIRECT_PATH"] != "/", "REDIRECT_PATH must not be /"
Session(app)
```

In the above code snippet, you initialize a new Flask application and load the configuration settings using `app.config.from_object(app_config)`. By using `from_object`, the app inherits the configurations from the specified in `(app_config)`. 

You also perform an assertion check to ensure the redirect path of your app isn't set to the root path (“/”). `Session(app)` initializes session management for your app, which enables you to handle sessions and store data such as user authentication states across multiple requests. 

## Configure ProxyFix middleware for local development

Since the sample web app runs on local host, we use the `ProxyFix` middleware to fix the URL scheme and host information in the request headers. Add the following code to `app.py` to apply ProxyFix:

```python
from werkzeug.middleware.proxy_fix import ProxyFix
app.wsgi_app = ProxyFix(app.wsgi_app, x_proto=1, x_host=1)
```

## Initialize an authentication object

Next, you initialize an authentication object by creating an instance of the `[identity.web.Auth](https://identity-library.readthedocs.io/en/latest/#identity.web.Auth)` class. You also pass the parameters `session`, `authority`, `client_id`, and `client_credential` in the constructor when initializing the Auth object, as follows: 

```python
app.jinja_env.globals.update(Auth=identity.web.Auth)  # Useful in template for B2C
auth = identity.web.Auth(
    session=session,
    authority=app.config["AUTHORITY"],
    client_id=app.config["CLIENT_ID"],
    client_credential=app.config["CLIENT_SECRET"],
)
```

In this code snippet, `app.jinja_env.globals.update(Auth=identity.web.Auth)`adds a new global variable named `Auth` and assigns it the value of  `identity.web.Auth`. This makes `Auth`accessible in all templates rendered by the Flask application. 

## Sign in users

The authorization flow you build in this app consists of two legs. In the first leg, you invoke the `auth.log_in` function to sign in users, as shown:

```python
@app.route("/login")
def login():
    return render_template("login.html", version=__version__, **auth.log_in(
        scopes=app_config.SCOPE, # Have user consent to scopes during log-in
        redirect_uri=url_for("auth_response", _external=True), # Optional. If present, this absolute URL must match your app's redirect_uri registered in Microsoft Entra admin center
        prompt="select_account",  # Optional.
        ))
```

When a user navigates to the `/login` URL in your app, Flask invokes the view function that handles the request to render the `login.html` template. Inside `login()`, you call the `auth.log_in` function with a list of scopes that the user should consent to during the sign in process. You also provide `redirect_uri` in the parameters, which should match the app's redirect URI i the Microsoft Azure admin center.

You can optionally add parameters such as `prompt`, which controls the behavior of the log in prompt by requesting for reauthentication, user consent, or account selection among accounts with active sessions. 

In the second leg of the authorization flow, you handle the authentication response by calling the `auth.complete_log_in` function inside the redirect_uri controller, as shown: 

```python
@app.route(app_config.REDIRECT_PATH)
def auth_response():
    result = auth.complete_log_in(request.args)
    if "error" in result:
        return render_template("auth_error.html", result=result)
    return redirect(url_for("index"))
```
The `complete_log_in()` function takes in the incoming `auth_response` dictionary as the query parameters. If successful, the function redirects the user to the "index" route using `redirect(url_for("index"))`. This means the user has successfully logged in their information is available as a dictionary containing claims from an already-validated ID token.

If the result contains an error as determined by the condition `if "error" in result:`, then render the `"auth_error.html"` template to the user.

## Sign out users

To sign out users from your Flask application, invoke the `auth.log_out()` method as follows:

```python
@app.route("/logout")
def logout():
    return redirect(auth.log_out(url_for("index", _external=True)))
```

When a user navigates to the `/logout` URL route in the app, Flask invokes the logout function that signs them out of the current app. You also specify the page that users should be redirected to upon logging out. In the code snippet, we redirect users to the app's homepage using `url_for("index", _external=True).`

## Define an entry point for the web app

After implementing the sign in and sign out logic, add an entry point to your app's homepage by creating the `index()` function as follows:

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

The `index()` function is invoked when a user navigates to the app's root URL("/"). It handles configuration checks and validates user authentication before rendering the app's homepage. It checks if the client ID and client secret are missing in the configuration, and if either or both values are missing, Flask renders the `"config_error.html"` template. 

The function also calls `auth.get_user()` to verify whether the user is authenticated or not. If the user isn't authenticated, it redirects them to the `"login"` route. If authenticated, Flask renders the "index.html" template and passes the user object (retrieved from `auth.get_user()`) for rendering.

## Next steps

> [!div class="nextstepaction"]
> [Tutorial: Call a protected API and display the results in a Python Flask web app](tutorial-web-app-python-call-api.md)