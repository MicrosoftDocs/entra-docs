---
title: Call an API in iOS app by using native authentication
description: Learn how to acquire multiple access tokens and call an API in iOS app by using native authentication.

author: henrymbuguakiarie
manager: mwongerapk
ms.author: henrymbugua
ms.service: entra-external-id
ms.subservice: customers
ms.topic: tutorial
ms.date: 07/09/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to acquire multiple access tokens so that I call a web API in an iOS mobile app by using native authentication
---

# Tutorial: Call an API in iOS app by using native authentication

In this tutorial, you learn how to acquire an access token and call an API in your iOS mobile app. Microsoft Authentication Library (MSAL) native authentication SDK for iOS allows you to acquire multiple access tokens with a single sign-in. This capability allows you to acquire one or more access tokens without requiring a user to reauthenticate. 

In this tutorial, you learn how to: 

> [!div class="checklist"]
> 
> - Acquire one or multiple access tokens.
> - Call an API

## Prerequisites

- Complete the steps in [Tutorial: Add sign-in and sign-out in iOS app by using native authentication](tutorial-native-authentication-ios-sign-in-sign-out.md). This tutorial shows you how to sign in users in your iOS app by using native authentication.
- Complete the steps in [Sign in users and call an API in sample iOS mobile app by using native authentication](sample-native-authentication-ios-sample-app-call-web-api.md)

## Acquire an access token

Once the user signs in, you acquire an access token by specifying the scopes for which the access token is valid. 

MSAL native authentication SDK can store multiple access tokens. After signing in, you can obtain an access token by using the `getAccessToken(scope:)` function and specifying the scopes for the new access token you wish to grant.

1. Declare and set values for a set of API scopes by using the following code snippet:

    ```swift
    let protectedAPIUrl1: String? = nil // Developers should set the URL of their first web API resource here
    let protectedAPIUrl2: String? = nil // Developers should set the URL of their second web API resource here
    // Developers should set the respective scopes for their web API resources here, for example: ["api://<Resource_App_ID>/ToDoList.Read", "api://<Resource_App_ID>/ToDoList.ReadWrite"]
    let protectedAPIScopes1: [String] = []
    let protectedAPIScopes2: [String] = []
    ```

    - Initialize `protectedAPIUrl1` with the URL of your first web API.
    - Initialize `protectedAPIUrl2` with the URL of your second web API.
    - Define `protectedAPIScopes1` with scopes for your first API, like `["api://<Resource_App_ID>/ToDoList.Read", "api://<Resource_App_ID>/ToDoList.ReadWrite"]`.
    - Define `protectedAPIScopes2` with scopes for your second API, similar to `protectedAPIScopes1`.
    

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

    The `signInPressed` method handles the sign-in button press. It checks if the email and password fields are filled. If either is empty, it shows "Email or password not set." If both fields are filled, it logs the email, displays "Signing in...", and initiates the sign-in using the `signIn` method from `nativeAuth` with the provided email and password.

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

    The `protectedApi1Pressed` and `protectedApi2Pressed` methods manage the process of acquiring access tokens for two distinct set of scopes. They first ensure that each API's URL and scopes are properly configured. If an access token for the API is already available, it directly accesses the API. Otherwise, it requests an access token and informs the user about the ongoing token retrieval process.
    

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

The `accessProtectedAPI` method performs a GET request to an API endpoint using the provided access token. It sets up the request with the token in the Authorization header. Upon receiving a successful response (HTTP status code 200-299), it deserializes the JSON response and updates the UI with the HTTP status code and response body. If there are any errors during the request or response handling, it displays the error message in the UI accordingly. This method facilitates accessing either API 1 or API 2 based on the specified URL and access token passed to it.

## Related content

- [Explore native authentication API reference](/entra/identity-platform/reference-native-authentication-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json).
- [Customize the look and feel of the authentication experience for the external tenant](concept-branding-customers.md).
