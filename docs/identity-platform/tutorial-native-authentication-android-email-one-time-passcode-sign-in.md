---
title: Add email and SMS one-time passcode MFA to an Android app using native authentication
description: Learn how to add multi-factor authentication (MFA) with email and SMS one-time passcodes to an Android app using Microsoft Entra native authentication.

author: henrymbuguakiarie
manager: pmwongera

ms.author: henrymbugua
ms.service: identity-platform
ms.subservice: external
ms.topic: tutorial
ms.date: 01/26/2026
ms.custom:
#Customer intent: As a developer, I want to add email and SMS one-time passcode–based multi-factor authentication (MFA) to an Android app using native authentication, so I can secure user sign-in with an additional verification step.
---

# Tutorial: Add email one-time passcode MFA to your Android app

This tutorial demonstrates how to implement multi-factor authentication (MFA) into your Android app using the native authentication. MFA adds an extra layer of security to your app by requiring users to provide an extra verification step during sign-in. Currently, we support Email and SMS one-time passcode MFA.
We will also demonstrate how to enhance security during authentication and enforce MFA by using [authentication context](/entra/identity/conditional-access/concept-conditional-access-cloud-apps#authentication-context).

In this tutorial, you learn how to:

- Sign in a user with email one-time passcode MFA
- Specify the authentication context during user sign-in to enforce MFA.

## Prerequisites

1. Complete the steps in [Tutorial: Add sign-in in Android app by using native authentication](/entra/external-id/customers/tutorial-native-authentication-android-sign-in-sign-out).

1. To enable multifactor authentication (MFA) for your customers, follow the steps in [Add multifactor authentication (MFA) to an app](../external-id/customers/how-to-multifactor-authentication-customers.md). Currently, native authentication supports email one-time passcode as a second factor for MFA, which is available only when the primary authentication method is email with password.

1. If you'd like to explore our Sign-in with MFA implementation, take a look at our [Code sample](https://github.com/Azure-Samples/ms-identity-ciam-native-auth-android-sample) before getting started.

## Add MFA capabilities to the client configuration file

To support multi-factor authentication (MFA), update the Android client configuration to include the required MFA capabilities.


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
    "capabilities": ["mfa_required"],
    "logging": {
    "pii_enabled": false,
    "log_level": "INFO",
    "logcat_enabled": true
    }
}
```

## Sign in a user with email one-time passcode MFA

To sign in a user with email one-time passcode MFA, after collecting email and password, you need to send an email containing a one-time passcode for the user to verify their email. When the user enters a valid one-time passcode, the app signs them in.

To sign in a user with email one-time passcode MFA, you need to:

1. Create a user interface (UI) to:

    - Advise the user that MFA is required to sign in (optional).
    - Display to the user the possible `authMethods` and have them select the one with email (optional).
    - Collect an email one-time passcode from the user to fulfill second authenticator factor.
    - Resend one-time passcode (recommended).

1. Handle `MFARequired` sign in result:

    ```kotlin
    is SignInResult.MFARequired -> {
        // Handle "mfa required" result 
        val awaitingMFAState = actionResult.nextState

        // You can select the first authMethod which has a challengeChannel of type email
        // Or use "actionResult.authMethods" to let the user pick the authentication method to use.
        val authMethod = actionResult.authMethods.first {it.challengeChannel.uppercase() == "EMAIL"}        
        val requestChallengeResult = awaitingMFAState.requestChallenge(authMethod: authMethod)
        
        // Handle "mfa verification required" result 
        if (requestChallengeResult is MFARequiredResult.VerificationRequired) {
            // Next Step: submitChallenge using nextState
        } else {
            // Handle unexpected result as well as errors
        }
    }
    ```

    When signing in, if MFA is necessary, the system returns `SignInResult.MFARequired`. At this point, you can advise the user that MFA is required to proceed with the authentication, or you can call the `requestChallenge(authMethod)` method to send the one-time passcode to the user's email address. In most common scenario `requestChallenge(authMethod)`, returns a result `MFARequiredResult.VerificationRequired`, which indicates that the SDK expects the app to submit the email one-time passcode sent to the user's email address.

1. Handle `submitChallenge()` result:

    ```kotlin
    val mfaRequiredState = requestChallengeResult.nextState
    val submitChallengeResult = mfaRequiredState.submitChallenge(emailCode)
    
    when (submitChallengeResult) {
        is SignInResult.Complete -> {
            // Handle sign in success               
        }
        is SubmitChallengeError -> {
            // Handle "mfa submit challenge" error
        }
        else -> {
            // Handle unexpected result
        }
    }
    ```

    The `MFARequiredResult.VerificationRequired` object contains a new state reference, which you can retrieve through `requestChallengeResult.nextState`. The new state gives you access to the `submitChallenge()` method that you can use to submit the MFA challenge. 
    In most common scenario, the `submitChallenge()` returns a result, `SignInResult.Complete`, which indicates that the user has been authenticated successfully.

## Use authentication context during sign-in

Before specifying the authentication context during sign-in, please ensure that you configure the conditional access policy on the Microsoft Entra admin center by completing the steps listed in [Configure authentication contexts](/entra/identity/conditional-access/concept-conditional-access-cloud-apps#configure-authentication-contexts). 
After configuring the authentication context, you can specify this request claim during sign-in by using the following code snippet:

```kotlin
CoroutineScope(Dispatchers.Main).launch {
    val parameters = NativeAuthSignInParameters(username = email)
    parameters.password = password

    // before calling the signIn method, we need to specify the authentication context as request claim
    val authenticationContextClaim = "{\"access_token\":{\"acrs\":{\"essential\":true,\"value\":\"<authentication context id>\"}}}"
    parameters.claimsRequest = ClaimsRequest.getClaimsRequestFromJsonString(authenticationContextClaim)

    // now we can call the signIn method
    val actionResult = authClient.signIn(parameters)

    // Handle actionResult here
 }
