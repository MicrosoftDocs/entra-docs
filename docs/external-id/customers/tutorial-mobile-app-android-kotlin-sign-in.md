---
title: Sign in users Android (Kotlin) app for authentication
description: The tutorials provide a step-by-step guide on how to Sign in users in Android (Kotlin) app for authentication.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 05/10/2024
ms.custom: developer
#Customer intent: As a developer, I want to learn how to Sign in users in Android (Kotlin) app for authentication using Microsoft Entra External ID.
---

# Tutorial: Sign in users in Android (Kotlin) mobile app

This is the third tutorial in the tutorial series that guides you on signing in users using Microsoft Entra External ID.

In this tutorial, you'll:

> [!div class="checklist"]
>
> - Sign in user
> - Sign out user

## Prerequisites

[Tutorial: Prepare your Android app for authentication](tutorial-mobile-app-android-kotlin-prepare-app.md).

## Sign in user

You have two main options for signing in users using Microsoft Authentication Library (MSAL) for Android: acquiring tokens interactively or silently.

1. To sign in user interactively, use the following code:

    ```kotlin
        private fun acquireTokenInteractively() {
        binding.txtLog.text = ""

        if (account != null) {
            Toast.makeText(this, "An account is already signed in.", Toast.LENGTH_SHORT).show()
            return
        }

        /* Extracts a scope array from text, i.e. from "User.Read User.ReadWrite" to ["user.read", "user.readwrite"] */
        val scopes = scopes.lowercase().split(" ")
        val parameters = AcquireTokenParameters.Builder()
            .startAuthorizationFromActivity(this@MainActivity)
            .withScopes(scopes)
            .withCallback(getAuthInteractiveCallback())
            .build()

        authClient.acquireToken(parameters)
    }
    ```
    
    The code initiates the process of acquiring a token interactively using MSAL for Android. It first clears the text log field. Then, it checks if there's already a signed-in account, if so, it displays a toast message indicating that an account is already signed in and returns. 

    Next, it extracts scopes from text input and converts them to lowercase before splitting them into an array. Using these scopes, it builds parameters for acquiring a token, including starting the authorization process from the current activity and specifying a callback. Finally, it calls `acquireToken()` on the authentication client with the constructed parameters to initiate the token acquisition process.

    
    In the code, where we specify our callback, we use a function called `getAuthInteractiveCallback()`. The function should have the following code:

    ```kotlin
    private fun getAuthInteractiveCallback(): AuthenticationCallback {
        return object : AuthenticationCallback {

            override fun onSuccess(authenticationResult: IAuthenticationResult) {
                /* Successfully got a token, use it to call a protected resource - Web API */
                Log.d(TAG, "Successfully authenticated")
                Log.d(TAG, "ID Token: " + authenticationResult.account.claims?.get("id_token"))
                Log.d(TAG, "Claims: " + authenticationResult.account.claims

                /* Reload account asynchronously to get the up-to-date list. */
                CoroutineScope(Dispatchers.Main).launch {
                    accessToken = authenticationResult.accessToken
                    getAccount()

                    binding.txtLog.text = getString(R.string.log_token_interactive) +  accessToken
                }
            }

            override fun onError(exception: MsalException) {
                /* Failed to acquireToken */
                Log.d(TAG, "Authentication failed: $exception")

                accessToken = null
                binding.txtLog.text = getString(R.string.exception_authentication) + exception

                if (exception is MsalClientException) {
                    /* Exception inside MSAL, more info inside MsalError.java */
                } else if (exception is MsalServiceException) {
                    /* Exception when communicating with the STS, likely config issue */
                }
            }

            override fun onCancel() {
                /* User canceled the authentication */
                Log.d(TAG, "User cancelled login.");
            }
        }
    }
    ```
    
    The code snippet defines a function, `getAuthInteractiveCallback`, which returns an instance of `AuthenticationCallback`. Within this function, an anonymous class implementing the `AuthenticationCallback` interface is created.

    When authentication succeeds (`onSuccess`), it logs the successful authentication, retrieves the ID token and claims, updates the access token asynchronously using `CoroutineScope`, and updates the UI with the new access token. The code retrieves the ID token from the `authenticationResult` and logs it. Claims in the token contain information about the user, such as their name, email, or other profile information. You can retrieve the claims associated with the current account by accessing `authenticationResult.account.claims`.

    If there's an authentication error (`onError`), it logs the error, clears the access token, updates the UI with the error message, and provides more specific handling for `MsalClientException` and `MsalServiceException`. If the user cancels the authentication (`onCancel`), it logs the cancellation.

    Make sure you include the import statements. Android Studio should include the import statements for you automatically.

