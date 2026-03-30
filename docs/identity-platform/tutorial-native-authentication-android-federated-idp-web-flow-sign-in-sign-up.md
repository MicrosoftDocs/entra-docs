---
title: Add federated identity provider sign-in and sign-up to an Android app using native authentication web flow
description: Learn how to enable federated identity provider sign-in and sign-up in an Android app using Microsoft Entra native authentication with web-based authentication flow.

author: henrymbuguakiarie
manager: pmwongera

ms.author: henrymbugua
ms.service: identity-platform

ms.subservice: external
ms.topic: tutorial
ms.date: 03/30/2026
ms.custom:
#Customer intent: As an Android developer, I want to enable federated identity provider sign-in and sign-up using native authentication web flow so that users can authenticate with existing social accounts like Apple, Google, or Facebook.
---

# Tutorial: Add federated identity provider sign-in and sign-up web flow to your Android app

This tutorial demonstrates how to implement federated identity provider (IdP) authentication into your Android app using native authentication with web flow. Federated IdP authentication allows users to sign in or sign up using their existing accounts from providers like Apple, Facebook, Google, or custom OpenID Connect (OIDC) providers.

In this tutorial, you learn how to:

- Sign in a user using a federated identity provider via web flow
- Sign up a user using a federated identity provider via web flow

## Prerequisites

1. Complete the steps in [Tutorial: Prepare your Android mobile app for native authentication](tutorial-native-authentication-prepare-android-app.md).
1. Configure federated identity providers in your Microsoft Entra External ID tenant. Follow the steps in the Microsoft Entra admin center to add and configure your desired identity providers:

   - [Configure Apple as an identity provider](../external-id/customers/how-to-apple-federation-customers.md)
   - [Configure Facebook as an identity provider](../external-id/customers/how-to-facebook-federation-customers.md)
   - [Configure Google as an identity provider](../external-id/customers/how-to-google-federation-customers.md)
   - [Configure a custom OIDC provider](../external-id/customers/how-to-custom-oidc-federation-customers.md)

      > [!NOTE]
      > The domain of the Issuer URI is configured for custom OIDC will be your `domain_hint`.

1. Add/update the MSAL dependency to at least `8.1.0` to your app's `build.gradle` file if not already present:
1. If you'd like to explore our federated IdP Sign in and Sign up implementation, take a look at our [sample Android application](https://github.com/Azure-Samples/ms-identity-ciam-native-auth-android-sample/blob/main/app/src/main/java/com/azuresamples/msalnativeauthandroidkotlinsampleapp/IdPSignInSignUpWebFragment.kt) before getting started.

## Sign in a user with a federated identity provider

To sign in a user with a federated identity provider via web flow, you need to first identify the identity provider to authenticate with, and the corresponding `domain_hint`.

- Identity providers are from the prerequisite configuration above.
- `domain_hint` values are defined here in [Issuer acceleration](/entra/external-id/customers/concept-authentication-methods-customers#issuer-acceleration). The `domain_hint` specifies which identity provider to redirect to for federated IdP authentication.

You'll send a request with the `domain_hint` which will open the OAuth/OIDC web flow to complete the sign in via web view.

> [!NOTE]
> Microsoft Entra and Microsoft Account (MSA) identity providers are currently not supported.

### Steps

1. Create a user interface to sign in with a federated identity provider. This should identify a specific identity provider and its corresponding `domain_hint`.  

1. Once `domain_hint` value is identified from the client app, call `INativeAuthPublicClientApplication.acquireToken` with `domain_hint` to trigger OAuth/OIDC web authentication with IdP like below.

   Use the Prompt value as `Prompt.LOGIN` to force interactive authentication, even if user is signed in.

    ```kotlin
    private fun signInWithIdp(domainHint: String) {
        val acquireTokenParameters = AcquireTokenParameters.Builder()
            .startAuthorizationFromActivity(requireActivity())
            .withScopes(listOf("openid", "profile", "email"))
            .withDomainHint(domainHint)
            .withPrompt(Prompt.LOGIN)
            .withCallback(getAuthenticationCallback())
            .build()
        
        authClient.acquireToken(acquireTokenParameters)
    }
    ```

1. To handle the sign in results, you need to implement the `AuthenticationCallback`, example below:

    ```kotlin
    private fun getAuthenticationCallback(): AuthenticationCallback {
        return object : AuthenticationCallback {
            
            override fun onSuccess(authenticationResult: IAuthenticationResult) {
                Log.d(TAG, "Successfully authenticated with IdP")
                
                val account = authenticationResult.account
                val idToken = account.idToken
                val accessToken = authenticationResult.accessToken
                
                Toast.makeText(
                    requireContext(),
                    "Sign in successful!",
                    Toast.LENGTH_SHORT
                ).show()
            }
            
            override fun onError(exception: MsalException) {
                Log.e(TAG, "Authentication failed: ${exception.message}", exception)
                
                showErrorDialog(
                    "Sign in failed",
                    exception.message ?: "An error occurred during authentication"
                )
            }
            
            override fun onCancel() {
                Log.d(TAG, "User cancelled authentication")
                
                Toast.makeText(
                    requireContext(),
                    "Sign in cancelled",
                    Toast.LENGTH_SHORT
                ).show()
            }
        }
    }
    ```

    For error code and handling, refer to [Handle errors and exceptions in MSAL for Android](/entra/msal/android/handling-exceptions).

1. You can also retrieve the current cached account after successful authentication by using the `getCurrentAccount()` from `INativeAuthPublicClientApplication`, which returns an object, `accountResult`:

    ```kotlin
    val accountResult = iNativeAuthPublicClientApplication.getCurrentAccount()
    
    when (accountResult) {
        is GetAccountResult.AccountFound -> {
            accountResult.resultValue.getIdToken()
        }
    
        is GetAccountResult.NoAccountFound -> {
            Log.d(TAG, "No account found")
        }
    
        is GetAccountError -> {
            displayDialog(
                getString(R.string.msal_exception_title),
                accountResult.exception?.message ?: accountResult.errorMessage
            )
        }
    }
    ```

## Sign up a user with a federated identity provider

To sign up a user with a federated identity provider, the process is almost the same as signing in, with a minor change to the Prompt value: use `Prompt.CREATE`.

```kotlin
private fun signUpWithIdp(domainHint: String) {
    val acquireTokenParameters = AcquireTokenParameters.Builder()
        .startAuthorizationFromActivity(requireActivity())
        .withScopes(listOf("openid", "profile", "email"))
        .withDomainHint(domainHint)
        .withPrompt(Prompt.CREATE)
        .withCallback(getAuthenticationCallback())
        .build()
    
    authClient.acquireToken(acquireTokenParameters)
}
```

# Related content

- For attribute collection, this happens in web sign-up flow UX. Refer to [User profile attributes](../external-id/customers/concept-user-attributes.md).
- For SMS and email one-time passcode multifactor authentication (MFA), this is handled also in web flow UX. If enabled, after the social IdP authentication completes, the client app prompt the user for MFA as part of the web flow. For more information, see [Multifactor authentication in external tenants](../external-id/customers/concept-multifactor-authentication-customers.md) and [Add multifactor authentication (MFA) to an app](../external-id/customers/how-to-multifactor-authentication-customers.md).
