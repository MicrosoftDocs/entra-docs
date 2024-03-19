---
title: "Tutorial: Create and configure an Python web app for authentication"
description: "Create and configure project, add configuration for authentication and install required packages"
author: Dickson-Mwendia
manager: CelesteDG
ms.author: dmwendia
ms.date: 03/18/2024
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an application developer, I want to create a Python web app project, then configure it in such a way that I can add authentication with Microsoft Entra ID.
---

# Prepare a Python web app for authentication

This tutorial is part 2 of a series that demonstrates building a Python Flask web app and preparing it for authentication using the Microsoft Entra admin center. In [part 1 of this series](tutorial-web-app-python-register-app.md), you registered and configured the application in your Microsoft Entra ID tenant.

In this tutorial: 

> [!div class="checklist"]
>
> - Create a new Python Flask web app project
> - Install app dependencies
> - Add the application's UI components
> - Create the configuration file
> - Create a .env file to store configuration settings.

## Prerequisites

- Complete the steps in [Tutorial: Register a Python web app with the Microsoft identity platform](tutorial-web-app-python-register-app.md)
- [Visual Studio Code](https://visualstudio.microsoft.com/downloads/) or any other IDE.
- <a href="https://www.python.org/downloads/" target="_blank">Python 3.9 or higher</a> installed locally.

## Create a new Python web app project

To complete the rest of the tutorial, you'll need to create a Python Flask web app project. If you prefer using a completed code sample for learning, download the [Python Flask web app sample](https://github.com/Azure-Samples/ms-identity-docs-code-python/flask-web-app) from GitHub. 

To build the Python Flask web app from scratch, follow these steps:

1. Create a folder to host your application and name it *flask-web-app*.
1. Navigate to your project directory and create three files named *app.py*, *app.config.py*, and *requirements.txt*
1. Create an .env file in the root folder of the project.
1. In your project root directory, create a folder named *templates*. Flask will look for rendering templates in this subdirectory. 

After you create the files, your project's file and directory structure should be similar to the following:

```
python-webapp/
├── templates/
│     ├── auth.error.html
│     ├── config.error.html
│     ├── display.html
│     ├── index.html
│     ├── login.html
├── .env.sample
├── app.py
├── app.config.py
│── requirements.txt
```

## Install app dependencies

The application you build uses the the [`identity` package](https://pypi.org/project/identity/), a wrapper around the Microsoft Authentication Library (MSAL) for Python. You'll also install Flask, Flask Session, requests, and all other dependencies that the app requires. Update *requirements.txt* with these dependencies.

```python
Flask>=2.2
Flask-Session>=0.3.2,<0.6
werkzeug>=2
requests>=2,<3
identity>=0.5.1,<0.6
python-dotenv<0.22 
```

## Add application UI components

Flask uses the helper function `render_template()` for rendering HTML templates containing both static and dynamic content. In this section, you create HTML templates for each of the routes you'll define in the app, including login, logout, API calls, and error templates. Follow these steps to create templates for each of these pages:

#### Login templates

In the templates folder, create a HTML file named *login.html* and add the following content: 

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Microsoft Identity Python Web App: Login</title>
</head>
<body>
    <h1>Microsoft Identity Python Web App</h1>

    {% if user_code %}
    <ol>
      <li>To sign in, type <b>{{ user_code }}</b> into
        <a href='{{ auth_uri }}' target=_blank>{{ auth_uri }}</a>
        to authenticate.
      </li>
      <li>And then <a href="{{ url_for('auth_response') }}">proceed</a>.</li>
    </ol>
    {% else %}
    <ul><li><a href='{{ auth_uri }}'>Sign In</a></li></ul>
    {% endif %}

    {% if config.get("B2C_RESET_PASSWORD_AUTHORITY") %}
    <a href='{{Auth(session={}, authority=config["B2C_RESET_PASSWORD_AUTHORITY"], client_id=config["CLIENT_ID"]).log_in(redirect_uri=url_for("auth_response", _external=True))["auth_uri"]}}'>Reset Password</a>
    {% endif %}

    <hr>
    <footer style="text-align: right">Microsoft identity platform Web App Sample {{ version }}</footer>
</body>
</html>
```

This template represents the login page where users can log in to your application. You’ll need to add a login form to this template. Here’s the basic structure:

#### Index template

In the templates folder, create a HTML file named *index.html* and add the following content: 

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Microsoft Identity Python Web App: Index</title>
</head>
<body>
    <h1>Microsoft Identity Python Web App</h1>
    <h2>Welcome {{ user.get("name") }}!</h2>

    <ul>
    {% if config.get("ENDPOINT") %}
      <li><a href='/call_downstream_api'>Call a downstream API</a></li>
    {% endif %}

    {% if config.get("B2C_PROFILE_AUTHORITY") %}
      <li><a href='{{Auth(session={}, authority=config["B2C_PROFILE_AUTHORITY"], client_id=config["CLIENT_ID"]).log_in(redirect_uri=url_for("auth_response", _external=True))["auth_uri"]}}'>Edit Profile</a></li>
    {% endif %}

    <li><a href="/logout">Logout</a></li>
    </ul>

    <hr>
    <footer style="text-align: right">Microsoft identity platform Web App Sample {{ version }}</footer>
</body>
</html>
```
The index template serves as a general design template that other templates inherit. Your app will render this template when serving the page that all users, authenticated or not, can access.

#### Display page

This template is likely used to display the result of an API call. It could show data retrieved from a downstream API. Here’s a simple example:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Microsoft Identity Python Web App: API</title>
</head>
<body>
    <a href="javascript:window.history.go(-1)">Back</a> <!-- Displayed on top of a potentially large JSON response, so it will remain visible -->
    <h1>Result of the downstream API Call</h1>
    <pre>{{ result |tojson(indent=4) }}</pre> <!-- Just a generic json viewer -->
</body>
</html>
```

#### Error templates

**Auth error template**

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    {% if config.get("B2C_RESET_PASSWORD_AUTHORITY") and "AADB2C90118" in result.get("error_description") %} <!-- This will be reached when user forgot their password -->
      <!-- See also https://docs.microsoft.com/en-us/azure/active-directory-b2c/active-directory-b2c-reference-policies#linking-user-flows -->
      <meta http-equiv="refresh" content='0;{{config.get("B2C_RESET_PASSWORD_AUTHORITY")}}?client_id={{config.get("CLIENT_ID")}}'>
    {% endif %}
    <title>Microsoft Identity Python Web App: Error</title>
</head>
<body>
    <h2>Login Failure</h2>
    <dl>
      {#
        Flask automatically escapes these unsafe input, so we do not have to.
        See also https://flask.palletsprojects.com/en/2.0.x/templating/#jinja-setup
      #}
      <dt>{{ result.get("error") }}</dt>
      <dd>{{ result.get("error_description") }}</dd>
    </dl>
    <hr>
    <a href="{{ url_for('index') }}">Homepage</a>
</body>
</html>
```

**Config error template**

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Microsoft Identity Python Web App: Error</title>
</head>
<body>
    <h2>Config Missing</h2>
    <p>
        Almost there. Did you forget to set up
<a target=_blank
href="https://learn.microsoft.com/azure/active-directory/develop/web-app-quickstart?pivots=devlang-python#step-5-configure-the-sample-app">
necessary environment variables</a> for your deployment?
    </p>
    <hr>
    <a href="{{ url_for('index') }}">Homepage</a>
</body>
</html>
```

## Create the configuration file

In your code editor, open *app_config.py*, which holds the configuration parameters, and add the following code:

```python
import os
AUTHORITY= "https://login.microsoftonline.com/common"

# Application (client) ID of app registration
CLIENT_ID = "80977fed-1946-4cac-a25a-c8dd1d5636ce" 
# Application's generated client secret: never check this into source control!
CLIENT_SECRET = "ADO8Q~wEwKnSkg4xfH4Hgq~yp4OYlJR80k9i_anw" 
REDIRECT_PATH = "/getAToken"  # Used for forming an absolute URL to your redirect URI.

ENDPOINT = 'https://graph.microsoft.com/v1.0/me'  
SCOPE = ["User.Read"]

# Tells the Flask-session extension to store sessions in the filesystem
SESSION_TYPE = "filesystem"
```

The `msalConfig` object contains a set of configuration options that can be used to customize the behavior of your authentication flows. This configuration object is passed into the instance of our public client application upon creation. 

## Create a .env file to store configuration settings.

In this sample, you'll use a .env file to store and manage the application's configuration settings, environment variables, and credentials that shouldn't be embedded in our code. Open the .env file you created at the root of your project directory and add the following.

```python
# The following variables are required for the app to run.
CLIENT_ID=<client id>
CLIENT_SECRET=<client secret>
AUTHORITY=<your authority url>
```

In your *.env.sample* file, find the placeholders:

- `client id` and replace it with the Application (client) ID of the app you registered earlier.


## Next step

Learn how to add sign-in support to a Python Flask web app in the next part of this tutorial series:

> [!div class="nextstepaction"]
> [Tutorial: Add sign-in support to a Python Flask web app](tutorial-web-app-python-sign-in-users.md)
