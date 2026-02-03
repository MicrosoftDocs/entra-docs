---
title: Federation with Microsoft Entra ID
description: Comprehensive hub for federation scenarios including AD FS, migration to cloud authentication, external partner federation, and hybrid identity federation configuration.
author: garrodonnell
ms.author: godonnell
ms.service: entra-id
ms.subservice: hybrid
ms.topic: hub-page
ms.date: 02/03/2026
ai-usage: ai-assisted
---

# Federation with Microsoft Entra ID

Federation enables users to authenticate with your organization's identity infrastructure and access cloud resources. Organizations use federation for hybrid identity scenarios, partner access (B2B), and legacy authentication requirements. However, many organizations are now migrating from federation to modern cloud authentication for improved security and simplified management.

This guide helps you make informed decisions about federation, whether you're evaluating federation for your hybrid environment, migrating away from AD FS, or configuring external partner access.

## Choose your authentication strategy

Federation is one approach to hybrid identity, but it's not always the best choice for modern organizations. Consider your goals carefully.

### Common scenarios

| Scenario | Recommended approach | Key benefit |
|----------|---------------------|-------------|
| Migrate from AD FS to cloud | [Move to cloud authentication](#migrate-from-ad-fs-to-cloud-authentication) | Reduced infrastructure, improved security |
| New hybrid deployment | [Use password hash sync](#compare-hybrid-authentication-methods) | Simpler, more resilient than federation |
| Partner organization access | [Configure SAML/WS-Fed federation](#enable-external-partner-federation) | Direct federation without guest accounts |
| Legacy on-premises requirements | [Deploy AD FS with Entra Connect](#configure-federation-with-microsoft-entra-connect) | Support for legacy protocols |
| Multiple domain federation | [Configure multi-domain support](#configure-federation-with-microsoft-entra-connect) | Single AD FS farm for multiple domains |
| Migrate enterprise apps from AD FS | [Move apps to Microsoft Entra ID](#migrate-applications-from-ad-fs) | Modern authentication, reduced dependencies |

### Compare hybrid authentication methods

| Factor | Federation (AD FS) | Password hash sync (PHS) | Pass-through authentication (PTA) |
|--------|-------------------|--------------------------|-----------------------------------|
| **Infrastructure** | High (AD FS servers, load balancers, proxies) | Low (lightweight agent) | Medium (on-premises agents) |
| **Complexity** | High (certificates, claims, policies) | Low | Medium |
| **Resilience** | Requires HA infrastructure | Works during outages (cached hashes) | Requires on-premises availability |
| **Security** | On-premises control | Passwords sync to cloud | Passwords stay on-premises |
| **Modern auth support** | Requires configuration | Native | Native |
| **Maintenance** | High (patches, certificates, monitoring) | Minimal | Low |
| **Cloud-only features** | Limited support | Full support | Full support |
| **Best for** | Legacy requirements, strict on-premises control | Most organizations, cloud migration | Compliance requiring passwords on-premises only |

### Decision guidance

**Migrate from federation if:**
- You want to reduce infrastructure complexity and maintenance
- You're moving to cloud-only or cloud-first architecture
- You need better support for modern authentication and passwordless
- Your security requirements don't mandate on-premises password validation
- You want to eliminate certificate management overhead

**Keep federation if:**
- Compliance requires on-premises authentication for all users
- You have legacy applications requiring AD FS-specific claims
- You need smart card or certificate-based authentication for all scenarios
- You have existing AD FS infrastructure that's well-maintained and working

**Use external federation if:**
- You collaborate with partner organizations that have their own identity systems
- You want direct federation instead of guest account management
- Partners need to use their own credentials without password sync

## Plan federation deployment

If you're implementing federation, consider resilience and high availability requirements.

### Architecture and planning

| Article | Description |
|---------|-------------|
| [Build resilience in hybrid authentication architecture](../../architecture/resilience-in-hybrid.md) | Design resilient federation infrastructure with backup authentication methods and disaster recovery. |
| [Plan your Microsoft Entra hybrid join implementation](../../devices/hybrid-join-plan.md) | Understand federated authentication requirements for hybrid-joined devices including WS-Trust endpoints. |

### Step-by-step federation setup

| Article | Description |
|---------|-------------|
| [Tutorial: Federate a single AD forest environment to the cloud](tutorial-federation.md) | Complete walkthrough for setting up federation in a test or production environment. |

## Migrate from AD FS to cloud authentication

Most organizations can improve security and reduce complexity by moving from AD FS to cloud authentication. Organizations migrating from federation typically see reduced infrastructure costs, simplified operations, and better support for modern authentication features like passwordless. Microsoft provides tools and guidance for staged migrations with minimal risk.

### Plan your migration

| Article | Description |
|---------|-------------|
| [Migrate from federation to cloud authentication](migrate-from-federation-to-cloud-authentication.md) | Comprehensive migration guide covering assessment, planning, staged rollout, and validation. |
| [Best practices to migrate applications and authentication](../../architecture/migration-best-practices.md) | Strategic guidance for migrating authentication from on-premises to Microsoft Entra ID. |

### Migrate enterprise applications

| Article | Description |
|---------|-------------|
| [Migrate AD FS applications to Microsoft Entra ID](../../enterprise-apps/migrate-ad-fs-application-howto.md) | Move SAML and WS-Federation applications from AD FS to Microsoft Entra ID for modern authentication. |
| [SAML-based single sign-on configuration and limitations](../../enterprise-apps/migrate-adfs-saml-based-sso.md) | Map AD FS SSO settings to Microsoft Entra ID SAML configuration for application migration. |

## Configure federation with Microsoft Entra Connect

If you need to deploy or maintain federation, use Microsoft Entra Connect to integrate AD FS with Microsoft Entra ID. Federation requires significant infrastructure (AD FS servers, load balancers, web application proxies) and ongoing maintenance including certificate management and security updates.

### Understand federation options

| Article | Description |
|---------|-------------|
| [What is federation with Microsoft Entra ID?](whatis-fed.md) | Overview of federation concepts, scenarios, and when to use federation vs. cloud authentication. |
| [Microsoft Entra Connect and federation](how-to-connect-fed-whatis.md) | Understand how Microsoft Entra Connect integrates with AD FS for federated authentication. |
| [Microsoft Entra federation compatibility list](how-to-connect-fed-compatibility.md) | Third-party identity providers certified to work with Microsoft Entra ID federation. |

### Deploy and configure federation

| Article | Description |
|---------|-------------|
| [Customize an installation of Microsoft Entra Connect](how-to-connect-install-custom.md) | Custom installation including AD FS deployment and federation configuration options. |
| [Microsoft Entra Connect: Next steps and how to manage](how-to-connect-post-installation.md) | Post-installation configuration tasks and ongoing management of federation. |
| [Microsoft Entra Connect - AD FS management and customization](how-to-connect-fed-management.md) | Manage AD FS farm, add servers, customize sign-in pages, and configure trust relationships. |
| [Multiple Domain Support for Federating with Microsoft Entra ID](how-to-connect-install-multiple-domains.md) | Configure federation for multiple DNS domains using a single AD FS farm. |

### Configure claims and authentication

| Article | Description |
|---------|-------------|
| [Configure group claims for applications](how-to-connect-fed-group-claims.md) | Customize group claims in SAML tokens for federated applications. |
| [Change subdomain authentication type using PowerShell](../../users/domains-verify-custom-subdomain.md) | Modify authentication settings for specific subdomains within your federation. |

## Manage federation infrastructure

Ongoing maintenance is critical for federation reliability and security.

### Certificate management

| Article | Description |
|---------|-------------|
| [Certificate renewal for Microsoft 365 and Microsoft Entra users](how-to-connect-fed-o365-certs.md) | Renew token signing and decryption certificates for federated domains. |
| [Emergency rotation of the AD FS certificates](how-to-connect-emergency-ad-fs-certificate-rotation.md) | Emergency procedures for rotating compromised or expiring certificates. |

### Monitoring and audit

| Article | Description |
|---------|-------------|
| [Audit Administrator Events in Microsoft Entra Connect Sync](admin-audit-logging.md) | Track administrative changes and operations in Microsoft Entra Connect. |

## Enable external partner federation

Configure federation with partner organizations for B2B collaboration scenarios.

### Direct federation setup

| Article | Description |
|---------|-------------|
| [Add a SAML/WS-Fed identity provider for B2B](../../external-id/direct-federation.md) | Configure direct federation with partner identity providers for external user access. |
| [Set up AD FS federation for B2B](../../external-id/direct-federation-adfs.md) | Specific configuration steps for federating with partner AD FS environments. |

### Social and custom identity providers

| Article | Description |
|---------|-------------|
| [Add Google as an identity provider for B2B](../../external-id/customers/how-to-google-federation-customers.md) | Enable external users to sign in with Google accounts. |
| [Add OIDC-based identity provider for customer sign-in](../../external-id/customers/how-to-custom-oidc-federation-customers.md) | Configure custom OpenID Connect identity providers for customer access. |

## Configure device federation

Integrate federated authentication with device join scenarios for hybrid environments.

| Article | Description |
|---------|-------------|
| [Targeted deployments of Microsoft Entra hybrid join](../../devices/hybrid-join-control.md) | Control which devices use federated authentication for hybrid Azure AD join. |

## Additional resources

### Federation concepts and SSO

Understand how federation fits into Microsoft Entra's broader authentication strategy:

- [What is single sign-on in Microsoft Entra ID?](../../enterprise-apps/what-is-single-sign-on.md)
- [Identity providers for External ID](../../external-id/identity-providers.md)

### Compare authentication methods

Not sure which hybrid authentication method to use? Review the comprehensive comparison:

- [Choose the right authentication method for your hybrid identity solution](choose-ad-authn.md)

### Related content

- [What is hybrid identity?](../whatis-hybrid-identity.md)
- [Password hash synchronization](whatis-phs.md)
- [Pass-through authentication](how-to-connect-pta.md)
- [Password management in Microsoft Entra ID](../../authentication/overview-sspr.md)
- [Single sign-on (SSO) in Microsoft Entra ID](../../enterprise-apps/sso-overview.md)
- [Microsoft Entra Connect installation guide](how-to-connect-install-roadmap.md)
