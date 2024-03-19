---
title: "Tutorial: Call a protected API and display the results"
description: Call a protected API and display the results.
author: Dickson-Mwendia
manager: CelesteDG
ms.author: dmwendia
ms.date:  03/18/2024
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an application developer, I want to use my app to call a web API, in this case Microsoft Graph. I need to know how to modify my code to call the API successfully.
---

# Tutorial: Call a protected API and display the results

In the [previous tutorial](tutorial-web-app-dotnet-sign-in-users.md), you added the sign-in and sign-out experiences to the application. The application can now be configured to call a web API. For the purposes of this tutorial, the Microsoft Graph API is called to display the profile information of the logged-in user.

In this tutorial:

> [!div class="checklist"]
>
> * Call a protected downstream API
> * Run and test the application

## Call the API and display the results


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

## Test the application

Follow these steps to test the sign in, call API, and sign out experiences in your web app:

1. I f you haven't already, replace the placeholder values in the *.env.sample* file with your Microsoft Entra app registration details (client ID, client secret, and authority URL)

1. Create a virtual environment for the app:

    [!INCLUDE [Virtual environment setup](~/../azure-docs-pr/articles/app-service/includes/quickstart-python/virtual-environment-setup.md)]

1. Install the requirements using `pip`:

    ```shell
    pip install -r requirements.txt
    ```

1. Run the app from the command line, specifying the host and port to match the redirect URI:

    ```shell
    flask run --host=localhost --port=5000
    ```
1. Copy the https URL that appears in the terminal, for example, https://localhost:5000, and paste it into a browser. We recommend using a private or incognito browser session.

1. After the sign-in window appears, provide the account to sign in with and select **Next**:

    :::image type="content" source="./media/python-webapp/sign-in-page.png" alt-text="Screenshot showing the sign-in screen.":::
1. Your browser will redirect you to provide a password for your account. Enter the password and select  select **Sign in**.

    At this point, the sign-in flow may vary depending on the additional security information your organization requires, for example, multi-factor authentication using an authenticator app.

1. For **Stay signed in**, you can select either **No** or **Yes**.

1. The application requests permission to maintain access to data you have given it access to, sign you in, and read your profile. Select **Accept**.

    :::image type="content" source="./media/python-webapp/consent.png" alt-text="Screenshot showing the consent request window.":::

1. The following screenshot appears, indicating that you have signed in to the application:

    :::image type="content" source="./media/python-webapp/signed-in-user.png" alt-text="Screenshot showing a signed in user.":::

1. To call a protected API and show the results, select **Call a Downstream API**. A successful call to the Microsoft Graph API returns information about the signed in user, as shown:

    :::image type="content" source="./media/python-webapp/call-api-results.png" alt-text="Screenshot showing the results of a successful API call.":::

## Sign out from the application

1. Find the **Logout** link in the top right corner of the page, and select it.
1. You're prompted to pick an account to sign out from. Select the account you used to sign in.
1. A message appears indicating that you signed out. You can now close the browser window.

## Next steps

TBD