---
title: Sign in users iOS (Swift) app for authentication
description: The tutorials provide a step-by-step guide on how to sign in users in iOS (Swift) app for authentication.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: sample
ms.date: 05/09/2024
ms.custom: developer
#Customer intent: As a developer, I want to sign in users in iOS (Swift) app for authentication using Microsoft Entra External ID.
---

# Tutorial: Sign in users in iOS (Swift) mobile app

This is the third tutorial in the tutorial series that guides you on signing in users using Microsoft Entra External ID.

In this tutorial, you'll:

> [!div class="checklist"]
>
> - Sign in user.
> - Sign out user.

## Prerequisites

- [Tutorial: Prepare your iOS (Swift) app for authentication](tutorial-mobile-app-ios-swift-prepare-app.md)

## Sign in user

You have two main options for signing in users using Microsoft Authentication Library (MSAL) for iOS: acquiring tokens interactively or silently.

1. To sign in user interactively, use the following code:

    ```swift
    acquireTokenInteractively() {
        guard let applicationContext = self.applicationContext else { return }
        guard let webViewParameters = self.webViewParamaters else { return }
        
        updateLogging(text: "Acquiring token interactively...")

        let parameters = MSALInteractiveTokenParameters(scopes: Configuration.kScopes, webviewParameters: webViewParameters)
        parameters.promptType = .selectAccount
        
        applicationContext.acquireToken(with: parameters) { (result, error) in
            
            if let error = error {
                
                self.updateLogging(text: "Could not acquire token: \(error)")
                return
            }
            
            guard let result = result else {
                
                self.updateLogging(text: "Could not acquire token: No result returned")
                return
            }
            
            self.accessToken = result.accessToken
            self.updateLogging(text: "Access token is \(self.accessToken)")
            self.updateCurrentAccount(account: result.account)
        }
    }
    ```
    
    The code first checks if the application context and web view parameters are available. Then, it updates the logging to indicate that it's acquiring the token interactively. Next, it sets up parameters for interactive token acquisition, specifying the scopes and web view parameters. It also sets the prompt type to select an account.
    
    Afterwards, it calls the `acquireToken` method on the application context with the defined parameters. In the completion handler, it checks for any errors. If an error is encountered, it updates the logging with the error message. If successful, it retrieves the access token from the result, updates the logging with the token, and updates the current account.

    Once your app acquires an access token, you can retrieve the claims associated with the current account. To do so, use the following code snippet:
    
    ```swift
    let claims = result.account.accountClaims
    let preferredUsername = claims?["preferred_username"] as? String
    ```
    
    The code reads claims from the account by accessing the `accountClaims` property of the `result.account` object. It then retrieves the value of the "preferred_username" claim from the claims dictionary and assigns it to the `preferredUsername` variable.

