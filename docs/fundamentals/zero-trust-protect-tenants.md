---
title: Security guidance - Protect tenants and isolate production systems
description: Improve your security posture with the Microsoft Entra Zero Trust assessment to protect tenants and isolate production systems.

ms.service: entra
ms.subservice: fundamentals
ms.topic: concept-article
ms.date: 09/11/2025

ms.author: sarahlipsey
author: shlipsey
manager: pmwongera
ms.reviewer: ramical
---
# Configure Microsoft Entra for Zero Trust: Protect tenants and isolate production systems

Protecting your tenant and isolating production systems is about setting tenant boundaries and keeping your production systems isolated from test and pre-production environments. Lateral movement was a critical concern from the [Secure Future Initiative](https://www.microsoft.com/trust-center/security/secure-future-initiative?msockid=2bad2df65a416adb0e5838355b3e6b95#SFI-pillars). 

Even smaller organizations can protect their environments by implementing stricter guest access policies and limiting who can create tenants. Larger organizations that manage several environments should take action to prevent unauthorized tenant sprawl and lateral movement. All organizations can benefit from these checks to reduce attack surface area through unmanaged tenants.

## Zero Trust security recommendations

### Permissions to create new tenants are limited to the Tenant Creator role
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21787](../includes/secure-recommendations/21787.md)]

### Allow/Deny lists of domains to restrict external collaboration are configured
[!INCLUDE [21874](../includes/secure-recommendations/21874.md)]

### Guests are not assigned high privileged directory roles
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [22128](../includes/secure-recommendations/22128.md)]

### Guests can't invite other guests
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21791](../includes/secure-recommendations/21791.md)]

### Guests have restricted access to directory objects
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21792](../includes/secure-recommendations/21792.md)]

### App instance property lock is configured for all multitenant applications
[!INCLUDE [21777](../includes/secure-recommendations/21777.md)]

### Guests don't have long lived sign-in sessions
[!INCLUDE [21824](../includes/secure-recommendations/21824.md)]

### Guest access is protected by strong authentication methods
[!INCLUDE [21851](../includes/secure-recommendations/21851.md)]

### Guest self-service sign-up via user flow is disabled
[!INCLUDE [21823](../includes/secure-recommendations/21823.md)]

### Outbound cross-tenant access settings are configured
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21790](../includes/secure-recommendations/21790.md)]

### Guests don't own apps in the tenant
[!INCLUDE [21868](../includes/secure-recommendations/21868.md)]

### All guests have a sponsor
[!INCLUDE [21877](../includes/secure-recommendations/21877.md)]

### Inactive guest identities are disabled or removed from the tenant
[!INCLUDE [21858](../includes/secure-recommendations/21858.md)]