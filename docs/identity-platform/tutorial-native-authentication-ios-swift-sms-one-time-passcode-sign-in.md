---
title: Add SMS one-time passcode MFA to an iOS and macOS app using native authentication
description: Learn how to add multi-factor authentication (MFA) with SMS one-time passcode (OTP) to an iOS or macOS app using native authentication, including enforcing MFA with authentication context and handling MFA errors.

author: henrymbuguakiarie
manager: pmwongera

ms.author: henrymbugua
ms.service: identity-platform
ms.subservice: external
ms.topic: tutorial
ms.date: 01/27/2026
ms.custom:
# Customer intent: As a developer or DevOps engineer, I want to add SMS one-time passcode (OTP) multi-factor authentication to an iOS or macOS app using native authentication so that I can enforce MFA during sign-in and securely handle MFA challenges and errors.
---

# Tutorial: Add SMS one-time passcode MFA to your iOS/macOS app

This tutorial shows you how to add multi-factor authentication (MFA) with SMS one-time passcode (OTP) to your iOS/macOS app using native authentication. MFA adds an extra layer of security by requiring a second verification step during sign-in. 
We will also demonstrate how to enhance security during authentication and enforce MFA by using [authentication context](/entra/identity/conditional-access/concept-conditional-access-cloud-apps#authentication-context). 

In this tutorial, you learn how to:

- Sign in a user with SMS one-time passcode MFA
- Specify an authentication context during sign-in to enforce MFA
- Handle sign-in with SMS one-time passcode MFA errors

## Prerequisites

1. Complete the steps in [Tutorial: Add sign-in and sign-out in iOS/macOS app by using native authentication](tutorial-native-authentication-ios-macos-sign-in-sign-out.md).

1. Enable SMS as an MFA method in your tenant: follow the steps in [Enable SMS as an MFA method](../identity/authentication/howto-authentication-sms-signin.md#enable-the-sms-based-authentication-method).

1. If you'd like to explore our Sign-in with SMS one time passcode MFA implementation, take a look at our [Code sample](https://github.com/Azure-Samples/ms-identity-ciam-native-auth-ios-sample) before getting started.

## Configure client capabilities to require MFA

> [!NOTE] 
> Currently there is a known issue using the SMS one time passcode with the authority format:
> `<tenantName>.ciamlogin.com/<tenantName>.onmicrosoft.com`
> because of that the following format should be used:
> `<tenantName>.ciamlogin.com/<tenantID>`

Configure the client with the appropriate capabilities value to enforce MFA during native authentication initialization.

```swift
let tenantId = "00000000-0000-0000-0000-000000000000" //Replace with your tenant ID
let authority = try MSALCIAMAuthority(url: URL(string: "https://\(Configuration.tenantSubdomain).ciamlogin.com/\(tenantId)")!)
let config = MSALNativeAuthPublicClientApplicationConfig(clientId: Configuration.clientId, authority: authority, challengeTypes: [.OOB, .password])
config.capabilities = [.mfaRequired]
nativeAuth = try MSALNativeAuthPublicClientApplication(nativeAuthConfiguration: config)
```

## Sign in a user with SMS one-time passcode MFA

To sign in a user with SMS one-time passcode MFA, after collecting first factor, you need to send an SMS containing a one-time passcode for the user to verify their phone number. When the user enters a valid one-time passcode, the app signs them in.

To sign in a user with SMS one-time passcode MFA, you need to:
1. Create a user interface (UI) to:

    - Advise the user that MFA is required to sign in (optional).
    - Display to the user the possible `authMethods` and have them select the one with phone SMS (optional).
    - Collect a SMS one-time passcode from the user to fulfill second authenticator factor.
    - Resend one-time passcode (recommended).
  
1. Implement the `onSignInAwaitingMFA` method as part of the `SignInStartDelegate` protocol:

   ```swift
    extension ViewController: SignInStartDelegate {
    
        // previous code omitted
    
        func onSignInAwaitingMFA(authMethods: [MSALAuthMethod], newState: AwaitingMFAState) {
            // inform the user that MFA is required
            let alert = UIAlertController(
                title: "MFA required", 
                message: "Do you want to proceed with MFA?", 
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                // You can select the first authMethod which has a channelgeChannel of type email
                // Or use "actionResult.authMethods" to let the user pick the authentication method to use.
                var authMethod = actionResult.authMethods.first { $0.channelTargetType.isEmailType }
                self.authMethod = authMethod
                newState.requestChallenge(authMethod: authMethod, delegate: self)
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                self.resultTextView.text = "Second factor authentication required"
            }))
            
            present(alert, animated: true)
        }
    }
    ```

    The `signIn(username:delegate)` results in a call to delegate methods. The `onSignInAwaitingMFA(authMethods:newState)` method handles the scenario where MFA is required. You present an alert to the user, asking if they want to proceed with MFA. If the user chooses **OK** you request the MFA challenge by calling `newState.requestChallenge(authMethod: authMethod delegate: self)`. The `newState.requestChallenge(authMethod: authMethod, delegate: self)` method sends the one-time passcode to the user's phone number.

    If you prefer not to inform the user about the necessity for MFA, you can bypass the user interaction by directly invoking `newState.requestChallenge(authMethod: authMethod, delegate: self)`.
    The `requestChallenge(authMethod: delegate)` requires the authMethod to be specified where the SMS should be sent and accepts a delegate parameter. You must implement the required methods in the `MFARequestChallengeDelegate` protocol.

1. Implement the `MFARequestChallengeDelegate` protocol:

    ```swift
    extension ViewController: MFARequestChallengeDelegate {
        
        func onMFARequestChallengeError(error: MFARequestChallengeError, newState: MFARequiredState?) {
            resultTextView.text = "Error requesting MFA challenge: \(error.errorDescription ?? "no description")"
        }
    
        func onMFARequestChallengeVerificationRequired(
            newState: MFARequiredState,
            sentTo: String,
            channelTargetType: MSALNativeAuthChannelType,
            codeLength: Int
        ) {
            let code = retrieveCodeFromUser()
            newState.submitChallenge(challenge: code, delegate: self)
        }
    }
    ```

    In the most common scenario, you receive a call to `onMFARequestChallengeVerificationRequired(newState:sentTo:channelTargetType:codeLength)` to indicate that a code has been sent to verify the user's phone number. Once you collect the one-time passcode from the user, you can call the `submitChallenge` calls like this `newState.submitChallenge(challenge: code, delegate: self)`. The `submitChallenge` accepts a delegate parameter and you must implement the required methods in the `MFASubmitChallengeDelegate` protocol.

1. Implement the `MFASubmitChallengeDelegate` protocol:

    ```swift
    extension MultiFactorAuthenticationViewController: MFASubmitChallengeDelegate {
    
        func onMFASubmitChallengeError(error: MFASubmitChallengeError, newState: MFARequiredState?) {
            resultTextView.text = "Error submitting MFA challenge: \(error.errorDescription ?? "no description")"
            newState.submitChallenge(challenge: "newCode", delegate: self)
        }
    
        func onSignInCompleted(result: MSALNativeAuthUserAccountResult) {
            print("Signed in as: \(result.account.username ?? "unknown user")")
        }
    }
    ```

    The `MFASubmitChallengeDelegate` protocol enables you to handle MFA code submission and verification. It provides methods to manage errors, such as invalid codes through `onMFASubmitChallengeError`, allowing resubmission. When the MFA is successful, `onSignInCompleted` finalizes the sign-in process. Implementing this delegate ensures smooth MFA handling during authentication.

## Use authentication context during sign-in

[This](tutorial-native-authentication-ios-swift-email-one-time-passcode-sign-in.md#use-authentication-context-during-sign-in) is how you can use authentication context during sign-in. 

## Handle sign-in with SMS one-time passcode MFA errors

To handle errors that occur during MFA, you need to implement the following methods:

1. To handle errors in the `requestChallenge` method, use the following code snippet

    ```swift
    func onMFARequestChallengeError(error: MFARequestChallengeError, newState: MFARequiredState?) {
        if error.isBrowserRequired {
            showResultText("Browser is required")
        } else if error.isAuthMethodBlocked {
            showResultText("Authentication method selected has been blocked. Reach out to customer support  to seek assistance.")
        } else {
            showResultText("Unexpected error while requesting challenge: \(error.errorDescription ?? "No error description")")
        }
    }
    ```
    
    The `onMFARequestChallengeError` function handles errors that occur during an MFA request challenge.
    
1.  To handle errors in the `submitChallenge(challenge)` method, use the following code snippet

    ```swift
    func onMFASubmitChallengeError(error: MFASubmitChallengeError, newState: MFARequiredState?) {
        if error.isInvalidChallenge {
            // Inform the user that the submitted code was incorrect and ask for a new code to be supplied
            let userSuppliedCode = retrieveNewCode()
            newState.submitChallenge(challenge: userSuppliedCode, delegate: self)
        } else {
            showResultText("Unexpected error occurred: \(error.errorDescription ?? "No error description")")
        }
    }
    ```
    
    The `onMFASubmitChallengeError` function handles errors that occur during the submission of an MFA challenge. In case the challenge submitted is invalid, you can use the `newState` parameter to submit a new challenge.
 
## Next steps
- [Tutorial: Add Phone SMS strong authentication method registration to your iOS/macOS app](tutorial-native-authentication-ios-swift-sms-strong-authentication-method.md)
