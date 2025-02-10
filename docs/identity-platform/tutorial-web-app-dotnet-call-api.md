---
title: "Tutorial: Test an ASP.NET Core web app and call an API"
description: Learn how to call the Microsoft Graph web API, sign-in, and display the profile information of the logged-in user
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.date: 01/18/2024
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an application developer, I want to use my app to call a web API, in this case Microsoft Graph. I need to know how to modify my code so the API can be called successfully.
---

# Tutorial: Test an ASP.NET Core web app and call an API

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

In this tutorial, you'll test the sign in and sign out experience of your ASP.NET Core web app and call the Microsoft Graph API. In the [previous tutorial](./tutorial-web-app-dotnet-sign-in-users.md), you added the authentication elements, the sign-in and sign-out experiences to the application to enable your app call a web API. For the purposes of this tutorial, the Microsoft Graph API is called to display the profile information of the logged-in user.

In this tutorial:

> [!div class="checklist"]
>
> * Test the application and display the results from the API
> * Sign out of the application
> * Clean up resources

## Prerequisites

* Completion of the prerequisites and steps in [Tutorial: Add sign in to an application](tutorial-web-app-dotnet-sign-in-users.md).

## Test the application

This section demonstrates how to test the application by signing in and calling the Microsoft Graph API to display the profile information of the logged-in user.

### [Workforce tenant](#tab/workforce-tenant)

1. Start the application by typing the following in the terminal to launch the `https` profile in the *launchSettings.json* file.
1. Open a new private browser, and enter the application URI into the browser, in this case `https://localhost:7274`.
1. After the sign-in window appears, select the account in which to sign in with. Ensure the account matches the criteria of the app registration.
1. Fill in your email, one time-passcode as instructed to complete the sign-in flow. You can choose to stay signed in or not in the **Stay signed in** window.
1. The application requests permission to maintain access to data you have given it access to, and to sign you in and read your profile. Select **Accept**.
1. The following screenshot appears, indicating that you have signed in to the application and have accessed your profile details from the Microsoft Graph API.

    :::image type="content" source="./media/common-web-app/dotnet-core/display-api-call-results-dotnet-core.png" alt-text="Screenshot depicting the results of the API call." lightbox="./media/common-web-app/dotnet-core/display-api-call-results-dotnet-core.png":::


### [External tenant](#tab/external-tenant)

1. Start the application by typing the following in the terminal to launch the `https` profile in the *launchSettings.json* file.
1. Open a new private browser, and enter the application URI into the browser, in this case `https://localhost:7274`.
1. To test the sign-up user flow you configured earlier, select **No account? Create one**.
1. In the **Create account** window, enter the email address registered to your external tenant, which will start the sign-up flow as a user for your application.
1. Fill in your email, one time-passcode, new password as instructed to complete the sign-up flow. You can choose to stay signed in or not in the **Stay signed in** window.
1. The application requests permission to maintain access to data you have given it access to, and to sign you in and read your profile. Select **Accept**.
1. The following screenshot appears, indicating that you have signed in to the application and have accessed your profile details from the Microsoft Graph API.

    :::image type="content" source="./media/common-web-app/dotnet-core/display-api-call-results-dotnet-core.png" alt-text="Screenshot depicting the results of the API call." lightbox="./media/common-web-app/dotnet-core/display-api-call-results-dotnet-core.png":::

---

## Sign-out from the application

Now that you've tested the application and called the Microsoft Graph API, you should sign out of the application.

1. Find the **Sign out** link in the top right corner of the page, and select it.
1. You're prompted to pick an account to sign out from. Select the account you used to sign in.
1. A message appears indicating that you signed out. You can now close the browser window.

## Clean up resources

Navigate to the Microsoft Entra admin center and delete the application registration. This will remove the application from your tenant and prevent any further access to the application.

## See also

- [Enable self-service password reset](../external-id/customers/how-to-enable-password-reset-customers.md)