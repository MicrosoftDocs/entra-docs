---
title: Security features in external tenants
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

## NEW

## Built-in Security Controls

When you create a Microsoft Entra External ID external tenant, core security features are enabled by default. These controls are designed to protect applications from various cyber threats, ensuring robust security for external-facing applications.

|Feature Name  |Description  |
|--------------|-------------|
|Brute Force Protection            | Helps mitigate brute force attacks by limiting the number of login attempts. |
|Common Networking HTTP Protection | Provides protection against common networking HTTP threats.                  |
|Account Protection                | Ensures accounts are protected from unauthorized access.                     |
|Access Control                    | Controls access to applications and resources.                               |
 
## Real-time and Offline Protection

Microsoft Entra External ID provides layers of protection that work together to detect and mitigate abnormal traffic patterns and malicious activities. These feature help ensure that legitimate requests are processed while harmful traffic is filtered out.

|Feature Name	|Description |
|---------------|------------|    
|Real-time Protection	|Detects abnormal traffic patterns and activates mitigation protocols in real-time. |
|Offline Protection	    |Filters out malicious traffic while allowing legitimate requests.                  |

## Conditional Access and MFA

Customizable policies and multifactor authentication methods significantly enhance security by reducing the risk of unauthorized access and ensuring that only legitimate users can access the applications and resources.

|Feature Name	|Description |
|---------------|------------| 
|Conditional Access Policies	    |Customizable policies that trigger MFA to enhance security. [Learn more](~/identity/conditional-access/overview.md)   |
|Multifactor Authentication (MFA)	|Methods configured to reduce the risk of compromise by 99.22%. [Learn more](concept-multifactor-authentication-customers.md)|

## Next steps

- [Planning for customer identity and access management](concept-planning-your-solution.md)
