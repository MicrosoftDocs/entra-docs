---
title: Security guidance - Protect engineering systems
description: Improve your security posture with the Microsoft Entra Zero Trust assessment to protect engineering systems.

ms.service: entra
ms.subservice: fundamentals
ms.topic: concept-article
ms.date: 07/14/2025

ms.author: sarahlipsey
author: shlipsey
manager: pmwongera
ms.reviewer: ramical
---
# Configure Microsoft Entra for Zero Trust: Protect engineering systems

The [Secure Future Initiative](https://www.microsoft.com/trust-center/security/secure-future-initiative?msockid=2bad2df65a416adb0e5838355b3e6b95#SFI-pillars) pillar for protecting engineering systems was first developed to safeguard Microsoft’s own software assets and infrastructure. The practices and insights gained from this internal work are now shared with customers, enabling you to strengthen your own software security and code protection.

These recommendations focus on ensuring least privilege access to your organization's engineering systems and resources. 

## Security recommendations

### Global Administrator role activation triggers an approval workflow
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21817](../includes/secure-recommendations/21817.md)]

### Global Administrators don't have standing access to Azure subscriptions
[!INCLUDE [21788](../includes/secure-recommendations/21788.md)]

### Creating new applications and service principals is restricted to privileged users
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21807](../includes/secure-recommendations/21807.md)]

### Inactive applications don't have highly privileged Microsoft Graph API permissions
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21770](../includes/secure-recommendations/21770.md)]

### Inactive applications don't have highly privileged built-in roles
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21771](../includes/secure-recommendations/21771.md)]

### App registrations use safe redirect URIs
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21885](../includes/secure-recommendations/21885.md)]

### Service principals use safe redirect URIs
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [23183](../includes/secure-recommendations/23183.md)]

### App registrations must not have dangling or abandoned domain redirect URIs
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21888](../includes/secure-recommendations/21888.md)]

### Resource-specific consent to application is restricted
[!INCLUDE [applies-to-zero-trust-assessment](../includes/secure-recommendations/applies-to-zero-trust-assessment.md)]

[!INCLUDE [21810](../includes/secure-recommendations/21810.md)]

### Workload Identities are not assigned privileged roles
[!INCLUDE [21836](../includes/secure-recommendations/21836.md)]

### Enterprise applications must require explicit assignment or scoped provisioning
[!INCLUDE [21869](../includes/secure-recommendations/21869.md)]

### Conditional Access policies for Privileged Access Workstations are configured
[!INCLUDE [21830](../includes/secure-recommendations/21830.md)]