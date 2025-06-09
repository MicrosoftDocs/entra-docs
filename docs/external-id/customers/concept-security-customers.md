---
title: Security Features in External Tenants
description: Learn about security features and fundamentals for Microsoft Entra External ID customer identity and access management (CIAM) in external tenant configurations.
 
ms.author: cmulligan
author: csmulligan
manager: dougeby
ms.service: entra-external-id
 
ms.subservice: external
ms.topic: concept-article
ms.date: 06/09/2025
ms.custom: it-pro
---

# Security fundamentals for external tenants

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Microsoft Entra External ID external tenants include several baseline security features to help immediately secure customer data. Default settings provide initial protection against threats like brute force attacks and network layer attacks. These protections serve as a starting point as you develop your own identity security plan and add Microsoft Entra premium security features.

## Built-in security controls

In newly created external tenants, the following core security features are enabled by default to help protect applications from various cyber threats.

|Feature Name  |Description  |
|--------------|-------------|
|Brute force protection            | Mitigates brute force attacks by limiting the number of login attempts to prevent unauthorized access through repeated password guessing. |
|Common networking HTTP Protection | Provides protection against common network-layer attacks and timing-based attacks, protecting against attempts to overwhelm your service with excessive requests.|
|Account Protection                | Ensures accounts are protected from unauthorized access to safeguard user data and prevent account compromise.   |
|Access Control                    | Controls access to applications and resources, ensuring only authorized users can access sensitive information.  |
 
## Real-time and offline protection

Microsoft Entra External ID detects and mitigates abnormal traffic patterns and malicious activities, allowing legitimate requests to be processed while harmful traffic is filtered out.

|Feature Name	|Description |
|---------------|------------|    
|Real-time protection	|Detects abnormal traffic patterns and activates mitigation protocols in real-time, filtering out malicious traffic while allowing legitimate requests. |
|Offline Protection	    |Filters out malicious traffic while allowing legitimate requests even when real-time measures are not active.                  |

## Conditional Access and MFA

Customizable policies and multifactor authentication enhance security by reducing unauthorized access and ensuring only legitimate users can access applications and resources.

|Feature Name	|Description |
|---------------|------------| 
|Conditional Access policies	    |Customizable policies that trigger MFA to defend against threats like phishing and account takeovers. [Learn more](~/identity/conditional-access/overview.md)   |
|Multifactor authentication (MFA)	|MFA methods configured to ensure only legitimate users can access applications, significantly reducing the risk of unauthorized access. [Learn more](concept-multifactor-authentication-customers.md)|

## Related content

- [Planning for customer identity and access management](concept-planning-your-solution.md)
- [Microsoft Entra Blog: Built-in security controls for external-facing apps](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/built-in-security-controls-for-external-facing-apps/4175879)
