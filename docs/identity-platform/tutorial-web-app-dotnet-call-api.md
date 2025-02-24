---
title: "Tutorial: Call an API and display the results"
description: Learn how to call the Microsoft Graph web API, sign-in, and display the profile information of the logged-in user
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.date: 01/18/2024
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an application developer, I want to use my app to call a web API, in this case Microsoft Graph. I need to know how to modify my code so the API can be called successfully.
---

# Tutorial: Call an API and display the results

In the [previous tutorial](tutorial-web-app-dotnet-sign-in-users.md), you added the sign-in and sign-out experiences to the application. The application can now be configured to call a web API. For the purposes of this tutorial, the Microsoft Graph API is called to display the profile information of the logged-in user.

In this tutorial:

> [!div class="checklist"]
>
> * Call the API and display the results
> * Test the application

## Prerequisites

* Completion of the prerequisites and steps in [Tutorial: Add sign in to an application](tutorial-web-app-dotnet-sign-in-users.md).

## Call the API and display the results

1. Under **Pages**, open the *Index.cshtml.cs* file and replace the entire contents of the file with the following snippet. Check that the project `namespace` matches your project name.

   :::code language="csharp" source="~/../ms-identity-docs-code-dotnet/web-app-aspnet/Pages/Index.cshtml.cs":::

1. Open *Index.cshtml* and add the following code to the bottom of the file. This handles how the information received from the API is displayed:

   :::code language="csharp" source="~/../ms-identity-docs-code-dotnet/web-app-aspnet/Pages/Index.cshtml" range="13-17":::

## Test the application

### [Visual Studio](#tab/visual-studio)

Start the application by selecting **Start without debugging**.

### [Visual Studio Code](#tab/visual-studio-code)

1. Start the application by typing the following in the terminal:

    #### [.NET 6.0](#tab/dotnet6)

    ```powershell
    dotnet run
    ```

    #### [.NET 7.0](#tab/dotnet7)

    ```powershell
    dotnet run --launch-profile https
    ```

---

1. Depending on your IDE, you may need to enter the application URI into the browser, for example `https://localhost:7100`. After the sign-in window appears, select the account in which to sign in with. Ensure the account matches the criteria of the app registration.

    :::image type="content" source="./media/web-app-tutorial-04-call-web-api/pick-account.png" alt-text="Screenshot depicting account options to sign in.":::

1. Upon selecting the account, a second window appears indicating that a code will be sent to your email address. Select **Send code**, and check your email inbox.

    :::image type="content" source="./media/web-app-tutorial-04-call-web-api/sign-in-send-code.png" alt-text="Screenshot depicting a screen to send a code to the user's email.":::

1. Open the email from the sender **Microsoft account team**, and enter the 7-digit *single-use code*. Once entered, select **Sign in**.

    :::image type="content" source="./media/web-app-tutorial-04-call-web-api/enter-code.png" alt-text="Screenshot depicting the single-use code sign in procedure.":::

1. For **Stay signed in**, you can select either **No** or **Yes**.

    :::image type="content" source="./media/web-app-tutorial-04-call-web-api/stay-signed-in.png" alt-text="Screenshot depicting the option on whether to stay signed in.":::

1. The application requests permission to maintain access to data you have given it access to, and to sign you in and read your profile. Select **Accept**.

    :::image type="content" source="./media/web-app-tutorial-04-call-web-api/permissions-requested.png" alt-text="Screenshot depicting the permission requests.":::

1. The following screenshot appears, indicating that you have signed in to the application and have accessed your profile details from the Microsoft Graph API.

    :::image type="content" source="./media/common-web-app/dotnet-core/display-api-call-results-dotnet-core.png" alt-text="Screenshot depicting the results of the API call." lightbox="./media/common-web-app/dotnet-core/display-api-call-results-dotnet-core.png":::

## Sign-out from the application

1. Find the **Sign out** link in the top right corner of the page, and select it.
1. You're prompted to pick an account to sign out from. Select the account you used to sign in.
1. A message appears indicating that you signed out. You can now close the browser window.

## Next steps

Learn how to use the Microsoft identity platform by building a web API with the following tutorial series.

> [!div class="nextstepaction"]
> [Tutorial: Register a web API with the Microsoft identity platform](web-api-tutorial-01-register-app.md)