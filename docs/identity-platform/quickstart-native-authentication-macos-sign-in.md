---
title: Sign in users in sample macOS (Swift) app by using native authentication
description: Learn how to configure macOS (Swift) sample app to sign up and sign in using Microsoft Entra External ID.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: external
ms.topic: how-to
ms.date: 02/23/2024
ms.custom:
#Customer intent: As a dev, devops, I want to learn about how to configure native authentication macOS sample app to sign up and sign in scenarios using Microsoft Entra External ID.
---

# Sign in users in sample macOS app by using native authentication

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

This guide shows how to run an macOS sample application that demonstrates sign-up and sign in scenarios using Microsoft Entra External ID. 

In this article, you learn how to: 

- Enable public client and native authentication flows. 
- Update a sample native macOS application to use your own external tenant details. 
- Run and test the sample native macOS application. 

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
   - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use contoso. If you don't have your tenant subdomain, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details). 

> [!NOTE]
> Remember to select a scheme to build and destination where you run the built products. Each scheme contains a list of real or simulated devices that represent the available destinations. 

## Run and test sample macOS application 

To build and run your code, select **Run** from the **Product** menu in Xcode. After a successful build, Xcode will launch the sample app in the Simulator. 

:::image type="content" source="media/native-authentication/macos/native-auth-sign-in-sign-up-password-macos.png" alt-text="Screenshot of user prompt to enter email and password in macOS app." lightbox="media/native-authentication/macos/native-auth-sign-in-sign-up-password-expanded-macos.png"::: 

This guide tests **Email and password** usage. Enter a valid email address and password, select **Sign Up**, and launch the submit code screen: 

:::image type="content" source="media/native-authentication/macos/enter-one-time-pass-code-macos.png" alt-text="Screenshot of user prompt to enter one-time passcode (OTP) in macOS app." lightbox="media/native-authentication/macos/enter-one-time-pass-code-expanded-macos.png"::: 
 
After you enter your email address on the previous screen, the application will send a verification code to it. Once you submit the received code, the application takes you back to the previous screen and automatically signs you in.  

## Next steps 

- [Tutorial: Prepare your iOS/macOS app for native authentication](../external-id/customers/tutorial-native-authentication-prepare-ios-macos-app.md).
