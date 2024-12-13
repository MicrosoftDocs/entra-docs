---
title: "Tutorial: Create and configure a Python Flask web app for authentication"
description: "Create new Python Flask web app project, add UI templates, and add required configurations."
author: Dickson-Mwendia
manager: CelesteDG
ms.author: dmwendia
ms.date: 04/18/2024
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an application developer, I want to create a Python Flask web app project, then configure it in such a way that I can add authentication with Microsoft Entra ID.
---

# Prepare a Python Flask web app for authentication

This tutorial is part 2 of a series that demonstrates building a Python Flask web app and adding sign in support using the Microsoft identity platform. In [part 1 of this series](tutorial-web-app-python-register-app.md), you registered and configured the application in your Microsoft Entra ID tenant.

In this tutorial, you: 

> [!div class="checklist"]
>
> - Create a new Python Flask web app project
> - Install app dependencies
> - Add the application's UI components
> - Configure your Flask web app to use Microsoft Entra ID for authentication

## Prerequisites

- Complete the steps in [Tutorial: Register a Python web app with the Microsoft identity platform](tutorial-web-app-python-register-app.md).
- [Visual Studio Code](https://visualstudio.microsoft.com/downloads/) or any other IDE.
- <a href="https://www.python.org/downloads/" target="_blank">Python 3.9 or higher</a> installed locally.

## Create a new Python web app project

To complete the rest of the tutorial, you need to create a Python Flask web app project. If you prefer using a completed code sample for learning, download the [Python Flask web app sample](https://github.com/Azure-Samples/ms-identity-docs-code-python/archive/refs/heads/main.zip) from GitHub. 

To build the Python Flask web app from scratch, follow these steps:

1. Create a folder to host your application and name it *flask-web-app*.
1. Navigate to your project directory and create three files named *app.py*, *app.config.py*, and *requirements.txt*.
1. Create an .env file in the root folder of the project.
1. Create a folder named *templates* in your project root directory. Flask looks for rendering templates in this subdirectory. 

After you create the files, your project's file and directory should be similar to the following structure:

```
python-webapp/
├── templates/
│     ├── display.html
│     ├── index.html
│     ├── login.html
├── .env.sample
├── app.py
├── app.config.py
│── requirements.txt
```

## Install app dependencies

The application you build uses the [`identity` package](https://pypi.org/project/identity/), a wrapper around the Microsoft Authentication Library (MSAL) for Python. You also install Flask, Flask Session, requests, and all other dependencies that the app requires. Update *requirements.txt* with these dependencies.

```python
Flask>=2.2
Flask-Session>=0.3.2,<0.6
werkzeug>=2
requests>=2,<3
identity>=0.5.1,<0.6
python-dotenv<0.22 
```

## Add application UI components

In this section, you create HTML templates for each of the routes you define in the app, including sign-in, sign-out, API calls, and error templates. Follow these steps to create templates for each of these pages:

#### Login templates

In the templates folder, create an HTML file named *login.html* and add the following content: 

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

    <hr>
    <footer style="text-align: right">Microsoft identity platform Web App Sample {{ version }}</footer>
</body>
</html>
```

This template represents the login page where users can sign in to your application.

#### Index template

In the templates folder, create an HTML file named *index.html* and add the following content: 

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

    <li><a href="/logout">Logout</a></li>
    </ul>

    <hr>
    <footer style="text-align: right">Microsoft identity platform Web App Sample {{ version }}</footer>
</body>
</html>
```
The index template serves as a homepage for the web app, rendered when users visit the root URL of the app.

#### Display page

This template is used to display the result of a downstream API call. Add the following snippet to *display.html*.

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

In the templates folder, create an HTML file called *auth_error.html* that displays any error messages that may come up. Add the following code to *auth_error.html.*

```html
<!DOCTYPE html>*
<html lang="en">
<head>
    <meta charset="UTF-8">
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

In the templates folder, create an HTML file called *config_error.html* that displays a message when a required configuration is missing. Add the following code to *config_error.html*.

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
AUTHORITY= os.getenv("AUTHORITY")

# Application (client) ID of app registration
CLIENT_ID = os.getenv("CLIENT_ID")
# Application's generated client secret: never check this into source control!
CLIENT_SECRET = os.getenv("CLIENT_SECRET")
 
REDIRECT_PATH = "/getAToken"  # Used for forming an absolute URL to your redirect URI.

ENDPOINT = 'https://graph.microsoft.com/v1.0/me'  
SCOPE = ["User.Read"]

# Tells the Flask-session extension to store sessions in the filesystem
SESSION_TYPE = "filesystem"
```

## Create a .env file to store configuration settings.

In this sample, you use an .env file to store and manage the application's configuration settings, environment variables, and credentials that shouldn't be embedded in our code. Open the .env file you created at the root of your project directory and add the following values.

```python
# The following variables are required for the app to run.
CLIENT_ID=<client id>
CLIENT_SECRET=<client secret>
AUTHORITY=<Enter_your_authority_url>
```

In your *.env.sample* file, replace the placeholders for:

-   * `CLIENT_ID` with the **Application (client) ID** available on the app registration overview page.
    * `CLIENT_SECRET` with the client secret you created in the **Certificates & Secrets** 
    * `AUTHORITY` with `https://login.microsoftonline.com/<TENANT_GUID>`. The **Directory (tenant) ID** is available on the app registration overview page.

## Next step

Learn how to add sign-in support to a Python Flask web app in the next part of this tutorial series:

> [!div class="nextstepaction"]
> [Tutorial: Add sign-in support to a Python Flask web app](tutorial-web-app-python-sign-in-users.md)
