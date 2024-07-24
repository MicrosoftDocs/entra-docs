---
title: Self-service password reset in Android app using native authentication
description: Learn how to implement self-service password reset (SSPR) to my Android app using native authentication.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 02/23/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want add self-service password reset (SSPR) to my Android app using native authentication so that users can reset their own password with no administrator or help desk involvement.
---

# Tutorial: Add self-service password reset  
 
This tutorial demonstrates how to enable users to change or reset their password, with no administrator or help desk involvement.
  
In this tutorial, you learn how to: 
 
> [!div class="checklist"]
>
> - Add self-service password reset (SSPR) flow.
> - Add the required user interface (UI) for SSPR to your app. 
> - Handle errors. 
 
## Prerequisites  
 
- Complete the steps in [Sign in users in a sample native Android mobile application](how-to-run-native-authentication-sample-android-app.md). This article shows you how to run a sample Android that you configure by using your tenant settings.  
- [Enable self-service password reset](how-to-enable-password-reset-customers.md). This article enables you to enable the email one-time passcode authentication method for all users in your tenant, which is a requirement for SSPR. 
- [Tutorial: Prepare your Android app for native authentication](tutorial-native-authentication-android-sign-up.md). 
 
## Add self-service password reset flow
 
To add SSPR flow to your Android application, you need a password reset user interface:  
 
- An input text field to collect user's email address (username).
- An input text field to collect one-time passcode.
- An input text field to collect new password.
 
When users forget their passwords, they need a form to input their usernames (email addresses) to start password reset flow. The user selects the **Forget Password** button or link.

### Start password reset flow

To handle the request when the user selects the **Forget Password** button or link, use the Android SDK's `resetPassword(username)` method as shown in the following code snippet:  
 
   ```kotlin 
    private fun forgetPassword() { 
     CoroutineScope(Dispatchers.Main).launch { 
         try { 
           val resetPasswordResult = authClient.resetPassword( 
                 username = emailAddress 
             ) 

            when (resetPasswordResult) { 
                is ResetPasswordStartResult.CodeRequired -> { 
                    // The implementation of submiteCode() please see below. 
                    submitCode(resetPasswordResult.nextState) 
                } 
                 is ResetPasswordError -> {
                     // Handle errors
                     handleResetPasswordError(resetPasswordResult)
                 }
            } 
        } catch (exception: MsalException) { 
             // Handle exception 
         } 
     } 
    } 
   ``` 

