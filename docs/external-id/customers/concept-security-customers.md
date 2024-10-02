---
title: Security features in external tenants
description: Learn about CIAM security features.
 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: concept-article
ms.date: 09/03/2024
ms.author: mimart
ms.custom: it-pro

---

# Security fundamentals for external tenants

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Microsoft Entra External ID external tenants include several baseline security features to help immediately secure customer data. Default settings provide initial protection against threats like brute force attacks and network layer attacks. These protections serve as a starting point as you develop your own identity security plan and incorporate additional Microsoft Entra premium security features.

## Brute force protection

|Feature                                 |Notes     |
|----------------------------------------|----------|
|IP level throttling                     |Detects when a bad actor tries to overwhelm the system with requests.|
|Application and tenant level throttling |Detects unusually high traffic spikes from specific applications in your tenant and applies rate-limiting to protect your other applications.|
|Smart Lockout                           |Blocks attackers who attempt to guess passwords or use brute force methods to gain access, while allowing legitimate users to retain access to their accounts.|
|Feature level throttling                |Ensures the availability of critical sign-in functionality by prioritizing it during times of high demand.|
|User creation level throttling          |Allows for a steady increase in user sign-ups while protecting against misuse of tenant resources.|

## Account protection and access control

|Feature            |Notes     |
|-------------------|----------|
|Conditional Access |Allows organizations to set rules around user sign-in to applications and data, preventing unauthorized access (sign-up rules are currently unavailable). [Learn more](~/identity/conditional-access/overview.md) </br>**Note:** Default settings are provided, but some Identity Protection features require configuration.      |
|Risk detections    |Reports Risk Events based on numerous parameters and can be used in CA for Risked Based access control. [Learn more](~/id-protection/concept-identity-protection-risks.md#risk-detections-mapped-to-riskeventtype) </br>**Note:** Default settings are provided, but premium risk event detection requires configuration. |
|Impossible travel  |This detection identifies user activities (in single or multiple sessions) originating from geographically distant locations within a time period shorter than the time it takes to travel from the first location to the second. This type of activity might indicate that a different user is using the same credentials. |

## Common networking protection

|Feature         |Notes     |
|----------------|----------|
|HTTP protection |Network-layer attacks, such as those targeting common L3/L4 vulnerabilities and timing-based attacks are blocked with only minimal processing |

## Next steps

- [Planning for customer identity and access management](concept-planning-your-solution.md)
