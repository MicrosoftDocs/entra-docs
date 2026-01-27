---
title: Add email strong authentication method registration to an Android app using native authentication
description: Learn how to register an email one-time passcode as a strong authentication method for MFA-enabled users in an Android app using Microsoft Entra native authentication.

author: henrymbuguakiarie
manager: pmwongera

ms.author: henrymbugua
ms.service: identity-platform
ms.subservice: external
ms.topic: tutorial
ms.date: 01/27/2026
ms.custom:
#Customer intent: As a developer, I want to register an email one-time passcode as a strong authentication method for MFA-enabled users in an Android app using native authentication, so users can complete MFA when no strong authentication method is registered.
---

# Tutorial: Add Email strong authentication method registration to your Android app

This tutorial demonstrates how to implement Email strong authentication method registration into your Android app using native authentication. At least one strong authentication is mandatory for MFA-enabled users. Currently, we only support Email and SMS one-time passcode as strong authentication method.

In this tutorial, you learn how to: 

- Register a strong authentication method for an MFA-enabled user.
- Handle strong authentication method registration errors.

## Prerequisites

1. Complete the steps in [Tutorial: Add sign-in in Android app by using native authentication](tutorial-native-authentication-android-sign-in-sign-out.md).

1. To enforce multifactor authentication (MFA) for your customers, use the steps in [Add multifactor authentication (MFA) to an app](../external-id/customers/how-to-multifactor-authentication-customers.md) to add Email OTP MFA to your sign-in flow. Currently, native authentication supports Email and SMS one-time passcode as a second factor for MFA. Therefore, email OTP as second factor is only available when the authentication method is email with password.

1. If you'd like to explore our strong authentication method registration implementation, take a look at our [Code sample](https://github.com/Azure-Samples/ms-identity-ciam-native-auth-android-sample) before getting started.


## Add strong authentication method registration to the client configuration file

To support strong authentication method, update the Android client configuration to include the required registration capabilities.

```json
{
    "client_id": "Enter_the_Application_Id_Here",
    "authorities": [
    {
        "type": "CIAM",
        "authority_url": "https://Enter_the_Tenant_Subdomain_Here.ciamlogin.com/Enter_the_Tenant_Subdomain_Here.onmicrosoft.com/"
    }
    ],
    "challenge_types": ["oob", "password"],
    "capabilities": ["registration_required"],
    "logging": {
    "pii_enabled": false,
    "log_level": "INFO",
    "logcat_enabled": true
    }
}
```

## Register Email one-time passcode as strong authentication method

To register an email one-time passcode for an MFA-enabled user, you can either use the default email address provided during account creation or specify an alternative email address as the strong authentication method. This process is triggered only the first time the MFA is required, and the user doesn't have a strong authentication method registered. Afterward, you need to send an email containing a one-time passcode for the user to verify their email address. Once the user enters a valid one-time passcode, the app completes the sign-in process.

To register a strong authentication method (email one-time passcode) for MFA-enabled user, you need to:

1. Create a user interface (UI) to:

    - Advise the user that strong authentication method registration is required to sign in (optional).
    - Collect an email address to be registered as strong authentication method. If the user doesn't provide an email address, the default email address provided during account creation will be used.
    - Collect an email one-time passcode from the user to fulfill two-factor authentication.
    - Resend one-time passcode (recommended).
  
2. Handle `StrongAuthMethodRegistrationRequired` sign in result:

   ```kotlin
    val parameters = NativeAuthSignInParameters(username = email)
    parameters.password = password 
    val signInResult: SignInResult = authClient.signIn(parameters) 
   
    when (actionResult) {
        // Handle "strong authentication method registration required" result 
        is SignInResult.StrongAuthMethodRegistrationRequired -> {
            val authMethod = actionResult.authMethods.first {it.challengeChannel.uppercase() == "EMAIL"}
            // Next Step: challengeAuthMethod using nextState 
        }
    }
    ```

    When signing in, if MFA is necessary and there's no strong authentication registered, the system returns `SignInResult.StrongAuthMethodRegistrationRequired`, require the user to specify an alternative email address as the strong authentication method, or to use the default email address provided during account creation.

