---
title: Prepare your iOS (Swift) app for authentication
description: The tutorials provide a step-by-step guide on how to prepare your iOS (Swift) app for authentication.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: sample
ms.date: 05/07/2024
ms.custom: developer
#Customer intent: As a developer, I want to prepare iOS (Swift) app for authentication using Microsoft Entra External ID.
---

# Tutorial: Prepare your iOS (Swift) app for authentication

This tutorial demonstrate how to add Microsoft Authentication Library (MSAL) for iOS and macOS to your iOS Swift app.

In this tutorial, you'll;

> [!div class="checklist"]
>
> - Add the MSAL framework to an iOS (Swift) app.
> - Create SDK instance.

## Prerequisites

- <a href="https://developer.apple.com/xcode/resources/" target="_blank">Xcode</a>.
- If you haven't already, follow the instructions in [Tutorial: Register and configure iOS (Swift) mobile app](tutorial-mobile-app-ios-swift-prepare-tenant.md) and register an app in your external tenant. Make sure you complete the following steps:
    - Register an application.
    - Add a platform redirect URL.
    - Enable public client flow.
    - Delegated permission to Microsoft Graph.
- iOS (Swift) project

## Add the MSAL framework to an iOS (Swift) app

The MSAL authentication SDK is used for integrating authentication into your apps using standard OAuth2 and OpenID Connect. It allows you to sign in users or apps with Microsoft identities. To add MSAL to your iOS (Swift) project, follow these steps:

1. Open your iOS project in Xcode.
1. Select **Add Package Dependencies...** from the **File** menu.
1. Enter `https://github.com/AzureAD/microsoft-authentication-library-for-objc` as the Package URL and choose **Add Package**


## Create SDK instance

1. Import the MSAL library into your view controller by adding `import MSAL` at the top of your `ViewController` class.
1. Add a `applicationContext` member variable to your ViewController class by adding the following code just before the `viewDidLoad()` function:
    
    ```swift
    var applicationContext : MSALPublicClientApplication?
    ```

1. Add the following code to the view `viewDidLoad()` function:

    ```swift
     do {
            try self.initMSAL()
        } catch let error {
            self.updateLogging(text: "Unable to create Application Context \(error)")
        }
    ``` 

1. Add the following code that creates `initMSAL()` which initialize MSAL:

    ```swift
        func initMSAL() throws {
        
        guard let authorityURL = URL(string: Configuration.kAuthority) else {
            self.updateLogging(text: "Unable to create authority URL")
            return
        }
        
        let authority = try MSALCIAMAuthority(url: authorityURL)
        
        let msalConfiguration = MSALPublicClientApplicationConfig(clientId: Configuration.kClientID,
                                                                  redirectUri: Configuration.kRedirectUri,
                                                                  authority: authority)
        self.applicationContext = try MSALPublicClientApplication(configuration: msalConfiguration)
    }
    ```
    
    This code initializes the MSAL for iOS. It first attempts to create a URL for the authority using the provided _Configuration.kAuthority_ string. If successful, it creates an MSAL authority object based on that URL. Then, it configures the `MSALPublicClientApplication` with the given client ID, redirect URI, and authority. If all configurations are set up correctly, it initializes the application context with the configured `MSALPublicClientApplication`. If any errors occur during the process, it throws an error.

1. Create `Configuration.swift` file and the following configurations:

    ```swift
    import Foundation

    @objcMembers
    class Configuration: NSObject {
        static let kTenantSubdomain = "Enter_the_Tenant_Subdomain_Here"
        
        // Update the below to your client ID you received in the portal.
        static let kClientID = "Enter_the_Application_Id_Here"
        static let kRedirectUri = "Enter_the_Redirect_URI_Here"
        static let kProtectedAPIEndpoint = "Enter_the_Protected_API_Full_URL_Here"
        static let kScopes: [String] = ["Enter_the_Protected_API_Scopes_Here"]
        
        static let kAuthority = "https://\(kTenantSubdomain).ciamlogin.com"
    
    }
    ```
    
    This Swift configuration code defines a class named `Configuration` that inherits from `NSObject` and is marked with `@objcMembers`. It includes static constants for various configuration parameters related to an authentication setup. These parameters include the _tenant subdomain_, _client ID_, _redirect URI_, _protected API endpoint_, and _scopes_.

    Find the placeholder:

    - `Enter_the_Application_Id_Here` and replace it with the **Application (client) ID** of the app you registered earlier.
    - `Enter_the_Redirect_URI_Here` and replace it with the value of *kRedirectUri* in the MSAL configuration file you downloaded earlier when you added the platform redirect URL.
    - `Enter_the_Protected_API_Scopes_Here` and replace it with the scopes recorded earlier. If you haven't recorded any scopes, you can leave this scope list empty.
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't know your tenant subdomain, learn how to [read your tenant details](how-to-create-external-tenant-portal.md#get-the-external-tenant-details).

## Next steps

[Tutorial: Sign in users in iOS (Swift) mobile app](tutorial-mobile-app-ios-swift-sign-in.md)
