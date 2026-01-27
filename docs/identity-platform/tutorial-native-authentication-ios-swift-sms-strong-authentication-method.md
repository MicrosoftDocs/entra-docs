---
title: Add phone SMS strong authentication method registration to an iOS and macOS app using native authentication
description: Learn how to register phone SMS as a strong authentication method for MFA-enabled users in an iOS or macOS app using native authentication, including configuring client capabilities and handling registration challenges.

author: henrymbuguakiarie
manager: pmwongera

ms.author: henrymbugua
ms.service: identity-platform
ms.subservice: external
ms.topic: tutorial
ms.date: 11/17/2025
ms.custom:
# Customer intent: As a developer or DevOps engineer, I want to register phone SMS as a strong authentication method for MFA-enabled users in an iOS or macOS app using native authentication so that users can complete MFA securely during sign-in.
---

# Tutorial: Add Phone SMS strong authentication method registration to your iOS/macOS app

This tutorial demonstrates how to implement SMS strong authentication method registration into your iOS/macOS app using native authentication. At least one strong authentication is mandatory for MFA-enabled users. Currently, we support email and SMS one-time passcode as strong authentication method.

In this tutorial, you learn how to:

- Register SMS as a strong authentication method for a MFA-enabled user.


## Prerequisites

1. Complete the steps in [Tutorial: Add sign-in and sign-out in iOS/macOS app by using native authentication](tutorial-native-authentication-ios-macos-sign-in-sign-out.md).

1. To enforce multifactor authentication (MFA) for your customers, use the steps in [Add SMS one-time passcode MFA to your iOS/macOS app](../external-id/customers/how-to-multifactor-authentication-customers.md) to add SMS one time passcode MFA to your sign-in flow. We support email and SMS one-time passcode MFA.

1. If you'd like to explore our strong authentication method registration implementation, take a look at our [Code sample](https://github.com/Azure-Samples/ms-identity-ciam-native-auth-ios-sample) before getting started.

## Configure client capabilities for strong authentication method registration

> [!NOTE] 
> Currently there is a known issue using the SMS one time passcode with the authority format:
> `<tenantName>.ciamlogin.com/<tenantName>.onmicrosoft.com`
> because of that the following format should be used:
> `<tenantName>.ciamlogin.com/<tenantID>`

Configure the client with the capabilities parameter to require strong authentication method registration when initializing the native authentication client.

```swift
let tenantId = "00000000-0000-0000-0000-000000000000" //Replace with your tenant ID
let authority = try MSALCIAMAuthority(url: URL(string: "https://\(Configuration.tenantSubdomain).ciamlogin.com/\(tenantId)")!)
let config = MSALNativeAuthPublicClientApplicationConfig(clientId: Configuration.clientId, authority: authority, challengeTypes: [.OOB, .password])
config.capabilities = [.registrationRequired]
nativeAuth = try MSALNativeAuthPublicClientApplication(nativeAuthConfiguration: config)
```


## Register SMS one-time passcode as strong authentication method

To register a SMS one-time passcode for an MFA-enabled user, you need to specify a phone number as the strong authentication method. This process is triggered only the first time the MFA is required, and the user doesn't have a strong authentication method registered. Afterward, you need to send an SMS containing a one-time passcode for the user to verify their phone number. Once the user enters a valid one-time passcode, the SDK completes the sign-in process.

To register a strong authentication method (phone SMS passcode) for MFA-enabled user, you need to:

1. Create a user interface (UI) to:

    - Advise the user that strong authentication method registration is required to sign in (optional).
    - Collect a phone number to be registered as strong authentication method (optional). The user must provide a phone number to have it registed as a strong auth method.
    - Collect a SMS one-time passcode from the user to fulfill two-factor authentication.
    - Resend one-time passcode (recommended).
  
