---
title: Run Android Kotlin sample app
description: Learn how to configure Android Kotlin sample app to sign up, sign in, sign out and reset password scenarios using Microsoft Entra External ID for customers.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: active-directory

ms.subservice: ciam
ms.topic: how-to
ms.date: 11/29/2023
ms.custom: developer, devx-track-dotnet
#Customer intent: As a dev, devops, I want to learn about how to configure native auth Android Kotlin sample app to sign up, sign in, sign out and reset password scenarios using Microsoft Entra External ID for customers.
---

# How to run the Android sample app

# How to run the Android sample app
 
This guide demonstrates how to run an Android sample application that showcases sign up, sign in, sign out and reset password scenarios using Microsoft Entra External ID for customers.
 
In this article, you learn how to:
 
- Register application in the Microsoft Entra External ID for customers tenant. 
- Enable public client and native authentication flows. 
- Create a sign-in and sign-out user flow in the Microsoft Entra External ID for customers tenant. 
- Associate your application with the user flow. 
- Edit the Android configuration code sample file to use your own Microsoft Entra External ID for customer tenant details. 
- Run and test the sample native Android Kotlin mobile application. 
 
## Prerequisites 

- <a href="https://developer.android.com/studio/archive" target="_blank">Android Studio Dolphin | 2021.3.1 Patch 1</a> 
- Microsoft Entra External ID for customers tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>.
 
## Register an application
 
To enable your application to sign in users with Microsoft Entra, Microsoft Entra External ID for customers must be made aware of the application you create. The app registration establishes a trust relationship between the app and Microsoft Entra. When you register an application, Microsoft Entra External ID generates a unique identifier known as an **Application (client) ID**, a value used to identify your app when creating authentication requests. 

The following steps show you how to register your app in the Microsoft Entra admin center: 
 
1. Sign in to the <a href="https://entra.microsoft.com/" target="_blank">Microsoft Entra admin center</a>.
1. If you have access to multiple tenants, make sure you use the directory that contains your Microsoft Entra External ID for customers tenant: 
 
   1. Select the **Directories + subscriptions** icon <img type="icon" src="../media/portal-directory-subscription-filter.png"> in the toolbar. 
   1. On the **Portal settings | Directories + subscriptions** page, find your Microsoft Entra External ID for customers directory in the **Directory name** list, and then select **Switch**. 
 
1. On the sidebar menu, select **Identity**. 
1. Select **Applications** > **App Registrations**. 
1. Select **+ New registration**. 
1. In the **Register an application** page that appears; 
 
   1. Enter a meaningful application **Name** that will be displayed to users of the app, for example _ciam-client-app_. 
   1. Under **Supported account types**, select **Accounts in this organizational directory only**. 
 
1. Select **Register**. 
1. The application's **Overview** pane will display upon successful registration. Record the **Application (client) ID** to be used in your application source code.
 
## Enable public client and native authentication flows
 
To specify that this app is a public client and can use native authentication, enable public client and native authentication flows: 

1. Select the created application from the App registrations page 
2. Under **Manage**, select **Authentication**. 
3. Under **Advanced settings**, for **Enable the following mobile and desktop flows**, select **Yes**.
4. Under **Advanced settings**, for **Enable native authentication**, select **Yes**.
5. Select **Save** button. 
 
## Grant API permissions 
 
1. From the **App registrations** page, select the application that you created (such as _ciam-client-app_) to open its **Overview** page. 
1. Under **Manage**, select **API permissions**. 
1. Under **Configured permissions**, select **Add a permission**. 
1. Select **Microsoft APIs** tab. 
1. Under **Commonly used Microsoft APIs** section, select **Microsoft Graph**. 
1. Select **Delegated permissions** option. 
1. Under **Select permissions** section, search for and select **offline_access**, **openid**, and **profile** permissions. 
1. Select the **Add permissions** button. 
1. At this point, you've assigned the permissions correctly. However, since the tenant is a customer's tenant, the consumer users themselves can't consent to these permissions. You as the admin must consent to these permissions on behalf of all the users in the tenant: 
 
   1. Select **Grant admin consent for <your tenant name>**, then select **Yes**. 
   1. Select **Refresh**, then verify that **Granted for<your tenant name>** appears under **Status** for both scopes. 
 
    :::image type="content" source="media/native-auth/android/api-permissions.jpg" alt-text="Screenshot showing configured permission in Microsoft Entra admin center":::

## Create a user flow 
 
Follow these steps to create a user flow. 
 
1. Sign in to the <a href="https://entra.microsoft.com/" target="_blank">Microsoft Entra admin center</a>. 
1. If you have access to multiple tenants, make sure you use the directory that contains your Microsoft Entra External ID for customers tenant: 
 
   1. Select the **Directories + subscriptions** icon in the toolbar. 
   1. On the **Portal settings | Directories + subscriptions** page, find your Microsoft Entra External ID for customers directory in the **Directory name** list, and then select **Switch**. 
 