3. Handle `challengeAuthMethod()` result:

    ```kotlin
    val registerStrongAuthState = signInResult.nextState
    verificationContact = "user@contoso.com" // Do NOT hard-code email in production. Use the email provided during account creation or prompt the user for input.
    val params = NativeAuthChallengeAuthMethodParameters(authMethod, verificationContact = verificationContact)
    val challengeAuthResult = registerStrongAuthState.challengeAuthMethod(params)
    
    when (challengeAuthResult) {
        is RegisterStrongAuthChallengeResult.VerificationRequired -> {
            // Next Step: submitChallenge using nextState
        }
        is RegisterStrongAuthChallengeError -> {
            // Handle "register strong auth challenge" error
        }
        else -> {
            // Handle unexpected result
        }
    }
    ```

    The `challengeAuthMethod()` method sends a one-time passcode to the email address specified in `verificationContact`. In most common scenario `challengeAuthMethod()`, returns a result `RegisterStrongAuthChallengeResult.VerificationRequired`, which indicates that the SDK expects the app to submit the email one-time passcode sent to email address. The `RegisterStrongAuthChallengeResult.VerificationRequired` object contains a new state reference, which you can retrieve through `challengeAuthResult.nextState`. The new state gives you access to the `submitChallenge()` method that you can use to submit the email one-time passcode sent to the user's email address.

4. Handle `submitChallenge()` result:

    ```kotlin
    val registerStrongAuthVerificationRequiredState = challengeAuthResult.nextState
    val submitChallengeResult = registerStrongAuthVerificationRequiredState.submitChallenge(emailCode)
    
    when (actionResult) {
        is SignInResult.Complete -> {
            // Handle sign in success      
        }
        is RegisterStrongAuthSubmitChallengeError -> {
            // Handle "register strong auth submit challenge" error
        }
        else -> {
            // Handle unexpected result      
        }
    }
    ```

    In most common scenario, `submitChallenge()` returns the result `SignInResult.Complete`, which indicates that the user has been authenticated successfully.


## Handle strong authentication method registration errors

To handle errors that occur during strong authentication method registration, you can use these code snippets:

1.  Handle errors for the `challengeAuthMethod()` method:

    ```kotlin
    val challengeAuthResult = registerStrongAuthState.challengeAuthMethod(params)
    
    if (challengeAuthResult is RegisterStrongAuthChallengeResult.VerificationRequired) {
        // Next Step: submit challenge
    } else if (challengeAuthResult is RegisterStrongAuthChallengeError) {
        // Handle errors under RegisterStrongAuthChallengeError
        when {
            error.isInvalidInput() -> {
                // Display error
            }
            else -> {
                // Unexpected error
            }
        }
    }
    ```

    The `RegisterStrongAuthChallengeError` is handled after registering a challenge using `registerStrongAuthState.challengeAuthMethod()` method. Use the `isInvalidInput()` method to check for the specific error, such as, the entered verification contact is invalid. In this case, the previous state reference must be used to send a new challenge.


2. Handle errors for the `submitChallenge()` method:

    ```kotlin
    val submitChallengeResult = registerStrongAuthVerificationRequiredState.submitChallenge(challenge = emailCode)
    
    if (submitChallengeResult is SignInResult.Complete) {
        // Handle sign in success
    } else if (submitChallengeResult is RegisterStrongAuthSubmitChallengeError) {
        // Handle errors under RegisterStrongAuthSubmitChallengeError
        when {
            error.isInvalidChallenge() -> {
                // Display error
            }
            else -> {
                // Unexpected error
            }
        }
    }
    ```

    The `RegisterStrongAuthSubmitChallengeError` is handled after submitting the challenge using `registerStrongAuthVerificationRequiredState.submitChallenge(challenge = emailCode)`. Use the `isInvalidChallenge()` method to check for the specific error, such as, the submitted challenge is invalid. In this case, the previous state reference must be used to reperform the challenge submission.
 
## Next steps

- [Tutorial: Add SMS one-time passcode MFA to your Android app](tutorial-native-authentication-android-sms-one-time-passcode-sign-in.md)
