---
title: "Tutorial: Call a protected API and display the results"
description: Call a protected API and display the results.
author: Dickson-Mwendia
manager: CelesteDG
ms.author: dmwendia
ms.date: 04/18/2024
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an application developer, I want to use my app to call a web API, in this case Microsoft Graph. I need to know how to modify my code to call the API successfully.
---

# Tutorial: Call a protected API and display the results

In the [previous tutorial](tutorial-web-app-dotnet-sign-in-users.md), you added the sign-in and sign-out experiences to the application. You can now build on these functionalities to allow signed in users call a protected web API. For the purposes of this tutorial, you call the Microsoft Graph API and display profile information of the logged-in user.

In this tutorial:

> [!div class="checklist"]
>
> * Add code to call a protected downstream API
> * Run and test the application

## Call the API and display the results

To call a protected API, you should first acquire an access token for the current user by calling `auth.get_token_for_user` as follows:

```python
@app.route("/call_downstream_api")
def call_downstream_api():
    token = auth.get_token_for_user(app_config.SCOPE)
    if "error" in token:
        return redirect(url_for("login"))
    # Use access token to call downstream api
    api_result = requests.get(
        app_config.ENDPOINT,
        headers={'Authorization': 'Bearer ' + token['access_token']},
        timeout=30,
    ).json()
    return render_template('display.html', result=api_result)
``` 

When a user navigates to the `/call_downstream_api` URL route, Flask invokes the `call_downstream_api()` function that first attempts to obtain an access token using `auth.get_token_for_user(app_config.SCOPE)`. If there's an authentication issue or any error in the token, redirect the user to the sign-in page for reauthentication.

If the app successfully obtains an access token, it makes an HTTP request to the downstream API using the `requests.get(...)` method. In the request, our downstream API URL is specified in `app_config.ENDPOINT`. You also pass the access token in the `Authorization` field of the request header. 

A successful request to the downstream API (Microsoft Graph API) returns a JSON response stored in an `api_result` variable and passed to the `display.html` template for rendering. 

## Add code to run the app

To run your app, add the following code snippet at the end of your *app.py* file.

```python
if __name__ == "__main__":
    app.run()
```

## Test the app

Follow these steps to test the sign in, call API, and sign out experiences in your web app:

1. If you haven't already, replace the placeholder values in the *.env.sample* file with your Microsoft Entra app registration details (client ID, client secret, and authority URL)

1. Create a virtual environment for the app:

    [!INCLUDE [Virtual environment setup](./includes/python-web-app/virtual-environment-setup.md)]

1. Install the requirements using `pip`:

    ```shell
    pip install -r requirements.txt
    ```

1. Run the app from the command line. Ensure your app is running on the same port as the redirect URI you configured earlier.

    ```shell
    flask run --host=localhost --port=5000
    ```
1. Copy the https URL that appears in the terminal, for example, https://localhost:5000, and paste it into a browser. We recommend using a private or incognito browser session.

1. After the sign-in window appears, provide the account to sign in with and select **Next**:

    :::image type="content" source="./media/python-webapp/sign-in-page.png" alt-text="Screenshot showing the sign-in screen.":::
1. Your browser will redirect you to provide a password for your account. Enter the password and select **Sign in**.

    At this point, the sign-in flow might vary depending on the security information your organization requires, for example, multifactor authentication using an authenticator app.

1. For **Stay signed in**, you can select either **No** or **Yes**.

1. The application requests permission to maintain access to data you've given it access to, sign you in, and read your profile. Select **Accept** to consent to these permissions.

1. The following screenshot appears, indicating that you're signed in to the application:

    :::image type="content" source="./media/python-webapp/signed-in-user.png" alt-text="Screenshot showing a signed in user.":::

1. To call a protected API and show the results, select **Call a downstream API**. A successful call to the Microsoft Graph API returns information about the signed in user, as shown:

    :::image type="content" source="./media/python-webapp/call-api-results.png" alt-text="Screenshot showing the results of a successful API call.":::

## Sign out of the app

1. Select **Logout** to sign out of the app.
1. You're prompted to pick an account to sign out from. Select the account you used to sign in.
1. A message appears indicating that you signed out. You can now close the browser window.

## See also

The app you built uses the [identity library](https://identity-library.readthedocs.io/en/latest/), which abstracts most details of the Microsoft Authentication Library (MSAL) for Python. For more information on how to use MSAL Python for different scenarios, see the [MSAL Python documentation](/entra/msal/python/).