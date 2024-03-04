---
title: Run Android Kotlin sample app
description: Learn how to configure Android Kotlin sample app to sign up, sign in, sign out and reset password scenarios using Microsoft Entra External ID for customers.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: active-directory

ms.subservice: ciam
ms.topic: how-to
ms.date: 02/29/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to learn about how to configure native authentication Android Kotlin sample app to sign up, sign in, sign out and reset password scenarios using Microsoft Entra External ID for customers.
---

# How to run the Android sample app 

This guide shows how to run an Android sample application that demonstrates sign-up, sign in, sign out, and password reset scenarios using Microsoft Entra External ID for customers. 
  
In this article, you learn how to: 
 
- Register application in the Microsoft Entra External ID for customers tenant.  
- Enable public client and native authentication flows.  
- Create user flow in the Microsoft Entra External ID for customers tenant.  
- Associate your application with the user flow.  
- Edit the Android configuration code sample file to use your own Microsoft Entra External ID for customer tenant details.  
- Run and test the sample native Android Kotlin mobile application.  
 
## Prerequisites  

- <a href="https://developer.android.com/studio/archive" target="_blank">Android Studio Dolphin | 2021.3.1 Patch 1</a>.
- Microsoft Entra External ID for customers tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>. 
 
## Register an application
 
[!INCLUDE [register client app](../customers/includes/register-app/register-client-app-common.md)]
 
## Enable public client and native authentication flows 

[!INCLUDE [Enable public client and native authentication](../customers/includes/native-auth/enable-native-authentication.md)]
 
## Grant API permissions  
 
[!INCLUDE [Grant API permissions](../customers/includes/register-app/grant-native-authentication-api-permission.md)]

## Create a user flow  
 
[!INCLUDE [Create user flow](../customers/includes/configure-user-flow/create-native-authentication-sign-in-sign-out-user-flow.md)]
 
## Associate the  app with the user flow  

[!INCLUDE [associate user flow](../customers/includes/configure-user-flow/add-app-user-flow.md)]  
 
## Clone sample Android mobile application  
 
1. Open Terminal and navigate to a directory where you want to keep the code.  
1. Clone the application from GitHub by running the following command:  
 
   ```bash 
   git clone https://github.com/Azure-Samples/ms-identity-ciam-native-auth-android-sample 
   ``` 
 
## Configure the sample Android mobile application  
 
1. In Android Studio, open the project that you cloned. 
 
2. Open `app/src/main/res/raw/native_auth_sample_app_config.json` file. 
3. Find the placeholder: 
 
   - `Enter_the_Application_Id_Here` and replace it with the **Application (client) ID** of the app you registered earlier. 
   - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't know your tenant subdomain, learn how to [read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details). 
   
The application is now configured and ready to run. 
 
## Run and test sample Android mobile application  
 
To build and run your app, follow these steps:  
 
1. In the toolbar, select your app from the run configurations menu.  
1. In the target device menu, select the device that you want to run your app on.  
 
   If you don't have any devices configured, you need to either create an Android Virtual Device to use the Android Emulator or connect a physical device.  
 
1. Select **Run** button.  
 
1. The app opens on the email and one-time passcode screen.  

    :::image type="content" source="media/native-authentication/android/android-email-otp.png" alt-text="Screenshot of user prompt to enter email in Android application." lightbox="media/native-authentication/android/android-email-otp-expanded.png"::: 
 
1. Enter a valid email address and select **Sign up**. The app launches the submit code screen.  
 
    :::image type="content" source="media/native-authentication/android/android-submit-code.png" alt-text="Screenshot of user prompt to enter one-time passcode in Android application." lightbox="media/native-authentication/android/android-submit-code-expanded.png"::: 
 
1. You receive an email containing a one-time passcode. Enter the one-time passcode and select **Next**. If the sign-up was successful, you'll automatically be signed in. 

    :::image type="content" source="media/native-authentication/android/android-sign-in-account-display.png" alt-text="Screenshot showing sign-in successfully completed in the Android application." lightbox="media/native-authentication/android/android-sign-in-account-display-expanded.png"::: 

1. Select **Sign out** to clear the signed in account from the cache. After signing out, the application will allow a new user to sign up or sign in.  
 
## Other flows  
 
The sample app supports the following flows:  
 
- _Email + one-time passcode_: Follow this flow to sign in or sign up with an email and a one-time passcode. 
- _Email + password_: Follow this flow to sign in or sign up with an email, password, and one-time passcode. 
- _Email + password sign-up with user attributes_: Follow this flow to sign up with email, password, and user attributes. 
- _Password reset_: Follow this flow to reset the password. 
- _Fallback to web browser_: Follow this flow to use the browser to sign in or sign up. 
- _Access Protected API_: Follow this flow to call a protected API.
 
    > [!NOTE] 
    > In the [Create a user flow](#create-a-user-flow) section, you created a user flow where you chose **Email one-time passcode** under **Identity providers > Email Accounts**. For flows 2 through 4, you require a user flow that uses **Email with password** under **Identity providers > Email Accounts**. 
 
Follow the steps in [Create a user flow](#create-a-user-flow) to create a user flow that uses **Email with password** under **Identity providers > Email Accounts**. Remember to [associate the application with the new user flow](#associate-the--app-with-the-user-flow). 

Alternatively, modify the existing user flow to use **Email with password**. To modify the user flow you created earlier, follow these steps: 

- Select **External Identities** > **User flows** > **SignInSignUpSample** > **Identity providers** > **Email with password** > **Save**. 

After linking your application with the new user flow or modifying the existing user flow, run the application and use the bottom navigation to select different flows for testing. 

## Next steps 
 
- [Tutorial: Prepare your Android app for native authentication](tutorial-native-authentication-prepare-android-app.md). 
