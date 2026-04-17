---
title: Add federated identity provider sign-in and sign-up to an Android app using native authentication web flow
description: Learn how to enable federated identity provider sign-in and sign-up in an Android app using Microsoft Entra native authentication with web-based authentication flow.

author: henrymbuguakiarie
manager: pmwongera

ms.author: henrymbugua
ms.service: identity-platform

ms.subservice: external
ms.topic: tutorial
ms.date: 04/10/2026
ai-usage: ai-assisted
ms.custom:
#Customer intent: As an Android developer, I want to enable federated identity provider sign-in and sign-up using native authentication web flow so that users can authenticate with existing social accounts like Apple, Google, or Facebook.
---

# Tutorial: Add federated identity provider sign-in and sign-up web flow to your Android app

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

This tutorial demonstrates how to implement federated identity provider (IdP) authentication into your Android app using native authentication with web flow. Federated IdP authentication allows users to sign in or sign up using their existing accounts from providers like Apple, Facebook, Google and custom OIDC providers.

In this tutorial, you learn how to:

> [!div class="checklist"]
>
> - Sign in a user using a federated identity provider via web flow
> - Sign up a user using a federated identity provider via web flow

## Prerequisites

1. Complete the steps in [Tutorial: Prepare your Android mobile app for native authentication](tutorial-native-authentication-prepare-android-app.md).

1. Configure federated identity providers in your Microsoft Entra External ID tenant. Follow the steps in the Microsoft Entra admin center to add and configure your desired identity providers:

   - [Configure Apple as an identity provider](../external-id/customers/how-to-apple-federation-customers.md)
   - [Configure Facebook as an identity provider](../external-id/customers/how-to-facebook-federation-customers.md)
   - [Configure Google as an identity provider](../external-id/customers/how-to-google-federation-customers.md)
   - [Configure a custom OIDC provider](../external-id/customers/how-to-custom-oidc-federation-customers.md). Use the domain of the Issuer URI configured for custom OIDC as the `domain_hint`.

1. If you'd like to explore our federated IdP Sign in and Sign up implementation, take a look at our [sample Android application](https://github.com/Azure-Samples/ms-identity-ciam-native-auth-android-sample/blob/main/app/src/main/java/com/azuresamples/msalnativeauthandroidkotlinsampleapp/IdPSignInSignUpWebFragment.kt) before getting started.

## Sign in a user with a federated identity provider

To sign in a user with a federated identity provider via web flow, you need to first identify the identity provider to register/authenticate with, and the corresponding `domain_hint`.

- Use the identity providers defined in the [prerequisite configuration section](#prerequisites).
- Use the `domain_hint` parameter to direct authentication to a specific identity provider. Choose one of the following values:
  - `"Apple"` for Apple
  - `"Facebook"` for Facebook
  - `"Google"` for Google

To sign in a user, you need to:

1. Create a user interface to sign in with a federated identity provider. This should identify a specific identity provider and its corresponding `domain_hint`.  

1. Once `domain_hint` value is identified from the client app, call `INativeAuthPublicClientApplication.acquireToken` with `domain_hint` to trigger web authentication with Social IdP. Here's a code snippet example:

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

### Update configurations

1. Ensure your client JSON configuration file includes the `redirect_uri` parameter for handling web-based authentication flows:

   - [Microsoft Authentication Library (MSAL) configuration](/entra/msal/android/msal-configuration#redirect_uri)

    ```json
    {
        "client_id": "Enter_the_Application_Id_Here",
        "redirect_uri": "msauth://com.yourpackage.name/Enter_your_Signature_Hash_Here",
        "authorities": [
        {
            "type": "CIAM",
            "authority_url": "https://Enter_the_Tenant_Subdomain_Here.ciamlogin.com/Enter_the_Tenant_Subdomain_Here.onmicrosoft.com/"
        }
        ],
        ...
    }
    ```

1. Add or update the MSAL dependency to at least `8.1.0` in your app's `build.gradle` file if not already present:

    ```gradle
    dependencies {
        implementation 'com.microsoft.identity.client:msal:[8.1.0,)'
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

## Related content

- For attribute collection, this happens in web sign-up flow UX. Refer to [User profile attributes](../external-id/customers/concept-user-attributes.md).
- For SMS and email one-time passcode multifactor authentication (MFA), this is handled also in web flow UX. If enabled, after the social IdP authentication completes, the client app prompt the user for MFA as part of the web flow. For more information, see [Multifactor authentication in external tenants](../external-id/customers/concept-multifactor-authentication-customers.md) and [Add multifactor authentication (MFA) to an app](../external-id/customers/how-to-multifactor-authentication-customers.md).