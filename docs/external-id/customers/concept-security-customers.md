---
title: Security Features in External Tenants
description: Learn about security features and fundamentals for Microsoft Entra External ID customer identity and access management (CIAM) in external tenant configurations.
 
ms.author: cmulligan
author: csmulligan
manager: dougeby
ms.service: entra-external-id
 
ms.subservice: external
ms.topic: concept-article
ms.date: 11/19/2025
ms.custom: it-pro
---

# Security fundamentals for external tenants

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Microsoft Entra External ID provides baseline security features for external tenants, offering immediate protection against threats like brute force and network layer attacks. These default settings serve as a foundation for developing your own identity security plan. From this starting point, you can implement real-time and offline protection through Microsoft Entra premium security features.

## Built-in security controls

In newly created external tenants, the following core security features are enabled by default to help protect applications from various cyber threats.

|Feature Name  |Description  |
|--------------|-------------|
|[Brute force protection](/entra/identity/authentication/howto-password-smart-lockout)            | Mitigates brute force attacks by limiting the number of sign-in attempts to prevent unauthorized access through repeated password guessing. |
|[Common networking HTTP Protection](/entra/external-id/customers/reference-service-limits) | Provides protection against common network-layer attacks and timing-based attacks, protecting against attempts to overwhelm your service with excessive requests.|
|Account Protection    | Helps safeguard against unauthorized access to protect user data and prevent account breaches. Relying solely on risk-based multifactor authentication (MFA) isn't a complete security strategy for account protection. MFA is just one control and isn't sufficient for comprehensive identity protection. We offer partner solutions account protection ([Cloudflare](/entra/external-id/customers/how-to-configure-waf-integration) and [Akamai](/entra/external-id/customers/how-to-configure-akamai-integration)) and continue to develop additional options. |
|[Access Control](/entra/external-id/customers/how-to-use-app-roles-customers) | Controls access to applications and resources so that only authorized users can access sensitive information.  |
 
## Conditional Access and multifactor authentication (MFA)

Customizable policies and MFA enhance security by reducing unauthorized access to applications and resources.

|Feature Name |Description |
|---------------|------------|
|[Conditional Access policies](/entra/external-id/customers/concept-supported-features-customers#conditional-access) |Customizable policies that trigger MFA to defend against threats like phishing and account takeovers. See [What is Conditional Access?](~/identity/conditional-access/overview.md) and [Developer guide to Conditional Access authentication context](~/identity-platform/developer-guide-conditional-access-authentication-context.md) for more information about Conditional Access.   |
|Multifactor authentication (MFA) |MFA methods configured to ensure only legitimate users can access applications, significantly reducing the risk of unauthorized access. [Learn more](concept-multifactor-authentication-customers.md)     |

## Related content

- [Planning for customer identity and access management](concept-planning-your-solution.md)
- [Microsoft Entra Blog: Built-in security controls for external-facing apps](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/built-in-security-controls-for-external-facing-apps/4175879)
- [Microsoft Entra External ID deployment guide for security operations](../../architecture/deployment-external-operations.md)