1. To sign in user silently, use the following code:

    ```kotlin
        private fun acquireTokenSilently() {
        binding.txtLog.text = ""

        if (account == null) {
            Toast.makeText(this, "No account available", Toast.LENGTH_SHORT).show()
            return
        }

        /* Extracts a scope array from text, i.e. from "User.Read User.ReadWrite" to ["user.read", "user.readwrite"] */
        val scopes = scopes.lowercase().split(" ")
        val parameters = AcquireTokenSilentParameters.Builder()
            .forAccount(account)
            .fromAuthority(account!!.authority)
            .withScopes(scopes)
            .forceRefresh(false)
            .withCallback(getAuthSilentCallback())
            .build()

        authClient.acquireTokenSilentAsync(parameters)
    }
    ```

    The code initiates the process of acquiring a token silently. It first clears the text log. Then, it checks if there's an available account; if not, it displays a toast message indicating this and exits. Next, it extracts scopes from text input, converts them to lowercase, and splits them into an array. 

    Using these scopes, it constructs parameters for acquiring a token silently, specifying the account, authority, scopes, and callback. Finally, it asynchronously triggers `acquireTokenSilentAsync()` on the authentication client with the constructed parameters, starting the silent token acquisition process.

    In the code, where we specify our callback, we use a function called `getAuthSilentCallback()`. The function should have the following code:

    ```kotlin
    private fun getAuthSilentCallback(): SilentAuthenticationCallback {
        return object : SilentAuthenticationCallback {
            override fun onSuccess(authenticationResult: IAuthenticationResult?) {
                Log.d(TAG, "Successfully authenticated")

                /* Display Access Token */
                accessToken = authenticationResult?.accessToken
                binding.txtLog.text = getString(R.string.log_token_silent) + accessToken
            }

            override fun onError(exception: MsalException?) {
                /* Failed to acquireToken */
                Log.d(TAG, "Authentication failed: $exception")

                accessToken = null
                binding.txtLog.text = getString(R.string.exception_authentication) + exception

                when (exception) {
                    is MsalClientException -> {
                        /* Exception inside MSAL, more info inside MsalError.java */
                    }
                    is MsalServiceException -> {
                        /* Exception when communicating with the STS, likely config issue */
                    }
                    is MsalUiRequiredException -> {
                        /* Tokens expired or no session, retry with interactive */
                    }
                }
            }

        }
    }
    ```
    
    The code defines a callback for silent authentication. It implements the `SilentAuthenticationCallback` interface, overriding two methods. In the `onSuccess` method, it logs successful authentication and displays the access token. 

    In the `onError` method, it logs authentication failure, handles different types of exceptions, such as `MsalClientException` and `MsalServiceException`, and suggests retrying with interactive authentication if needed.

    Make sure you include the import statements. Android Studio should include the import statements for you automatically.

## Sign out

To sign out a user from your Android (Kotlin) app using MSAL for Android, use the following code:

```kotlin
private fun removeAccount() {
    binding.userName.text = ""
    binding.txtLog.text = ""

    authClient.signOut(signOutCallback())
}
```

The code removes an account from the application. It clears the displayed user name and text log. Then, it triggers the sign out process using the authentication client, specifying a sign out callback to handle the completion of the sign out operation.

In the code, where we specify our callback, we use a function called `signOutCallback()`. The function should have the following code:

```kotlin
private fun signOutCallback(): ISingleAccountPublicClientApplication.SignOutCallback {
    return object : ISingleAccountPublicClientApplication.SignOutCallback {
        override fun onSignOut() {
            account = null
            updateUI(account)
        }

        override fun onError(exception: MsalException) {
            binding.txtLog.text = getString(R.string.exception_remove_account) + exception
        }
    }
}
```

The code defines a sign out callback for a single account in the public client application. It implements the `ISingleAccountPublicClientApplication.SignOutCallback` interface, overriding two methods. 

In the `onSignOut` method, it nullifies the current account and updates the user interface accordingly. In the `onError` method, it logs any errors that occur during the sign out process and updates the text log with the corresponding exception message.

Make sure you include the import statements. Android Studio should include the import statements for you automatically.

## Next steps

[Tutorial: Call a protected web API in Android (Kotlin) app](tutorial-mobile-app-android-kotlin-sign-in-call-api.md).