- `resetPassword(username)` method initiates password reset flow and an email one-time passcode is sent to the user's emails address for verification.  
- The return result of `resetPassword(username)` is either `ResetPasswordStartResult.CodeRequired` or `ResetPasswordError`.
- If `resetPasswordResult is ResetPasswordStartResult.CodeRequired`, the app needs to collect the email one-time passcode from the user and submits it as shown in [Submit email one-time passcode](#submit-email-one-time-passcode). 
- If `resetPasswordResult is ResetPasswordError`, Android SDK provides utility methods to enable you to analyze the specific errors further: 
      - `isUserNotFound()` 
      - `isBrowserRequired()` 

- These errors indicate that the previous operation was unsuccessful, and so a reference to a new state isn't available. Handle these errors as shown in [Handle errors](#handle-password-reset-errors) section.
 
### Submit email one-time passcode

Your app collects the email one-time passcode from the user. To submit the email one-time passcode, use the following code snippet:  
 
   ```kotlin 
   private suspend fun submitCode(currentState: ResetPasswordCodeRequiredState) { 
       val code = binding.codeText.text.toString() 
       val submitCodeResult = currentState.submitCode(code) 
 
       when (submitCodeResult) { 
           is ResetPasswordSubmitCodeResult.PasswordRequired -> { 
               // Handle success
               resetPassword(submitCodeResult.nextState) 
           } 
            is SubmitCodeError -> {
                // Handle errors
                handleSubmitCodeError(actionResult)
            }
       } 
   } 
   ```

- The return result of the `submitCode()` action is either `ResetPasswordSubmitCodeResult.PasswordRequired` or `SubmitCodeError`. 
- If `submitCodeResult is ResetPasswordSubmitCodeResult.PasswordRequired` the app needs to collect a new password from the user and submit it as shown in [Submit a new password](#submit-a-new-password). 
- If the user doesn't receive the email one-time passcode in their email, the app can resend the email one-time passcode. Use the following code snippet to resend a new email one-time passcode:  
  
   ```kotlin 
   private fun resendCode() { 
       clearCode() 
 
       val currentState = ResetPasswordCodeRequiredState 
 
       CoroutineScope(Dispatchers.Main).launch { 
           val resendCodeResult = currentState.resendCode() 
 
           when (resendCodeResult) { 
               is ResetPasswordResendCodeResult.Success -> { 
                   // Handle code resent success
               } 
               is ResendCodeError -> {
                    // Handle ResendCodeError errors
                }
           } 
       } 
   } 
   ``` 

    - The return result of the `resendCode()` action is either `ResetPasswordResendCodeResult.Success` or `ResendCodeError`. 

    - `ResendCodeError` is an unexpected error for SDK. This error indicates that the previous operation was unsuccessful, so a reference to a new state isn't available.

- If `submitCodeResult is SubmitCodeError`, Android SDK provides utility methods to enable you to analyze the specific errors further: 
    - `isInvalidCode()` 
    - `isBrowserRequired()` 
    
    These errors indicate that the previous operation was unsuccessful, and so a reference to a new state isn't available. Handle these errors as shown in [Handle errors](#handle-password-reset-errors) section.  

### Submit a new password
 
After you verify the user's email, you need to collect a new password from the user and submit it. The password that the app collects from the user need to meet [Microsoft Entra's password policies](/entra/identity/authentication/concept-password-ban-bad-combined-policy). Use the following code snippet:
 
```kotlin 
private suspend fun resetPassword(currentState: ResetPasswordPasswordRequiredState) { 
    val password = binding.passwordText.text.toString() 

    val submitPasswordResult = currentState.submitPassword(password) 

    when (submitPasswordResult) { 
        is ResetPasswordResult.Complete -> { 
            // Handle reset password complete. 
        } 
        is ResetPasswordSubmitPasswordError -> {
            // Handle errors
            handleSubmitPasswordError(actionResult)
        }
    } 
} 
``` 

- The return result of the `submitPassword()` action is either `ResetPasswordResult.Complete` or `ResetPasswordSubmitPasswordError`. 

- `ResetPasswordResult.Complete` indicates a successful password reset flow.
 
- If `submitPasswordResult is ResetPasswordSubmitPasswordError`, the SDK provides utility methods  for further analyzing the specific type of error returned: 
      - `isInvalidPassword()`
      - `isPasswordResetFailed()`

    These errors indicate that the previous operation was unsuccessful, and so a reference to a new state isn't available. Handle these errors as shown in [Handle errors](#handle-password-reset-errors) section.


## Auto sign in after password reset 

After a successful password reset flow, you can automatically sign in your users without initiating a fresh sign-in flow. 

The `ResetPasswordResult.Complete` returns `SignInContinuationState` object. The `SignInContinuationState` provides access to `signIn()` method.  
 
To automatically sign in users after a password reset, use the following code snippet:  

   ```kotlin 
    private suspend fun resetPassword(currentState: ResetPasswordPasswordRequiredState) { 
        val submitPasswordResult = currentState.submitPassword(password) 
    
        when (submitPasswordResult) { 
            is ResetPasswordResult.Complete -> { 
                signInAfterPasswordReset(nextState = actionResult.nextState)
            } 
        } 
    } 
    
    private suspend fun signInAfterPasswordReset(nextState: SignInContinuationState) {
         val currentState = nextState
         val actionResult = currentState.signIn()
         when (actionResult) {
             is SignInResult.Complete -> {
                 fetchTokens(accountState = actionResult.resultValue)
             }
             else {
                 // Handle unexpected error
             }
         }
     }
    
     private suspend fun fetchTokens(accountState: AccountState) {
         val accessTokenResult = accountState.getAccessToken()
         if (accessTokenResult is GetAccessTokenResult.Complete) {
             val accessToken =  accessTokenResult.resultValue.accessToken
             val idToken = accountState.getIdToken()
         }
    }
   ```

To retrieve ID token claims after sign-in, use the steps in [Read ID token claims](tutorial-native-authentication-android-sign-in-user-with-username-password.md#read-id-token-claims).

## Handle password reset errors 

A few expected errors might occur. For example, the user might attempt to reset the password with a nonexistent email or provide a password that doesn't meet the password requirements. 

When errors occur, give your users a hint to the errors.

These errors can happen at the start of password reset flow or at submit email one-time passcode or at submit password.  


### Handle start password reset error

To handle error caused by start password reset, use the following code snippet:

```kotlin
private fun handleResetPasswordError(error: ResetPasswordError) {
    when {
        error.isUserNotFound() -> {
            // Display error
        }
        else -> {
            // Unexpected error
        }
    }
}
```

### Handle submit email one-time passcode error

To handle error caused by submitting email one-time passcode, use the following code snippet:

```kotlin
private fun handleSubmitCodeError(error: SubmitCodeError) {
    when {
        error.isInvalidCode() -> {
            // Display error
        }
        else -> {
            // Unexpected error
        }
    }
}
```

### Handle submit password error

To handle error caused by submitting password, use the following code snippet:

```kotlin
private fun handleSubmitPasswordError(error: ResetPasswordSubmitPasswordError) {
    when {
        error.isInvalidPassword() || error.isPasswordResetFailed()
        -> {
            // Display error
        }
        else -> {
            // Unexpected error
        }
    }
}
```
[!INCLUDE [Custom claims provider](../customers/includes/native-auth/support-custom-claims-provider.md)]

## Next steps
 
[Tutorial: Support web fallback in Android app](tutorial-native-authentication-android-support-web-fallback.md) 
