---
title: Sign in user and call a protected web API in iOS app
description: The tutorials provide a step-by-step guide on how to Sign in user and call a protected web API in iOS (Swift) app for authentication.

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

# Tutorial: Call a protected web API in iOS (Swift) app

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

::: zone pivot="workforce"

This is the fourth tutorial in the tutorial series that guides you on signing in users and calling a protected web API using Microsoft Entra ID.

In this tutorial, you:

> [!div class="checklist"]
>
> - Call a protected web API.

## Prerequisites

- [Tutorial: Sign in users in iOS (Swift) mobile app](tutorial-mobile-app-ios-swift-sign-in.md)

## Call API

Once you have a token, your app can use it in the HTTP header to make an authorized request to the Microsoft Graph:

| header key    | value                  |
| ------------- | ---------------------- |
| Authorization | Bearer \<access-token> |

Add the following code to the `ViewController` class:

```swift
    func getContentWithToken() {

        // Specify the Graph API endpoint
        let graphURI = getGraphEndpoint()
        let url = URL(string: graphURI)
        var request = URLRequest(url: url!)

        // Set the Authorization header for the request. We use Bearer tokens, so we specify Bearer + the token we got from the result
        request.setValue("Bearer \(self.accessToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                self.updateLogging(text: "Couldn't get graph result: \(error)")
                return
            }

            guard let result = try? JSONSerialization.jsonObject(with: data!, options: []) else {

                self.updateLogging(text: "Couldn't deserialize result JSON")
                return
            }

            self.updateLogging(text: "Result from Graph: \(result))")

            }.resume()
    }
```

See [Microsoft Graph API](https://graph.microsoft.com) to learn more about the Microsoft Graph API.

## Test your app

Build and deploy the app to a test device or simulator. You should be able to sign in and get tokens for Microsoft Entra ID or personal Microsoft accounts.

The first time a user signs into your app, they'll be prompted by Microsoft identity to consent to the permissions requested. While most users are capable of consenting, some Microsoft Entra tenants have disabled user consent, which requires admins to consent on behalf of all users. To support this scenario, register your app's scopes.

After you sign in, the app will display the data returned from the Microsoft Graph `/me` endpoint.

## Next steps

Learn more about building mobile apps that call protected web APIs in our multi-part scenario series.

> [!div class="nextstepaction"] 
> [Scenario: Mobile application that calls web APIs](scenario-mobile-app-configuration.md)


::: zone-end

::: zone pivot="external"

This is the fourth tutorial in the tutorial series that guides you on signing in users and calling a protected web API using Microsoft Entra External ID.

In this tutorial, you:

> [!div class="checklist"]
>
> - Call a protected web API.

## Prerequisites

- [Tutorial: Sign in users in iOS (Swift) mobile app](tutorial-mobile-app-ios-swift-sign-in.md)
- An API registration that exposes at least one scope (delegated permissions) and one app role (application permission) such as *ToDoList.Read*. If you haven't already, follow the instructions for [call an API in a sample iOS mobile app](../external-id/customers/sample-native-authentication-ios-sample-app-call-web-api.md) to have a functional protected ASP.NET Core web API. Make sure you complete the following steps:

    - Register a web API application.
    - Configure API scopes.
    - Configure app roles.
    - Configure optional claims.
    - Clone or download sample web API.
    - Configure and run sample web API.

## Call API

To call a protected web API from your iOS app, use the following code:

```swift
    func getContentWithToken() {
        // Specify the API endpoint in _Configuration.swift_ file you created earlier
        guard let url = URL(string: Configuration.kProtectedAPIEndpoint) else {
            let errorMessage = "Invalid API url"
            print(errorMessage)
            updateLogging(text: errorMessage)
            return
        }
        var request = URLRequest(url: url)
        
        // Set the Authorization header for the request. We use Bearer tokens, so we specify Bearer + the token we got from the result
        request.setValue("Bearer \(self.accessToken)", forHTTPHeaderField: "Authorization")
        
        self.updateLogging(text: "Performing request...")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                self.updateLogging(text: "Couldn't get API result: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                self.updateLogging(text: "Couldn't get API result: \(error)")
                return
            }
            
            guard let data = data, let result = try? JSONSerialization.jsonObject(with: data, options: []) else {
                self.updateLogging(text: "Couldn't deserialize result JSON")
                return
            }
            
            self.updateLogging(text: """
                                Accessed API successfully using access token.
                                HTTP response code: \(httpResponse.statusCode)
                                HTTP response body: \(result)
                                """)
            
            }.resume()
    }
```

The code specifies the API endpoint, ensuring its validity. Then, it constructs a request object, setting the authorization header with the access token obtained. After logging the initiation of the request, it performs the request asynchronously using `URLSession`. 

Upon completion, it checks for any errors during the request. If an error occurs, it logs the corresponding message. Next, it verifies the success of the HTTP response, ensuring it falls within the range of 200 to 299 status codes. After, it deserializes the received JSON data. Finally, it updates the logging text, indicating successful access to the API along with relevant HTTP response details.

## Related content

- [Sign in users in sample iOS (Swift) mobile app](../external-id/customers/sample-mobile-app-ios-swift-sign-in.md)
- [Sign in users and call an API in sample iOS mobile app by using native authentication](../external-id/customers/sample-native-authentication-ios-sample-app-call-web-api.md)
- [Tutorial: Prepare your iOS/macOS app for native authentication](../external-id/customers/tutorial-native-authentication-prepare-ios-macos-app.md)


::: zone-end

