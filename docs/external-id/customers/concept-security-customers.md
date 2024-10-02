---
title: Security features in external tenants
description: Learn about security features and fundamentals for Microsoft Entra External ID customer identity and access management (CIAM) in external tenant configurations.
 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: concept-article
ms.date: 10/02/2024
ms.author: mimart
ms.custom: it-pro

---

# Security fundamentals for external tenants

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Microsoft Entra External ID external tenants include several baseline security features to help immediately secure customer data. Default settings provide initial protection against threats like brute force attacks and network layer attacks. These protections serve as a starting point as you develop your own identity security plan and add Microsoft Entra premium security features.

## Brute force protection

|Feature                                 |Notes     |
|----------------------------------------|----------|
|IP level throttling                     |Detects when a bad actor tries to overwhelm the system with requests.|
|Application and tenant level throttling |Detects unusually high traffic spikes from specific applications in your tenant and applies rate-limiting to protect your other applications.|
|Smart Lockout                           |Blocks attackers who attempt to guess passwords or use brute force methods to gain access, while allowing legitimate users to retain access to their accounts. [Learn more](~/identity/authentication/howto-password-smart-lockout.md) |
|Feature level throttling                |Ensures the availability of critical sign-in functionality by prioritizing it during times of high demand.|
|User creation level throttling          |Allows for a steady increase in user sign-ups while protecting against misuse of tenant resources.|

## Account protection and access control

|Feature            |Notes     |
|-------------------|----------|
|Conditional Access |Allows organizations to set rules around user sign-in to applications and data, preventing unauthorized access (sign-up rules are currently unavailable). [Learn more](~/identity/conditional-access/overview.md) <br></br>**Note:** Default settings are provided, but risk-based access policies powered by ID Protection require configuration.|
|ID Protection risk detection  |Reports risk events based on numerous parameters and can be used in Conditional Access for risk-based access control. [Learn more](~/id-protection/concept-identity-protection-risks.md#risk-detections-mapped-to-riskeventtype) <br></br>**Example:** *Impossible travel* is a risk detection that identifies user activities in distant locations, where the timeframe is too short to travel from one location to the other. The activity can be in a single session or multiple sessions. This type of activity might indicate that someone is using another user’s credentials. <br></br>**Note:** Default Conditional Access settings are provided, but risk-based access policies powered by ID Protection require configuration. |

## Common networking protection

|Feature         |Notes     |
|----------------|----------|
|HTTP protection |Network-layer attacks, such as those targeting common L3/L4 vulnerabilities and timing-based attacks, are blocked with only minimal processing. |

## Next steps

- [Planning for customer identity and access management](concept-planning-your-solution.md)
