---
title: Self-service password reset
description: Learn how to implement self-service password reset.

author: henrymbuguakiarie
manager: mwongerapk

ms.author: henrymbugua
ms.service: active-directory

ms.subservice: ciam
ms.topic: how-to
ms.date: 02/13/2024
ms.custom: developer
#Customer intent: As a dev, devops, I want to learn how to self-service password reset.
---

# Tutorial: Self-service password reset 
 
This tutorial demonstrates how to give users the ability to change or reset their password, with no administrator or help desk involvement. 
 
In this tutorial, you learn how to: 
 
- Add self-service password reset flow.
- Handle errors.
 
## Prerequisites 
 
- [Sign in users in a sample native Android mobile application](how-to-run-sample-android-app.md).
- [Enable self-service password reset](how-to-enable-password-reset-customers.md).
- [Tutorial: Add sign up, sign in and sign out with email one-time passcode](tutorial-native-auth-android-sign-up-sign-in-sign-out.md).
 
## Add self-service password reset flow 
 
To add self-service password reset flow to your Android application, you need a password reset user interface, which has: 
 
- One text field for email 
- One text field for one-time passcode (OTP) 
- One text field for new password 
- Submit button 

The following wire frame shows a high-level view of the self-service password reset flow:

:::image type="content" source="media/native-auth/android/SSPR_flow_image.png" alt-text="A mock-up image illustrates Self-service password reset flow.":::

 
To initialize the native authentication, import the Microsoft Authentication Library (MSAL) configuration in the `onCreateView` lifecycle as demonstrated in the following code: 
 
```kotlin 
authClient = PublicClientApplication.createNativeAuthPublicClientApplication( 
    requireContext(), 
    R.raw.native_auth_email_password_config 
) 
``` 
 
1. When a user forgets their password, they need a form to input their email. Here's sample user interface: 
    
    :::image type="content" source="media/native-auth/android/email_text_field.png" alt-text="Screenshot showing email input form.":::

    To handle the request when the user selects the **Forget Password** button, use the following code snippet: 
 
   ```kotlin 
    private fun forgetPassword() { 
        CoroutineScope(Dispatchers.Main).launch { 
            try { 
                val email = binding.emailText.text.toString() 
 
                val resetPasswordResult = authClient.resetPassword( 
                    username = email 
                ) 
 
               when (resetPasswordResult) { 
                   is ResetPasswordStartResult.CodeRequired -> { 
                       // The implementaion of submiteCode() please see below. 
                       submitCode( 
                           resetPasswordResult.nextState 
                       ) 
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
 
2. The use receives a one-time passcode in their email. The following image shows how to capture the one-time passcode: 
 
    :::image type="content" source="media/native-auth/android/code_text_field.png" alt-text="Screenshot showing OTP input form.":::
 
   To process the code submitted by the user, use the following code snippet: 
 
   ```kotlin 
   private suspend fun submitCode(currentState: ResetPasswordCodeRequiredState) { 
       val code = binding.codeText.text.toString() 
       val submitCodeResult = currentState.submitCode(code) 
 
       when (submitCodeResult) { 
           is ResetPasswordSubmitCodeResult.PasswordRequired -> { 
               // The implementaion of resetPassword() please see below. 
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

    If the submitted OTP is valid, the code sets the `nextState` to process a new user password. If the user doesn't receive the OTP in their email, they have the option to use "Resend Passcode" to request a new OTP. 
    
    To process this request, use the following code snippet: 
 
   ```kotlin 
   private fun resendCode() { 
       clearCode() 
 
       val currentState = ResetPasswordCodeRequiredState 
 
       CoroutineScope(Dispatchers.Main).launch { 
           val resendCodeResult = currentState.resendCode() 
 
           when (resendCodeResult) { 
               is ResetPasswordResendCodeResult.Success -> { 
                   currentState = resendCodeResult.nextState 
                   Toast.makeText(requireContext(), "Code sent", Toast.LENGTH_LONG).show() 
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

 
3. After verifying the user's email, you need to have the user create a new password. 
 
    :::image type="content" source="media/native-auth/android/password_text_field.png" alt-text="Screenshot showing password input form.":::
 
   To create new user password, use the following code snippet: 
 
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

This is an advanced version of the sign in flows [earlier described](tutorial-native-auth-sign-in-user-with-username-password.md), which has the added benefit of automatically signing in after successfully reset password. 

The `ResetPasswordResult.Complete` returns `SignInContinuationState` object. And `SignInContinuationState` provides access to `signIn()` method. 

To reset a user's password and then sign them in, you can use the following code snippet: 


   ```kotlin 
   private suspend fun resetPassword(currentState: ResetPasswordPasswordRequiredState) { 
       val password = binding.passwordText.text.toString() 
 
       val submitPasswordResult = currentState.submitPassword(password) 
 
       when (submitPasswordResult) { 
           is ResetPasswordResult.Complete -> { 
               signInAfterPasswordReset(
                    nextState = actionResult.nextState
                )
           } 
       } 
   } 

   private suspend fun signInAfterPasswordReset(nextState: SignInContinuationState) {
        val currentState = nextState
        val actionResult = currentState.signIn()
        when (actionResult) {
            is SignInResult.Complete -> {
                // Sign in complete
                fetchTokens(
                    accountState = actionResult.resultValue
                )
            }
            else {
                // Unexpected error
            }
        }
    }

    private suspend fun fetchTokens(accountState: AccountState) {
        val accessTokenState = accountState.getAccessToken()
            if (accessTokenState is GetAccessTokenResult.Complete) {
                val accessToken = accessTokenState.resultValue.accessToken
                val idToken = accountState.getIdToken()
            }
        }
```

## Handle errors
A few common, expected error states exist. For example, the user might attempt to reset the password with a nonexistent email or provide a password that doesn't meet the password requirements. Giving your users a hint to those errors is the simplest way to handle them.

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
 
## Next Steps 
 
[Tutorial: Support web fallback in Android app ](tutorial-native-auth-support-web-fallback.md)

