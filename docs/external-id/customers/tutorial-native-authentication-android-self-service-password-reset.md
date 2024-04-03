---
title: Android self-service password reset
description: Learn how to implement self-service password reset in Android.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: entra-external-id

ms.subservice: customers
ms.topic: tutorial
ms.date: 02/23/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to learn how to self-service password reset.
---

# Tutorial: Self-service password reset  
 
This tutorial demonstrates how to give users the ability to change or reset their password, with no administrator or help desk involvement.  
  
In this tutorial, you learn how to: 
 
- Add self-service password reset flow. 
- Handle errors. 
 
## Prerequisites  
 
- [Sign in users in a sample native Android mobile application](how-to-run-native-authentication-sample-android-app.md). 
- [Enable self-service password reset](how-to-enable-password-reset-customers.md). 
- [Tutorial: Prepare your Android app for native authentication](tutorial-native-authentication-android-sign-up.md). 
 
## Add self-service password reset flow  
 
To add self-service password reset flow to your Android application, you need a password reset user interface, which has:  
 
- A UI to submit email.
- A UI to submit one-time passcode.
- A UI to submit new password.
- Submit button.
 
1. When users forget their passwords, they need a form to input their usernames (email addresses). To handle the request when the user selects the **Forget Password** button, use the following code snippet:  
 
   ```kotlin 
    private fun forgetPassword() { 
     CoroutineScope(Dispatchers.Main).launch { 
         try { 
           val resetPasswordResult = authClient.resetPassword( 
                 username = emailAddress 
             ) 

            when (resetPasswordResult) { 
                is ResetPasswordStartResult.CodeRequired -> { 
                    // The implementaion of submiteCode() please see below. 
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
    The code snippet generates a one-time passcode and sends it to the user's email for verification.  

    The return result of the `resetPassword()` action is either `ResetPasswordStartResult.CodeRequired` or `ResetPasswordError`. 

    In the case of `ResetPasswordError`, the SDK provides utility methods  for further analyzing the specific type of error returned: 
      - `isUserNotFound()` 
      - `isBrowserRequired()` 

    Errors such as these indicate that the previous operations were unsuccessful, and because of that they don't include a reference to a new state. 
 
2. The user receives a one-time passcode in their email. To process the code submitted by the user, use the following code snippet:  
 
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

    The return result of the `submitCode()` action is either `ResetPasswordSubmitCodeResult.PasswordRequired` or `SubmitCodeError`. 

    In the case of `SubmitCodeError`, the SDK provides utility methods  for further analyzing the specific type of error returned: 
      - `isInvalidCode()` 
      - `isBrowserRequired()` 
    
    Errors such as these indicate that the previous operations were unsuccessful, and because of that they don't include a reference to a new state. 

    If the submitted one-time passcode is valid, the code sets the `nextState` to process a new user password. If the user doesn't receive the one-time passcode in their email, they have the option to use "Resend Passcode" to request a new one-time passcode.  
    
    Use the following code snippet to resend a new passcode:  
  
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

    The return result of the `resendCode()` action is either `ResetPasswordResendCodeResult.Success` or `ResendCodeError`. 

    If it's `ResendCodeError`, it's an unexpected error for SDK. The previous operation was unsuccessful, and because of that they don't include a reference to a new state. 

 
3. After verifying the user's email, you need to have the user create a new password. To create new user password, use the following code snippet:  
 
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

    The return result of the `submitPassword()` action is either `ResetPasswordResult.Complete` or `ResetPasswordSubmitPasswordError`. 

    In the case of `ResetPasswordSubmitPasswordError`, the SDK provides utility methods  for further analyzing the specific type of error returned: 
      - `isInvalidPassword()`
      - `isPasswordResetFailed()`

    Errors such as these indicate that the previous operations were unsuccessful, and because of that they don't include a reference to a new state. 

Assuming no errors occur during the process, you have built a self-service password reset flow.  

## Sign in after password reset 

This is an advanced version of the sign in flows [earlier described](tutorial-native-authentication-android-sign-in-user-with-username-password.md), which has the added benefit of automatically signing in after successfully reset password.  

The `ResetPasswordResult.Complete` returns `SignInContinuationState` object. And `SignInContinuationState` provides access to `signIn()` method.  
 
To reset a user's password and then sign them in, you can use the following code snippet:  


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

## Handle errors 
A few common, expected errors might occur. For example, the user might attempt to reset the password with a nonexistent email or provide a password that doesn't meet the password requirements. Giving your users a hint to those errors is the simplest way to handle them. 

To handle the errors during password reset, use the following code snippet: 

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
 
## Next steps  
 
[Tutorial: Support web fallback in Android app](tutorial-native-authentication-android-support-web-fallback.md) 

