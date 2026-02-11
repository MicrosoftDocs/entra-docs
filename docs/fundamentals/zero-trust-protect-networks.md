---
title: Security guidance - Protect networks
description: Improve your security posture with the Microsoft Entra Zero Trust assessment to protect networks.

ms.service: entra
ms.subservice: fundamentals
ms.topic: concept-article
ms.date: 02/09/2026

ms.author: sarahlipsey
author: shlipsey
manager: pmwongera
ms.reviewer: ramical
---

# Configure Microsoft Entra for Zero Trust: Protect networks

The "Protect networks" pillar of the [Secure Future Initiative](https://www.microsoft.com/trust-center/security/secure-future-initiative?msockid=2bad2df65a416adb0e5838355b3e6b95#SFI-pillars) emphasizes the critical importance of securing network access and implementing network-based controls to prevent unauthorized access to organizational resources. The best practices in this pillar focus on actions such as establishing network boundaries, controlling traffic flows, and implementing location-based access policies that verify the trustworthiness of network connections before granting access.

## Zero Trust security recommendations

### Named locations are configured
[!INCLUDE [21865](../includes/secure-recommendations/21865.md)]

### Tenant restrictions v2 policy is configured
[!INCLUDE [21793](../includes/secure-recommendations/21793.md)]

### Network validation is configured through Universal Continuous Access Evaluation
[!INCLUDE [25371](../includes/secure-recommendations/25371.md)]

### Global Secure Access client is deployed on all managed endpoints
[!INCLUDE [25372](../includes/secure-recommendations/25372.md)]

### Global Secure Access licenses are available in the tenant and assigned to users
[!INCLUDE [25375](../includes/secure-recommendations/25375.md)]

### Internet Access forwarding profile is enabled
[!INCLUDE [25406](../includes/secure-recommendations/25406.md)]

### Global Secure Access web content filtering is enabled and configured
[!INCLUDE [25408](../includes/secure-recommendations/25408.md)]

### Microsoft 365 traffic is actively flowing through Global Secure Access
[!INCLUDE [25376](../includes/secure-recommendations/25376.md)]

### Universal tenant restrictions block unauthorized external tenant access
[!INCLUDE [25377](../includes/secure-recommendations/25377.md)]

### External collaboration is governed by explicit cross-tenant access policies
[!INCLUDE [25378](../includes/secure-recommendations/25378.md)]

### Conditional Access policies use compliant network controls
[!INCLUDE [25379](../includes/secure-recommendations/25379.md)]
