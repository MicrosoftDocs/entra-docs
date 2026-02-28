---
title: Overview of Microsoft Entra ID Account Recovery
description: Learn about Microsoft Entra ID Account Recovery, which enables users to regain access to their accounts through identity verification when they've lost all authentication methods.
ms.topic: concept-article
ms.date: 11/07/2025
author: BullittRacer
ms.reviewer: tilarso
ms.custom: sfi-ga-nochange, sfi-image-nochange
# Customer intent: As a Microsoft Entra Administrator, I want to learn about account recovery and how it differs from password reset.
---

# Overview of Microsoft Entra ID Account Recovery

In today's digital workplace, users depend on multiple authentication methods to access their organizational resources. However, situations arise where users lose access to all their authentication methods—their primary device is lost, and backup codes are unavailable. In such scenarios, traditional self-service password reset (SSPR) isn't sufficient because it relies on users having access to at least one registered authentication method. This challenge is particularly problematic for passwordless users who have no fallback self-service options and must contact their helpdesk, undergo secure identity verification processes, and receive initial credentials from IT staff to re-provision their lost authentication methods and set up replacement devices.

Microsoft Entra ID Account Recovery addresses these critical scenarios by enabling users to regain access to their accounts through a robust identity verification process. Unlike password reset, which assumes users retain some form of authentication method, account recovery focuses on re-establishing trust in the user's identity when they've lost access to all authentication mechanisms.

Account recovery represents a paradigm shift from simple credential reset to comprehensive user identity verification and user re-onboarding. It leverages advanced identity verification technologies, including Microsoft Entra Verified ID, to ensure that the person requesting account recovery is indeed the legitimate account owner. This approach not only maintains security while providing users with a path to regain access during total lockout scenarios, but also significantly reduces security risks by removing human judgment from the verification process. Traditional helpdesk-led recovery methods are vulnerable to social engineering attacks where bad actors can manipulate support staff into illegitimately recovering accounts, but account recovery's identity proofing eliminates this attack vector entirely.

## What is account recovery

Microsoft Entra ID Account Recovery is an advanced authentication recovery mechanism that enables users to regain access to their organizational accounts when they've lost access to all registered authentication methods. Unlike traditional password reset capabilities, account recovery focuses on identity verification and trust re-establishment prior to replacement of authentication methods rather than simple credential recovery.

### Key characteristics of account recovery

**Identity-centric approach**: Account recovery shifts the focus from *what you know* (passwords) and *what you have* (passkeys, SMS/Voice, Software OTP, and so on) to *who you are* by using comprehensive identity verification. This approach acknowledges that in total lockout scenarios, traditional authentication factors might be compromised or unavailable.

**Trust re-establishment**: The process treats account recovery as a re-onboarding scenario where the organization must verify and re-establish trust in the user's identity. This ensures that only legitimate account owners can regain access to their accounts and organizational resources.

**Integration with modern identity technologies**: Account recovery leverages Microsoft Entra Verified ID + Face Check and advanced identity verification services provided through the Microsoft Security Store to provide strong assurance of user identity during the recovery process.

### When to use account recovery

Account recovery is designed for critical scenarios where users face complete authentication lockout:

- **Device loss or theft**: When users lose their primary devices containing authenticator apps, security keys, or other authentication methods
- **Complete authentication failure**: When all registered authentication methods become unavailable simultaneously  
- **Account compromise recovery**: When a security incident requires complete authentication method reset as part of the incident response

### Account recovery versus self-service password reset (SSPR)

Although account recovery and SSPR both aim to restore user access, they address different scenarios, and use distinct approaches:

| Aspect | Self-Service Password Reset (SSPR) | Account Recovery (SSAR) |
|--------|-----------------------------------|--------------------------------------|
| **Primary use case** | User forgot password, but retains access to authentication methods | User lost access to all authentication methods |
| **Authentication requirement** | At least one registered authentication method (policy controls can require up to 2 methods) | Identity verification through certified partner |
| **Trust assumption** | User's identity is verified through existing methods | User's identity must be re-established |
| **Recovery scope** | Password only | Complete authentication method reset |
| **Technology dependency** | Existing MFA methods, security questions | Identity verification services, Verified ID |
| **Security level** | Medium - relies on pre-registered methods | High - requires comprehensive identity proofing |

### Business benefits

**Reduced helpdesk burden**: By providing a secure option for total lockout scenarios, account recovery significantly reduces the number of high-priority support tickets that require manual intervention from IT staff.

**Improved user experience**: Users can recover their accounts independently without waiting for helpdesk availability, reducing downtime and maintaining productivity during critical situations.

**Enhanced security posture**: The identity verification approach provides stronger security assurances compared to traditional recovery methods that might rely on social engineering-vulnerable information.

