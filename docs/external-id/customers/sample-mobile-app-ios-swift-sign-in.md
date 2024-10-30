---
title: Sign in users in sample iOS (Swift) mobile app 
description: Learn how to authenticate users in an external tenant using a sample iOS (Swift) application.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: external
ms.topic: quickstart
ms.date: 04/04/2024
ms.custom: developer
#Customer intent: As a developer, I want to authenticate users from a sample iOS mobile app so that I can experience how Microsoft Entra External ID works.
---

# Sign in users in sample iOS (Swift) mobile app

This guide demonstrates how to configure a sample iOS mobile application to sign in users.

In this article, you do the following tasks: 

- Register an application in the Microsoft Entra admin center.
- Add a platform redirect URL.
- Enable public client flows.   
- Update the iOS configuration code sample file to use your own Microsoft Entra External ID for external tenant details.  
- Run and test the sample iOS mobile application.  

## Prerequisites  

- <a href="https://developer.apple.com/xcode/resources/" target="_blank">Xcode</a>.
- An external tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a>.

## Register an application

[!INCLUDE [register client app](../customers/includes/register-app/register-client-app-common.md)]

## Add a platform redirect URL

[!INCLUDE [Enable public client](../customers/includes/register-app/add-platform-redirect-url-ios.md)]

## Enable public client flow

[!INCLUDE [Enable public client](../customers/includes/register-app/enable-public-client-flow.md)]

## Grant admin consent

[!INCLUDE [Grant API permissions](../customers/includes/register-app/grant-api-permission-sign-in.md)]

## Clone sample iOS mobile application

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

   ```console 
   git clone https://github.com/Azure-Samples/ms-identity-ciam-browser-delegated-ios-sample.git
   ```

## Configure the sample iOS mobile application

To enable authentication and access to Microsoft Graph resources, configure the sample by following these steps:

1. In Xcode, open the project that you cloned.
1. Open */MSALiOS/Configuration.swift* file.
1. Find the placeholder:

    - `Enter_the_Application_Id_Here` and replace it with the **Application (client) ID** of the app you registered earlier.
    - `Enter_the_Redirect_URI_Here` and replace it with the value of *kRedirectUri* in the Microsoft Authentication Library (MSAL) configuration file you downloaded earlier when you added the platform redirect URL.
    - `Enter_the_Protected_API_Scopes_Here` and replace it with the scopes recorded in [Grant admin concent](#grant-admin-consent). If you haven't recorded any scopes, you can leave this scope list empty.
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't know your tenant subdomain, learn how to [read your tenant details](how-to-create-external-tenant-portal.md#get-the-external-tenant-details).


You've configured the app and it's ready to run.

## Run and test the iOS sample app
 
To build and run your app, follow these steps:
 
1. To build and run your code, select **Run** from the **Product** menu in Xcode. After a successful build, Xcode will launch the sample app in the Simulator.
1. Select **Acquire Token Interactively** to request an access token.
1. If you select **API - Perform GET** to call a protected ASP.NET Core web API, you will get an error. 

For more information about calling a protected web API, see our [Next steps](#next-steps) 

## Next steps

- [Sign in users and call a protected web API in sample iOS (Swift) app](sample-mobile-app-ios-swift-sign-in-call-api.md).
