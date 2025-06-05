---
title: "Tutorial: Call Microsoft Graph API from a Python Flask web app"
description: Call Microsoft Graph API from a Python Flask web app
author: SHERMANOUKO
manager: CelesteDG

ms.author: shermanouko
ms.date: 02/24/2025
ms.service: identity-platform
ms.topic: tutorial
#Customer intent: As an application developer, I want to use my Python Flask web app to call Microsoft Graph API so that I can read a signed-in user's profile information.
---

# Tutorial: Call Microsoft Graph API from a Python Flask web app

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

In this tutorial, you call Microsoft Graph API from a Python Flask web app. In the [previous tutorial](tutorial-web-app-python-flask-sign-in-out.md), you added the sign-in and sign-out experiences to the application. Once a user signs in, the app acquires an access token to call Microsoft Graph API.

In this tutorial, you:

> [!div class="checklist"]
>
> - Update an existing Python Flask web app to acquire an access token
> - Use the access token to call Microsoft Graph API.

## Prerequisites

Complete the steps in [Tutorial: Add add sign-in to a Python Flask web app by using Microsoft identity platform](tutorial-web-app-node-sign-in-sign-out.md). 

## Define scopes and API endpoint

In this example, we call the Microsoft Graph API to get the signed-in user's profile information. If your app is in a workforce tenant, on sign-in, the user consents to the scopes required by the app to access the Microsoft Graph API. If your app is in an external tenant, ensure you [grant admin consent on behalf of users in your tenant](./quickstart-register-app.md#grant-admin-consent-external-tenants-only). The app then uses the access token to call the API and display the results.

In your *.env* file, add the endpoint we're calling and the scopes required to call the Microsoft Graph API:

```
SCOPE=User.Read
ENDPOINT=https://graph.microsoft.com/v1.0/me
```

Read the new configs in your app by updating the *app_config.py* file.

```python
# other configs go here
SCOPE = os.getenv("SCOPE")
ENDPOINT = os.getenv("ENDPOINT")
```

## Call a protected API

1. Pass the API endpoint to the homepage. This enables you to call your endpoint. Update the `/` route to look like shown in the following code snippet:

    ```python
    @app.route("/")
    @auth.login_required
    def index(*, context):
        return render_template(
            'index.html',
            user=context['user'],
            title="Flask Web App Sample",
            api_endpoint=os.getenv("ENDPOINT") # added this line
        )
    ```

1. Call the protected Microsoft Graph API as shown in the following code snippet. We pass the list of scopes that our app needs to use. If scopes are present, the context contains an access token. The access token is used to call the downstream API. Add this code to the *app.py* file:

    ```python
    @app.route("/call_api")
    @auth.login_required(scopes=os.getenv("SCOPE", "").split())
    def call_downstream_api(*, context):
        api_result = requests.get(  # Use access token to call a web api
            os.getenv("ENDPOINT"),
            headers={'Authorization': 'Bearer ' + context['access_token']},
            timeout=30,
        ).json() if context.get('access_token') else "Did you forget to set the SCOPE environment variable?"
        return render_template('display.html', title="API Response", result=api_result)
    ``` 

    If the app successfully obtains an access token, it makes an HTTP request to the downstream API using the `requests.get(...)` method. In the request, our downstream API URL is specified in `app_config.ENDPOINT` and the access token passed in the `Authorization` field of the request header. 
    
    A successful request to the downstream API (Microsoft Graph API) returns a JSON response stored in an `api_result` variable and passed to the `display.html` template for rendering. 

## Display API results

Create a file called *display.html* in the *templates* folder. This page displays the result of the call to the Microsoft Graph endpoint. Add the following code to the *display.html* file:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Microsoft Identity Python Web App: API</title>
</head>
<body>
    <a href="javascript:window.history.go(-1)">Back</a> <!-- Displayed on top of a potentially large JSON response, so it will remain visible -->
    <h1>{{title}}</h1>
    <pre>{{ result |tojson(indent=4) }}</pre> <!-- Just a generic json viewer -->
</body>
</html>
```

## Run and test the sample web app

[!INCLUDE [python-flask-web-app-run-app](./includes/python-web-app/flask-web-app-tutorial.md)]

## Call API

1. Select the **Call an API** link on the home page. The app calls the Microsoft Graph API to get the signed-in user's profile information. The app displays the result of the call to the API.

1. Select **Logout** to sign out of the app. You're prompted to pick an account to sign out from. Select the account you used to sign in.

## Reference material

The [ms_identity_python](https://github.com/azure-samples/ms-identity-python) abstracts the details of the MSAL library. For more information, see [MSAL Python documentation](/entra/msal/python/). This reference material helps you understand how you initialize an app and acquire tokens using MSAL Python.
