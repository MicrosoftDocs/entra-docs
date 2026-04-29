---
title: Add federated identity provider sign-in and sign-up to an iOS app using native authentication web flow
description: Learn how to enable federated identity provider sign-in and sign-up in an iOS app using Microsoft Entra native authentication with web-based authentication flow.

author: henrymbuguakiarie
manager: pmwongera

ms.author: henrymbugua
ms.service: identity-platform

ms.subservice: external
ms.topic: tutorial
ms.date: 04/10/2026
ms.custom:
#Customer intent: As an iOS developer, I want to enable federated identity provider sign-in and sign-up using native authentication web flow so that users can authenticate with existing social accounts like Apple, Google, or Facebook.
---

# Tutorial: Add federated identity provider sign-in and sign-up web flow to your iOS app

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

This tutorial demonstrates how to implement federated identity provider (IdP) authentication into your iOS app using native authentication with web flow. Federated IdP authentication allows users to sign in or sign up using their existing accounts from providers like Apple, Facebook, Google and custom OIDC providers.

In this tutorial, you learn how to:

> [!div class="checklist"]
>
> - Sign in a user using a federated identity provider via web flow
> - Sign up a user using a federated identity provider via web flow

## Prerequisites

1. Complete the steps in [Tutorial: Prepare your iOS/macOS app for native authentication](tutorial-native-authentication-prepare-ios-macos-app.md).

1. Configure federated identity providers in your Microsoft Entra External ID tenant. Follow the steps in the Microsoft Entra admin center to add and configure your desired identity providers:

   - [Configure Apple as an identity provider](../external-id/customers/how-to-apple-federation-customers.md)
   - [Configure Facebook as an identity provider](../external-id/customers/how-to-facebook-federation-customers.md)
   - [Configure Google as an identity provider](../external-id/customers/how-to-google-federation-customers.md)
   - [Configure a custom OIDC provider](../external-id/customers/how-to-custom-oidc-federation-customers.md). Use the domain of the Issuer URI configured for custom OIDC as the `domain_hint`.
  
1. Ensure your app supports web fallback [Tutorial: Support web fallback](tutorial-native-authentication-ios-macos-support-web-fallback.md).

1. Add/update the Microsoft Authentication Library (MSAL) dependency to at least `2.6.0`.

1. If you'd like to explore our federated IdP Sign in and Sign up implementation, take a look at our [sample iOS application](https://github.com/Azure-Samples/ms-identity-ciam-native-auth-ios-sample/blob/main/NativeAuthSampleApp/WebFallbackViewController.swift) before getting started.

## Sign in a user with a federated identity provider

To sign in a user with a federated identity provider via web flow, you need to first identify the identity provider to authenticate with, and the corresponding `domain_hint`.

- Use the identity providers defined in the [prerequisite configuration section](#prerequisites).
- Use the `domain_hint` parameter to direct authentication to a specific identity provider. Choose one of the following values:

  - `"Apple"` for Apple
  - `"Facebook"` for Facebook
  - `"Google"` for Google

To sign in a user, you need to:

1. Create a user interface that lets the user sign in with a federated identity provider. This interface should identify a specific identity provider and its corresponding `domain_hint`.  

1. Once `domain_hint` value is identified from the client app, create `MSALInteractiveTokenParameters`, set `domain_hint` and  call `acquireToken(with: parameters)` method of `MSALNativeAuthPublicClientApplication` to trigger web authentication with Social IdP like below.

   Use the Prompt type value as `.login` to force interactive authentication, even if user is signed in.

    ```swift
    let parameters = MSALInteractiveTokenParameters(scopes: ["User.Read"], webviewParameters: webviewParams)
    parameters.promptType = .login
    parameters.domainHint = domainHint
    
    nativeAuth.acquireToken(with: parameters) { [weak self] (result: MSALResult?, error: Error?) in
        guard let self = self else { return }
    
        if let error = error {
            self.showResultText("Error acquiring token: \(error)")
            return
        }
    
        self.msalAccount = result?.account
    
        guard let msalAccount = self.msalAccount else {
            self.showResultText("Could not acquire token: No result or account returned")
            return
        }
    
        self.updateUI()
    }
    ```

1. You can also retrieve the current cached account after successful authentication by using the `getNativeAuthUserAccount()` from `MSALNativeAuthPublicClientApplication`:

    ```swift
        if let account = nativeAuth.getNativeAuthUserAccount() {
            ...
        }
    ```

## Sign up a user with a federated identity provider

To sign up a user with a federated identity provider, the process is almost the same as signing in, with a minor change to the Prompt value: use `.create`.

```swift
    let parameters = MSALInteractiveTokenParameters(scopes: ["User.Read"], webviewParameters: webviewParams)
    parameters.promptType = .create
    parameters.domainHint = domainHint

    nativeAuth.acquireToken(with: parameters) { [weak self] (result: MSALResult?, error: Error?) in
        ...
    }
```

## Related content

- For attribute collection, this happens in web sign-up flow UX. Refer to [User profile attributes](../external-id/customers/concept-user-attributes.md).
- For SMS and email one-time passcode multifactor authentication (MFA), this is handled also in web flow UX. If enabled, after the social IdP authentication completes, the client app prompt the user for MFA as part of the web flow. For more information, see [Multifactor authentication in external tenants](../external-id/customers/concept-multifactor-authentication-customers.md) and [Add multifactor authentication (MFA) to an app](../external-id/customers/how-to-multifactor-authentication-customers.md).