2. Implement the `onSignInStrongAuthMethodRegistration` method as part of the `SignInStartDelegate` protocol:

   ```swift
    extension ViewController: SignInStartDelegate {
    
        // previous code omitted
        func onSignInStrongAuthMethodRegistration(authMethods: [MSALAuthMethod], newState: RegisterStrongAuthState) {
       
            // inform the user that registration is required
            let alert = UIAlertController(
                title: "Missing strong authentication method", 
                message: "Registration of strong authentication method is required. Do you want to proceed with registration?", 
                preferredStyle: .alert
            )
        
            // You can select the first authMethod which has a channelgeChannel of type email
            // Or use "actionResult.authMethods" to let the user pick the authentication method to use.
            var authMethod = actionResult.authMethods.first { $0.channelTargetType.isEmailType }

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                if verificationContact.isEmpty {
                    verificationContact = "<phone number>" // format should be "<+prefix phone_number>"
                }
                let parameter = MSALNativeAuthChallengeAuthMethodParameters(authMethod: authMethod, verificationContact: verificationContact)
                newState.challengeAuthMethod(parameters: parameter, delegate: self)
            }))

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                self.resultTextView.text = "Strong authentication method registration is required"
            }))

            present(alert, animated: true)
    }
    ```

    The `signIn(username:password:delegate)` results in a call to delegate methods. The `onSignInStrongAuthMethodRegistration(authMethods:newState)` method handles the scenario where registration of a strong authentication method is required. You can present an alert to the user, asking if they want to proceed with registration. If the user chooses **OK** you request the MFA challenge by calling `newState.challengeAuthMethod(parameters:delegate)`. The `newState.challengeAuthMethod(parameters:delegate)` method sends the strong authentication method to the server for registration.

    If you prefer not to inform the user about the necessity for registration, you can bypass the user interaction by directly invoking `newState.challengeAuthMethod(parameters:delegate)`.
    The `challengeAuthMethod` accepts a parameter and a delegate instance, you must implement the required methods in the `RegisterStrongAuthChallengeDelegate` protocol.

3. Implement the `RegisterStrongAuthChallengeDelegate` protocol:

    ```swift
    extension ViewController: RegisterStrongAuthChallengeDelegate {
        func onRegisterStrongAuthChallengeError(
            error: RegisterStrongAuthChallengeError,
            newState: RegisterStrongAuthState?
        ) {
            resultTextView.text = "Error registering strong authentication method: \(error.errorDescription ?? "no description")"
        }

        func onRegisterStrongAuthVerificationRequired(
            result: MSALNativeAuthRegisterStrongAuthVerificationRequiredResult
        ) {
            let newState = result.newState
            if verificationContact.isEmpty {
                verificationContact = "<phone number>" // format should be "<+prefix phone_number>"
            }
            let parameter = MSALNativeAuthChallengeAuthMethodParameters(authMethod: authMethod)
            newState.challengeAuthMethod(parameters: parameter, delegate: self)
        }
    }
    ```

    In the most common scenario, you receive a call to `onRegisterStrongAuthVerificationRequired(result)` to indicate that the SDK expects the app to submit the SMS one-time passcode sent to phone number. Once the submission is complete, you can call the `challengeAuthMethod` method like this `newState.challengeAuthMethod(parameters:delegate)`. The `challengeAuthMethod` accepts a delegate parameter and you must implement the required methods in the `RegisterStrongAuthSubmitChallengeDelegate` protocol.

4. Implement the `RegisterStrongAuthSubmitChallengeDelegate` protocol:

    ```swift
    extension ViewController: RegisterStrongAuthSubmitChallengeDelegate {
         func onRegisterStrongAuthSubmitChallengeError(
            error: RegisterStrongAuthSubmitChallengeError,
            newState: RegisterStrongAuthVerificationRequiredState?
        ) {
            resultTextView.text = "Error submitting challenge: \(error.errorDescription ?? "no description")"
            newState.submitChallenge(challenge: "newCode", delegate: self)
        }
    
        func onSignInCompleted(result: MSALNativeAuthUserAccountResult) {
            print("Signed in as: \(result.account.username ?? "unknown user")")
        }
    }
    ```

    The `RegisterStrongAuthSubmitChallengeDelegate` protocol enables you to handle verification code submission. It provides methods to manage errors, such as invalid codes through `onRegisterStrongAuthSubmitChallengeError`, allowing resubmission. When the verification is successful, the `onSignInCompleted` method is called and the sign-in process is finalized.
 
## Next steps

- [Tutorial: Self-service password reset](tutorial-native-authentication-ios-macos-self-service-password-reset.md) 

