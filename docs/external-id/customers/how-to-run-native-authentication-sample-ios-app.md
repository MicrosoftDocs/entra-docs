---
title: Run iOS sample app
description: Learn how to configure iOS sample app to sign up, sign in, sign out and reset password scenarios using Microsoft Entra External ID for customers.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: active-directory

ms.subservice: ciam
ms.topic: how-to
ms.date: 02/23/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to learn about how to configure native authentication iOS sample app to sign up, sign in, sign out and reset password scenarios using Microsoft Entra External ID for customers.
---

# How to run the iOS sample app 

This guide shows how to run an iOS sample application that demonstrates sign-up, sign in, sign out, and reset password scenarios using Microsoft Entra External ID for customers. 

In this article, you learn how to: 

- Register application in the Microsoft Entra External ID for customers. 
- Enable public client and native authentication flows. 
- Create user flow in the Microsoft Entra External ID for customers. 
- Associate your application with the user flow. 
- Update a sample native iOS mobile application to use your own Microsoft Entra External ID for customers tenant details. 
- Run and test the sample native iOS mobile application. 

## Prerequisites 

- <a href="https://developer.apple.com/xcode/resources/" target="_blank">Xcode</a> 
- Microsoft Entra External ID for customers tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a> 

## Register an application 

[!INCLUDE [register client app](../customers/includes/register-app/register-client-app-common.md)]

## Enable public client and native authentication flows 

[!INCLUDE [Enable public client and native authentication](../customers/includes/native-auth/enable-native-authentication.md)]

## Grant API permissions 

[!INCLUDE [Grant API permissions](../customers/includes/register-app/grant-native-authentication-api-permission.md)]

## Create a user flow 

[!INCLUDE [Create user flow](../customers/includes/configure-user-flow/create-native-authentication-sign-in-sign-out-user-flow.md)]

## Associate the application with the user flow 
 
[!INCLUDE [associate user flow](../customers/includes/configure-user-flow/add-app-user-flow.md)] 

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

1. In Xcode, open _NativeAuthSampleApp.xcodeproj_ project. 
1. Open _NativeAuthSampleApp/Configuration.swift_ file. 
1. Find the placeholder:

   - `Enter_the_Application_Id_Here` and replace it with the **Application (client) ID** of the app you registered earlier. 
   - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use contoso. If you don't have your tenant subdomain, learn how to [read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details). 

> [!NOTE]
> Remember to select a scheme to build and destination where you run the built products. Each scheme contains a list of real or simulated devices that represent the available destinations. 

## Run and test sample iOS mobile application 

To build and run your code, select **Run** from the **Product** menu in Xcode. After a successful build, Xcode will launch the sample app in the Simulator. 

:::image type="content" source="media/native-authentication/ios/native-auth-sign-in-sign-up.png" alt-text="Screenshot of user prompt to enter email in iOS app." lightbox="media/native-authentication/ios/native-auth-sign-in-sign-up-expanded.png"::: 

This guide tests **Email one-time-passcode** usage. Enter a valid email address, select **Sign Up**, and launch the submit code screen: 

:::image type="content" source="media/native-authentication/ios/enter-one-time-pass-code.png" alt-text="Screenshot of user prompt to enter one-time passcode (OTP) in iOS app." lightbox="media/native-authentication/ios/enter-one-time-pass-code-expanded.png"::: 
 
After you enter your email address on the previous screen, the application will send a verification code to it. Once you submit the received code, the application takes you back to the previous screen and automatically signs you in.  

## Other flows 

The sample app supports the following flows: 

- _Email + one-time passcode_: Follow this flow to sign in or sign up with an email and a one-time passcode. 
- _Email + password_: Follow this flow to sign in or sign up with email and a password. 
- _Email + password sign up with custom attributes_: Follow this flow to sign up with email, password, and custom attributes. 
- _Password reset_: Follow this flow to reset the password. 
- _Fallback to web browser_: Follow this flow to use the browser to sign in or sign up. 
- _Access Protected API_: Follow this flow to call a protected API.

    > [!NOTE]
    > In the [Create a user flow](#create-a-user-flow) section, you created a user flow where you chose **Email one-time passcode** under **Identity providers** > **Email Accounts**. For flows 2 through 4, you require a user flow that uses **Email with password** under **Identity providers** > **Email Accounts**. 

Follow the steps in [Create a user flow](#create-a-user-flow) to create a user flow that uses **Email with password** under **Identity providers** > **Email Accounts**. Remember to [associate the application with the new user flow.](#associate-the-application-with-the-user-flow) 

Alternatively, modify the existing user flow to use **Email with password**. To modify the user flow you created earlier, follow these steps: 

- Select **External Identities** > **User flows** > **SignInSignUpSample** > **Identity providers** > **Email with password** > **Save**. 

After linking your application with the new user flow or modifying the existing user flow, run the application and use the bottom navigation to select different flows for testing. 

## Next steps 

- [Tutorial: Prepare your iOS app for native authentication](tutorial-native-authentication-prepare-ios-app.md). 

