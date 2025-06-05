---
title: Sign in users in iOS (Swift) app for authentication
description: The tutorials provide a step-by-step guide on how to sign in users in iOS (Swift) app for authentication.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: identity-platform

ms.topic: tutorial
ms.date: 05/09/2024
ms.custom:
zone_pivot_groups: entra-tenants
#Customer intent: As a developer, I want to sign in users in iOS (Swift) app for authentication using Microsoft Entra ID.
---

# Tutorial: Sign in users in iOS (Swift) mobile app

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

::: zone pivot="workforce"

This is the third tutorial in the tutorial series that guides you on signing in users using Microsoft Entra ID.

[!INCLUDE [select-tenant-type-statement](./includes/select-tenant-type-statement.md)]

In this tutorial, you:

> [!div class="checklist"]
>
> - Sign in user.
> - Sign out user.
> - Create your app's UI

## Prerequisites

- [Tutorial: Prepare your iOS (Swift) app for authentication](tutorial-mobile-app-ios-swift-prepare-app.md)

## Sign in user

You have two main options for signing in users using Microsoft Authentication Library (MSAL) for iOS: acquiring tokens interactively or silently.

1. To sign in user interactively, use the following code:

    ```swift
    func acquireTokenInteractively() {
    
        guard let applicationContext = self.applicationContext else { return }
        guard let webViewParameters = self.webViewParameters else { return }
    
        // #1
        let parameters = MSALInteractiveTokenParameters(scopes: kScopes, webviewParameters: webViewParameters)
        parameters.promptType = .selectAccount
    
        // #2
        applicationContext.acquireToken(with: parameters) { (result, error) in
    
            // #3
            if let error = error {
    
                self.updateLogging(text: "Could not acquire token: \(error)")
                return
            }
    
            guard let result = result else {
    
                self.updateLogging(text: "Could not acquire token: No result returned")
                return
            }
    
            // #4
            self.accessToken = result.accessToken
            self.updateLogging(text: "Access token is \(self.accessToken)")
            self.updateCurrentAccount(account: result.account)
            self.getContentWithToken()
        }
    }
    ```


    The `promptType` property of `MSALInteractiveTokenParameters` configures the authentication and consent prompt behavior. The following values are supported:
    
    - `.promptIfNecessary` (default) - The user is prompted only if necessary. The SSO experience is determined by the presence of cookies in the webview, and the account type. If multiple users are signed in, account selection experience is presented. *This is the default behavior*.
    - `.selectAccount` - If no user is specified, the authentication webview presents a list of currently signed-in accounts for the user to select from.
    - `.login` - Requires the user to authenticate in the webview. Only one account may be signed-in at a time if you specify this value.
    - `.consent` - Requires the user to consent to the current set of scopes for the request.
    

1. To sign in user silently, use the following code:

    ```swift

        func acquireTokenSilently(_ account : MSALAccount!) {
    
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
    
            let parameters = MSALSilentTokenParameters(scopes: kScopes, account: account)
    
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
                self.getContentWithToken()
            }
        }
    ```

    The `acquireTokenSilently` method, attempts to silently acquire an access token for an existing MSAL account. It uses the `applicationContext` to request the token with specified scopes. If an error occurs, it checks if user interaction is required and, if so, initiates an interactive token acquisition. Upon success, it updates the access token, logs the result, enables the sign-out button, and retrieves content using the token.

### Handle the sign-in callback (iOS only)

Open the *AppDelegate.swift* file. To handle the callback after sign-in, add `MSALPublicClientApplication.handleMSALResponse` to the `appDelegate` class like this:

```swift
// Inside AppDelegate...
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        return MSALPublicClientApplication.handleMSALResponse(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String)
}

```

**If you are using Xcode 11**, you should place MSAL callback into the *SceneDelegate.swift* instead.
If you support both UISceneDelegate and UIApplicationDelegate for compatibility with older iOS, MSAL callback would need to be placed into both files.

```swift
func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {

        guard let urlContext = URLContexts.first else {
            return
        }

        let url = urlContext.url
        let sourceApp = urlContext.options.sourceApplication

        MSALPublicClientApplication.handleMSALResponse(url, sourceApplication: sourceApp)
    }
```

## Sign out user

