---
title: Sign in users in sample macOS (Swift) app by using native authentication
description: Learn how to configure macOS sample app to sign up and sign in using Microsoft Entra External ID.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: how-to
ms.date: 02/23/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to learn about how to configure native authentication macOS sample app to sign up and sign in scenarios using Microsoft Entra External ID.
---

# Sign in users in sample macOS (Swift) app by using native authentication

This guide shows how to run an macOS sample application that demonstrates sign-up and sign in scenarios using Microsoft Entra External ID. 

In this article, you learn how to: 

- Register application in the external tenant. 
- Enable public client and native authentication flows. 
- Create user flow in the external tenant. 
- Associate your application with the user flow. 
- Update a sample native macOS application to use your own external tenant details. 
- Run and test the sample native macOS application. 

## Prerequisites 

- <a href="https://developer.apple.com/xcode/resources/" target="_blank">Xcode</a> 
- An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a> 

## Register an application 

[!INCLUDE [register client app](../customers/includes/register-app/register-client-app-common.md)]

## Enable public client and native authentication flows 

[!INCLUDE [Enable public client and native authentication](../customers/includes/native-auth/enable-native-authentication.md)]

## Grant admin consent 

[!INCLUDE [Grant API permissions](../customers/includes/register-app/grant-api-permission-sign-in.md)]

## Create a user flow 

[!INCLUDE [Create user flow](../customers/includes/configure-user-flow/create-native-authentication-sign-in-sign-out-user-flow-password.md)]

## Associate the application with the user flow 
 
[!INCLUDE [associate user flow](../customers/includes/configure-user-flow/add-app-user-flow.md)] 

## Clone sample macOS application 

1. Open Terminal and navigate to a directory where you want to keep the code. 
1. Clone the macOS application from GitHub by running the following command: 

   ```bash
   git clone https://github.com/Azure-Samples/ms-identity-ciam-native-auth-macos-sample.git
   ```

1. Navigate to the directory where the repo was cloned: 

   ```bash
   cd ms-identity-ciam-native-auth-macos-sample
   ```

## Configure the sample macOS application 

1. In Xcode, open *NativeAuthSampleAppMacOS.xcodeproj* project. 
1. Open *NativeAuthSampleAppMacOS/Configuration.swift* file. 
1. Find the placeholder:

   - `Enter_the_Application_Id_Here` and replace it with the **Application (client) ID** of the app you registered earlier. 
   - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use contoso. If you don't have your tenant subdomain, learn how to [read your tenant details](how-to-create-external-tenant-portal.md#get-the-external-tenant-details). 

> [!NOTE]
> Remember to select a scheme to build and destination where you run the built products. Each scheme contains a list of real or simulated devices that represent the available destinations. 

## Run and test sample macOS application 

To build and run your code, select **Run** from the **Product** menu in Xcode. After a successful build, Xcode will launch the sample app in the Simulator. 

:::image type="content" source="media/native-authentication/macos/native-auth-sign-in-sign-up-password-macos.png" alt-text="Screenshot of user prompt to enter email and password in macOS app." lightbox="media/native-authentication/macos/native-auth-sign-in-sign-up-password-expanded-macos.png"::: 

This guide tests **Email and password** usage. Enter a valid email address and password, select **Sign Up**, and launch the submit code screen: 

:::image type="content" source="media/native-authentication/macos/enter-one-time-pass-code-expanded-macos.png" alt-text="Screenshot of user prompt to enter one-time passcode (OTP) in macOS app." lightbox="media/native-authentication/macos/enter-one-time-pass-code-macos.png"::: 
 
After you enter your email address on the previous screen, the application will send a verification code to it. Once you submit the received code, the application takes you back to the previous screen and automatically signs you in.  

## Next steps 

- [Tutorial: Prepare your iOS/macOS app for native authentication](tutorial-native-authentication-prepare-ios-app.md).
