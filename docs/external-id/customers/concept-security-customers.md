---
title: Security Features in External Tenants
description: Learn about security features and fundamentals for Microsoft Entra External ID customer identity and access management (CIAM) in external tenant configurations. 

ms.author: cmulligan
author: csmulligan
manager: dougeby
ms.service: entra-external-id

ms.subservice: external
ms.topic: concept-article
ms.date: 06/11/2025
ms.custom: it-pro
---

# Security fundamentals for external tenants

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Microsoft Entra External ID provides baseline security features for external tenants, offering immediate protection against threats like brute force and network layer attacks. These default settings serve as a foundation for developing your own identity security plan. From this starting point, you can implement real-time and offline protection through Microsoft Entra premium security features.

:::image type="content" source="media/concept-security-customers/security-layers.png" alt-text="Security layers diagram":::

## Core protection

Every external tenant starts with core protection. This foundational layer provides baseline security features from the moment the tenant is created, ensuring essential safeguards against common threats.

To learn more about our general security recommendations for Microsoft Entra, see [Configure Microsoft Entra for increased security](/entra/fundamentals/configure-security). This article focused on workforce tenant-specific security features, but many of them are available in external tenants as well.

<!--- Will https://learn.microsoft.com/en-us/security/zero-trust/assessment/overview be available for external tenants too? --->

## Prevent DDOS and OWASP vulnerabilities

To maintain application availability and integrity, this layer integrates with Web Application Firewall (WAF) solutions. It helps prevent Distributed Denial of Service (DDOS) attacks and adheres to OWASP standards for secure web applications. For more information on configuring WAF with External ID, see our [Azure](/entra/external-id/customers/tutorial-configure-external-id-web-app-firewall), [Cloudflare](/entra/external-id/customers/how-to-configure-waf-integration), and [Akamai](/entra/external-id/customers/how-to-configure-akamai-integration) integration guides.

## Prevent fake account sign-up

Fraudulent accounts are blocked through advanced fraud prevention models. By analyzing sign-up patterns and behaviors, this layer proactively stops fake accounts before they can impact your environment. For more details, see [Fraud protection integration](/entra/external-id/customers/how-to-integrate-fraud-protection) options.

## Sign-in account take-over protection

This layer focuses on preventing unauthorized access to user accounts. It includes mechanisms for account take-over prevention and IRSF (International Revenue Share Fraud) protection to keep credentials secure. This feature is coming soon to external tenants.

## Offline monitoring and detections

Beyond real-time protection, this layer uses offline threat hunting models to analyze historical data and detect patterns of suspicious activity. It ensures continuous security even after initial sign-in events. Learn more about [Azure Monitor and Microsoft Sentinel integration](/entra/external-id/customers/how-to-azure-monitor).

## Security implementation

We recommend the below approach. This approach balances Threat prevention, user impact, and implementation cost.

### Priority 1: Immediate implementation (Week 1–2)

| **Security feature** |**Description** |**Threat prevention** | **User impact** | **Implementation effort** | **Licensing** |
|----|----|----|----|----|
| **[Brute force protection](/entra/identity/authentication/howto-password-smart-lockout)** |Mitigates brute force attacks by limiting the number of sign-in attempts to prevent unauthorized access through repeated password guessing. |High – Prevents brute force, account takeover | None - No disruption for end users |Zero – Enabled by default | Free (First 50K MAU) |
| **[Common networking HTTP Protection](/entra/external-id/customers/reference-service-limits)** |Provides protection against common network-layer attacks and timing-based attacks, protecting against attempts to overwhelm your service with excessive requests. |High – Prevents account compromises |Low – Sensitive actions only |Zero – Enabled by default | Free (First 50K MAU) |
| **[Access Control](/entra/external-id/customers/how-to-use-app-roles-customers)** | Controls access to applications and resources so that only authorized users can access sensitive information.  |High – Enforces authorization in applications |Medium– User adoption |Medium – Setup required | Free (First 50K MAU) |
| **[Enable multifactor authentication (MFA) for all users](concept-multifactor-authentication-customers.md)** |Require users to verify their identity with an additional factor beyond their password to prevent unauthorized access. |High – Adds second factor authentication |High – User adoption |Medium – Setup required | Free (First 50K MAU) |
| **[Activity logging](/entra/identity/monitoring-health/concept-sign-ups) & [User insights](/entra/external-id/customers/how-to-user-insights)** |Use sign-up logs to monitor and troubleshoot registration activity, and leverage user activity dashboards to track sign-ins, MFA performance, and fraud detection for external tenants. |Medium – Enables threat detection | None - No disruption for end users |Medium – Setup required | Free tier available |

