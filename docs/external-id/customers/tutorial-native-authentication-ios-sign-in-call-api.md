---
title: Call an API in iOS/macOS app by using native authentication
description: Learn how to acquire multiple access tokens and call an API in iOS/macOS app by using native authentication.

author: henrymbuguakiarie
manager: mwongerapk
ms.author: henrymbugua
ms.service: entra-external-id
ms.subservice: customers
ms.topic: tutorial
ms.date: 08/12/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to acquire multiple access tokens so that I call a web API in an iOS/macOS mobile app by using native authentication
---

# Tutorial: Call multiple APIs in iOS/macOS app by using native authentication

[!INCLUDE [applies-to-ios-macOS](../includes/applies-to-ios-macos.md)]

In this tutorial, you learn how to acquire an access token and call an API in your iOS/macOS mobile app. Microsoft Authentication Library (MSAL) native authentication SDK for iOS/macOS allows you to acquire multiple access tokens with a single sign-in. This capability allows you to acquire one or more access tokens without requiring a user to reauthenticate. 

In this tutorial, you learn how to: 

> [!div class="checklist"]
> 
> - Acquire one or multiple access tokens.
> - Call an API

## Prerequisites

- Complete the steps in [Sign in users and call an API in sample iOS mobile app by using native authentication](sample-native-authentication-ios-sample-app-call-web-api.md).
- Complete the steps in [Tutorial: Add sign-in and sign-out in iOS/macOS app by using native authentication](tutorial-native-authentication-ios-macos-sign-in-sign-out.md). This tutorial shows you how to sign in users in your iOS/macOS app by using native authentication.


## Acquire one or multiple access tokens

MSAL native authentication SDK can store multiple access tokens. After signing in, you can obtain an access token by using the `getAccessToken(scope:)` function and specifying the scopes for the new access token you wish to grant.

1. Declare and set values for a set of API scopes by using the following code snippet:

    ```swift
    let protectedAPIUrl1: String? = nil
    let protectedAPIUrl2: String? = nil 
    let protectedAPIScopes1: [String] = []
    let protectedAPIScopes2: [String] = []

    var accessTokenAPI1: String?
    var accessTokenAPI2: String?
    ```

    - Initialize `protectedAPIUrl1` with the URL of your first web API.
    - Initialize `protectedAPIUrl2` with the URL of your second web API.
    - Define `protectedAPIScopes1` with scopes for your first API, like `["api://<Resource_App_ID>/ToDoList.Read", "api://<Resource_App_ID>/ToDoList.ReadWrite"]`.
    - Define `protectedAPIScopes2` with scopes for your second API, similar to `protectedAPIScopes1`.
    - Declare the optional string variables `accessTokenAPI1` and `accessTokenAPI2`.
    

1. Signs in user by using the following code snippet:

    ```swift
    @IBAction func signInPressed(_: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            resultTextView.text = "Email or password not set"
            return
        }

        print("Signing in with email \(email) and password")

        showResultText("Signing in...")

        nativeAuth.signIn(username: email, password: password, delegate: self)
    }
    ```

    The `signInPressed` method handles the sign-in button press. It checks if the email and password fields are filled. If either is empty, it shows "Email or password not set." If both fields are filled, it logs the email, displays "Signing in...", and initiates the sign-in using the `signIn` method from `nativeAuth` with the provided email and password. The SDK retrieves a token valid for the default OIDC scopes (openid, offline_access, profile) because no scopes are specified.

