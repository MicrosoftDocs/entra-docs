---
title: Security guidance - Protect identities and secrets
description: Improve your security posture with the Microsoft Entra Zero Trust assessment to protect identities and secrets.

ms.service: entra
ms.subservice: fundamentals
ms.topic: concept-article
ms.date: 07/14/2025

ms.author: sarahlipsey
author: shlipsey
manager: pmwongera
ms.reviewer: ramical
---

# Configure Microsoft Entra for Zero Trust: Protect identities and secrets

User and application authentication and authorization are the entry point into your identity and secrets infrastructure. Protecting all identities and secrets is a foundational step in your Zero Trust journey and a pillar of the [Secure Future Initiative](https://www.microsoft.com/trust-center/security/secure-future-initiative?msockid=2bad2df65a416adb0e5838355b3e6b95#SFI-pillars). 

The recommendations and Zero Trust checks that are part of this pillar help reduce the risk of unauthorized access.


## Zero Trust security recommendations

### Applications don't have client secrets configured 
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21772](../includes/secure-recommendations/21772.md)]

### Applications don't have certificates with expiration longer than 180 days 
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21773](../includes/secure-recommendations/21773.md)]

### Application Certificates need to be rotated on a regular basis
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21992](../includes/secure-recommendations/21992.md)]

### Microsoft services applications don't have credentials configured
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21774](../includes/secure-recommendations/21774.md)]

### User consent settings are restricted
[!INCLUDE [21776](../includes/secure-recommendations/21776.md)]

### Admin consent workflow is enabled
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21809](../includes/secure-recommendations/21809.md)]

### Privileged accounts are cloud native identities
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21814](../includes/secure-recommendations/21814.md)]

### All privileged role assignments are activated just in time and not permanently active
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21815](../includes/secure-recommendations/21815.md)]

### Privileged accounts have phishing-resistant methods registered
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21782](../includes/secure-recommendations/21782.md)]

### Privileged Microsoft Entra built-in roles are targeted with Conditional Access policies to enforce phishing-resistant methods
[!INCLUDE [21783](../includes/secure-recommendations/21783.md)]

### Require password reset notifications for administrator roles
[!INCLUDE [21891](../includes/secure-recommendations/21891.md)]

### Block legacy authentication
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21796](../includes/secure-recommendations/21796.md)]

### Migrate from legacy MFA and SSPR policies
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21803](../includes/secure-recommendations/21803.md)]

### SMS and Voice Call authentication methods are disabled
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21804](../includes/secure-recommendations/21804.md)]

### Turn off Seamless SSO if there is no usage
[!INCLUDE [21985](../includes/secure-recommendations/21985.md)]

### Secure the MFA registration (My Security Info) page
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21806](../includes/secure-recommendations/21806.md)]

### Use cloud authentication
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21829](../includes/secure-recommendations/21829.md)]

### Users have strong authentication methods configured
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21801](../includes/secure-recommendations/21801.md)]

### User sign-in activity uses token protection
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21786](../includes/secure-recommendations/21786.md)]

### Restrict device code flow
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21808](../includes/secure-recommendations/21808.md)]

### Authentication transfer is blocked
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21828](../includes/secure-recommendations/21828.md)]

### Authenticator app shows sign-in context
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21802](../includes/secure-recommendations/21802.md)]

### Password expiration is disabled
[!INCLUDE [21811](../includes/secure-recommendations/21811.md)]

### Require multifactor authentication for device join and device registration using user action
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21872](../includes/secure-recommendations/21872.md)]

### Enable Microsoft Entra ID security defaults
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21871](../includes/secure-recommendations/21871.md)]

## Security recommendations that also apply to this pillar

- Global Administrators don't have standing access to Azure subscriptions