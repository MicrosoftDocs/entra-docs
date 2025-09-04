---
title: Sign in users in sample iOS (Swift) app by using native authentication
description: Learn how to configure iOS (Swift) sample app to sign up, sign in, sign out and reset password scenarios using Microsoft Entra External ID.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: identity-platform

ms.subservice: external
ms.topic: how-to
ms.date: 02/23/2024
ms.custom:
#Customer intent: As a dev, devops, I want to learn about how to configure native authentication iOS sample app to sign up, sign in, sign out and reset password scenarios using Microsoft Entra External ID.
---

# Sign in users in sample iOS (Swift) mobile app by using native authentication

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this quickstart you learn how to run an iOS sample application that demonstrates sign-up, sign in, sign out, and reset password scenarios using Microsoft Entra External ID. 

## Prerequisites 

* An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a> 
* This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
  * Application Administrator
  * Application Developer
* An external tenant. If you don't have one, [create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.

* If you haven't already done so, [Register an application in the Microsoft Entra admin center](quickstart-register-app.md). Make sure to:

    * Record the **Application (client) ID** and **Directory (tenant) ID** for later use.
    * [Grant admin consent](quickstart-register-app.md#grant-admin-consent-external-tenants-only) to the application.

* If you haven't already done so, [Create a user flow in the Microsoft Entra admin center](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md)
* [Associate your app registration with the user flow](/entra/external-id/customers/how-to-user-flow-add-application)
* <a href="https://developer.apple.com/xcode/resources/" target="_blank">Xcode</a> 

## Enable public client and native authentication flows 

[!INCLUDE [Enable public client and native authentication](../external-id/customers/includes/native-auth/enable-native-authentication.md)]

## Clone sample iOS mobile application 

1. Open Terminal and navigate to a directory where you want to keep the code. 
1. Clone the iOS mobile application from GitHub by running the following command: 

   ```bash
   git clone https://github.com/Azure-Samples/ms-identity-ciam-native-auth-ios-sample.git
   ```

1. Navigate to the directory where the repo was cloned: 

   ```bash
   cd ms-identity-ciam-native-auth-ios-sample
   ```

## Configure the sample iOS mobile application 

1. In Xcode, open *NativeAuthSampleApp.xcodeproj* project. 
1. Open *NativeAuthSampleApp/Configuration.swift* file. 
1. Find the placeholder:

   - `Enter_the_Application_Id_Here` and replace it with the **Application (client) ID** of the app you registered earlier. 
   - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use contoso. If you don't have your tenant subdomain, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details). 

> [!NOTE]
> Remember to select a scheme to build and destination where you run the built products. Each scheme contains a list of real or simulated devices that represent the available destinations. 

## Run and test sample iOS mobile application 

To build and run your code, select **Run** from the **Product** menu in Xcode. After a successful build, Xcode will launch the sample app in the Simulator. 

:::image type="content" source="media/native-authentication/ios/native-auth-sign-in-sign-up.png" alt-text="Screenshot of user prompt to enter email in iOS app." lightbox="media/native-authentication/ios/native-auth-sign-in-sign-up-expanded.png"::: 

This guide tests **Email one-time-passcode** usage. Enter a valid email address, select **Sign Up**, and launch the submit code screen: 

:::image type="content" source="media/native-authentication/ios/enter-one-time-pass-code.png" alt-text="Screenshot of user prompt to enter one-time passcode (OTP) in iOS app." lightbox="media/native-authentication/ios/enter-one-time-pass-code-expanded.png"::: 
 
After you enter your email address on the previous screen, the application will send a verification code to it. Once you submit the received code, the application takes you back to the previous screen and automatically signs you in.  

## Other scenarios that this sample supports 

The sample app supports the following flows: 

- **Email + password** covers sign-in or sign-up flows with an email with password. 
- **Email + password sign-up with user attributes** covers sign-up with email and password, and submitting user attributes. 
- **Password reset** covers self-service password reset (SSPR). 
- **Access Protected API** covers call a protected API after the user successfully signs up or signs in and acquires an access token.
- **Fallback to web browser** covers the use the browser-based authentication as a fallback mechanism when the user can't complete authentication through native authentication for whatever reason. 

## Test email with password flow

In this section, you test email with password flow, with its variants such as, email with password sign-up with user attributes and SSPR:

1. Use the steps in [create a user flow](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md) to create a new user flow, but this time select **Email with password** as your authentication method. You need to configure **Country/Region** and **City** as the user attributes. Alternatively, you can modify the existing user flow to use **Email with password** (Select **External Identities** > **User flows** > **SignInSignUpSample** > **Identity providers** > **Email with password** > **Save**).  

1. Use the steps in [associate the application with the new user flow](../external-id/customers/how-to-user-flow-add-application.md) to add an app to your new user flow. 

1. Run the sample app, then select the ellipsis menu (**...**) to open more options. 

1. Select the scenario you want to test, such as **Email + password** or **Email + password sign-up with user attributes** or **Password reset**, then follow the prompts. To test **Password reset**, you need to first sign up a user, and [enable email one-time passcode](../external-id/customers/how-to-enable-password-reset-customers.md) for all users in your tenant.

## Test call a protected API flow

Use the steps in [Call a protected web API in a sample iOS mobile app by using native authentication](quickstart-native-authentication-ios-call-api.md) to call a protected web API from a sample Android mobile app.

## Next steps 

> [!div class="nextstepaction"]
> [Tutorial: Prepare your iOS/macOS app for native authentication](../external-id/customers/tutorial-native-authentication-prepare-ios-macos-app.md). 
