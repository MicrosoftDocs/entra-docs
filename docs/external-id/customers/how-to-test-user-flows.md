---
title: Test a user flow
description: Learn how to use the Run user flow feature to test your sign-up and sign-in user flow for your consumer and business customer apps.
 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: customers

ms.topic: how-to
ms.date: 02/15/2024
ms.author: mimart
ms.custom: it-pro

#Customer intent: As a dev, devops, or it admin, I want to see the end user's experience when they sign in to an application that uses the user flow I created.
---

# Test your sign-up and sign-in user flow  

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

The **Run user flow** feature allows you to test your user flows by simulating a user’s sign-up or sign-in experience with your application. You can use this feature to verify that your user flow is working as expected. To use this feature, you select the user flow associated with your application, run the user flow, and enter the requested sign-up or sign-in information.

This feature obtains most of the values it needs to run from the application registration. You can select the application you want to test and specify the browser language for the user interface, but you can generally leave the other fields at their default values.

## Prerequisites

- A **Microsoft Entra external tenant**: You can set up a <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">free trial</a>, or you can create a new external tenant in Microsoft Entra ID.
- A [sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md).
- Your application, which is [registered with Microsoft Entra](how-to-register-ciam-app.md), has a Redirect URI specified, and is [associated with your user flow](how-to-user-flow-add-application.md).

## To test your user flow

Follow these steps to use the **Run user flow** feature to test your user flow.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **Identity** > **External Identities** > **User flows**.

1. Select your user flow from the list. At least one application with a redirect URI must be associated with this user flow (see the [Prerequisites](#prerequisites)).

   > [!NOTE]
   > If the application you want to test hasn't been added to the user flow yet, you can add it now. After adding the application, there may be a short delay before it becomes available for testing with the **Run user flow** feature.

1. Select the **Run user flow** button.

   :::image type="content" source="media/how-to-test-user-flows/run-user-flow-button.png" alt-text="Screenshot showing the Run user flow button.":::

1. In the **Run user flow** pane, most of the fields are populated with values from the application registration, so you can leave the default values. For details about each field, refer to the table below.

   :::image type="content" source="media/how-to-test-user-flows/run-user-flow-pane.png" alt-text="Screenshot showing the Run user flow pane.":::

   |Field    |Description  |
   |---------|---------|
   |**Open Id Configuration URL**     | This value is retrieved from the application registration. It's the publicly accessible URL that was assigned to your application when you registered it with Microsoft Entra ID. This URL points to the OpenID configuration document used by client applications to find authentication URLs and public signing keys. The format is: `https://{tenant}.ciamlogin.com/{tenant}.onmicrosoft.com/v2.0/.well-known/openid-configuration?appid=00001111-aaaa-2222-bbbb-3333cccc4444`        |
   |**Application**     | This menu lists the applications that are associated with this user flow. At least one application is required. If there are multiple applications, select the one you want to test.       |
   |**Reply URL** / **Redirect URI**   | This value is retrieved from the application registration, and is required for the Run user flow feature to work. Keep the current setting, which is the reply URL or redirect URI (depending on the protocol) that is configured for your application. [Learn more](how-to-register-ciam-app.md?tabs=spa#about-redirect-uri)       |
   |**Resource**     | This value is retrieved from the application registration for a protected web API and applies to access tokens. The **Resource** is the globally unique **Application ID URI** that was assigned to the API when it was exposed during app registration ([learn more](~/identity-platform/quickstart-configure-app-expose-web-apis.md)). The access token must contain both the **Resource** and **Scopes** values to allow secure access to the web API.  |
   |**Scopes**     | This value is retrieved from the application registration for a protected web API and applies to access tokens. The **Scopes** are the permissions needed by an application to access the data and functionality in the API. These values are defined when you expose the API during app registration ([learn more](~/identity-platform/quickstart-configure-app-expose-web-apis.md)). The access token must contain both the **Resource** and **Scopes** values to allow secure access to the web API. |
   |**Response type**     | The **Response type** specifies the type of information to be returned in the token issued by the authorization endpoint. The values that are available for **Response type** are based on how the implicit grant and hybrid flows settings are configured in the application registration. If ID tokens are specified (for implicit and hybrid flows), then **id token** is available in this list. If only access tokens are specified (or no tokens are specified), **code** is the only option available.    |
   |**Proof Code for Key Exchange**     | The authorization code flow with Proof Key for Code Exchange (PKCE) is recommended for single-page applications (SPAs). With PKCE, an authorization code is delivered instead of a token to the specified reply URL of the application. To test the PKCE flow, select the **Specify code challenge** check box. Then you can use the autogenerated **Code Verifier**, **Code Challenge method**, and **Code Challenge** values to test the user flow experience. Or you can use the values expected by your application during development so the application can redeem the authorization code for a token. [Learn more](~/identity-platform/v2-oauth2-auth-code-flow.md)        |
   |**Localization**     | To test a specific language, select the **Specify ui locales** option and use **Select target language** menu to choose the language. [Learn more](how-to-customize-languages-customers.md)        |
   |**Run user flow endpoint**     | This URL runs the user flow with the selected options. You can use this URL or select the **Run user flow** button.        |

1. Select the **Run user flow** button, or copy the **Run user flow endpoint** URL into a new browser window.

1. The sign-in page opens, allowing you to test the user experience.