```
At this point the MFA flow should be initiated, and the method `onSignInAwaitingMFA(newState)` will be invoked.
    
## Handle sign-in with email one-time passcode MFA errors

To handle errors that occur during MFA, you can use these code snippets:

1.  Handle errors for the `requestChallenge(authMethod:)` method:

    ```kotlin
    val requestChallengeResult = mfaRequiredState.requestChallenge(authMethod: authMethod)
    
    if (requestChallengeResult is MFARequiredResult.VerificationRequired) {
        // Next Step: submit challenge
    } else if (requestChallengeResult is MFARequestChallengeError) {
        // Handle errors under MFARequestChallengeError
        when {
            error.isBrowserRequired() -> {
                // Display error
            }
            else -> {
                // Unexpected error
            }
        }
    }
    ```

    The `MFARequestChallengeError` is handled after requesting an MFA challenge using `mfaRequiredState.requestChallenge(authMethod: authMethod)`. If the result is `MFARequiredResult.VerificationRequired`, the next step is to submit the challenge. 

1. Handle errors for the `submitChallenge(challenge)` method:

    ```kotlin
    val verifyChallengeResult = mfaRequiredState.submitChallenge(challenge = emailCode)
    
    if (verifyChallengeResult is SignInResult.Complete) {
        // Handle sign in success
    } else if (verifyChallengeResult is MFASubmitChallengeError) {
        // Handle errors under MFASubmitChallengeError
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

    The `MFASubmitChallengeError` is handled after submitting the challenge using `mfaRequiredState.submitChallenge(challenge = emailCode)`. Use the `isInvalidChallenge()` method to check for the specific error, such as, the submitted challenge is invalid. In this case, the previous state reference must be used to reperform the challenge submission.

## Next steps

- [Tutorial: Add Email strong authentication method registration to your Android app](tutorial-native-authentication-android-email-strong-auth-method-registration.md)

