---
title: Security guidance - Protect networks
description: Improve your security posture with the Microsoft Entra Zero Trust assessment to protect networks.

ms.topic: concept-article
ms.date: 02/11/2026

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

### Web content filtering policies are configured
[!INCLUDE [25408](../includes/secure-recommendations/25408.md)]

### Web content filtering uses category-based rules
[!INCLUDE [25409](../includes/secure-recommendations/25409.md)]

### Web content filtering policies are linked to security profiles
[!INCLUDE [25410](../includes/secure-recommendations/25410.md)]

### Web content filtering integrates with Conditional Access
[!INCLUDE [25407](../includes/secure-recommendations/25407.md)]

### TLS inspection is enabled and correctly configured for outbound traffic
[!INCLUDE [25411](../includes/secure-recommendations/25411.md)]

### Threat intelligence filtering protects internet traffic
[!INCLUDE [25412](../includes/secure-recommendations/25412.md)]

### AI Gateway protects enterprise generative AI applications from prompt injection attacks
[!INCLUDE [25415](../includes/secure-recommendations/25415.md)]

### Global Secure Access cloud firewall protects branch office internet traffic
[!INCLUDE [25416](../includes/secure-recommendations/25416.md)]

### Microsoft 365 traffic is actively flowing through Global Secure Access
[!INCLUDE [25376](../includes/secure-recommendations/25376.md)]

### Universal tenant restrictions block unauthorized external tenant access
[!INCLUDE [25377](../includes/secure-recommendations/25377.md)]

### External collaboration is governed by explicit cross-tenant access policies
[!INCLUDE [25378](../includes/secure-recommendations/25378.md)]

### Conditional Access policies use compliant network controls
[!INCLUDE [25379](../includes/secure-recommendations/25379.md)]

### Source IP restoration is enabled
[!INCLUDE [25370](../includes/secure-recommendations/25370.md)]

### Global Secure Access signaling for Conditional Access is enabled
[!INCLUDE [25380](../includes/secure-recommendations/25380.md)]

### Network traffic is routed through Global Secure Access for security policy enforcement
[!INCLUDE [25381](../includes/secure-recommendations/25381.md)]

### Traffic forwarding profiles are scoped to appropriate users and groups for controlled deployment
[!INCLUDE [25382](../includes/secure-recommendations/25382.md)]

### Private network connectors are active and healthy to maintain Zero Trust access to internal resources
[!INCLUDE [25391](../includes/secure-recommendations/25391.md)]

### Private network connectors are running the latest version
[!INCLUDE [25392](../includes/secure-recommendations/25392.md)]

### Private DNS is configured for internal name resolution
[!INCLUDE [25399](../includes/secure-recommendations/25399.md)]

### Intelligent Local Access is enabled and configured
[!INCLUDE [25405](../includes/secure-recommendations/25405.md)]

### Quick Access is enabled and bound to a connector
[!INCLUDE [25393](../includes/secure-recommendations/25393.md)]

### Quick Access is bound to a Conditional Access policy
[!INCLUDE [25394](../includes/secure-recommendations/25394.md)]

### Entra Private Access Application segments are defined to enforce least-privilege access
[!INCLUDE [25395](../includes/secure-recommendations/25395.md)]

### Domain controller RDP access is protected by phishing-resistant authentication through Global Secure Access
[!INCLUDE [25398](../includes/secure-recommendations/25398.md)]

### Private Access sensors are enforcing strong authentication policies on domain controllers
[!INCLUDE [25403](../includes/secure-recommendations/25403.md)]

### Quick Access has user or group assignments
[!INCLUDE [25480](../includes/secure-recommendations/25480.md)]

### All Private Access apps have user or group assignments
[!INCLUDE [25481](../includes/secure-recommendations/25481.md)]

### Outbound traffic from VNet integrated workloads is routed through Azure Firewall
[!INCLUDE [25535](../includes/secure-recommendations/25535.md)]

### Threat intelligence is enabled in deny mode on Azure Firewall
[!INCLUDE [25537](../includes/secure-recommendations/25537.md)]

### IDPS inspection is enabled in deny mode on Azure Firewall
[!INCLUDE [25539](../includes/secure-recommendations/25539.md)]

### Application Gateway WAF is enabled in prevention mode
[!INCLUDE [25541](../includes/secure-recommendations/25541.md)]

### Azure Front Door WAF is enabled in prevention mode
[!INCLUDE [25543](../includes/secure-recommendations/25543.md)]