1. Acquire one or multiple access tokens by using the following code snippet:

    ```swift
    @IBAction func protectedApi1Pressed(_: Any) {
        guard let url = protectedAPIUrl1, !protectedAPIScopes1.isEmpty else {
            showResultText("API 1 not configured.")
            return
        }
        
        if let accessToken = accessTokenAPI1 {
            accessProtectedAPI(apiUrl: url, accessToken: accessToken)
        } else {
            accountResult?.getAccessToken(scopes: protectedAPIScopes1, delegate: self)
            let message = "Retrieving access token to use with API 1..."
            showResultText(message)
            print(message)
        }
    }
    
    @IBAction func protectedApi2Pressed(_: Any) {
        guard let url = protectedAPIUrl2, !protectedAPIScopes2.isEmpty else {
            showResultText("API 2 not configured.")
            return
        }
        
        if let accessToken = accessTokenAPI2 {
            accessProtectedAPI(apiUrl: url, accessToken: accessToken)
        } else {
            accountResult?.getAccessToken(scopes: protectedAPIScopes2, delegate: self)
            let message = "Retrieving access token to use with API 2..."
            showResultText(message)
            print(message)
        }
    }
    ```

    The `protectedApi1Pressed` and `protectedApi2Pressed` methods manage the process of acquiring access tokens for two distinct sets of scopes. They first ensure that each API's URL and scopes are properly configured. If an access token for the API is already available, it directly accesses the API. Otherwise, it requests an access token and informs the user about the ongoing token retrieval process.

    To assign an access token to `protectedAPIScopes1` and `protectedAPIScopes2`, use the following snippet:

    ```swift
    func onAccessTokenRetrieveCompleted(result: MSALNativeAuthTokenResult) {
        print("Access Token: \(result.accessToken)")

        if protectedAPIScopes1.allSatisfy(result.scopes.contains),
           let url = protectedAPIUrl1
        {
            accessTokenAPI1 = result.accessToken
            accessProtectedAPI(apiUrl: url, accessToken: result.accessToken)
        }
        
        if protectedAPIScopes2.allSatisfy(result.scopes.contains(_:)),
           let url = protectedAPIUrl2
        {
            accessTokenAPI2 = result.accessToken
            accessProtectedAPI(apiUrl: url, accessToken: result.accessToken)
        }
        
        showResultText("Signed in." + "\n\n" + "Scopes:\n\(result.scopes)" + "\n\n" + "Access Token:\n\(result.accessToken)")
        updateUI()
    }

    func onAccessTokenRetrieveError(error: MSAL.RetrieveAccessTokenError) {
        showResultText("Error retrieving access token: \(error.errorDescription ?? "No error description")")
    }
    ```

    The `onAccessTokenRetrieveCompleted` method prints the access token to the console. It then checks if `protectedAPIScopes1` are included in the result's scopes and if `protectedAPIUrl1` is available; if so, it sets `accessTokenAPI1` and calls `accessProtectedAPI` with the URL and token. It performs a similar check for `protectedAPIScopes2` and `protectedAPIUrl2`, updating `accessTokenAPI2` and making the API call if conditions are met. Finally, the method displays a message with the signed-in status, scopes, and access token, and updates the UI.

    The `onAccessTokenRetrieveError` method displays an error message with the description of the access token retrieval error or a default message if no description is provided.

## Call an API

Use the following code snippets to call an API:

```swift
func accessProtectedAPI(apiUrl: String, accessToken: String) {
    guard let url = URL(string: apiUrl) else {
        let errorMessage = "Invalid API url"
        print(errorMessage)
        DispatchQueue.main.async {
            self.showResultText(errorMessage)
        }
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error found when accessing API: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.showResultText(error.localizedDescription)
            }
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
        else {
            DispatchQueue.main.async {
                self.showResultText("Unsuccessful response found when accessing the API")
            }
            return
        }
        
        guard let data = data, let result = try? JSONSerialization.jsonObject(with: data, options: []) else {
            DispatchQueue.main.async {
                self.showResultText("Couldn't deserialize result JSON")
            }
            return
        }
        
        DispatchQueue.main.async {
            self.showResultText("""
                            Accessed API successfully using access token.
                            HTTP response code: \(httpResponse.statusCode)
                            HTTP response body: \(result)
                            """)
        }
    }
    
    task.resume()
}
```

The `accessProtectedAPI` method sends a GET request to the specified API endpoint using the provided access token. It configures the request with the token in the Authorization header. When it receives a successful response (HTTP status code 200-299), it deserializes the JSON data and updates the UI with the HTTP status code and response body. If an error occurs during the request or response handling, it displays the error message in the UI. This method allows access to either API 1 or API 2, depending on the URL and access token provided.

## Related content

- [Explore native authentication API reference](/entra/identity-platform/reference-native-authentication-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json).
- [Customize the look and feel of the authentication experience for the external tenant](concept-branding-customers.md).