1. On the sidebar menu, select **Identity**. 
1. Select **External Identities** > **User flows**. 
1. Select **+ New user flow**. 
1. On the **Create** page: 
 
   1. Enter a **Name** for the user flow, such as _SignInSignUpSample_. 
   1. In the **Identity providers** list, select **Email Accounts**. This identity provider allows users to sign-in or sign-up using their email address. 
   1. Under **Email accounts**, you can select one of the two options. For this tutorial, select **Email one-time passcode**. 
 
      - **Email with password**: Allows new users to sign up and sign in using an email address as the sign-in name and a password as their first factor credential. 
      - **Email one-time passcode**: Allows new users to sign up and sign in using an email address as the sign-in name and email one-time passcode as their first factor credential. 
 
        > [!NOTE] 
        > Email one-time passcode must be enabled at the tenant level (**All Identity Providers** > **Email One-time passcode**) for this option to be available at the user flow level. 
 
   1. Under **User attributes**, you can choose the attributes you want to collect from the user upon sign-up. For this guide select **Country/Region** and **City**. 
   1. Select **OK**. (Users can be prompted for attributes when they sign up for the first time)
 
1. Select **Create**. The new user flow appears in the **User flows** list. If necessary, refresh the page. 
 
## Associate the  app with the user flow 
 
Although many applications can be associated with your user flow, a single application can only be associated with one user flow.

To associate your user flow with your app, follow these steps.

1. On the sidebar menu, select **Identity**. 
1. Select **External Identities**, then **User flows**. 
1. In the **User flows** page, select the **User flow name** you created earlier, for example, _SignInSignUpSample_. 
1. Under **Use**, select **Applications**. 
1. Select **Add application**. 
1. Select the application from the list such as _ciam-client-app_ or use the search box to find the application, and then select it. 
 
1. Choose **Select**. 
 
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
 
   1. `Enter_the_Application_Id_Here` and replace it with the **Application (client) ID** of the app you registered earlier. 
   2. `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't know your tenant subdomain, learn how to [read your tenant details](https://learn.microsoft.com/azure/active-directory/external-identities/customers/how-to-create-customer-tenant-portal#get-the-customer-tenant-details).
   
   The application is now configured and ready to run.
 
## Run and test sample Android mobile application 
 
To build and run your app, follow these steps: 
 
1. In the toolbar, select your app from the run configurations menu. 
1. In the target device menu, select the device that you want to run your app on. 
 
   If you don't have any devices configured, you need to either create an Android Virtual Device to use the Android Emulator or connect a physical device. 
 
1. Select **Run** button. 
 
1. The app will open on the email and one-time passcode screen. 

    :::image type="content" source="media/native-auth/android/android-email-otp.png" alt-text="Screenshot of user prompt to enter email in Android application.":::
 
1. Enter a valid email address and select **Sign up**. The app will launch submit code screen. 
 
    :::image type="content" source="media/native-auth/android/android-submit-code.png" alt-text="Screenshot of user prompt to enter OTP in Android application.":::
 
1. You'll receive an email containing a one-time passcode. Enter the one-time passcode and select **Next**. If the sign-up was successful, you will automatically be signed in.

    :::image type="content" source="media/native-auth/android/android-sign-in-account-display.png" alt-text="Screenshot showing sign-in successfully completed in the Android application.":::

1. Select **Sign out** to clear the signed in account from the cache. After signing out, the application will allow a new user to sign up or sign in. 
 
### Other flows 
 
The sample app supports the following flows: 
 
1. _Email + one-time passcode_: Follow this flow to sign in or sign up with an email and a one-time passcode. 
1. _Email + password_: Follow this flow to sign in or sign up with an email, password and one-time passcode. 
1. _Email + password sign up with user attributes_: Follow this flow to sign up with email, password and user attributes. 
1. _Password reset_: Follow this flow to reset the password. 
1. _Fallback to web browser_: Follow this flow to use the browser to sign in or sign up. 
 
    > [!NOTE] 
    > In the [Create a user flow](#create-a-user-flow) section, you created a user flow where you chose **Email one-time passcode** under **Identity providers > Email Accounts**. For flows 2 through 4, you require a user flow that uses **Email with password** under **Identity providers > Email Accounts**.
 
Follow the steps in [Create a user flow](#create-a-user-flow) to create a user flow that uses **Email with password** under **Identity providers > Email Accounts**. Remember to [associate the application with the new user flow](#associate-the-app-with-the-user-flow).

Alternatively, modify the existing user flow to use **Email with password**. To modify the user flow you created earlier, follow these steps:

- Select **External Identities** > **User flows** > **SignInSignUpSample** > **Identity providers** > **Email with password** > **Save**.

After linking your application with the new user flow or modifying the existing user flow, run the application and use the bottom navigation to select different flows for testing.

## Next steps 
 
- Tutorial: Prepare your Android app for native authentication.
