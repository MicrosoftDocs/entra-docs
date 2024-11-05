---
# Required metadata
# For more information, see https://review.learn.microsoft.com/en-us/help/platform/learn-editor-add-metadata?branch=main
# For valid values of ms.service, ms.prod, and ms.topic, see https://review.learn.microsoft.com/en-us/help/platform/metadata-taxonomies?branch=main

title:       # Add a title for the browser tab
description: # Add a meaningful description for search results
author:      gdaluz1 # GitHub alias
ms.author:   202107107014 # Microsoft alias
ms.service:  # Add the ms.service or ms.prod value
# ms.prod:   # To use ms.prod, uncomment it and delete ms.service
ms.topic:    # Add the ms.topic value
ms.date:     11/05/2024
---
# Enhancing Accessibility with Multi-Factor Authentication in Microsoft Entra ID

As cybersecurity threats evolve, Multi-Factor Authentication (MFA) has become a cornerstone of secure digital identity. Microsoft Entra ID (formerly Azure AD) offers a range of MFA methods designed not only for robust security but also to cater to diverse user needs, including those with accessibility constraints. Here's a closer look at how these MFA options enhance accessibility and inclusivity.

1. **Authenticator App**

The Microsoft Authenticator app provides either notifications for quick approval or generates time-based codes for more traditional MFA entry. This app is compatible with various assistive technologies, including screen readers, making it accessible for users with visual impairments. It also offers flexibility for individuals who prefer not to rely solely on SMS or voice calls.

[https://www.microsoft.com/en-us/security/mobile-authenticator-app?msockid=04750fac1789618938f71b4a16ee6056](https://www.microsoft.com/security/mobile-authenticator-app?msockid=04750fac1789618938f71b4a16ee6056)

2. **SMS and Voice Calls**

SMS and voice call options cater to those who may not use a smartphone app. This can be particularly beneficial for individuals with certain accessibility needs:

- **SMS:** Allows users to receive a verification code via text message, which can be useful for those with hearing impairments or those who prefer text-based communication.

- **Voice Calls:** Voice calls are a great option for users with visual impairments, as they provide audio cues rather than visual or tactile ones.

[https://learn.microsoft.com/en-us/entra/identity/authentication/concept-authentication-phone-options](/entra/identity/authentication/concept-authentication-phone-options)

3. **FIDO2 Security Keys**

FIDO2 security keys are physical devices that offer a highly accessible and secure MFA option. These hardware keys support biometric authentication (such as fingerprint scans) or PINs, making them ideal for users who may find traditional passwords or other authentication methods challenging. FIDO2 keys are particularly beneficial for users with physical disabilities who may have difficulty typing complex passwords.

[https://learn.microsoft.com/en-us/entra/identity/authentication/how-to-register-passkey-with-security-key](/entra/identity/authentication/how-to-register-passkey-with-security-key)

4. **Windows Hello for Business**

Windows Hello for Business leverages biometric authentication (facial recognition or fingerprint) and PINs, offering a quick, secure, and accessible MFA option. This method eliminates the need for password input, which can be challenging for users with physical or cognitive disabilities. Biometric authentication allows for seamless access while maintaining strong security.

[https://learn.microsoft.com/en-us/windows/security/identity-protection/hello-for-business/policy-settings?tabs=feature](/windows/security/identity-protection/hello-for-business/policy-settings?tabs=feature)

5. **Email Verification**

While not as secure as other MFA methods, email verification can be useful in certain accessibility scenarios, providing a fallback option. For users who experience difficulty with SMS, voice, or app-based authentication, email can offer a familiar and easily accessible alternative.

References:

[Available verification methods](/entra/identity/authentication/concept-mfa-howitworks)

[How to enable MFA]()

Conclusion

Microsoft Entra ID's range of MFA options enables individuals with diverse needs to access secure authentication without compromising on usability. By offering various options like the Authenticator app, SMS and voice calls, FIDO2 keys, Windows Hello, and email verification, Microsoft Entra ID ensures that security measures remain accessible and inclusive for all users.

Selecting the right MFA method depends on individual needs and constraints. Microsoft’s commitment to flexible and inclusive authentication helps everyone stay secure, regardless of their physical or technological limitations. For those with specific accessibility requirements, it’s worth exploring each MFA option to find the one that aligns best with personal preferences and usability needs.
