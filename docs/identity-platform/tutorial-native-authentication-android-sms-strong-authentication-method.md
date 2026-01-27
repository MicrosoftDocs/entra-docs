---
title: Add SMS strong authentication method registration to an Android app using native authentication
description: Learn how to register an SMS one-time passcode as a strong authentication method for MFA-enabled users in an Android app using Microsoft Entra native authentication.

author: henrymbuguakiarie
manager: pmwongera

ms.author: henrymbugua
ms.service: identity-platform
ms.subservice: external
ms.topic: tutorial
ms.date: 01/26/2026
ms.custom:
#Customer intent: As a developer, I want to register an SMS one-time passcode as a strong authentication method for MFA-enabled users in an Android app using native authentication, so users can complete MFA when no strong authentication method is registered.
---

# Tutorial: Add SMS strong authentication method registration to your Android app

This tutorial demonstrates how to implement SMS strong authentication method registration into your Android app using native authentication. At least one strong authentication is mandatory for MFA-enabled users. Currently, we only support Email and SMS one-time passcode as strong authentication method.

In this tutorial, you learn how to: 

- Register a strong authentication method for an MFA-enabled user.
- Handle strong authentication method registration errors.

## Prerequisites

1. Enroll in a Private Preview of SMS and Email OTP MFA on Native Authentication – [Fill out form](https://forms.office.com/r/P3m1q2j3hg)

1. Complete the steps in [Tutorial: Add sign-in in Android app by using native authentication](tutorial-native-authentication-android-sign-in-sign-out.md).

1. To enforce multifactor authentication (MFA) for your customers, use the steps in [Add multifactor authentication (MFA) to an app](../external-id/customers/how-to-multifactor-authentication-customers.md) to add SMS MFA to your sign-in flow. Currently, native authentication supports Email and SMS one-time passcode as a second factor for MFA. 

1. If you'd like to explore our strong authentication method registration implementation, take a look at our [Code sample](https://github.com/Azure-Samples/ms-identity-ciam-native-auth-android-sample) before getting started.

## Add strong authentication method registration to the client configuration file

> [!NOTE] 
> Currently there is a known issue using the SMS one time passcode with the authority format:
> `<tenantSubdomain>.ciamlogin.com/<tenantSubdomain>.onmicrosoft.com`
> because of that the following format should be used:
> `<tenantSubdomain>.ciamlogin.com/<tenantID>`

To support strong authentication method, update the Android client configuration to include the required registration capabilities.

```json
{
    "client_id": "Enter_the_Application_Id_Here",
    "authorities": [
    {
        "type": "CIAM",
        "authority_url": "https://Enter_the_Tenant_Subdomain_Here.ciamlogin.com/Enter_the_Tenant_Id_Here/"
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

## Register SMS one-time passcode as strong authentication method

To register an SMS one-time passcode for an MFA-enabled user, you need to specify a phone number as the strong authentication method. This process is triggered only the first time the MFA is required, and the user doesn't have a strong authentication method registered. Afterward, you need to send an SMS containing a one-time passcode for the user to verify their phone number. Once the user enters a valid one-time passcode, the SDK completes the sign-in process.

To register a strong authentication method (SMS one-time passcode) for MFA-enabled user, you need to:

1. Create a user interface (UI) to:

    - Advise the user that strong authentication method registration is required to sign in (optional).
    - Collect a phone number to be registered as strong authentication method. The user must provide a phone number to have it registered as a strong authentication method.
    - Collect an SMS one-time passcode from the user to fulfill two-factor authentication.
    - Resend one-time passcode (recommended).

  
2. Handle `StrongAuthMethodRegistrationRequired` sign in result:

   ```kotlin
    val parameters = NativeAuthSignInParameters(username = email)
    parameters.password = password 
    val signInResult: SignInResult = authClient.signIn(parameters) 
   
    when (actionResult) {
        // Handle "strong authentication method registration required" result 
        is SignInResult.StrongAuthMethodRegistrationRequired -> {
            val authMethod = actionResult.authMethods.first {it.challengeChannel.uppercase() == "SMS"}
            // Next Step: challengeAuthMethod using nextState
        }
    }
    ```

    When signing in, if MFA is necessary and there is no strong authentication registered, the system returns `SignInResult.StrongAuthMethodRegistrationRequired`, require the user to specify a phone number as the strong authentication method.

3. Handle `challengeAuthMethod()` result:

    ```kotlin
    val registerStrongAuthState = signInResult.nextState
    val verificationContact = "<phone number>" // format should be "<+prefix phone_number>"
    val params = NativeAuthChallengeAuthMethodParameters(authMethod, verififcationContact)
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

    The `challengeAuthMethod()` method sends a one-time passcode to the phone number specified in `verificationContact`. `challengeAuthMethod()`, returns a result `RegisterStrongAuthChallengeResult.VerificationRequired`, which indicates that the SDK expects the app to send an SMS one-time passcode sent to phone number. The `RegisterStrongAuthChallengeResult.VerificationRequired` object contains a new state reference, which you can retrieve through `challengeAuthResult.nextState`. The new state gives you access to the `submitChallenge()` method that you can use to submit the SMS one-time passcode sent to the user's phone number.

4. Handle `submitChallenge()` result:

    ```kotlin
    val registerStrongAuthVerificationRequiredState = challengeAuthResult.nextState
    val submitChallengeResult = registerStrongAuthVerificationRequiredState.submitChallenge(smsCode)
    
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
        // define error from the typed variable
        val error = challengeAuthResult

        // Handle errors under RegisterStrongAuthChallengeError
        when {
            error.isInvalidInput() -> {
                // Display error
            }
            error.isAuthMethodBlocked() -> {
                // Authentication method selected has been blocked. Reach out to customer support  to seek assistance.
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
    val submitChallengeResult = registerStrongAuthVerificationRequiredState.submitChallenge(challenge = smsCode)
    
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

    The `RegisterStrongAuthSubmitChallengeError` is handled after submitting the challenge using `registerStrongAuthVerificationRequiredState.submitChallenge(challenge = smsCode)`. Use the `isInvalidChallenge()` method to check for the specific error, such as, the submitted challenge is invalid. In this case, the previous state reference must be used to reperform the challenge submission.
 
## Next steps

- [Tutorial: Add self-service password reset](tutorial-native-authentication-android-self-service-password-reset.md)