**Scalability for remote work**: Account recovery enables organizations to support distributed workforces without requiring physical presence or complex manual verification processes.

## How does it work

Microsoft Entra ID Account Recovery operates through a comprehensive identity verification and trust re-establishment process which starts at login. Users who attempt to sign-in but have lost all their methods can self-report their inability to sign-in, triggering the account recovery workflow. The system combines multiple verification layers to ensure that only legitimate account owners can recover their access while maintaining the highest security standards.

### Core components

**Identity Verification Providers (IDV)**: Account recovery integrates with trusted third-party identity verification services that can validate user identity by using government-issued documents, biometric verification, and other high-assurance methods. These providers issue verifiable credentials that attest to the user's verified identity. Provider availability and selections are available in the [Microsoft Security Store](https://securitystore.microsoft.com/). 

**Microsoft Entra Verified ID**: The platform's decentralized identity service enables users to present cryptographically secure identity credentials during recovery. These credentials provide tamper-evident proof of identity verification, without exposing sensitive personal information. For more information about Verified ID, see [Introduction to Microsoft Entra Verified ID](/entra/verified-id/decentralized-identifier-overview).

**Entra ID Account Recovery Configuration**: A specialized configuration wizard in Microsoft Entra ID enables admins to define the requirements for recovery, including who can recover, and what trusted provider performs identity verification. 


### Recovery workflow

The account recovery process follows a structured workflow designed to balance security with user experience.

:::image type="content" border="true" source="media/concept-account-recovery-overview/recovery-steps-overview.png" alt-text="Conceptual diagram of the account recovery process.":::

#### Step 1: Discover Account Recovery entry

1. **Account name**: Users provide their account identifier (typically username or email address).
2. **Access point**: Users access recovery through sign-in after indicating they can't access their account. 
3. **Eligibility check**: The system verifies that the account is eligible for recovery based on organizational policies.
4. **Start recovery with an IDV**: The user is directed to an IDV specified by the tenant admin based upon the user geography.

#### Step 2: Identity verification through Identity Verification Provider

1. **External identity proofing**: Users are redirected to trusted IDVs to complete identity validation.
2. **Document verification**: IDVs verify government-issued identification documents by using advanced fraud detection.
3. **Biometric validation**: Liveness checks and facial recognition ensure the person who submits credentials is physically present.
4. **Credential issuance**: Upon successful verification, users receive a verifiable credential (Verified ID) that attests to their identity, and is stored in Microsoft Authenticator.

#### Step 3: Identity presentation and ownership validation

1. **Credential presentation**: Users present their newly acquired Verified ID to Microsoft Entra ID.
2. **Credential verification**: The system validates the credential's authenticity and integrity.
3. **Attribute correlation**: The system matches identity attributes from the credential against stored user profile information.

#### Step 4: Access restoration

1. **Temporary access provision**: Users receive temporary access credentials (such as Temporary Access Pass) with limited validity.
2. **Guided re-enrollment**: Users are directed through the process of registering new authentication methods.

## Evaluation and production modes

Admins can deploy account recovery in Evaluation mode to see how the change will imapct users. But users can't recover their accounts in evaluation mode. 

## Try account recovery

Account recovery is secure by default with evaluation mode for user verification, and only takes 5 to 10 minutes to set up. [Try the preview](how-to-account-recovery-enable.md) and we appreciate your feedback!

## Related content

- [Frequently asked questions about Microsoft Entra ID account recovery](self-service-account-recovery.yml)
- [How end users can perform account recovery in Microsoft Entra ID](how-to-account-recovery-for-users.md)
- [How it works: Microsoft Entra self-service password reset](concept-sspr-howitworks.md) - Learn about traditional password reset capabilities and when to use SSPR versus account recovery
- [What is Microsoft Entra Verified ID?](/entra/verified-id/decentralized-identifier-overview) - Understand the decentralized identity technology that powers SSAR's verification process  
- [Plan your Microsoft Entra Verified ID verification solution](/entra/verified-id/plan-verification-solution) - Design guidance for implementing identity verification scenarios
- [Onboard new remote employees using ID verification](/entra/verified-id/remote-onboarding-new-employees-id-verification) - Specific implementation guidance for employee onboarding scenarios
- [Verified helpdesk with Microsoft Entra Verified ID](/entra/verified-id/helpdesk-with-verified-id) - How to improve helpdesk operations with identity verification
- [Enable the Temporary Access Pass policy](howto-authentication-temporary-access-pass.md) - Configure temporary credentials for account recovery scenarios
- [Plan a phishing-resistant passwordless authentication deployment](how-to-deploy-phishing-resistant-passwordless-authentication.md) - Long-term strategy to reduce dependency on traditional authentication methods
- [What is Microsoft Entra authentication?](overview-authentication.md) - Overview of authentication capabilities in Microsoft Entra ID
