---
title: Security Features in External Tenants
description: Learn about security features and fundamentals for Microsoft Entra External ID customer identity and access management (CIAM) in external tenant configurations. 
ms.topic: concept-article
ms.date: 01/28/2026
ms.custom: it-pro
---

# Security fundamentals for external tenants

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

External-facing identity systems support a wide range of customer experiences. That wide range also makes them attractive targets for common customer identity and access management (CIAM) attack patterns such as credential stuffing, automated bot sign-ups, account takeover attempts, and high-volume traffic spikes. Understanding these threats helps explain why a clear, layered security approach is essential. Microsoft Entra External ID provides foundational capabilities you can build on. This guide helps you understand how to strengthen that foundation with recommended controls and integrations based on common CIAM threat patterns.

This article outlines:

- The attack vectors that commonly target CIAM systems.
- The security controls that can help you address them.
- A prioritized roadmap to guide implementation.
- Available third‑party integrations for fraud, bot, and DDoS protection.
- Known limitations specific to external tenants.

Our goal is to offer a practical, actionable roadmap that helps you make informed decisions about how to secure your customer-facing experiences.

## Security model for external tenants

A defense‑in‑depth strategy requires combining multiple control layers:

- Front‑door protection (WAF, bot mitigation, IP controls)
- Identity security (MFA, Conditional Access, access control) 
- Fraud prevention (sign‑up and sign‑in detection through 3P providers) 
- Application‑level authorization
- Monitoring and alerting 

Each layer addresses a different class of attacks, reducing the likelihood of compromise and limiting the blast radius.

### Priority 1: Immediate implementation

These protections are foundational. They're quick to enable and essential for establishing a secure baseline for your external identity flows. Additional protections introduced in Priority 2 address fraud, bots, DDoS, and more advanced attack patterns.

| **Security feature** |**Description** |**Threats addressed** | **User impact** | **Implementation effort** |
|----|----|----|----|----|
| **[Brute force protection](/entra/identity/authentication/howto-password-smart-lockout)** |Mitigates brute force attacks by limiting the number of sign-in attempts to prevent unauthorized access through repeated password guessing. <br> **Note:** Smart lockout focuses on password misuse; broader bot and fraud activity is addressed through additional controls later in this article.  |Prevents brute force, account takeover.  | None — No end-user impact |None – Enabled by default  |
| **[Common networking HTTP protection](/entra/external-id/customers/reference-service-limits)** |These built‑in protections help filter malformed traffic, limit abusive request patterns, and mitigate common protocol‑level attacks.<br> **Note:** These safeguards support application stability, but high‑volume DDoS and sophisticated bots require WAF or bot‑mitigation integrations described later.  |Protects against common network attacks.  |Low – Sensitive actions only |None – Enabled by default |
| **[Access Control](/entra/external-id/customers/how-to-use-app-roles-customers)** | Ensures users only access what they should by applying app roles and authorization rules.<br> **Note:** Access Control enforces authorization, not user verification -so combining it with MFA and adaptive controls enhances overall security. |Enforces authorization in applications.  |Medium– User adoption |Medium – Setup required | 
| **[Enable multifactor authentication (MFA) for all users](concept-multifactor-authentication-customers.md)** |MFA adds a second verification step beyond passwords, significantly reducing the risk of account takeover.<br> **Note:** MFA limits stolen‑credential attacks but must be paired with fraud detection and monitoring to prevent automated or malicious sign‑up attempts.  |Adds second factor authentication. |High – User adoption |Medium – Setup required | 
| **[Activity logging](/entra/identity/monitoring-health/concept-sign-ups) & [User insights](/entra/external-id/customers/how-to-user-insights)** |Activity logs and insights provide visibility into sign-ups, sign-ins, error patterns, and anomalies. They help you identify unusual trends and investigate issues quickly, supporting early detection, and informed decision making.  |Enables threat detection. | None — No end-user impact |Medium – Setup required |

### Priority 2: Short-term implementation

