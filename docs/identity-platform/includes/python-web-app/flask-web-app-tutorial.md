---
author: SHERMANOUKO
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 02/12/2025
ms.author: shermanouko
ms.manager: mwongerapk
---

#### [Workforce tenant](#tab/workforce-tenant)

1. In your terminal, run the following command:

    ```console
    python3 -m flask run --debug --host=localhost --port=3000
    ```
    
    You can use the port of your choice. This should be similar to the port of the redirect URI you registered earlier.

1. Open your browser, then go to `http://localhost:3000`. You'll see a sign-in page.

1. Follow the steps and enter the necessary details to sign in with your Microsoft account. You're requested to provide an email address and password to sign in.

1. If there are any scopes needed by the application, a consent screen is presented. The application requests permission to maintain access to data you allow access to, and to sign you in and then read your profile, as shown in the screenshot. Select **Accept**.

1. After you sign in or sign up, you're redirected back to the web app. You'll see a page that looks similar to the following screenshot:

    :::image type="content" source="../../media/includes/python-web-app/flask-home-page.png" alt-text="Screenshot of flask web app sample after successful authentication.":::

1. Select **Logout** to sign the user out of the web app.

#### [External tenant](#tab/external-tenant)

1. In your terminal, run the following command:

    ```console
    python3 -m flask run --debug --host=localhost --port=3000
    ```
    
    You can use the port of your choice. This should be similar to the port of the redirect URI you registered earlier.

1. Open your browser, then go to `http://localhost:3000`. You'll see a sign-in page.

1. On the sign-in page, type your **Email address**, select **Next**, type your **Password**, then select **Sign in**. If you don't have an account, select **No account? Create one** link, which starts the sign-up flow.

1. If you choose the sign-up option, you'll go through the sign-uo flow. Fill in your email, one-time passcode, new password and more account details to complete the whole sign-up flow.

1. If there are any scopes needed by the application, a consent screen is presented. The application requests permission to maintain access to data you allow access to, and to sign you in and then read your profile, as shown in the screenshot. Select **Accept**.

1. After you sign in or sign up, you're redirected back to the web app. You'll see a page that looks similar to the following screenshot:

    :::image type="content" source="../../media/includes/python-web-app/flask-home-page.png" alt-text="Screenshot of flask web app sample after successful authentication.":::

1. Select **Logout** to sign the user out of the web app.
