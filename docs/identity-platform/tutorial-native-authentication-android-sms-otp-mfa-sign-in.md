---
title: Add SMS one-time passcode MFA to an Android app using native authentication
description: Learn how to add multi-factor authentication (MFA) with SMS one-time passcodes to an Android app using Microsoft Entra native authentication.

author: henrymbuguakiarie
manager: pmwongera

ms.author: henrymbugua
ms.service: identity-platform
ms.subservice: external
ms.topic: tutorial
ms.date: 01/26/2026
ms.custom:
#Customer intent: As a developer, I want to add SMS one-time passcode–based multi-factor authentication (MFA) to an Android app using native authentication, so I can require a second verification step during sign-in and strengthen app security.
---

# Tutorial: Add SMS one-time passcode MFA to your Android app

This tutorial shows you how to add multi-factor authentication (MFA) with SMS one-time passcode (OTP) to your Android app using native authentication. MFA adds an extra layer of security by requiring a second verification step during sign-in.
We will also demonstrate how to enhance security during authentication and enforce MFA by using [authentication context](/entra/identity/conditional-access/concept-conditional-access-cloud-apps#authentication-context). 

In this tutorial, you learn how to:

- Sign in a user with SMS one-time passcode MFA
- Specify an authentication context during sign-in to enforce MFA
- Handle sign-in with SMS one-time passcode MFA errors

## Prerequisites

1. Enroll in a Private Preview of SMS and Email OTP MFA on Native Authentication – [Fill out form](https://forms.office.com/r/P3m1q2j3hg)

2. Complete the steps in [Tutorial: Add sign-in and sign-out in Android app by using native authentication](tutorial-native-authentication-android-sign-in-sign-out.md).

3. Enable SMS as an MFA method in your tenant: follow the steps in [Enable SMS as an MFA method](../../../SMS-MFA/get-started-sms-mfa.md#enable-sms-as-an-mfa-method).

5. If you'd like to explore our Sign-in with MFA using SMS implementation, take a look at our [Code sample](https://github.com/Azure-Samples/ms-identity-ciam-native-auth-android-sample) before getting started.

## Add MFA capabilities to the client configuration file

To support multi-factor authentication (MFA), update the Android client configuration to include the required MFA capabilities.

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
    "capabilities": ["mfa_required"],
    "logging": {
    "pii_enabled": false,
    "log_level": "INFO",
    "logcat_enabled": true
    }
}
```

> [!NOTE] Currently there is a known issue using the SMS one time passcode with the authority format:
> `<tenantSubdomain>.ciamlogin.com/<tenantSubdomain>.onmicrosoft.com`
> because of that the following format should be used:
> `<tenantSubdomain>.ciamlogin.com/<tenantID>`

## Sign in a user with SMS one-time passcode MFA

To sign in a user with SMS one-time passcode MFA, after collecting first factor, you need to send an SMS containing a one-time passcode for the user to verify their phone number. When the user enters a valid one-time passcode, the app signs them in.

To sign in a user with SMS one-time passcode MFA, you need to:

1. Create a user interface (UI) to:

    - Advise the user that MFA is required to sign in (optional).
    - Collect a SMS one-time passcode from the user to fulfill second authenticator factor.
    - Resend one-time passcode (recommended).
  
1. Handle `MFARequired` sign in result:

    ```kotlin
    is SignInResult.MFARequired -> {
        // Handle "mfa required" result 
        val awaitingMFAState = actionResult.nextState

        // Select the authentication method from authMethods, either programmatically or through the UI, and assign it to authMethod.
        val authMethod = actionResult.authMethods.first {it.challengeChannel.uppercase() == "SMS"} 
        val requestChallengeResult = awaitingMFAState.requestChallenge(authMethod)
        
        // Handle "mfa verification required" result 
        if (requestChallengeResult is MFARequiredResult.VerificationRequired) {
            // Next Step: submitChallenge using nextState
        } else {
            // Handle unexpected result as well as errors
        }
    }
    ```

    When signing in, if MFA is necessary, the system returns `SignInResult.MFARequired`. At this point, you can advise the user that MFA is required to proceed with the authentication, or you can call the `requestChallenge(authMethod)` method to send the one-time passcode. In most common scenario `requestChallenge(authMethod)`, returns a result `MFARequiredResult.VerificationRequired`, which indicates that the SDK expects the app to submit SMS one-time passcode sent to the user's phone.

2. Handle `submitChallenge()` result:

    ```kotlin
    val mfaRequiredState = requestChallengeResult.nextState
    val submitChallengeResult = mfaRequiredState.submitChallenge(code)
    
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

[This](tutorial-native-authentication-android-email-otp-mfa-sign-in.md#use-authentication-context-during-sign-in) is how you can use authentication context during sign-in.

## Handle sign-in with SMS one-time passcode MFA errors

To handle errors that occur during MFA, implement error handling logic for both the challenge request and challenge submission:

1. Handle errors in the `requestChallenge` method:

    ```kotlin
    if (requestChallengeResult is MFARequiredResult.Error) {
        if (requestChallengeResult.isBrowserRequired()) {
            showResultText("Browser is required")
        } else {
            showResultText("Unexpected error while requesting challenge: ${requestChallengeResult.errorMessage}")
        }
    }
    ```

2. Handle errors in the `submitChallenge` method:

    ```kotlin
    if (result is SignInError) {
        if (result.isInvalidChallenge()) {
            // Inform the user that the submitted code was incorrect and ask for a new code
            // Optionally, allow resubmission using newState.submitChallenge(newCode, authMethod)
        } else {
            showResultText("Unexpected error occurred: ${result.errorMessage}")
        }
    }
    ```
 
## Next steps
- [Tutorial: Add SMS strong authentication method registration to your Android app](tutorial-native-authentication-android-sms-strong-auth-method-registration.md)