1. To sign in user silently, use the following code:

    ```swift
    func acquireTokenSilently() {
        self.loadCurrentAccount { (account) in
            
            guard let currentAccount = account else {
                
                self.updateLogging(text: "No token found, try to acquire a token interactively first")
                return
            }
            
            self.acquireTokenSilently(currentAccount)
        }
    }
    ```
    
    The code initiates the process of acquiring tokens silently. It first attempts to load the current account. If a current account is found, it proceeds to acquire the token silently using that account. If no current account is found, it updates the logging to indicate that no token is found and suggests trying to acquire a token interactively first. 

    In code above we're calling two function, `loadCurrentAccount` and `acquireTokenSilently`. The `loadCurrentAccount` function should have the following code:

    ```swift
    func loadCurrentAccount(completion: AccountCompletion? = nil) {
        
        guard let applicationContext = self.applicationContext else { return }
        
        let msalParameters = MSALParameters()
        msalParameters.completionBlockQueue = DispatchQueue.main
                
        // Note that this sample showcases an app that signs in a single account at a time
        applicationContext.getCurrentAccount(with: msalParameters, completionBlock: { (currentAccount, previousAccount, error) in
            
            if let error = error {
                self.updateLogging(text: "Couldn't query current account with error: \(error)")
                return
            }
            
            if let currentAccount = currentAccount {
                
                self.updateCurrentAccount(account: currentAccount)
                self.acquireTokenSilently(currentAccount)
                
                if let completion = completion {
                    completion(self.currentAccount)
                }
                
                return
            }
            
            // If testing with Microsoft's shared device mode, see the account that has been signed out from another app. More details here:
            // https://docs.microsoft.com/en-us/azure/active-directory/develop/msal-ios-shared-devices
            if let previousAccount = previousAccount {
                
                self.updateLogging(text: "The account with username \(String(describing: previousAccount.username)) has been signed out.")
                
            } else {
                
                self.updateLogging(text: "")
            }
            
            self.accessToken = ""
            self.updateCurrentAccount(account: nil)
            
            if let completion = completion {
                completion(nil)
            }
        })
    }
    ```
    
    
    The code uses MSAL for iOS to load the current account. It checks for errors and updates the logging accordingly. If a current account is found, it updates it and attempts to acquire tokens silently. If a previous account exists, it logs the sign out. If no accounts are found, it clears the access token. Finally, it executes a completion block if provided. 

    The `acquireTokenSilently` function should contain the following code:

    ```swift
    func acquireTokenSilently(_ account : MSALAccount) {
        guard let applicationContext = self.applicationContext else { return }
        
        /**
         
         Acquire a token for an existing account silently
         
         - forScopes:           Permissions you want included in the access token received
         in the result in the completionBlock. Not all scopes are
         guaranteed to be included in the access token returned.
         - account:             An account object that we retrieved from the application object before that the
         authentication flow will be locked down to.
         - completionBlock:     The completion block that will be called when the authentication
         flow completes, or encounters an error.
         */
        
        updateLogging(text: "Acquiring token silently...")
        
        let parameters = MSALSilentTokenParameters(scopes: Configuration.kScopes, account: account)
        
        applicationContext.acquireTokenSilent(with: parameters) { (result, error) in
            
            if let error = error {
                
                let nsError = error as NSError
                
                // interactionRequired means we need to ask the user to sign-in. This usually happens
                // when the user's Refresh Token is expired or if the user has changed their password
                // among other possible reasons.
                
                if (nsError.domain == MSALErrorDomain) {
                    
                    if (nsError.code == MSALError.interactionRequired.rawValue) {
                        
                        DispatchQueue.main.async {
                            self.acquireTokenInteractively()
                        }
                        return
                    }
                }
                
                self.updateLogging(text: "Could not acquire token silently: \(error)")
                return
            }
            
            guard let result = result else {
                
                self.updateLogging(text: "Could not acquire token: No result returned")
                return
            }
            
            self.accessToken = result.accessToken
            self.updateLogging(text: "Refreshed Access token is \(self.accessToken)")
            self.updateSignOutButton(enabled: true)
        }
    }

    ```
    
    This function uses MSAL for iOS to silently acquire a token for an existing account. After verifying the `applicationContext`, it logs the token acquisition process. Using `MSALSilentTokenParameters`, it defines the necessary parameters. Then, it attempts to acquire the token silently. If there's errors, it checks for user interaction requirements, initiating an interactive process if needed. Upon success, it updates the `accessToken` property and logs the refreshed token, concluding by enabling the sign out button.

## Sign out user

To sign out a user from your iOS (Swift) app using MSAL for iOS, use the following code:

```swift
   @IBAction func signOut(_ sender: UIButton) {
        
        guard let applicationContext = self.applicationContext else { return }
        
        guard let account = self.currentAccount else { return }
        
        guard let webViewParamaters = self.webViewParamaters else { return }
        
        updateLogging(text: "Signing out...")
        
        do {
            
            /**
             Removes all tokens from the cache for this application for the provided account
             
             - account:    The account to remove from the cache
             */
            
            let signoutParameters = MSALSignoutParameters(webviewParameters: webViewParamaters)
            
            // If testing with Microsoft's shared device mode, trigger signout from browser. More details here:
            // https://docs.microsoft.com/en-us/azure/active-directory/develop/msal-ios-shared-devices
            
            if (self.currentDeviceMode == .shared) {
                signoutParameters.signoutFromBrowser = true
            } else {
                signoutParameters.signoutFromBrowser = false
            }
            
            applicationContext.signout(with: account, signoutParameters: signoutParameters, completionBlock: {(success, error) in
                
                if let error = error {
                    self.updateLogging(text: "Couldn't sign out account with error: \(error)")
                    return
                }
                
                self.updateLogging(text: "Sign out completed successfully")
                self.accessToken = ""
                self.updateCurrentAccount(account: nil)
            })
            
        }
    }
```

The code verifies the existence of the `applicationContext`, `currentAccount`, and `webViewParamaters`. Then, it logs the sign out process. The code removes all tokens from the cache for the provided account. Depending on the current device mode, it determines whether to sign out from the browser. Upon completion, it updates the logging text accordingly. If an error occurs during the sign out process, it logs the error message. Upon successful sign out, it updates the access token to an empty string and clears the current account.

## Next steps

[Tutorial: Call a protected web API in iOS (Swift) app](tutorial-mobile-app-ios-swift-sign-in-call-api.md).
