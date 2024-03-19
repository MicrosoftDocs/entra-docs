---
title: Sign in users in sample Android (Kotlin) mobile app 
description: Learn how to Authenticate users in a Microsoft Entra ID for customers tenant using a sample Android (Kotlin) application.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: sample
ms.date: 03/19/2024
ms.custom: developer
#Customer intent: As a developer, I want to authenticate users from a sample Android mobile app so that I can experience how Microsoft Entra ID for customers work.
---

# Sign in users in sample Android (Kotlin) mobile app

This guide shows how to run an Android sample application that demonstrates sign-up, sign in, sign out, and password reset scenarios using Microsoft Entra ID for customers. 
  
In this article, you learn how to: 
 
- Register application in the Microsoft Entra External ID for customers tenant.  
- Enable public client and native authentication flows.  
- Create user flow in the Microsoft Entra External ID for customers tenant.  
- Associate your application with the user flow.  
- Update the Android configuration code sample file to use your own Microsoft Entra External ID for customer tenant details.  
- Run and test the sample native Android mobile application.  
 
## Prerequisites  

- <a href="https://developer.android.com/studio/archive" target="_blank">Android Studio Dolphin | 2021.3.1 Patch 1</a>.
- Microsoft Entra External ID for customers tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>. 


## Register an application
 
[!INCLUDE [register client app](../customers/includes/register-app/register-client-app-common.md)]

## Enable public client

[!INCLUDE [Enable public client](../customers/includes/register-app/enable-public-client-flow.md)]

## Grant API permissions
 
[!INCLUDE [Grant API permissions](../customers/includes/register-app/grant-native-authentication-api-permission.md)]

## Create a user flow
 
[!INCLUDE [Create user flow](../customers/includes/configure-user-flow/create-native-authentication-sign-in-sign-out-user-flow.md)]
 
## Associate the app with the user flow

[!INCLUDE [associate user flow](../customers/includes/configure-user-flow/add-app-user-flow.md)]

## Clone sample Android mobile application  

1. Open Terminal and navigate to a directory where you want to keep the code.  
1. Clone the application from GitHub by running the following command:  
 
   ```bash 
   git clone https://github.com/Azure-Samples/ms-identity-ciam-browser-delegated-android-sample
   ```
 
## Configure the sample Android mobile application  
 
1. In Android Studio, open the project that you cloned. 
 
2. Open */app/src/main/res/raw/auth_config_ciam.json* file. 
3. Find the placeholder: 
 
   - `Enter_the_Application_Id_Here` and replace it with the **Application (client) ID** of the app you registered earlier. 
   - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't know your tenant subdomain, learn how to [read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details). 
   
You've now configured the app and it's ready to run. 

## Run and test the sample Android mobile application 
 
To build and run your app, follow these steps:  
 
1. In the toolbar, select your app from the run configurations menu.
  
1. In the target device menu, select the device that you want to run your app on.  
 
   If you don't have any devices configured, you need to either create an Android Virtual Device to use the Android Emulator or connect a physical Android device.  
 
1. Select the **Run** button.

## Related content

- [How to run the Android sample app](how-to-run-native-authentication-sample-android-app.md).
