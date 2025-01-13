---
author: SHERMANOUKO
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 03/21/2024
ms.author: shermanouko
ms.manager: mwongerapk
---

1. In your terminal, run the following command:

    ```console
    python3 -m flask run --debug --host=localhost --port=3000
    ```
    
    You can use the port of your choice. This should be similar to the port of the redirect URI you registered earlier.

1. Open your browser, then go to `http://localhost:3000`. You should see the page similar to the following screenshot:

    :::image type="content" source="../../media/includes/run-app/flask-sign-in-page.png" alt-text="Screenshot of flask web app sample sign-in page.":::

1. After the page completes loading, select **Sign In** link. You're prompted to sign in.

1. On the sign-in page, type your **Email address**, select **Next**, type your **Password**, then select **Sign in**. If you don't have an account, select **No account? Create one** link, which starts the sign-up flow.

1. If you choose the sign-up option, you'll go through the sign-uo flow. Fill in your email, one-time passcode, new password and more account details to complete the whole sign-up flow.

1. After you sign in or sign up, you're redirected back to the web app. You'll see a page that looks similar to the following screenshot:

    :::image type="content" source="../../media/includes/run-app/flask-authenticated-page.png" alt-text="Screenshot of flask web app sample after successful authentication.":::

1. Select **Logout** to sign the user out of the web app or select **Call a downstream API** to make a call to a Microsoft Graph endpoint.
