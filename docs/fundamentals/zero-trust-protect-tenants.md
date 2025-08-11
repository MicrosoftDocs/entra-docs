---
title: Security guidance | Protect tenants and isolate production systems
description: Improve your security posture with the Microsoft Entra Zero Trust assessment to protect tenants and isolate production systems.

ms.service: entra
ms.subservice: fundamentals
ms.topic: concept-article
ms.date: 07/14/2025

ms.author: sarahlipsey
author: shlipsey
manager: pmwongera
ms.reviewer: ramical
---
# Protect tenants and isolate production systems with the Microsoft Entra Zero Trust assessment

The patterns and practices associated with the "Protect tenants and isolate production systems" tenant from the Secure Future Initiative (SFI) focuses on establishing strong tenant boundaries and implementing isolation controls that safeguard your organization's identity infrastructure. This critical security domain addresses the need to limit tenant creation privileges, control external collaboration through guest access policies, and ensure proper segregation between production and non-production environments. By implementing these recommendations, organizations can prevent unauthorized tenant sprawl, minimize the risk of data exposure through misconfigured external partnerships, and maintain clear boundaries that protect sensitive resources from both internal and external threats. The following security recommendations help establish a robust foundation for tenant protection and system isolation within your Microsoft Entra environment.

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