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

# Baseline security features in external tenants

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

<<<<<<< HEAD
Microsoft Entra External ID external tenants include several baseline security features to help immediately secure customer data. Default settings provide initial protection against threats like brute force attacks (such as denial of service or password spray attacks) and network layer attacks. These protections serve as a starting point as you develop your own identity security plan and incorporate additional Microsoft Entra premium security features.
=======
The integration of customer capabilities into Microsoft Entra ID means that your customer scenarios benefit from the advanced security and governance features available in Microsoft Entra ID. Your customers are able to self-service register for your applications using their preferred authentication methods, including social accounts through identity providers like Google and Facebook. And you can use features like multifactor authentication (MFA), Conditional Access, and Identity Protection to mitigate threats and detect risks.
>>>>>>> ba87c851f1d7ec989d3383aa3008beb214cb53e2

## Brute force protection

|Feature                                 |Notes     |
|----------------------------------------|----------|
|IP level throttling                     |Detects when a bad actor tries to overwhelm the system with requests.|
|Application and tenant level throttling |Detects unusually high traffic spikes from specific applications in your tenant and applies rate-limiting to protect your other applications.|
|Smart Lockout                           |Blocks attackers who attempt to guess passwords or use brute force methods to gain access, while allowing legitimate users to retain access to their accounts.|
|Feature level throttling                |Ensures the availability of critical sign-in functionality by prioritizing it during times of high demand.|
|User creation level throttling          |Allows for a steady increase in user sign-ups while protecting against misuse of tenant resources.|

## Account protection and access control

<<<<<<< HEAD
|Feature            |Notes     |
|-------------------|----------|
|Conditional Access |Allows organizations to set rules around user access to applications and data, preventing unauthorized access. [Learn more](~/identity/conditional-access/overview.md) </br>**Note:** Default settings are provided, but some Identity Protection features require configuration.      |
|Risk detections    |Reports Risk Events based on numerous parameters and can be used in CA for Risked Based access control. [Learn more](~/id-protection/concept-identity-protection-risks.md#risk-detections-mapped-to-riskeventtype) </br>**Note:** Default settings are provided, but premium risk event detection requires configuration. |
|Impossible travel  |This detection identifies user activities (in single or multiple sessions) originating from geographically distant locations within a time period shorter than the time it takes to travel from the first location to the second. This type of activity might indicate that a different user is using the same credentials. |
=======
Conditional Access policies are enforced after the user has completed first-factor authentication. For example, if a user's sign-in risk level is high, they must perform MFA to gain access. Alternatively, the most restrictive approach is to block access to the application.
>>>>>>> ba87c851f1d7ec989d3383aa3008beb214cb53e2

## Common networking protection

<<<<<<< HEAD
|Feature         |Notes     |
|----------------|----------|
|HTTP protection |Network-layer attacks, such as those targeting common L3/L4 vulnerabilities and timing-based attacks are blocked with only minimal processing |
=======
## Multifactor authentication (MFA)

Microsoft Entra MFA helps safeguard access to data and applications while maintaining simplicity for your users. Microsoft Entra External ID integrates directly with Microsoft Entra MFA so you can add security to your sign-up and sign-in experiences by requiring a second form of authentication. You can fine-tune MFA depending on the extent of security you want to apply to your apps. Consider the following scenarios:

- You offer a single app to customers and you want to enable MFA for an extra layer of security. You can enable MFA in a Conditional Access policy that's targeted to all users and your app.

- You offer multiple apps to your customers, but you don't require MFA for every application. For example, the customer can sign into an auto insurance application with a social or local account, but must verify the phone number before accessing the home insurance application registered in the same directory. In your Conditional Access policy, you can target all users but just those apps for which you want to enforce MFA.

Learn more about [MFA in external tenants](concept-multifactor-authentication-customers.md) or see [how to enable multifactor authentication](how-to-multifactor-authentication-customers.md).
## Identity protection

Microsoft Entra [Identity Protection](~/id-protection/overview-identity-protection.md) provides ongoing risk detection for your external tenant. It allows you to discover, investigate, and remediate identity-based risks. Identity Protection allows organizations to accomplish three key tasks:

- Automate the detection and remediation of identity-based risks.

- Investigate risks using data in the portal.

- Export risk detection data to other tools.

Identity Protection comes with risk reports that can be used to investigate identity risks in external tenants. For details, see [Investigate risk with Identity Protection in Microsoft Entra External ID](how-to-identity-protection-customers.md).

## Analyze user authentication trends for your apps

The Application user activity  feature under Usage & insights provides data analytics on user activity for registered applications in your tenant. You can use this feature to view, query, and analyze user requests and authentication trends. It can help you track changes, access patterns, and potential security breaches.

For details see [application user activity dashboards](how-to-user-insights.md). 
>>>>>>> ba87c851f1d7ec989d3383aa3008beb214cb53e2

## Next steps

- [Planning for customer identity and access management](concept-planning-your-solution.md)
