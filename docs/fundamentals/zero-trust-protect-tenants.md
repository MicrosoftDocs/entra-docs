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
[!INCLUDE [21787](../includes/secure-recommendations/21787.md)]

### Protected actions are enabled for high-impact management tasks
[!INCLUDE [21831](../includes/secure-recommendations/21831.md)]

### Enable protected actions to secure Conditional Access policy creation and changes
[!INCLUDE [21964](../includes/secure-recommendations/21964.md)]

### Guest access is limited to approved tenants
[!INCLUDE [21874](../includes/secure-recommendations/21874.md)]

### Guests are not assigned high privileged directory roles
[!INCLUDE [22128](../includes/secure-recommendations/22128.md)]

### Guests can't invite other guests
[!INCLUDE [21791](../includes/secure-recommendations/21791.md)]

### Guests have restricted access to directory objects
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
[!INCLUDE [21790](../includes/secure-recommendations/21790.md)]

### Guests don't own apps in the tenant
[!INCLUDE [21868](../includes/secure-recommendations/21868.md)]

### All guests have a sponsor
[!INCLUDE [21877](../includes/secure-recommendations/21877.md)]

### Inactive guest identities are disabled or removed from the tenant
[!INCLUDE [21858](../includes/secure-recommendations/21858.md)]

### All entitlement management policies have an expiration date
[!INCLUDE [21878](../includes/secure-recommendations/21878.md)]

### All entitlement management assignment policies that apply to external users require connected organizations 
[!INCLUDE [21875](../includes/secure-recommendations/21875.md)]

### All entitlement management assignment policies that apply to external users require approval
[!INCLUDE [21879](../includes/secure-recommendations/21879.md)]

### All entitlement management packages that apply to guests have expirations or access reviews configured in their assignment policies
[!INCLUDE [21929](../includes/secure-recommendations/21929.md)]

### Manage the local administrators on Microsoft Entra joined devices
[!INCLUDE [21955](../includes/secure-recommendations/21955.md)]

### Restrict nonadministrator users from recovering the BitLocker keys for their owned devices
[!INCLUDE [21954](../includes/secure-recommendations/21954.md)]
