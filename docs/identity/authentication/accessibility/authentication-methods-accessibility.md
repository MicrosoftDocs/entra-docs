---
title: Enhance accessibility with multifactor authentication in Microsoft Entra ID
description: Explains authentication Methods Accessibility
author:      gdaluz1 # GitHub alias
ms.author: justinha
ms.service: entra-id
ms.topic: article
ms.date: 03/04/2025
ms.subservice: authentication
---
# Improve accessibility with multifactor authentication in Microsoft Entra ID

As cybersecurity threats evolve, multifactor authentication (MFA) has become a cornerstone of secure digital identity. Microsoft Entra ID offers a range of MFA methods designed for robust security and diverse user needs, including those with accessibility constraints. Here's a closer look at how these MFA options enhance accessibility and inclusivity.

## Microsoft Authenticator

The Microsoft Authenticator app provides either notifications for quick approval or generates time-based codes for more traditional MFA entry. This app is compatible with various assistive technologies, including screen readers, making it accessible for users with visual impairments. It also offers flexibility for individuals who prefer not to rely solely on SMS or voice calls.

[Download Microsoft Authenticator](https://www.microsoft.com/security/mobile-authenticator-app?msockid=04750fac1789618938f71b4a16ee6056).

## Text and voice calls

Text and voice call options cater to those who may not use a smartphone app. This can be beneficial for individuals with certain accessibility needs:

- **Text:** Allows users to receive a verification code via text message, which can be useful for those with hearing impairments or those who prefer text-based communication.

- **Voice calls:** Voice calls are a great option for users with visual impairments, as they provide audio cues rather than visual or tactile ones.

For more information, see [Phone authentication methods](/entra/identity/authentication/concept-authentication-phone-options).

## FIDO2 security keys

FIDO2 security keys are physical devices that offer a highly accessible and secure MFA option. These hardware keys support biometric authentication (such as fingerprint scans) or PINs, making them ideal for users who may find traditional passwords or other authentication methods challenging. FIDO2 keys are beneficial for users with physical disabilities who may have difficulty typing complex passwords.

For more information, see [How to register passkey (FIDO2)](/entra/identity/authentication/how-to-register-passkey-with-security-key).

## Windows Hello for Business

Windows Hello for Business leverages biometric authentication (facial recognition or fingerprint) and PINs, offering a quick, secure, and accessible MFA option. This method eliminates the need for password input, which can be challenging for users with physical or cognitive disabilities. Biometric authentication allows for seamless access while maintaining strong security.

For more information, see [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/policy-settings?tabs=feature).

## Email verification

While not as secure as other MFA methods, email verification can be useful in certain accessibility scenarios, providing a fallback option. For users who experience difficulty with text, voice, or app-based authentication, email can offer a familiar and easily accessible alternative.

References:

- [Available verification methods](/entra/identity/authentication/concept-mfa-howitworks)
- [How to enable MFA](/entra/identity/authentication/tutorial-enable-azure-mfa)

## Conclusion

Microsoft Entra ID's range of MFA options enables individuals with diverse needs to access secure authentication without compromising on usability. To ensure that security measures remain accessible and inclusive for all users, Microsoft Entra ID offers various options like the Authenticator app, SMS and voice calls, FIDO2 keys, Windows Hello, and email verification.

Selecting the right MFA method depends on individual needs and constraints. Microsoft’s commitment to flexible and inclusive authentication helps everyone stay secure, regardless of their physical or technological limitations. For those with specific accessibility requirements, it’s worth exploring each MFA option to find the one that aligns best with personal preferences and usability needs.

## Related content

- [Available verification methods](/entra/identity/authentication/concept-mfa-howitworks)
- [How to enable MFA](/entra/identity/authentication/tutorial-enable-azure-mfa)
