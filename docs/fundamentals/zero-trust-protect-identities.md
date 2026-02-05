---
title: Security guidance - Protect identities and secrets
description: Improve your security posture with the Microsoft Entra Zero Trust assessment to protect identities and secrets.

ms.service: entra
ms.subservice: fundamentals
ms.topic: concept-article
ms.date: 09/11/2025

ms.author: sarahlipsey
author: shlipsey
manager: pmwongera
ms.reviewer: ramical
---

# Configure Microsoft Entra for Zero Trust: Protect identities and secrets

User and application authentication and authorization are the entry point into your identity and secrets infrastructure. Protecting all identities and secrets is a foundational step in your Zero Trust journey and a pillar of the [Secure Future Initiative](https://www.microsoft.com/trust-center/security/secure-future-initiative?msockid=2bad2df65a416adb0e5838355b3e6b95#SFI-pillars). 

The recommendations and Zero Trust checks that are part of this pillar help reduce the risk of unauthorized access. Protecting identities and secrets represents the core of Zero Trust within Microsoft Entra. Themes include proper use of secrets and certificates, appropriate limits on privileged accounts, and modern passwordless authentication methods.


## Zero Trust security recommendations

### Applications don't have client secrets configured 
[!INCLUDE [21772](../includes/secure-recommendations/21772.md)]

### Service principals don't have certificates or credentials associated with them 
[!INCLUDE [21896](../includes/secure-recommendations/21896.md)]

### Applications don't have certificates with expiration longer than 180 days 
[!INCLUDE [21773](../includes/secure-recommendations/21773.md)]

### Application certificates must be rotated on a regular basis
[!INCLUDE [21992](../includes/secure-recommendations/21992.md)]

### Enforce standards for app secrets and certificates
[!INCLUDE [21775](../includes/secure-recommendations/21775.md)]

### Microsoft services applications don't have credentials configured
[!INCLUDE [21774](../includes/secure-recommendations/21774.md)]

### User consent settings are restricted
[!INCLUDE [21776](../includes/secure-recommendations/21776.md)]

### Admin consent workflow is enabled
[!INCLUDE [21809](../includes/secure-recommendations/21809.md)]

### High Global Administrator to privileged user ratio
[!INCLUDE [21813](../includes/secure-recommendations/21813.md)]

### Privileged accounts are cloud native identities
[!INCLUDE [21814](../includes/secure-recommendations/21814.md)]

### All privileged role assignments are activated just in time and not permanently active
[!INCLUDE [21815](../includes/secure-recommendations/21815.md)]

### All Microsoft Entra privileged role assignments are managed with PIM
[!INCLUDE [21816](../includes/secure-recommendations/21816.md)]

### Passkey authentication method enabled
[!INCLUDE [21839](../includes/secure-recommendations/21839.md)]

### Security key attestation is enforced
[!INCLUDE [21840](../includes/secure-recommendations/21840.md)]

### Privileged accounts have phishing-resistant methods registered
[!INCLUDE [21839](../includes/secure-recommendations/21839.md)]

### Privileged Microsoft Entra built-in roles are targeted with Conditional Access policies to enforce phishing-resistant methods
[!INCLUDE [21783](../includes/secure-recommendations/21783.md)]

### Require password reset notifications for administrator roles
[!INCLUDE [21891](../includes/secure-recommendations/21891.md)]

### Block legacy authentication policy is configured
[!INCLUDE [21796](../includes/secure-recommendations/21796.md)]

### Temporary access pass is enabled
[!INCLUDE [21845](../includes/secure-recommendations/21845.md)]

### Restrict Temporary Access Pass to Single Use
[!INCLUDE [21846](../includes/secure-recommendations/21846.md)]

### Migrate from legacy MFA and SSPR policies
[!INCLUDE [21803](../includes/secure-recommendations/21803.md)]

### Block administrators from using SSPR  
[!INCLUDE [21842](../includes/secure-recommendations/21842.md)]

### Self-service password reset doesn't use security questions
[!INCLUDE [22072](../includes/secure-recommendations/22072.md)]

### SMS and Voice Call authentication methods are disabled
[!INCLUDE [21804](../includes/secure-recommendations/21804.md)]

### Turn off Seamless SSO if there is no usage
[!INCLUDE [21985](../includes/secure-recommendations/21985.md)]

### Secure the MFA registration (My Security Info) page
[!INCLUDE [21806](../includes/secure-recommendations/21806.md)]

### Use cloud authentication
[!INCLUDE [21829](../includes/secure-recommendations/21829.md)]

### All users are required to register for MFA
[!INCLUDE [21893](../includes/secure-recommendations/21893.md)]

### Users have strong authentication methods configured
[!INCLUDE [21801](../includes/secure-recommendations/21801.md)]

### User sign-in activity uses token protection
[!INCLUDE [21786](../includes/secure-recommendations/21786.md)]

### All user sign-in activity uses phishing-resistant authentication methods
[!INCLUDE [21784](../includes/secure-recommendations/21784.md)]

### All sign-in activity comes from managed devices
[!INCLUDE [21892](../includes/secure-recommendations/21892.md)]

### Security key authentication method enabled
[!INCLUDE [21838](../includes/secure-recommendations/21838.md)]

### Privileged roles aren't assigned to stale identities
[!INCLUDE [21854](../includes/secure-recommendations/21854.md)]

### Restrict device code flow
[!INCLUDE [21808](../includes/secure-recommendations/21808.md)]

### Authentication transfer is blocked
[!INCLUDE [21828](../includes/secure-recommendations/21828.md)]

### Microsoft Authenticator app shows sign-in context
[!INCLUDE [21802](../includes/secure-recommendations/21802.md)]

### Microsoft Authenticator app report suspicious activity setting is enabled
[!INCLUDE [21841](../includes/secure-recommendations/21841.md)]

### Password expiration is disabled
[!INCLUDE [21811](../includes/secure-recommendations/21811.md)]

### Smart lockout threshold set to 10 or less
[!INCLUDE [21850](../includes/secure-recommendations/21850.md)]

### Smart lockout duration is set to a minimum of 60
[!INCLUDE [21849](../includes/secure-recommendations/21849.md)]

### Add organizational terms to the banned password list
[!INCLUDE [21848](../includes/secure-recommendations/21848.md)]

### Require multifactor authentication for device join and device registration using user action
[!INCLUDE [21872](../includes/secure-recommendations/21872.md)]

### Local Admin Password Solution is deployed
[!INCLUDE [21953](../includes/secure-recommendations/21953.md)]

### Entra Connect Sync is configured with Service Principal Credentials
[!INCLUDE [24570](../includes/secure-recommendations/24570.md)]

### No usage of ADAL in the tenant
[!INCLUDE [21780](../includes/secure-recommendations/21780.md)]

### Block legacy Azure AD PowerShell module
[!INCLUDE [21844](../includes/secure-recommendations/21844.md)]

### Enable Microsoft Entra ID security defaults for free tenants
[!INCLUDE [21871](../includes/secure-recommendations/21871.md)]
