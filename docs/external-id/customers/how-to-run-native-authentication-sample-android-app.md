---
title: Sign in users in Android mobile app by using native authentication.
description: Learn how to configure a sample Android Kotlin sample app to sign in customer users by using Microsoft Entra's native authentication.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id 
ms.subservice: customers
ms.topic: how-to
ms.date: 02/29/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to configure native authentication Android Kotlin sample app enable customer users to sign up, sign in, sign out and reset password by using Microsoft Entra's native authentication.
---

# Sign in users in sample Android (Kotlin) mobile app by using native authentication

This guide shows how to run an Android sample application that demonstrates sign-up, sign in, sign out, and password reset scenarios using Microsoft Entra's [native authentication](concept-native-authentication.md). 
  
In this article, you learn how to: 
 
- Register application in the external tenant.  
- Enable public client and native authentication flows.  
- Create user flow in the external tenant.  
- Associate your application with the user flow.  
- Update the Android configuration code sample file to use your own Microsoft Entra External ID for external tenant details.  
- Run and test the sample native Android mobile application.  
 
## Prerequisites  

- <a href="https://developer.android.com/studio" target="_blank">Android Studio</a>.
- An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>. 
 
## Register an application
 
[!INCLUDE [register client app](../customers/includes/register-app/register-client-app-common.md)]
 
## Enable public client and native authentication flows 

[!INCLUDE [Enable public client and native authentication](../customers/includes/native-auth/enable-native-authentication.md)]
 
## Grant admin consent
 
[!INCLUDE [Grant API permissions](../customers/includes/register-app/grant-api-permission-sign-in.md)]

## Create a user flow
 
[!INCLUDE [Create user flow](../customers/includes/configure-user-flow/create-native-authentication-sign-in-sign-out-user-flow.md)]
 
## Associate the app with the user flow

[!INCLUDE [associate user flow](../customers/includes/configure-user-flow/add-app-user-flow.md)]  
 
## Clone sample Android mobile application
 
1. Open Terminal and navigate to a directory where you want to keep the code.  
1. Clone the application from GitHub by running the following command:  
 
   ```bash 
   git clone https://github.com/Azure-Samples/ms-identity-ciam-native-auth-android-sample 
   ``` 
 
## Configure the sample Android mobile application  
 
1. In Android Studio, open the project that you cloned. 
 
2. Open *app/src/main/res/raw/native_auth_sample_app_config.json* file. 
3. Find the placeholder: 
 
   - `Enter_the_Application_Id_Here` and replace it with the **Application (client) ID** of the app you registered earlier. 
   - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't know your tenant subdomain, learn how to [read your tenant details](how-to-create-external-tenant-portal.md#get-the-external-tenant-details). 
   
You've now configured the app and it's ready to run. 
 
## Run and test the sample Android mobile application 
 
To build and run your app, follow these steps:  
 
1. In the toolbar, select your app from the run configurations menu.
  
1. In the target device menu, select the device that you want to run your app on.  
 
   If you don't have any devices configured, you need to either create an Android Virtual Device to use the Android Emulator or connect a physical Android device.  
 
1. Select the **Run** button. The app opens the **Email & OTP** screen.  

    :::image type="content" source="media/native-authentication/android/android-email-otp.png" alt-text="Screenshot of user prompt to enter email in Android application." lightbox="media/native-authentication/android/android-email-otp-expanded.png"::: 
 
1. Enter a valid email address and select then **Sign up** button. The app opens the submit code screen and you receive an OTP code in the email address.  
 
    :::image type="content" source="media/native-authentication/android/android-submit-code.png" alt-text="Screenshot of user prompt to enter one-time passcode in Android application." lightbox="media/native-authentication/android/android-submit-code-expanded.png"::: 
 
1. Enter the OTP code that you receive in the email inbox and select **Next**. If the sign-up is successful, the app signs you in automatically. If you don't receive the OTP code in your email inbox, you can resend it after a while by selecting **Resend Passcode**.

    :::image type="content" source="media/native-authentication/android/android-sign-in-account-display.png" alt-text="Screenshot showing sign-in successfully completed in the Android application." lightbox="media/native-authentication/android/android-sign-in-account-display-expanded.png"::: 

1. To sign out, select the **Sign out** button. 
 
### Other scenarios that this sample supports 
 
This sample app also supports the following authentication flows:  
 
- **Email + password** covers sign-in or sign-up flows with an email with password. 
- **Email + password sign-up with user attributes** covers sign-up with email and password, and submitting user attributes. 
- **Password reset** covers self-service password reset (SSPR). 
- **Access Protected API** covers call a protected API after the user successfully signs up or signs in and acquires an access token.
- **Fallback to web browser** covers the use the browser-based authentication as a fallback mechanism when the user can't complete authentication through native authentication for whatever reason. 


## Test email with password flow

In this section, you test email with password flow, with its variants such as, email with password sign-up with user attributes and SSPR:

1. Use the steps in [create a user flow](#create-a-user-flow) to create a new user flow, but this time select **Email with password** as your authentication method. You need to configure **Country/Region** and **City** as the user attributes. Alternatively, you can modify the existing user flow to use **Email with password** (Select **External Identities** > **User flows** > **SignInSignUpSample** > **Identity providers** > **Email with password** > **Save**).  

1. Use the steps in [associate the application with the new user flow](#associate-the-app-with-the-user-flow) to add an app to your new user flow. 

1. Run the sample app, then select the ellipsis menu (**...**) to open more options. 

1. Select the scenario you want to test, such as **Email + password** or **Email + password sign-up with user attributes** or **Password reset**, then follow the prompts. To test **Password reset**, you need to first sign up a user, and [enable email one-time passcode](how-to-enable-password-reset-customers.md) for all users in your tenant.

## Test call a protected API flow

Use the steps in [Call a protected web API in a sample Android mobile app by using native authentication](sample-native-authentication-android-sample-app-call-web-api.md) to call a protected web API from a sample Android mobile app.
 

## Next steps
 
- [Tutorial: Prepare your Android app for native authentication](tutorial-native-authentication-prepare-android-app.md).