> [!Important]
> Signing out with MSAL removes all known information about a user from the application, as well as removing an active session on their device when allowed by device configuration. You can also optionally sign user out from the browser.

To add sign-out capability, add the following code inside the `ViewController` class.

```swift
@objc func signOut(_ sender: AnyObject) {

        guard let applicationContext = self.applicationContext else { return }

        guard let account = self.currentAccount else { return }

        do {

            /**
             Removes all tokens from the cache for this application for the provided account

             - account:    The account to remove from the cache
             */

            let signoutParameters = MSALSignoutParameters(webviewParameters: self.webViewParameters!)
            signoutParameters.signoutFromBrowser = false // set this to true if you also want to signout from browser or webview

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

## Create your app's UI

Now create a UI that includes a button to call the Microsoft Graph API, another to sign out, and a text view to see some output by adding the following code to the `ViewController` class:

### iOS UI

```swift
var loggingText: UITextView!
var signOutButton: UIButton!
var callGraphButton: UIButton!
var usernameLabel: UILabel!

func initUI() {

    usernameLabel = UILabel()
    usernameLabel.translatesAutoresizingMaskIntoConstraints = false
    usernameLabel.text = ""
    usernameLabel.textColor = .darkGray
    usernameLabel.textAlignment = .right

    self.view.addSubview(usernameLabel)

    usernameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0).isActive = true
    usernameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10.0).isActive = true
    usernameLabel.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
    usernameLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true

    // Add call Graph button
    callGraphButton  = UIButton()
    callGraphButton.translatesAutoresizingMaskIntoConstraints = false
    callGraphButton.setTitle("Call Microsoft Graph API", for: .normal)
    callGraphButton.setTitleColor(.blue, for: .normal)
    callGraphButton.addTarget(self, action: #selector(callGraphAPI(_:)), for: .touchUpInside)
    self.view.addSubview(callGraphButton)

    callGraphButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    callGraphButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 120.0).isActive = true
    callGraphButton.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
    callGraphButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true

    // Add sign out button
    signOutButton = UIButton()
    signOutButton.translatesAutoresizingMaskIntoConstraints = false
    signOutButton.setTitle("Sign Out", for: .normal)
    signOutButton.setTitleColor(.blue, for: .normal)
    signOutButton.setTitleColor(.gray, for: .disabled)
    signOutButton.addTarget(self, action: #selector(signOut(_:)), for: .touchUpInside)
    self.view.addSubview(signOutButton)

    signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    signOutButton.topAnchor.constraint(equalTo: callGraphButton.bottomAnchor, constant: 10.0).isActive = true
    signOutButton.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
    signOutButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true

    let deviceModeButton = UIButton()
    deviceModeButton.translatesAutoresizingMaskIntoConstraints = false
    deviceModeButton.setTitle("Get device info", for: .normal);
    deviceModeButton.setTitleColor(.blue, for: .normal);
    deviceModeButton.addTarget(self, action: #selector(getDeviceMode(_:)), for: .touchUpInside)
    self.view.addSubview(deviceModeButton)

    deviceModeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    deviceModeButton.topAnchor.constraint(equalTo: signOutButton.bottomAnchor, constant: 10.0).isActive = true
    deviceModeButton.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
    deviceModeButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true

    // Add logging textfield
    loggingText = UITextView()
    loggingText.isUserInteractionEnabled = false
    loggingText.translatesAutoresizingMaskIntoConstraints = false

    self.view.addSubview(loggingText)

    loggingText.topAnchor.constraint(equalTo: deviceModeButton.bottomAnchor, constant: 10.0).isActive = true
    loggingText.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10.0).isActive = true
    loggingText.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10.0).isActive = true
    loggingText.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 10.0).isActive = true
}

func platformViewDidLoadSetup() {

    NotificationCenter.default.addObserver(self,
                        selector: #selector(appCameToForeGround(notification:)),
                        name: UIApplication.willEnterForegroundNotification,
                        object: nil)

}

@objc func appCameToForeGround(notification: Notification) {
    self.loadCurrentAccount()
}

```

### macOS UI

```swift

var callGraphButton: NSButton!
var loggingText: NSTextView!
var signOutButton: NSButton!

var usernameLabel: NSTextField!