### Priority 2: Short-term implementation (1–3 Months)

| **Security feature** |**Description** |**Threat prevention** | **User impact** | **Implementation effort** | **Licensing** |
|----|----|----|----|----|
| **[Conditional Access](/entra/external-id/customers/concept-supported-features-customers#conditional-access)** | Customizable policies that trigger MFA to defend against threats like phishing and account takeovers. See [What is Conditional Access?](~/identity/conditional-access/overview.md) and [Developer guide to Conditional Access authentication context](~/identity-platform/developer-guide-conditional-access-authentication-context.md) for more information. |High – Risk-based access control |Medium – User adoption |Medium – Setup required  | Free (First 50K MAU)  |
| **[Credential and secret management](/entra/architecture/deployment-external-operations#application-security-credential-and-secret-management)** |Prefer certificates over client secrets for app authentication to External ID because certificates are more secure and harder to compromise. |High – Secure app credentials |None - No disruption for end users |Medium – Setup required  | Free (First 50K MAU) |
| **[Token lifetime management](/entra/architecture/deployment-external-operations#risk-reduction-with-token-lifetime-management)** |Configure the token lifetime to reduce your app’s exposure to compromised tokens. |Medium – Limit exposure |High – Requires frequent refreshes |Medium – Setup required  | Free (First 50K MAU) |
| **Custom Domain with Web Application Firewall (WAF)** |Use [Cloudflare](/entra/external-id/customers/how-to-configure-waf-integration), [Akamai](/entra/external-id/customers/how-to-configure-akamai-integration) or [Azure WAF](/entra/external-id/customers/tutorial-configure-external-id-web-app-firewall) for tenant security against DDoS attacks.  |High – DDoS and bot protection | Medium – User adoption |High – WAF integration | WAF costs vary |
| **Sign-up fraud protection** |Use [Arkose Labs](/entra/external-id/customers/how-to-integrate-fraud-protection?pivots=arkose) and [HUMAN Security](/entra/external-id/customers/how-to-integrate-fraud-protection?pivots=human) to protect against sign-up fraud and block automated bot attacks.  |High – Fraud protection |Medium – User adoption |High – Sign-up protection integration | Fraud protection costs vary |
| **Enhanced monitoring and alerting** | Use [Azure Monitor and Microsoft Sentinel](/entra/external-id/customers/how-to-azure-monitor) to enable one-click monitoring, log analytics, and advanced threat detection.  |Medium – Early threat detection | None - No disruption for end users |High – Azure Monitor integration | [Azure Monitor pricing](https://azure.microsoft.com/en-us/pricing/details/monitor) |

### Priority 3: Long-term implementation (3–12 Months)

| **Security feature** |**Description** |**Threat prevention** | **User impact** | **Implementation effort** | **Licensing** |
|----|----|----|----|----|
| **Monitoring and alerting** |Fine-tune monitoring and alert thresholds to improve accuracy. |Medium - Accurate monitoring |None - No disruption for end users | Medium – Setup required  | [Azure Monitor pricing](https://azure.microsoft.com/en-us/pricing/details/monitor) |
| **Continuous security enhancements and new features** |Use the 3–12 month period to iterate on your security controls and adopt [new enhancements](/entra/external-id/whats-new-docs?tabs=external-tenants). |Medium - Updated features |Depends on the new feature | Medium – Setup required  | Various costs |
| **[Zero Trust Assessment](/security/zero-trust/assessment/overview)** |Tests hundreds of security settings based on Secure Future Initiative (SFI) and Zero Trust principles. |High - Thorough security configuration testing |None – Backend only |Medium – Setup required  | Free (First 50K MAU) |

## Known limitations

These security features have limitations or are unavailable in external tenants. The following table lists these limitations and suggests possible workarounds.

|**Feature** | **Current limitation** |**Workaround** |
|----|----|----|----|
| **[Passkeys (FIDO2)](/entra/identity/authentication/concept-authentication-passkeys-fido2)** | Passkey registration isn't supported in external tenants.  | Use built-in controls. |
| **[ID Protection](/entra/id-protection/overview-identity-protection)** | ID Protection tenant risk detection isn’t supported in external tenants. | Use [Azure Monitor and Microsoft Sentinel integration](/entra/external-id/customers/how-to-azure-monitor). |

## Related content

- [Supported features in workforce and external tenants](/entra/external-id/customers/concept-supported-features-customers)