Once baseline controls are in place, implement protections that materially improve threat resilience.

| **Security feature** |**Description** |**Threats addressed** | **User impact** | **Implementation effort** |
|----|----|----|----|----|
| **[Conditional Access](/entra/external-id/customers/concept-supported-features-customers#conditional-access)** | Customizable policies that trigger MFA to defend against threats like phishing and account takeovers. See [What is Conditional Access?](~/identity/conditional-access/overview.md) and [Developer guide to Conditional Access authentication context](~/identity-platform/developer-guide-conditional-access-authentication-context.md) for more information. |Provides risk-based access control. |Medium – User adoption |Medium – Setup required  | 
| **[Credential and secret management](/entra/architecture/deployment-external-operations#application-security-credential-and-secret-management)** |Prefer certificates over client secrets for app authentication to External ID because certificates are more secure and harder to compromise. |Secures app credentials. |None — No end-user impact |Medium – Setup required  |
| **[Token lifetime management](/entra/architecture/deployment-external-operations#risk-reduction-with-token-lifetime-management)** |Configure the token lifetime to reduce your app’s exposure to compromised tokens. |Limits exposure. |High – Requires frequent refreshes |Medium – Setup required  |
| **Custom Domain with Web Application Firewall (WAF)** |Use [Cloudflare](/entra/external-id/customers/how-to-configure-waf-integration), [Akamai](/entra/external-id/customers/how-to-configure-akamai-integration) or [Azure WAF](/entra/external-id/customers/tutorial-configure-external-id-web-app-firewall) for tenant security against DDoS attacks.  |Provides DDoS and bot protection. | Medium – User adoption |High – WAF integration |
| **Sign-up fraud protection** |Use [Arkose Labs](/entra/external-id/customers/how-to-integrate-fraud-protection?pivots=arkose) and [HUMAN Security](/entra/external-id/customers/how-to-integrate-fraud-protection?pivots=human) to protect against sign-up fraud and block automated bot attacks.  |Provides fraud protection. |Medium – User adoption |High – Sign-up protection integration |
| **Enhanced monitoring and alerting** | Use [Azure Monitor and Microsoft Sentinel](/entra/external-id/customers/how-to-azure-monitor) to enable built-in monitoring, log analytics, and advanced threat detection.  |Provides early threat detection. | None — No end-user impact |High – Azure Monitor integration |

### Priority 3: Long-term implementation

These are iterative, ongoing improvements to strengthen posture over time.

| **Security feature** |**Description** |**Threats addressed** | **User impact** | **Implementation effort** | 
|----|----|----|----|----|
| **[Monitoring and alerting](/entra/external-id/customers/how-to-azure-monitor)** |Fine-tune monitoring and alert thresholds to improve accuracy. |Provides accurate monitoring. |None — No end-user impact | Medium – Setup required  |
| **Continuous security enhancements and new features** |Use the 3–12 month period to iterate on your security controls and adopt [new enhancements](/entra/external-id/whats-new-docs?tabs=external-tenants). |Helps prevent security threats and vulnerabilities. |Depends on the new feature. | Depends on the new feature.  |
| **[Zero Trust Assessment](/security/zero-trust/assessment/overview)** |Tests hundreds of security settings based on Secure Future Initiative (SFI) and Zero Trust principles. | Provides thorough security configuration testing. |None — No end-user impact |Medium – Setup required  |

## Known limitations

These security features have limitations or are unavailable in external tenants. The following table lists these limitations and suggests possible workarounds.

|**Feature** | **Current limitation** |**Workaround** |
|----|----|----|----|
| **[Passkeys (FIDO2)](/entra/identity/authentication/concept-authentication-passkeys-fido2)** | Passkey registration isn't supported in external tenants.  | Use built-in controls. |
| **[ID Protection](/entra/id-protection/overview-identity-protection)** | ID Protection isn’t supported in external tenants. | Not available in external tenants.|

## Related content

- [Supported features in workforce and external tenants](/entra/external-id/customers/concept-supported-features-customers)
