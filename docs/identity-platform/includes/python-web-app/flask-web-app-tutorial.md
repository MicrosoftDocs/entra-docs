---
author: SHERMANOUKO
ms.service: identity-platform
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
    
    You can use the port of your choice. This port should be similar to the port of the redirect URI you registered earlier.

1. Open your browser, then go to `http://localhost:3000`. You see a sign-in page.

1. Sign in with your Microsoft account by following the steps. You're requested to provide an email address and password to sign in.

1. If there are any scopes needed by the application, a consent screen is presented. The application requests permission to maintain access to data you allow access to and to sign you in. Select **Accept**. This screen doesn't appear if no scopes are defined.

#### [External tenant](#tab/external-tenant)

1. In your terminal, run the following command:

    ```console
    python3 -m flask run --debug --host=localhost --port=3000
    ```
    
    You can use the port of your choice. This port should be similar to the port of the redirect URI you registered earlier.

1. Open your browser, then go to `http://localhost:3000`. You see a sign-in page.

1. On the sign-in page, type your **Email address**, select **Next**, type your **Password**, then select **Sign in**. If you don't have an account, select **No account? Create one** link, which starts the sign-up flow.

1. If you choose the sign-up option, you go through the sign-up flow. To complete the whole sign-up flow, fill in your email, one-time passcode, new password and more account details.

1. If there are any scopes needed by the application, a consent screen is presented. The application requests permission to maintain access to data you allow access to, and to sign you in and then read your profile, as shown in the screenshot. Select **Accept**.
