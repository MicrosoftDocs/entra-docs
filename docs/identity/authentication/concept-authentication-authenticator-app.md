---
title: Microsoft Authenticator authentication method
description: Learn about using the Microsoft Authenticator in Microsoft Entra ID to help secure your sign-ins.

ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 10/21/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: calui

# Customer intent: As an identity administrator, I want to understand how to use the Microsoft Authenticator app in Microsoft Entra ID to improve and secure user sign-in events.
---
# Authentication methods in Microsoft Entra ID - Microsoft Authenticator app

Microsoft Authenticator provides another level of security to your Microsoft Entra work or school account or your Microsoft account. It's available for [Android](https://go.microsoft.com/fwlink/?linkid=866594) and [iOS](https://go.microsoft.com/fwlink/?linkid=866594). With the Microsoft Authenticator app, users can authenticate in a passwordless way during sign-in. They can also use it as a verification option during self-service password reset (SSPR) or multifactor authentication (MFA) events.

Microsoft Authenticator supports passkey, passwordless sign in, and MFA by using notifications and verification codes. 

- Users can sign in with a passkey in the Authenticator app and complete phishing-resistant authentication with their biometric sign-in or device PIN. 
- Users can set up Authenticator notifications and sign in with Authenticator instead of their username and password. 
- Users can receive an MFA request on their mobile device, and approve or deny the sign-in attempt from their phone. 
- They can also use an OATH verification code in the Authenticator app and enter it in a sign-in interface. 

For more information, see [Enable passwordless sign-in with the Microsoft Authenticator](howto-authentication-passwordless-phone.md). 

> [!NOTE]
> Users don't have the option to register their mobile app when they enable SSPR. Instead, users can register their mobile app at [https://aka.ms/mfasetup](https://aka.ms/mfasetup) or as part of the combined security info registration at [https://aka.ms/setupsecurityinfo](https://aka.ms/setupsecurityinfo).
> The Authenticator app may not be supported on beta versions of iOS and Android. In addition, starting October 20th, 2023 the Authenticator app on Android no longer supports older versions of the Android Company Portal. Android users with Company Portal versions below 2111 (5.0.5333.0) can't re-register or register new instances of Authenticator until they update their Company Portal application to a newer version.

## Passkey sign-in (preview)

Authenticator is a free passkey solution that lets users do passwordless phishing-resistant authentications from their own phones. Some key benefits to using passkeys in the Authenticator app:

- Passkeys can be easily deployed at scale. Then passkeys are available on a user’s phone for both mobile device management (MDM) and bring your own device (BYOD) scenarios.
- Passkeys in Authenticator come at no more cost and travel with the user wherever they go.
- Passkeys in Authenticator are device-bound which ensures the passkey doesn’t leave the device on which it was created.
- Users stay up-to-date with latest passkey innovation based upon open WebAuthn standards.
- Enterprises can layer other capabilities on top of authentication flows such as [Federal Information Processing Standards (FIPS) 140 compliance](#fips-140-compliant-for-microsoft-entra-authentication).


### Device-bound passkey

Passkeys in the Authenticator app are device-bound to ensure that they never leave the device they were created on. On an iOS device, Authenticator uses the Secure Enclave to create the passkey. On Android, we create the passkey in the Secure Element on devices that support it, or fall back to the Trusted Execution Environment (TEE).

### How passkey attestation works with Authenticator 

When attestation is enabled in the **Passkey (FIDO2)** policy, Microsoft Entra ID attempts to verify the legitimacy of the security key model or passkey provider where the passkey is being created. When a user registers a passkey in Authenticator, attestation verifies that the legitimate Microsoft Authenticator app created the passkey by using Apple and Google services. Here are details for how attestation works for each platform: 

- iOS: Authenticator attestation uses the [iOS App Attest service](https://developer.apple.com/documentation/devicecheck/preparing-to-use-the-app-attest-service) to ensure the legitimacy of the Authenticator app before registering the passkey.  

- Android: 
  - For Play Integrity attestation, Authenticator attestation uses the [Play Integrity API](https://developer.android.com/google/play/integrity/overview) to ensure the legitimacy of the Authenticator app before registering the passkey.  
  - For Key attestation, Authenticator attestation uses [key attestation by Android](https://developer.android.com/privacy-and-security/security-key-attestation) to verify that the passkey being registered is hardware-backed.     

>[!NOTE]
>For both iOS and Android, Authenticator attestation relies upon Apple and Google services to verify the authenticity of the Authenticator app. Heavy service usage can make passkey registration fail, and users may need to try again. If Apple and Google services are down, Authenticator attestation blocks registration that requires attestation until services are restored. To monitor the status of Google Play Integrity service, see [Google Play Status Dashboard](https://status.play.google.com/). To monitor the status of the iOS App Attest service, see [System Status](https://developer.apple.com/system-status/).

For more information about how to configure attestation, see [How to enable passkeys in Microsoft Authenticator for Microsoft Entra ID](how-to-enable-authenticator-passkey.md).


## Passwordless sign-in via notifications

Instead of seeing a prompt for a password after entering a username, users who enable phone sign-in from the Authenticator app sees a message to enter a number in their app. When the correct number is selected, the sign-in process is complete.

![Example of a browser sign-in asking for user to approve the sign-in.](./media/howto-authentication-passwordless-phone/phone-sign-in-microsoft-authenticator-app.png)

This authentication method provides a high level of security, and removes the need for the user to provide a password at sign-in. 

To get started with passwordless sign-in, see [Enable passwordless sign-in with the Microsoft Authenticator](howto-authentication-passwordless-phone.md).

## MFA via notifications through mobile app

The Authenticator app can help prevent unauthorized access to accounts and stop fraudulent transactions by pushing a notification to your smartphone or tablet. Users view the notification, and if it's legitimate, select **Verify**. Otherwise, they can select **Deny**.

> [!NOTE]
> Starting in August, 2023, anomalous sign-ins don't generate notifications, similarly to how sign-ins from unfamiliar locations don't generate notifications. To approve an anomalous sign-in, users can open Microsoft Authenticator, or Authenticator Lite in a relevant companion app like Outlook. Then they can either pull down to refresh or tap **Refresh**, and approve the request. 

![Screenshot of example web browser prompt for Authenticator app notification to complete sign-in process.](media/tutorial-enable-azure-mfa/tutorial-enable-azure-mfa-browser-prompt.png)

In China, the *Notification through mobile app* method on Android devices doesn't work because as Google play services (including push notifications) are blocked in the region. However, iOS notifications do work. For Android devices, alternate authentication methods should be made available for those users.

## Verification code from mobile app

The Authenticator app can be used as a software token to generate an OATH verification code. After entering your username and password, you enter the code provided by the Authenticator app into the sign-in interface. The verification code provides a second form of authentication.

> [!NOTE]
> OATH verification codes generated by Authenticator aren't supported for certificate-based authentication.

Users can have a combination of up to five OATH hardware tokens or authenticator applications, such as the Authenticator app, configured for use at any time.

<a name='fips-140-compliant-for-azure-ad-authentication'></a>

## FIPS 140 compliant for Microsoft Entra authentication

Consistent with the guidelines outlined in [NIST Special Publication 800-63B](https://pages.nist.gov/800-63-3/sp800-63b.html), authenticators used by US government agencies are required to use FIPS 140 validated cryptography. This guideline helps US government agencies meet the requirements of [Executive Order (EO) 14028](https://www.whitehouse.gov/briefing-room/presidential-actions/2021/05/12/executive-order-on-improving-the-nations-cybersecurity/?azure-portal=true). Additionally, this guideline helps other regulated industries such as healthcare organizations working with [Electronic Prescriptions for Controlled Substances (EPCS)](/azure/compliance/offerings/offering-epcs-us) meet their regulatory requirements.

FIPS 140 is a US government standard that defines minimum security requirements for cryptographic modules in information technology products and systems. The [Cryptographic Module Validation Program (CMVP)](https://csrc.nist.gov/Projects/cryptographic-module-validation-program?azure-portal=true) maintains the testing against the FIPS 140 standard.

### Microsoft Authenticator for iOS

Beginning with version 6.6.8, Microsoft Authenticator for iOS uses the native Apple CoreCrypto module for FIPS validated cryptography on Apple iOS FIPS 140 compliant devices. All Microsoft Entra authentications using phishing-resistant device-bound passkeys, push multifactor authentications (MFA), passwordless phone sign-in (PSI), and time-based one-time passcodes (TOTP) use the FIPS cryptography.

For more information about the FIPS 140 validated cryptographic modules being used and compliant iOS devices, see [Apple iOS security certifications](https://support.apple.com/guide/certifications/ios-security-certifications-apc3fa917cb49/1/web/1.0).


### Microsoft Authenticator for Android
Beginning with version 6.2409.6094 on Microsoft Authenticator for Android, all authentications in Microsoft Entra ID, including passkeys, are considered FIPS-compliant. Authenticator uses wolfSSL Inc.’s cryptographic module to achieve FIPS 140, Security Level 1 compliance on Android devices. For more details about the certification, see [Cryptographic Module Validation Program](https://csrc.nist.gov/projects/cryptographic-module-validation-program/certificate/4718).

## Determining Microsoft Authenticator registration type in Security info 
Users can access [Security info](https://mysignins.microsoft.com/security-info) (see the URLs in the next section) or by selecting Security info from MyAccount to manage and add more Microsoft Authenticator registrations. Specific icons are used to differentiate whether the Microsoft Authenticator registration is passwordless phone sign-in or MFA. 

Authenticator registration type | Icon
------ | ------
Microsoft Authenticator: Passwordless phone sign-in   | <img width="43" alt="Microsoft Authenticator passwordless sign-in Capable" src="https://user-images.githubusercontent.com/50213291/211923744-d025cd70-4b88-4603-8baf-db0fc5d28486.png">  
Microsoft Authenticator: (Notification/Code) | <img width="43" alt="Microsoft Authenticator MFA Capable" src="https://user-images.githubusercontent.com/50213291/211921054-d11983ad-4e0d-4612-9a14-0fef625a9a2a.png">


### SecurityInfo links

Cloud | Security info URL | 
------ | ------ | ------
Azure commercial (includes Government Community Cloud (GCC))   | https://aka.ms/MySecurityInfo 
Azure for US Government (includes GCC High and DoD) | https://aka.ms/MySecurityInfo-us 

## Updates to Authenticator

Microsoft continuously updates Authenticator to maintain a high level of security. To ensure that your users are getting the best experience possible, we recommend having them continuously update their Authenticator App. In the case of critical security updates, app versions that aren't up-to-date may not work, and may block users from completing their authentication. If a user is using a version of the app that isn't supported, they're prompted to upgrade to the latest version before they proceed to sign in.

Microsoft also periodically retires older versions of the Authenticator App to maintain a high security bar for your organization. If a user’s device doesn't support modern versions of Microsoft Authenticator, they can't sign with the app. We recommend these users sign in with an OATH verification code in Microsoft Authenticator to complete MFA.

## Next steps

- To get started with passkeys, see [How to enable passkeys in Microsoft Authenticator for Microsoft Entra ID](how-to-enable-authenticator-passkey.md).

- For more information about passwordless sign-in, see [Enable passwordless sign-in with the Microsoft Authenticator](howto-authentication-passwordless-phone.md).

- Learn more about configuring authentication methods using the [Microsoft Graph REST API](/graph/api/resources/authenticationmethods-overview).