func initUI() {

    usernameLabel = NSTextField()
    usernameLabel.translatesAutoresizingMaskIntoConstraints = false
    usernameLabel.stringValue = ""
    usernameLabel.isEditable = false
    usernameLabel.isBezeled = false
    self.view.addSubview(usernameLabel)

    usernameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30.0).isActive = true
    usernameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10.0).isActive = true

    // Add call Graph button
    callGraphButton  = NSButton()
    callGraphButton.translatesAutoresizingMaskIntoConstraints = false
    callGraphButton.title = "Call Microsoft Graph API"
    callGraphButton.target = self
    callGraphButton.action = #selector(callGraphAPI(_:))
    callGraphButton.bezelStyle = .rounded
    self.view.addSubview(callGraphButton)

    callGraphButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    callGraphButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0).isActive = true
    callGraphButton.heightAnchor.constraint(equalToConstant: 34.0).isActive = true

    // Add sign out button
    signOutButton = NSButton()
    signOutButton.translatesAutoresizingMaskIntoConstraints = false
    signOutButton.title = "Sign Out"
    signOutButton.target = self
    signOutButton.action = #selector(signOut(_:))
    signOutButton.bezelStyle = .texturedRounded
    self.view.addSubview(signOutButton)

    signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    signOutButton.topAnchor.constraint(equalTo: callGraphButton.bottomAnchor, constant: 10.0).isActive = true
    signOutButton.heightAnchor.constraint(equalToConstant: 34.0).isActive = true
    signOutButton.isEnabled = false

    // Add logging textfield
    loggingText = NSTextView()
    loggingText.translatesAutoresizingMaskIntoConstraints = false

    self.view.addSubview(loggingText)

    loggingText.topAnchor.constraint(equalTo: signOutButton.bottomAnchor, constant: 10.0).isActive = true
    loggingText.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10.0).isActive = true
    loggingText.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10.0).isActive = true
    loggingText.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10.0).isActive = true
    loggingText.widthAnchor.constraint(equalToConstant: 500.0).isActive = true
    loggingText.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
}

func platformViewDidLoadSetup() {}

```

Next, also inside the `ViewController` class, replace the `viewDidLoad()` method with:

```swift
    override func viewDidLoad() {

        super.viewDidLoad()

        initUI()

        do {
            try self.initMSAL()
        } catch let error {
            self.updateLogging(text: "Unable to create Application Context \(error)")
        }

        self.loadCurrentAccount()
        self.platformViewDidLoadSetup()
    }
```

## Next steps

> [!div class="nextstepaction"] 
> [Tutorial: Call a protected web API in iOS (Swift) app](tutorial-mobile-app-ios-swift-sign-in-call-api.md)

::: zone-end


::: zone pivot="external"

This is the third tutorial in the tutorial series that guides you on signing in users using Microsoft Entra ID.

[!INCLUDE [select-tenant-type-statement](./includes/select-tenant-type-statement.md)]

In this tutorial, you:

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
        guard let webViewParameters = self.webViewParameters else { return }
        
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
            // https://docs.microsoft.com/azure/active-directory/develop/msal-ios-shared-devices
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
        
        guard let webViewParameters = self.webViewParameters else { return }
        
        updateLogging(text: "Signing out...")
        
        do {
            
            /**
             Removes all tokens from the cache for this application for the provided account
             
             - account:    The account to remove from the cache
             */
            
            let signoutParameters = MSALSignoutParameters(webviewParameters: webViewParameters)
            
            // If testing with Microsoft's shared device mode, trigger signout from browser. More details here:
            // https://docs.microsoft.com/azure/active-directory/develop/msal-ios-shared-devices
            
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

The code verifies the existence of the `applicationContext`, `currentAccount`, and `webViewParameters`. Then, it logs the sign out process. The code removes all tokens from the cache for the provided account. Depending on the current device mode, it determines whether to sign out from the browser. Upon completion, it updates the logging text accordingly. If an error occurs during the sign out process, it logs the error message. Upon successful sign out, it updates the access token to an empty string and clears the current account.

## Next steps

> [!div class="nextstepaction"] 
> [Tutorial: Call a protected web API in iOS (Swift) app](tutorial-mobile-app-ios-swift-sign-in-call-api.md)

::: zone-end
